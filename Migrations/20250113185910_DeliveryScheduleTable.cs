using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class DeliveryScheduleTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "2d3521c7-b3cd-47c9-ad33-f3bf70edc19b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "739d4f64-100b-4275-b6cd-486d11deac52");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "82f41977-884b-40ae-89f4-a528b78add8a");

            migrationBuilder.CreateTable(
                name: "DeliverySchedules",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DeliveryDate = table.Column<DateOnly>(type: "date", nullable: false),
                    ConfirmedByAdmin = table.Column<bool>(type: "bit", nullable: false),
                    NoOfUnitsInDelivery = table.Column<int>(type: "int", nullable: false),
                    OutletId = table.Column<int>(type: "int", nullable: false),
                    DispatcherId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_DeliverySchedules", x => x.Id);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "1f7f73e0-eb34-444e-8b6b-c26825b0b8b2", null, "Manager", "MANAGER" },
                    { "6d77f750-e13a-43be-bf55-81e39b384b24", null, "Admin", "ADMIN" },
                    { "8d2b915c-1506-48ea-b64f-0c6125b7b540", null, "User", "USER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "DeliverySchedules");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "1f7f73e0-eb34-444e-8b6b-c26825b0b8b2");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "6d77f750-e13a-43be-bf55-81e39b384b24");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "8d2b915c-1506-48ea-b64f-0c6125b7b540");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "2d3521c7-b3cd-47c9-ad33-f3bf70edc19b", null, "Manager", "MANAGER" },
                    { "739d4f64-100b-4275-b6cd-486d11deac52", null, "User", "USER" },
                    { "82f41977-884b-40ae-89f4-a528b78add8a", null, "Admin", "ADMIN" }
                });
        }
    }
}
