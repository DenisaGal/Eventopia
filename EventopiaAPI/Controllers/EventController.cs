using Eurofins.Crescendo.Web.Application.Users.Shared;
using EventopiaAPI.DB;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventopiaAPI.Controllers
{
    [ApiController]
    [Route("events")]
    public class EventController : Controller
    {
        private readonly EventopiaDBContext _context;

        public EventController(EventopiaDBContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetEvents")]
        public async Task<IActionResult> GetEvents()
        {
            return _context.Events != null ? Ok(await _context.Events.ToListAsync()) : Problem("Entity set 'EventopiaDBContext.Events'  is null.");
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] EventDto newEvent)
        {
            if (ModelState.IsValid)
            {
                _context.Events.Add(new Event
                {
                    Id = Guid.NewGuid(),
                    Name = newEvent.Name,
                    Description = newEvent.Description,
                    Cost = newEvent.Cost,
                    Location = newEvent.Location,
                    Capacity = 0,
                    Date = DateTime.SpecifyKind(newEvent.Date, DateTimeKind.Utc),
                    Image = newEvent.Image,
                });
                await _context.SaveChangesAsync();
            }
            return Ok(newEvent);
        }
    }
}