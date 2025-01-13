using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class RemoveDuplicatedPhoneNumber : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "8bbf833d-6a1f-40cd-860b-62d22d021280");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "e9b76995-d01d-4bf9-a51d-bf90e0b62c26");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ee4f1de1-1373-4053-9965-a7c4d9ec1642");

            migrationBuilder.AlterColumn<string>(
                name: "PhoneNumber",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(15)",
                oldMaxLength: 15,
                oldNullable: true);

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
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

            migrationBuilder.AlterColumn<string>(
                name: "PhoneNumber",
                table: "AspNetUsers",
                type: "nvarchar(15)",
                maxLength: 15,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "8bbf833d-6a1f-40cd-860b-62d22d021280", null, "User", "USER" },
                    { "e9b76995-d01d-4bf9-a51d-bf90e0b62c26", null, "Manager", "MANAGER" },
                    { "ee4f1de1-1373-4053-9965-a7c4d9ec1642", null, "Admin", "ADMIN" }
                });
        }
    }
}
