namespace EventopiaAPI.DB
{
    public class Event
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string tax { get; set; }
        public int venue_id { get; set; }
        public int capacity { get; set; }
        public DateTime date { get; set; }
    }
}