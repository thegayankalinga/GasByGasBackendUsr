using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdatedTokenTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.RenameColumn(
                name: "IsEmpltyCylindersGivent",
                table: "GasTokens",
                newName: "IsEmptyCylinderGiven");

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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
                name: "IsEmptyCylinderGiven",
                table: "GasTokens",
                newName: "IsEmpltyCylindersGivent");

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
    }
}
