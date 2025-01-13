using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace backend.Migrations
{
    /// <inheritdoc />
    public partial class AddOutLetModelNew : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
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

            migrationBuilder.CreateTable(
                name: "Outlets",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    OutletName = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    OutletAddress = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    City = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Outlets", x => x.Id);
                });

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

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Outlets");

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
    }
}
