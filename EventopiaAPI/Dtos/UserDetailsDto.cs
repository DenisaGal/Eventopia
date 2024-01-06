namespace Eurofins.Crescendo.Web.Application.Users.Shared
{
    public class UserDetailsDto
    {
        public string Email { get; set; } = string.Empty;

        public bool IsOrganizer { get; set; }

        public IList<LookupDto> Events { get; set; } = null!;

    }
}