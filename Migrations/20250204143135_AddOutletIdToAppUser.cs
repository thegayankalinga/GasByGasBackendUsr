using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class AddOutletIdToAppUser : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "4bb70bc9-f133-42d7-85be-5e87c51de6ae");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5d58f097-58f4-458f-9414-c2a6aeb4003b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "72844301-5004-4628-890d-9244fa90fba0");

            migrationBuilder.AddColumn<int>(
                name: "OutletId",
                table: "AspNetUsers",
                type: "int",
                nullable: true);

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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

            migrationBuilder.DropColumn(
                name: "OutletId",
                table: "AspNetUsers");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "4bb70bc9-f133-42d7-85be-5e87c51de6ae", null, "User", "USER" },
                    { "5d58f097-58f4-458f-9414-c2a6aeb4003b", null, "Admin", "ADMIN" },
                    { "72844301-5004-4628-890d-9244fa90fba0", null, "Manager", "MANAGER" }
                });
        }
    }
}
