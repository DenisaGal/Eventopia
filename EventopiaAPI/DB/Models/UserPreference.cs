namespace EventopiaAPI.DB.Models
{
    public class UserPreference
    {
        public Guid UserId { get; set; }

        public Guid CategoryId { get; set; }

        public double Rating { get; set; }
    }
}
