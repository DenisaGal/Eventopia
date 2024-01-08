using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EventopiaAPI.Migrations
{
    public partial class EventImage : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "Image",
                table: "Events",
                type: "bytea",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Image",
                table: "Events");
        }
    }
}
