using EventopiaAPI.DB.Models;

namespace EventopiaAPI.DB
{
    public class User
    {
        public Guid Id { get; set; }
        public string EmailAddress { get; set; }
        public string Password { get; set; }

        public ICollection<Event> Events { get; set; }
        public ICollection<UserPreference> UserPreferences { get; set; }
    }
}