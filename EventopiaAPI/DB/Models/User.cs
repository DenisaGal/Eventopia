using EventopiaAPI.DB.Models;
using Npgsql.Logging;

namespace EventopiaAPI.DB
{
    public class User
    {
        public Guid Id { get; set; }

        public string EmailAddress { get; set; } = string.Empty;

        public string Password { get; set; } = string.Empty;

        public bool IsOrganizer {  get; set; }

        public ICollection<Event> Events { get; set; } = null!;

        public ICollection<UserPreference> UserPreferences { get; set; } = null!;
    }
}