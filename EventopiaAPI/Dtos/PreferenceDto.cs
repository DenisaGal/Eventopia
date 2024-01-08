namespace Eurofins.Crescendo.Web.Application.Users.Shared
{
    public class PreferenceDto
    {
        public double Rating { get; set; }

        public string CategoryName { get; set; } = string.Empty;

        public IList<LookupDto> Events { get; set; } = null!;
    }
}