﻿namespace Eurofins.Crescendo.Web.Application.Users.Shared
{
    public class EventDto
    {
        public Guid? Id { get; set; }

        public string Name { get; set; } = string.Empty;

        public string Description { get; set; } = string.Empty;

        public int Cost { get; set; }

        public string Location { get; set; } = string.Empty;

        public DateTime Date { get; set; }

        public IList<LookupDto> Categories { get; set; } = null!;
    }
}
