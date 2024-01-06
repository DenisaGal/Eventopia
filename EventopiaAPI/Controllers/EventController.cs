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
        public async Task<IActionResult> AddImage(Guid Id, [FromBody] Event newEvent)
        {
            if (Id != newEvent.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(newEvent);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EventExists(newEvent.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return Ok(newEvent);
        }

        private bool EventExists(Guid Id)
        {
            return (_context.Events?.Any(e => e.Id == Id)).GetValueOrDefault();
        }
    }
}