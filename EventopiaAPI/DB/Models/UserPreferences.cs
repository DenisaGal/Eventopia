namespace EventopiaAPI.DB.Models
{
    public class UserPreferences
    {
        public Guid user_id { get; set; }
        public Guid category_id { get; set; }
        public int rating { get; set; }
    }
}
