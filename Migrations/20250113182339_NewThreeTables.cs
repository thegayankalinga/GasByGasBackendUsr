using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class NewThreeTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "0e00c40f-9e8d-4007-ad72-7b550f12657c");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "a5d7ebe6-f619-4fb3-b21f-220e160fd46b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ebc90de7-6d69-4cbd-84b3-e98d7fcb3cbe");

            migrationBuilder.AddColumn<int>(
                name: "Stock",
                table: "Outlets",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "GasTokens",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RequestDate = table.Column<DateOnly>(type: "date", nullable: false),
                    ReadyDate = table.Column<DateOnly>(type: "date", nullable: true),
                    ExpectedPickupDate = table.Column<DateOnly>(type: "date", nullable: false),
                    Status = table.Column<int>(type: "int", nullable: false),
                    ConsumerType = table.Column<int>(type: "int", nullable: false),
                    IsEmpltyCylindersGivent = table.Column<bool>(type: "bit", nullable: false),
                    Price = table.Column<decimal>(type: "decimal(18,2)", precision: 18, scale: 2, nullable: true),
                    IsPaid = table.Column<bool>(type: "bit", nullable: false),
                    PaymentDate = table.Column<DateOnly>(type: "date", nullable: true),
                    UserEmail = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    OutletId = table.Column<int>(type: "int", nullable: false),
                    DeliveryScheduleId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GasTokens", x => x.Id);
                });

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "GasTokens");

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

            migrationBuilder.DropColumn(
                name: "Stock",
                table: "Outlets");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "0e00c40f-9e8d-4007-ad72-7b550f12657c", null, "Manager", "MANAGER" },
                    { "a5d7ebe6-f619-4fb3-b21f-220e160fd46b", null, "User", "USER" },
                    { "ebc90de7-6d69-4cbd-84b3-e98d7fcb3cbe", null, "Admin", "ADMIN" }
                });
        }
    }
}
