namespace EventopiaAPI.DB
{
    public class Event
    {
        public Guid id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string cost { get; set; }
        public string location { get; set; }
        public int capacity { get; set; }
        public int sold_tickets { get; set; }
        public DateTime date { get; set; }
    }
}