using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class NonOptionalStockRequest : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "b2607431-9f19-4ab8-8720-cf1f37f6793d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e0fbe266-9fff-4792-af96-a683082888f6");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ead770bc-87b2-48a6-8195-4dc3abd1bdc7");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "02d4ebef-da3e-484f-a871-50fa9fdfde7e", null, "Manager", "MANAGER" },
                    { "52d8788e-cbb9-4e1a-9032-86a7a629ceea", null, "Admin", "ADMIN" },
                    { "d8b5632e-225c-4cd7-92ac-89755e90d202", null, "User", "USER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "02d4ebef-da3e-484f-a871-50fa9fdfde7e");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "52d8788e-cbb9-4e1a-9032-86a7a629ceea");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "d8b5632e-225c-4cd7-92ac-89755e90d202");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "b2607431-9f19-4ab8-8720-cf1f37f6793d", null, "Manager", "MANAGER" },
                    { "e0fbe266-9fff-4792-af96-a683082888f6", null, "Admin", "ADMIN" },
                    { "ead770bc-87b2-48a6-8195-4dc3abd1bdc7", null, "User", "USER" }
                });
        }
    }
}
