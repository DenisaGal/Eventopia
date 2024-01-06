using Eurofins.Crescendo.Web.Application.Users.Shared;
using EventopiaAPI.DB;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Net.Mail;

namespace EventopiaAPI.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class UserController : Controller
    {
        private readonly EventopiaDBContext _context;

        public UserController(EventopiaDBContext context)
        {
            _context = context;
        }

        [HttpGet(Name = "GetUsers")]
        public async Task<IActionResult> GetUsers()
        {
            return _context.Users != null ? Ok(await _context.Users.ToListAsync()) : Problem("Entity set 'EventopiaDBContext.Users'  is null.");
        }

        [HttpGet(Name = "GetUserById")]
        public async Task<IActionResult> GetUserById(Guid? id)
        {
            if (id == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.Include(u => u.Events).FirstOrDefaultAsync(m => m.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            var userDto = new UserDetailsDto
            {
                Email = user.EmailAddress,
                IsOrganizer = user.IsOrganizer,
                Events = user.Events.Select(e => new LookupDto
                {
                    Id = e.Id,
                    Details = e.Name
                }).ToList()
            };

            return Ok(userDto);
        }

        [HttpGet(Name = "GetUserByEmail")]
        public async Task<IActionResult> GetUserByEmail(string? EmailAddress)
        {
            if (EmailAddress == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.EmailAddress == EmailAddress);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

        [HttpGet(Name = "GetUserTypeById")]
        public async Task<IActionResult> GetUserTypeById(Guid? id)
        {
            if (id == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.Id == id);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user.IsOrganizer);
        }

        [HttpGet(Name = "GetUserTypeByEmail")]
        public async Task<IActionResult> GetUserTypeByEmail(string? EmailAddress)
        {
            if (EmailAddress == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.EmailAddress == EmailAddress);
            if (user == null)
            {
                return NotFound();
            }

            return Ok(user.IsOrganizer);
        }

        //Register
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] UserDto newUser)
        {
            if (ModelState.IsValid)
            {
                _context.Users.Add(new User
                {
                    Id = Guid.NewGuid(),
                    EmailAddress = newUser.Email,
                    Password = BCrypt.Net.BCrypt.EnhancedHashPassword(newUser.Password, 13),
                    IsOrganizer = newUser.IsOrganizer,
                });
                await _context.SaveChangesAsync();
            }
            return Ok(newUser);
        }

        //Login
        [HttpPost]
        public async Task<IActionResult> LoginUser([FromBody] UserDto newUser)
        {
            if (newUser.Email == null || _context.Users == null)
            {
                return NotFound();
            }

            var user = await _context.Users.FirstOrDefaultAsync(m => m.EmailAddress == newUser.Email);
            if (user == null)
            {
                return NotFound();
            }

            if (newUser.Password != user.Password) /*(!BCrypt.Net.BCrypt.EnhancedVerify(newUser.Password, user.Password))*/
            {
                return BadRequest();
            }

            return Ok(user.Id);
        }
    }
}