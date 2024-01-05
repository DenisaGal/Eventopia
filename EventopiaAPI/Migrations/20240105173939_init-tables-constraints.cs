using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EventopiaAPI.Migrations
{
    public partial class inittablesconstraints : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_EventCategory_Categories_CategoriesId",
                table: "EventCategory");

            migrationBuilder.DropForeignKey(
                name: "FK_EventCategory_Events_EventsId",
                table: "EventCategory");

            migrationBuilder.DropForeignKey(
                name: "FK_UserEvent_Events_EventsId",
                table: "UserEvent");

            migrationBuilder.DropForeignKey(
                name: "FK_UserEvent_Users_UsersId",
                table: "UserEvent");

            migrationBuilder.DropForeignKey(
                name: "FK_UserPreference_Categories_CategoryId",
                table: "UserPreference");

            migrationBuilder.DropForeignKey(
                name: "FK_UserPreference_Users_UserId",
                table: "UserPreference");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserPreference",
                table: "UserPreference");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserEvent",
                table: "UserEvent");

            migrationBuilder.DropPrimaryKey(
                name: "PK_EventCategory",
                table: "EventCategory");

            migrationBuilder.RenameTable(
                name: "UserPreference",
                newName: "UserPreferences");

            migrationBuilder.RenameTable(
                name: "UserEvent",
                newName: "UserEvents");

            migrationBuilder.RenameTable(
                name: "EventCategory",
                newName: "EventCategories");

            migrationBuilder.RenameIndex(
                name: "IX_UserPreference_CategoryId",
                table: "UserPreferences",
                newName: "IX_UserPreferences_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_UserEvent_UsersId",
                table: "UserEvents",
                newName: "IX_UserEvents_UsersId");

            migrationBuilder.RenameIndex(
                name: "IX_EventCategory_EventsId",
                table: "EventCategories",
                newName: "IX_EventCategories_EventsId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserPreferences",
                table: "UserPreferences",
                columns: new[] { "UserId", "CategoryId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserEvents",
                table: "UserEvents",
                columns: new[] { "EventsId", "UsersId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_EventCategories",
                table: "EventCategories",
                columns: new[] { "CategoriesId", "EventsId" });

            migrationBuilder.AddForeignKey(
                name: "FK_EventCategories_Categories_CategoriesId",
                table: "EventCategories",
                column: "CategoriesId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_EventCategories_Events_EventsId",
                table: "EventCategories",
                column: "EventsId",
                principalTable: "Events",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserEvents_Events_EventsId",
                table: "UserEvents",
                column: "EventsId",
                principalTable: "Events",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserEvents_Users_UsersId",
                table: "UserEvents",
                column: "UsersId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserPreferences_Categories_CategoryId",
                table: "UserPreferences",
                column: "CategoryId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserPreferences_Users_UserId",
                table: "UserPreferences",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_EventCategories_Categories_CategoriesId",
                table: "EventCategories");

            migrationBuilder.DropForeignKey(
                name: "FK_EventCategories_Events_EventsId",
                table: "EventCategories");

            migrationBuilder.DropForeignKey(
                name: "FK_UserEvents_Events_EventsId",
                table: "UserEvents");

            migrationBuilder.DropForeignKey(
                name: "FK_UserEvents_Users_UsersId",
                table: "UserEvents");

            migrationBuilder.DropForeignKey(
                name: "FK_UserPreferences_Categories_CategoryId",
                table: "UserPreferences");

            migrationBuilder.DropForeignKey(
                name: "FK_UserPreferences_Users_UserId",
                table: "UserPreferences");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserPreferences",
                table: "UserPreferences");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserEvents",
                table: "UserEvents");

            migrationBuilder.DropPrimaryKey(
                name: "PK_EventCategories",
                table: "EventCategories");

            migrationBuilder.RenameTable(
                name: "UserPreferences",
                newName: "UserPreference");

            migrationBuilder.RenameTable(
                name: "UserEvents",
                newName: "UserEvent");

            migrationBuilder.RenameTable(
                name: "EventCategories",
                newName: "EventCategory");

            migrationBuilder.RenameIndex(
                name: "IX_UserPreferences_CategoryId",
                table: "UserPreference",
                newName: "IX_UserPreference_CategoryId");

            migrationBuilder.RenameIndex(
                name: "IX_UserEvents_UsersId",
                table: "UserEvent",
                newName: "IX_UserEvent_UsersId");

            migrationBuilder.RenameIndex(
                name: "IX_EventCategories_EventsId",
                table: "EventCategory",
                newName: "IX_EventCategory_EventsId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserPreference",
                table: "UserPreference",
                columns: new[] { "UserId", "CategoryId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserEvent",
                table: "UserEvent",
                columns: new[] { "EventsId", "UsersId" });

            migrationBuilder.AddPrimaryKey(
                name: "PK_EventCategory",
                table: "EventCategory",
                columns: new[] { "CategoriesId", "EventsId" });

            migrationBuilder.AddForeignKey(
                name: "FK_EventCategory_Categories_CategoriesId",
                table: "EventCategory",
                column: "CategoriesId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_EventCategory_Events_EventsId",
                table: "EventCategory",
                column: "EventsId",
                principalTable: "Events",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserEvent_Events_EventsId",
                table: "UserEvent",
                column: "EventsId",
                principalTable: "Events",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserEvent_Users_UsersId",
                table: "UserEvent",
                column: "UsersId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserPreference_Categories_CategoryId",
                table: "UserPreference",
                column: "CategoryId",
                principalTable: "Categories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserPreference_Users_UserId",
                table: "UserPreference",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
