using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class AddOutletModel : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "1f29fb2c-5f6d-4006-a7b2-b1348da59b6d");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "d8079ddf-03f2-4a75-8297-ddef9e0e93c2");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "df58ccb1-a16b-4ca9-8eb6-7758ea2a139c");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "960b4cc3-8f99-4286-b038-759d3fab67fd", null, "Manager", "MANAGER" },
                    { "9f6a391b-1ae1-488c-9d4e-01eea6606562", null, "User", "USER" },
                    { "f9476c9a-c475-4694-b005-c27d4eede6cd", null, "Admin", "ADMIN" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "960b4cc3-8f99-4286-b038-759d3fab67fd");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9f6a391b-1ae1-488c-9d4e-01eea6606562");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "f9476c9a-c475-4694-b005-c27d4eede6cd");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "1f29fb2c-5f6d-4006-a7b2-b1348da59b6d", null, "Admin", "ADMIN" },
                    { "d8079ddf-03f2-4a75-8297-ddef9e0e93c2", null, "Manager", "MANAGER" },
                    { "df58ccb1-a16b-4ca9-8eb6-7758ea2a139c", null, "User", "USER" }
                });
        }
    }
}
