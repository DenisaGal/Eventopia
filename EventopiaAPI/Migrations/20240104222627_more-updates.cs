using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EventopiaAPI.Migrations
{
    public partial class moreupdates : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "address_details",
                table: "Venues",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "description",
                table: "Venues",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<float>(
                name: "latitude",
                table: "Venues",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.AddColumn<int>(
                name: "location",
                table: "Venues",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<float>(
                name: "longitude",
                table: "Venues",
                type: "real",
                nullable: false,
                defaultValue: 0f);

            migrationBuilder.AddColumn<int>(
                name: "max_capacity",
                table: "Venues",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "name",
                table: "Venues",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "number",
                table: "Venues",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "region_id",
                table: "Venues",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "street",
                table: "Venues",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "zipcode",
                table: "Venues",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "category",
                table: "Preferences",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "name",
                table: "Preferences",
                type: "text",
                nullable: false,
                defaultValue: "");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "address_details",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "description",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "latitude",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "location",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "longitude",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "max_capacity",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "name",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "number",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "region_id",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "street",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "zipcode",
                table: "Venues");

            migrationBuilder.DropColumn(
                name: "category",
                table: "Preferences");

            migrationBuilder.DropColumn(
                name: "name",
                table: "Preferences");
        }
    }
}
