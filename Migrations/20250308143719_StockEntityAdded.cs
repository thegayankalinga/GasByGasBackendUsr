using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class StockEntityAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.CreateTable(
                name: "StockRequests",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OutletId = table.Column<int>(type: "int", nullable: false),
                    RequestedDate = table.Column<DateOnly>(type: "date", nullable: false),
                    CompletedDate = table.Column<DateOnly>(type: "date", nullable: true),
                    Completed = table.Column<bool>(type: "bit", nullable: false),
                    DeliveryScheduleId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StockRequests", x => x.Id);
                });

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StockRequests");

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
    }
}
