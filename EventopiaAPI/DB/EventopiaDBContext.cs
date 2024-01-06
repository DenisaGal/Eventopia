using EventopiaAPI.DB.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Npgsql.EntityFrameworkCore.PostgreSQL.Query.Expressions.Internal;
using System.Net;
using System.Reflection.Emit;
using System.Reflection.Metadata;

namespace EventopiaAPI.DB
{
    public class EventopiaDBContext : DbContext
    {
        public EventopiaDBContext(DbContextOptions<EventopiaDBContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Event> Events { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<UserPreference> UserPreferences { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            //User constraints
            modelBuilder.Entity<User>()
                .HasKey(u => u.Id);
            modelBuilder.Entity<User>()
                .HasIndex(u => u.EmailAddress)
                .IsUnique();
            modelBuilder.Entity<User>()
                .Property(u => u.Password)
                .IsRequired();
            modelBuilder.Entity<User>()
                .Property(u => u.IsOrganizer)
                .IsRequired()
                .HasDefaultValue(false);

            //Event constraints
            modelBuilder.Entity<Event>()
                .HasKey(e => e.Id);
            modelBuilder.Entity<Event>()
                .Property(e => e.Name)
                .IsRequired();
            modelBuilder.Entity<Event>()
                .Property(e => e.Description)
                .IsRequired();
            modelBuilder.Entity<Event>()
                .Property(e => e.Cost)
                .IsRequired();
            modelBuilder.Entity<Event>()
                .Property(e => e.Location)
                .IsRequired();
            modelBuilder.Entity<Event>()
                .Property(e => e.Capacity)
                .IsRequired();
            modelBuilder.Entity<Event>()
                .Property(e => e.SoldTickets)
                .IsRequired()
                .HasDefaultValue(0);
            modelBuilder.Entity<Event>()
                .Property(e => e.Date)
                .IsRequired();

            //Category constraints
            modelBuilder.Entity<Category>()
                .HasKey(c => c.Id);
            modelBuilder.Entity<Category>()
                .Property(c => c.Name)
                .IsRequired();

            //UserPreference constraints
            modelBuilder.Entity<UserPreference>()
                .HasKey(userCompany => new
                {
                    userCompany.UserId,
                    userCompany.CategoryId
                });
            modelBuilder.Entity<UserPreference>()
                .Property(u => u.Rating)
                .HasDefaultValue(null);

            //Many to many constraints

            modelBuilder.Entity<Event>()
                .HasMany(e => e.Categories)
                .WithMany(c => c.Events)
                .UsingEntity(x => x.ToTable("EventCategories"));

            modelBuilder.Entity<Event>()
                .HasMany(e => e.Users)
                .WithMany(u => u.Events)
                .UsingEntity(x => x.ToTable("UserEvents"));

        }

    }
}