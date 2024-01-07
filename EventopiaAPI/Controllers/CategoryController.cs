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