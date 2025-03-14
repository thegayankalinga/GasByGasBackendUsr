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
//using Scalar.AspNetCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddControllers().AddNewtonsoftJson(options =>
{
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
    options.SerializerSettings.NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore;
    options.SerializerSettings.DateFormatString = "yyyy-MM-dd HH:mm:ss";
    options.SerializerSettings.DateTimeZoneHandling = Newtonsoft.Json.DateTimeZoneHandling.Utc;
    //options.SerializerSettings.Converters.Add(new Newtonsoft.Json.Converters.StringEnumConverter());
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddOpenApi();

builder.Services.AddScoped<ITokenService, TokenService>();
builder.Services.AddScoped<IOutletRepository, OutletRepository>();
// builder.Services.AddScoped<IKeyVaultService, KeyVaultService>();
builder.Services.AddScoped<IGasTokenRepository, GasTokenRepository>();
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IDeliveryRepository, DeliveryRepository>();
builder.Services.AddScoped<ISmsService, SmsService>();
builder.Services.AddScoped<IMailService, MailService>();
builder.Services.AddScoped<IStockRepository, StockRepository>();

builder.Services.AddSingleton<SchedulerService>(); // Allow Controller access
builder.Services.AddSingleton<IKeyVaultService, KeyVaultService>();
builder.Services.AddHostedService<SchedulerService>();

// Add CORS policy
builder.Services.AddCors(options =>
{
    
    
    options.AddPolicy("AllowSpecificOrigins",
        policy => policy.WithOrigins(
                "http://localhost:5173",
                "http://localhost:3000", 
                "https://icy-wave-0c56fec00.4.azurestaticapps.net", 
                "https://green-hill-04841a400.6.azurestaticapps.net") // Replace with your React frontend URL
            .AllowAnyHeader()
            .AllowAnyMethod());
});

builder.Services.AddSwaggerGen(option =>
{
    
    option.SwaggerDoc("v1", new OpenApiInfo { Title = "Gas By Gas API", Version = "v1" });
    option.SchemaFilter<EnumSchemaFilter>();
    //option.UseInlineDefinitionsForEnums();
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
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            []
        }
    });
});

builder.Services.AddDbContext<ApplicationDbContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
});

var keyVaultUri = builder.Configuration["AzureKeyVault:VaultUri"];
if (!string.IsNullOrEmpty(keyVaultUri))
{
    builder.Configuration.AddAzureKeyVault(
        new Uri(keyVaultUri),
        new DefaultAzureCredential());
}
var signingKey = builder.Configuration["lmusigningkey"];

builder.Services.AddIdentity<AppUser, IdentityRole>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequireLowercase = false;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 6;
    //options.Password.RequiredUniqueChars = 0;
    options.SignIn.RequireConfirmedEmail = false;
    options.SignIn.RequireConfirmedPhoneNumber = false;
    options.User.RequireUniqueEmail = true;
}).AddEntityFrameworkStores<ApplicationDbContext>();

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





var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment() || app.Environment.IsProduction() || app.Environment.IsStaging())
{
    //app.MapOpenApi();
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        //options.SwaggerEndpoint("/openapi/v1.json", "Gas By Gas APIs");
    });
    
    // app.MapScalarApiReference(options =>
    // {
    //     options
    //         .WithTitle("Gas By Gas APIs")
    //         .WithTheme(ScalarTheme.Kepler)
    //         .WithDarkModeToggle(true)
    //         .WithDarkMode(false)
    //         .WithDefaultHttpClient(ScalarTarget.JavaScript, ScalarClient.Fetch)
    //         ;
    //
    // });
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

// Use CORS
app.UseCors("AllowSpecificOrigins");
app.MapControllers();

app.Run();
