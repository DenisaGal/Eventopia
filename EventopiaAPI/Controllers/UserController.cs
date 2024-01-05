using EventopiaAPI.DB;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EventopiaAPI.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class UserController : ControllerBase
    {
        private readonly EventopiaDBContext _context;

        public UserController(EventopiaDBContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetUsers")]
        public async Task<IActionResult> Index()
        {
            return _context.Users != null ? Ok(await _context.Users.ToListAsync()) : NotFound();
        }

        [HttpGet(Name = "GetUserDetails")]
        public async Task<IActionResult> Details(Guid? gid)
        {
            if(gid == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.gid == gid);
            if(user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [HttpGet(Name = "GetCreateUser")]
        public IActionResult Create()
        {
            return Ok();
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("gid,first_name,last_name,email_address,password,location,preferences,type")] User user)
        {
            if (ModelState.IsValid)
            {
                _context.Add(user);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return Ok(user);
        }

        [HttpGet(Name = "GetEditUser")]
        public async Task<IActionResult> Edit(int? gid)
        {
            if (gid == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(gid);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }

        [HttpGet(Name = "GetUserType")]
        public async Task<IActionResult> Type(Guid? gid)
        {
            if (gid == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.gid == gid);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user.type);
        }

        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(Guid gid, [Bind("gid,first_name,last_name,email_address,password,location,preferences,type")] User user)
        {
            if (gid != user.gid)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(user);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserExists(user.gid))
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
            return Ok(user);
        }

        [NonAction]
        public async Task<IActionResult> Delete(Guid? gid)
        {
            if (gid == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.gid == gid);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(Guid gid)
        {
            if (_context.Users == null)
            {
                return Problem("Entity set 'EventopiaDBContext.Users'  is null.");
            }
            var user = await _context.Users.FindAsync(gid);
            if (user != null)
            {
                _context.Users.Remove(user);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(Guid gid)
        {
            return (_context.Users?.Any(e => e.gid == gid)).GetValueOrDefault();
        }
    }
}