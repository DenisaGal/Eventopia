using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace EventopiaAPI.DB
{
    public class EventopoiaDBContext:DbContext
    {
        protected readonly IConfiguration Configuration;

        public EventopoiaDBContext(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            // connect to postgres with connection string from app settings
            options.UseNpgsql(Configuration.GetConnectionString("EventopiaDB"));
        }

        public DbSet<Event> Events { get; set; }
    }
}
