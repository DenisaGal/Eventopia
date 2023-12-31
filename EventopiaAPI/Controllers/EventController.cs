﻿using Eurofins.Crescendo.Web.Application.Users.Shared;
using EventopiaAPI.DB;
using EventopiaAPI.DB.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using NuGet.Protocol.Core.Types;

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
            if (_context.Events == null)
                return Problem("Entity set 'EventopiaDBContext.Events'  is null.");

            var events = await _context.Events.Include(e => e.Categories).ToListAsync();

            return Ok(events.Select(e => new EventDto
            {
                Id = e.Id,
                Name = e.Name,
                Description = e.Description,
                Cost = e.Cost,
                Location = e.Location,
                Date = e.Date,
                Categories = e.Categories.Select(c => new LookupDto
                {
                    Id = c.Id,
                    Details = c.Name
                }).ToList(),
            }).ToList());
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateEventDto newEvent)
        {
            if (ModelState.IsValid)
            {
                var newCategories = new List<Category>();
                foreach (var categoryId in newEvent.Categories)
                {
                    var category = await _context.Categories.FirstOrDefaultAsync(m => m.Id == categoryId);
                    if (category == null)
                    {
                        return NotFound();
                    }
                    newCategories.Add(category);
                }

                _context.Events.Add(new Event
                {
                    Id = Guid.NewGuid(),
                    Name = newEvent.Name,
                    Description = newEvent.Description,
                    Cost = newEvent.Cost,
                    Location = newEvent.Location,
                    Capacity = 0,
                    Date = DateTime.SpecifyKind(newEvent.Date, DateTimeKind.Utc),
                    Categories = newCategories
                });

                await _context.SaveChangesAsync();
            }
            return Ok(newEvent);
        }

        [HttpPost]
        public async Task<IActionResult> EditUserEvents(Guid userId, Guid eventId)
        {
            if (_context.Users == null || _context.Events == null)
            {
                return NotFound();
            }

            var user = await _context.Users.Include(u => u.Events).FirstOrDefaultAsync(m => m.Id == userId);
            var userEvent = await _context.Events.Include(u => u.Categories).FirstOrDefaultAsync(m => m.Id == eventId);
            if (user == null || userEvent == null)
            {
                return NotFound();
            }

            if (user.Events.Select(e => e.Id).ToList().Contains(eventId))
            {
                user.Events.Remove(userEvent);

                var categories = userEvent.Categories.Select(c => c.Id).ToList();
                for (var i = 0; i < categories.Count; i++)
                {
                    var categoryId = categories[i];
                    var preference = await _context.UserPreferences.FirstOrDefaultAsync(m => m.UserId == userId && m.CategoryId == categoryId);
                    if (preference == null)
                    {
                        return NotFound();
                    }
                    preference.Rating--;
                    _context.Update(preference);
                }
            }
            else
            {
                user.Events.Add(userEvent);

                var categories = userEvent.Categories.Select(c => c.Id).ToList();
                for(var i = 0; i < categories.Count; i++)
                {
                    var categoryId = categories[i];
                    var preference = await _context.UserPreferences.FirstOrDefaultAsync(m => m.UserId == userId && m.CategoryId == categoryId);
                    if (preference == null)
                    {
                        return NotFound();
                    }
                    preference.Rating++;
                    _context.Update(preference);
                }
            }

            await _context.SaveChangesAsync();

            return Ok();
        }
    }
}