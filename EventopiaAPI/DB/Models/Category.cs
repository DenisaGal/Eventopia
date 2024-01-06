namespace EventopiaAPI.DB.Models
{
    public class Category
    {
        public Guid Id { get; set; }

        public string Name { get; set; } = string.Empty;

        public ICollection<Event> Events { get; set; } = null!;

        public ICollection<UserPreference> UserPreferences { get; set; } = null!;
    }
}
