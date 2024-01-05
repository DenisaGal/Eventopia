using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace EventopiaAPI.Migrations
{
    public partial class initialsetup : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "addresses",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    city = table.Column<string>(type: "text", nullable: false),
                    county = table.Column<string>(type: "text", nullable: false),
                    country = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_addresses", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Events",
                columns: table => new
                {
                    id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    name = table.Column<string>(type: "text", nullable: false),
                    description = table.Column<string>(type: "text", nullable: false),
                    category = table.Column<string>(type: "text", nullable: false),
                    tax = table.Column<string>(type: "text", nullable: false),
                    venue_id = table.Column<int>(type: "integer", nullable: false),
                    tickets = table.Column<int>(type: "integer", nullable: false),
                    capacity = table.Column<int>(type: "integer", nullable: false),
                    date = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Events", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    gid = table.Column<Guid>(type: "uuid", nullable: false),
                    first_name = table.Column<string>(type: "text", nullable: false),
                    last_name = table.Column<string>(type: "text", nullable: false),
                    email_address = table.Column<string>(type: "text", nullable: false),
                    password = table.Column<string>(type: "text", nullable: false),
                    location = table.Column<int>(type: "integer", nullable: false),
                    preferences = table.Column<int>(type: "integer", nullable: false),
                    type = table.Column<bool>(type: "boolean", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.gid);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "addresses");

            migrationBuilder.DropTable(
                name: "Events");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
