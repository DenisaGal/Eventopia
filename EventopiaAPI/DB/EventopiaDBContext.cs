using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace EventopiaAPI.DB
{
    public class EventopiaDBContext : DbContext
    {
        protected readonly IConfiguration Configuration;

        public EventopiaDBContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            // connect to postgres with connection string from app settings
            options.UseNpgsql(Configuration.GetConnectionString("EventopiaDB"));
        }

        public DbSet<Event> Events { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Venue> Venues { get; set; }
        public DbSet<Preference> Preferences { get; set; }
        public DbSet<Location> Locations { get; set; }

    }
}
