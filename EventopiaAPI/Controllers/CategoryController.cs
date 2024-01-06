using EventopiaAPI.DB;
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
    }
}