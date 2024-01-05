namespace EventopiaAPI.DB
{
    public class User
    {
        public Guid id { get; set; }
        public string email_address { get; set; }
        public string password { get; set; }
    }
}