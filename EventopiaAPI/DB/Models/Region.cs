namespace EventopiaAPI.DB.Models
{
    public class Address
    {
        public Guid id { get; set; }
        public string city { get; set; }
        public string county { get; set; }
        public string country { get; set; }
    }
}
