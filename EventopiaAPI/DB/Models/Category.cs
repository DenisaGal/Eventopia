namespace EventopiaAPI.DB.Models
{
    public class Category
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        public ICollection<Event> Events { get; set; }
        public ICollection<UserPreference> UserPreferences { get; set; }
    }
}
