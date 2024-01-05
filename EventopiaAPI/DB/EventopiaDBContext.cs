using EventopiaAPI.DB.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System.Net;

namespace EventopiaAPI.DB
{
    public class EventopiaDBContext : DbContext
    {
        public EventopiaDBContext(DbContextOptions<EventopiaDBContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Event> Events { get; set; }

        public DbSet<Address> addresses { get; set; }
    }
}