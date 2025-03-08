using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class NICtoNic : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "123a58ff-84dd-4aa2-9645-957343d7a7bd");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "6708d8e7-89c1-463b-a61d-ffa095fcc718");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "77f49f7f-84d6-47d4-8c9d-58f7968e36bd");

            migrationBuilder.RenameColumn(
                name: "NIC",
                table: "AspNetUsers",
                newName: "Nic");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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

            migrationBuilder.RenameColumn(
                name: "Nic",
                table: "AspNetUsers",
                newName: "NIC");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "123a58ff-84dd-4aa2-9645-957343d7a7bd", null, "Admin", "ADMIN" },
                    { "6708d8e7-89c1-463b-a61d-ffa095fcc718", null, "Manager", "MANAGER" },
                    { "77f49f7f-84d6-47d4-8c9d-58f7968e36bd", null, "User", "USER" }
                });
        }
    }
}
