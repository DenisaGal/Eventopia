using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using EventopiaAPI.DB;
using Microsoft.AspNetCore.Identity;
using Microsoft.CodeAnalysis.Scripting;

namespace EventopiaAPI.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class UsersController : Controller
    {
        private readonly EventopiaDBContext _context;

        public UsersController(EventopiaDBContext context)
        {
            _context = context;
        }

        // GET: Users
        [HttpGet(Name = "GetUsers")]
        public async Task<IActionResult> GetUsers()
        {
            return _context.Users != null ? Ok(await _context.Users.ToListAsync()) : Problem("Entity set 'EventopiaDBContext.Users'  is null.");
        }

        // GET: Users/Details/5
        [HttpGet(Name = "GetUserDetails")]
        public async Task<IActionResult> GetUserDetails(Guid? id)
        {
            if (id == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [HttpGet(Name = "GetUserType")]
        public async Task<IActionResult> GetUserType(Guid? Id)
        {
            if (Id == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.Id == Id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user.Type);
        }

        // GET: Users/Create
        [HttpGet(Name = "GetCreateUser")]
        public IActionResult Create()
        {
            return Ok();
        }

        // POST: Users/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,EmailAddress,Password,Type")] User user)
        {
            if (ModelState.IsValid)
            {
                //user.Id = Guid.NewGuid();
                user.Password = BCrypt.Net.BCrypt.EnhancedHashPassword(user.Password, 13);
                _context.Add(user);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return Ok(user);
        }

        // GET: Users/Edit/5
        [HttpGet(Name = "GetEditUser")]
        public async Task<IActionResult> Edit(Guid? id)
        {
            if (id == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }

        // POST: Users/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(Guid id, [Bind("Id,EmailAddress,Password,Type")] User user)
        {
            if (id != user.Id)
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
                    if (!UserExists(user.Id))
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

        // GET: Users/Delete/5
        [NonAction]
        public async Task<IActionResult> Delete(Guid? id)
        {
            if (id == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users
                .FirstOrDefaultAsync(m => m.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(Guid id)
        {
            if (_context.Users == null)
            {
                return Problem("Entity set 'EventopiaDBContext.Users'  is null.");
            }
            var user = await _context.Users.FindAsync(id);
            if (user != null)
            {
                _context.Users.Remove(user);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserExists(Guid id)
        {
          return (_context.Users?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
