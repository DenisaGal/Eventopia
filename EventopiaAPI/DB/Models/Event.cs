using EventopiaAPI.DB.Models;

namespace EventopiaAPI.DB
{
    public class Event
    {
        public Guid Id { get; set; }

        public string Name { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;

        public int Cost { get; set; }

        public string Location { get; set; } = string.Empty;

        public int Capacity { get; set; }

        public int SoldTickets { get; set; }

        public DateTime Date { get; set; }
        public byte[]? Image { get; set; }

        public ICollection<User> Users { get; set; } = null!;

        public ICollection<Category> Categories { get; set; } = null!;
    }
}