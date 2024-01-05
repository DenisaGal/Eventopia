using EventopiaAPI.DB.Models;

namespace EventopiaAPI.DB
{
    public class Event
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Cost { get; set; }
        public string Location { get; set; }
        public int Capacity { get; set; }
        public int SoldTickets { get; set; }
        public DateTime Date { get; set; }

        public ICollection<User> Users { get; set; }
        public ICollection<Category> Categories { get; set; }
    }
}