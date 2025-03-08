using Azure.Identity;
using backend.Data;
using backend.Interfaces;
using backend.Models;
using backend.Repositories;
using backend.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// ✅ Initialize Azure Key Vault Configuration Before `builder.Build()`
var keyVaultUri = builder.Configuration["AzureKeyVault:VaultUri"];
if (!string.IsNullOrEmpty(keyVaultUri))
{
    builder.Configuration.AddAzureKeyVault(
        new Uri(keyVaultUri),
        new DefaultAzureCredential());
}

// ✅ Register Key Vault Service (Before Fetching Secrets)
builder.Services.AddSingleton<IKeyVaultService, KeyVaultService>();

// ✅ Create a Temporary Service Provider to Fetch the Connection String Before `builder.Build()`
using var tempProvider = builder.Services.BuildServiceProvider();
var keyVaultService = tempProvider.GetRequiredService<IKeyVaultService>();
var dbConnectionString = await keyVaultService.GetSecretAsync("DbConnectionString");

// ✅ Register Database Context with the Connection String from Azure Key Vault
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(dbConnectionString));

// ✅ Fetch JWT Signing Key Before `builder.Build()`
var signingKey = await keyVaultService.GetSecretAsync("lmusigningkey");

// ✅ Add Core Services
builder.Services.AddControllers().AddNewtonsoftJson(options =>
{
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
    options.SerializerSettings.NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore;
    options.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
    options.SerializerSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Utc;
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddOpenApi();

// ✅ Register Dependencies (Repositories & Services)
builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<IOutletRepository, OutletRepository>();
builder.Services.AddScoped<IGasTokenRepository, GasTokenRepository>();
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IDeliveryRepository, DeliveryRepository>();
builder.Services.AddScoped<ISmsService, SmsService>();
builder.Services.AddScoped<IMailService, MailService>();
builder.Services.AddScoped<IStockRepository, StockRepository>();

// ✅ Register Background Services
builder.Services.AddSingleton<SchedulerService>();
builder.Services.AddHostedService<SchedulerService>();

// ✅ CORS Configuration
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        policy => policy.WithOrigins("http://localhost:5173", "http://localhost:3000", "https://icy-wave-0c56fec00.4.azurestaticapps.net/login")
            .AllowAnyHeader()
            .AllowAnyMethod());
});

// ✅ Swagger Configuration
builder.Services.AddSwaggerGen(option =>
{
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "Gas By Gas API", Version = "v1" });
    option.SchemaFilter<EnumSchemaFilter>();
    option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter a valid token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "Bearer"
    });
    option.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            []
        }
    });
});

// ✅ Identity Configuration
builder.Services.AddIdentity<AppUser, IdentityRole>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequireLowercase = false;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 6;
    options.SignIn.RequireConfirmedEmail = false;
    options.SignIn.RequireConfirmedPhoneNumber = false;
    options.User.RequireUniqueEmail = true;
}).AddEntityFrameworkStores<ApplicationDbContext>();

// ✅ Authentication & JWT Configuration
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme =
        options.DefaultChallengeScheme =
            options.DefaultForbidScheme =
                options.DefaultScheme =
                    options.DefaultSignInScheme =
                        options.DefaultSignOutScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidIssuer = builder.Configuration["JWT:Issuer"],
        ValidAudience = builder.Configuration["JWT:Audience"],
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(
            System.Text.Encoding.UTF8.GetBytes(signingKey ?? throw new InvalidOperationException()))
    };
});

var app = builder.Build(); // ✅ No service modifications after this point.

// ✅ Configure the HTTP Request Pipeline
if (app.Environment.IsDevelopment() || app.Environment.IsProduction() || app.Environment.IsStaging())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.UseCors("AllowSpecificOrigins");
app.MapControllers();

app.Run();