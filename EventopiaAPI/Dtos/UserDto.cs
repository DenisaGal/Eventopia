﻿namespace Eurofins.Crescendo.Web.Application.Users.Shared
{
    public class UserDto
    {
        public Guid? Id { get; set; }
        public string Email { get; set; } = string.Empty;
        public string? Password { get; set; } = string.Empty;
        public bool IsOrganizer { get; set; }

    }
}