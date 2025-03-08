using System.Collections.Immutable;
using backend.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;

namespace backend.Data;

public class ApplicationDbContext: IdentityDbContext<AppUser>
{
    public ApplicationDbContext(DbContextOptions dbContextOptions): base(dbContextOptions)
    {

    }
    // public DbSet<User> Users { get; set; }
    public DbSet<Outlet> Outlets { get; set; }
    public DbSet<GasToken> GasTokens { get; set; }
    public DbSet<DeliverySchedule> DeliverySchedules { get; set; }
    
    public DbSet<StockRequest?> StockRequests { get; set; }
    
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.ConfigureWarnings(warnings =>
            warnings.Ignore(RelationalEventId.PendingModelChangesWarning));
    }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        List<IdentityRole> roles = new List<IdentityRole>
        {
            new IdentityRole {Name = "User", NormalizedName = "USER"},
            new IdentityRole {Name = "Admin", NormalizedName = "ADMIN"},
            new IdentityRole {Name = "Manager", NormalizedName = "MANAGER"},
        }; 
        modelBuilder.Entity<IdentityRole>().HasData(roles);
        
    }
    
    
}