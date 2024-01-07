using Eurofins.Crescendo.Web.Application.Users.Shared;
using EventopiaAPI.DB;
using EventopiaAPI.DB.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventopiaAPI.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class CategoryController : Controller
    {
        private readonly EventopiaDBContext _context;

        public CategoryController(EventopiaDBContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetCategories")]
        public async Task<IActionResult> GetCategories()
        {
            return _context.Categories != null ? Ok(await _context.Categories.ToListAsync()) : Problem("Entity set 'EventopiaDBContext.Categories'  is null.");
        }

        [HttpGet(Name = "GetCategoriesByUserId/{UserId}")]
        public async Task<IActionResult> GetCategoriesByUserId(Guid UserId)
        {
            var preferences = new List<PreferenceDto>();
            var categories = await _context.Categories.ToListAsync();
            foreach (var category in categories) {
                var userPreference = await _context.UserPreferences.FirstOrDefaultAsync(m => m.UserId == UserId && m.CategoryId == category.Id);
                if (userPreference == null)
                {
                    return NotFound();
                }

                if (userPreference.Rating > 0)
                {              
                    var events = await _context.Events.Where(e => e.Categories.Select(c => c.Id).Contains(category.Id) && !e.Users.Select(c => c.Id).Contains(UserId)).ToListAsync();

                    preferences.Add(new PreferenceDto
                    {
                        Rating = userPreference.Rating,
                        CategoryName = category.Name,
                        Events = events.Select(e => new LookupDto
                        { 
                            Id = e.Id,
                            Details = e.Name,
                            Extra = e.Description
                        }).ToList()
                    });
                }
            }

            return  Ok(preferences.Where(p => p.Events.Count > 0).OrderByDescending(p => p.Rating));
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CategoryDto newCategory)
        {
            var newId = Guid.NewGuid();

            if (ModelState.IsValid)
            {
                _context.Categories.Add(new Category
                {
                    Id = newId,
                    Name = newCategory.Name
                });

                var users = await _context.Users.ToListAsync();
                foreach(var user in users)
                {
                    _context.UserPreferences.Add(new UserPreference
                    {
                        UserId = user.Id,
                        CategoryId = newId,
                        Rating = 0
                    });
                }

                await _context.SaveChangesAsync();
            }
            return Ok(new CategoryDto 
            { 
                Id = newId, 
                Name = newCategory.Name
            });
        }
    }
}