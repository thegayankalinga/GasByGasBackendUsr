using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class AddedNoOfAllowedCylinders : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "0c6c9195-c4f8-43a5-96e0-1e972ddfd3ea");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e1eb9999-61c2-4c9f-8fb0-f47bdb5d0686");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ea0f2f0e-7966-460d-8fcb-c27c2a4a2c1e");

            migrationBuilder.AddColumn<int>(
                name: "NoOfCylindersAllowed",
                table: "AspNetUsers",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "RemainingCylindersAllowed",
                table: "AspNetUsers",
                type: "int",
                nullable: true);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "384f39a6-60a7-4593-a98c-19c8381a5bbf", null, "Admin", "ADMIN" },
                    { "4180775f-c2b0-4d05-a5f2-87ff441fb54e", null, "User", "USER" },
                    { "8d2b499c-dc35-433f-ba77-ee353e4ebdf7", null, "Manager", "MANAGER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "384f39a6-60a7-4593-a98c-19c8381a5bbf");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "4180775f-c2b0-4d05-a5f2-87ff441fb54e");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "8d2b499c-dc35-433f-ba77-ee353e4ebdf7");

            migrationBuilder.DropColumn(
                name: "NoOfCylindersAllowed",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "RemainingCylindersAllowed",
                table: "AspNetUsers");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "0c6c9195-c4f8-43a5-96e0-1e972ddfd3ea", null, "Manager", "MANAGER" },
                    { "e1eb9999-61c2-4c9f-8fb0-f47bdb5d0686", null, "User", "USER" },
                    { "ea0f2f0e-7966-460d-8fcb-c27c2a4a2c1e", null, "Admin", "ADMIN" }
                });
        }
    }
}
