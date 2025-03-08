using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdatedDeliverySchedule : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "7018b219-3ec0-4340-bcad-d3b41208b3e6");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "cc0cd097-227e-4af6-a358-744359127b10");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "d9a0be8f-d4fa-4b51-9d6d-fc4ff3412eee");

            migrationBuilder.DropColumn(
                name: "DispatcherId",
                table: "DeliverySchedules");

            migrationBuilder.AddColumn<string>(
                name: "DispatcherVehicleId",
                table: "DeliverySchedules",
                type: "nvarchar(30)",
                maxLength: 30,
                nullable: false,
                defaultValue: "");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "06615676-4523-47b4-b99f-3885e0fd2ec1", null, "Manager", "MANAGER" },
                    { "b5c4019e-b2e6-44ec-9e75-c71174b58df1", null, "Admin", "ADMIN" },
                    { "c93eaa5c-cb91-4db6-bbaa-d1b33aff0fde", null, "User", "USER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "06615676-4523-47b4-b99f-3885e0fd2ec1");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b5c4019e-b2e6-44ec-9e75-c71174b58df1");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "c93eaa5c-cb91-4db6-bbaa-d1b33aff0fde");

            migrationBuilder.DropColumn(
                name: "DispatcherVehicleId",
                table: "DeliverySchedules");

            migrationBuilder.AddColumn<int>(
                name: "DispatcherId",
                table: "DeliverySchedules",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "7018b219-3ec0-4340-bcad-d3b41208b3e6", null, "Manager", "MANAGER" },
                    { "cc0cd097-227e-4af6-a358-744359127b10", null, "User", "USER" },
                    { "d9a0be8f-d4fa-4b51-9d6d-fc4ff3412eee", null, "Admin", "ADMIN" }
                });
        }
    }
}
