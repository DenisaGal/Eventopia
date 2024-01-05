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

    }
}