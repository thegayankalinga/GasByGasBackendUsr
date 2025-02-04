using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class UpdatetoAppUser : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.RenameColumn(
                name: "ConsumerType",
                table: "GasTokens",
                newName: "UserType");

            migrationBuilder.AddColumn<string>(
                name: "BusinessRegistration",
                table: "AspNetUsers",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsConfirm",
                table: "AspNetUsers",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "4bb70bc9-f133-42d7-85be-5e87c51de6ae", null, "User", "USER" },
                    { "5d58f097-58f4-458f-9414-c2a6aeb4003b", null, "Admin", "ADMIN" },
                    { "72844301-5004-4628-890d-9244fa90fba0", null, "Manager", "MANAGER" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "4bb70bc9-f133-42d7-85be-5e87c51de6ae");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5d58f097-58f4-458f-9414-c2a6aeb4003b");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "72844301-5004-4628-890d-9244fa90fba0");

            migrationBuilder.DropColumn(
                name: "BusinessRegistration",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "IsConfirm",
                table: "AspNetUsers");

            migrationBuilder.RenameColumn(
                name: "UserType",
                table: "GasTokens",
                newName: "ConsumerType");

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
    }
}
