using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdatetoStockTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "4cb237b1-682a-49ac-b4db-59a818b1e9c3");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b27b7263-0f67-4de7-8a30-9764926b3ef7");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b9623ebd-a7b7-49b7-904c-63f8a4a6be61");

            migrationBuilder.AddColumn<int>(
                name: "NoOfUnitsDispatched",
                table: "StockRequests",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "NoOfUnitsRequired",
                table: "StockRequests",
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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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
                name: "NoOfUnitsDispatched",
                table: "StockRequests");

            migrationBuilder.DropColumn(
                name: "NoOfUnitsRequired",
                table: "StockRequests");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "4cb237b1-682a-49ac-b4db-59a818b1e9c3", null, "Manager", "MANAGER" },
                    { "b27b7263-0f67-4de7-8a30-9764926b3ef7", null, "User", "USER" },
                    { "b9623ebd-a7b7-49b7-904c-63f8a4a6be61", null, "Admin", "ADMIN" }
                });
        }
    }
}
