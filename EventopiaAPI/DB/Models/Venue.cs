namespace EventopiaAPI.DB
{
    public class Venue
    {
        public Guid id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public int max_capacity { get; set; }
        public int location { get; set; }
        public float longitude { get; set; }
        public float latitude { get; set; }
        public string street { get; set; }
        public int number { get; set; }
        public string zipcode { get; set; }
        public string address_details { get; set; }
        public int region_id { get; set; }
    }
}