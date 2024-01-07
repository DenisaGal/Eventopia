using Eurofins.Crescendo.Web.Application.Users.Shared;
using EventopiaAPI.DB;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace EventopiaAPI.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
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
            newEvent.Id = Guid.NewGuid();
            if (ModelState.IsValid)
            {
                _context.Events.Add(new Event
                {
                    Id = (Guid)newEvent.Id,
                    Name = newEvent.Name,
                    Description = newEvent.Description,
                    Cost = newEvent.Cost,
                    Location = newEvent.Location,
                    Capacity = 0,
                    Date = DateTime.SpecifyKind(newEvent.Date, DateTimeKind.Utc),
                });
                await _context.SaveChangesAsync();
            }
            return Ok(newEvent);
        }

        [HttpGet(Name = "GetEditEvent")]
        public async Task<IActionResult> Edit(Guid? id)
        {
            if (id == null || _context.Events == null)
            {
                return NotFound();
            }

            var @event = await _context.Events.FindAsync(id);
            if (@event == null)
            {
                return NotFound();
            }
            return Ok(@event);
        }

        [HttpPost]
        public async Task<IActionResult> AddImage(Guid? Id, IFormFile file)
        {
            if (Id == null || _context.Events == null)
            {
                return NotFound();
            }

            var @event = await _context.Events.FirstOrDefaultAsync(m => m.Id == Id);
            if (@event == null)
            {
                return NotFound();
            }

            if (file == null)
            {
               return BadRequest();
            }
            var ms = new MemoryStream();
            file.CopyTo(ms);
            var fileBytes = ms.ToArray();
            //string s = Convert.ToBase64String(fileBytes);

            if (ModelState.IsValid)
            {
                @event.Image = fileBytes;
                _context.Events.Update(@event);
                await _context.SaveChangesAsync();
            }

            return Ok();
        }

        private bool EventExists(Guid Id)
        {
            return (_context.Events?.Any(e => e.Id == Id)).GetValueOrDefault();
        }
    }
}