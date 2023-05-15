using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web;
using System.Web.UI;

namespace Project_Nusantara_Resto
{
    public partial class getDataMakanan : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Ambil kategori dari parameter POST
            string kategori = Request.Params["kategori"];

            // Buat koneksi ke database
            string connectionString = "server=localhost;database=nusantara_resto;uid=root;pwd=;";
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                // Buat query untuk mengambil data makanan sesuai kategori
                string query = "SELECT menu.menuCode, menu.menuName,menu.menuDesc,menu.menuStock,menu.menuImage,menu.menuPrice FROM menu JOIN category on category.categoryCode=menu.categoryCode WHERE category.categoryName=@kategori AND menu.menuStock >1";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@kategori", kategori);

                // Buka koneksi dan jalankan query
                conn.Open();
                MySqlDataReader reader = cmd.ExecuteReader();

                // Buat string builder untuk menampung data makanan
                System.Text.StringBuilder sb = new System.Text.StringBuilder();

                // Looping untuk membaca hasil query dan menambahkannya ke string builder
                while (reader.Read())
                {
                    string menuCode = reader["menuCode"].ToString();
                    string namaMakanan = reader["menuName"].ToString();
                    string hargaMakanan = ((decimal)reader["menuPrice"]).ToString("N0");
                    string deskripsiMakanan = reader["menuDesc"].ToString();
                    byte[] imageData = (byte[])reader["menuImage"];
                    string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                    string imageUrl = "data:image/png;base64," + base64String;

                    sb.Append("<div class=\"col-lg-3 col-md-4 col-sm-6 mb-4\">" +
                        "<div class=\"card h-100\">" +
                        "<img class=\"card-img-top\" src=\"" + imageUrl + "\" alt=\"Card image cap\">" +
                        "<div class=\"card-body d-flex flex-column\">" +
                        "<h5 class=\"card-title\">" + namaMakanan + "</h5>" +
                        "<p class=\"card-text\">" + deskripsiMakanan + "</p>" +
                        "<div class=\"mt-auto\">" +
                        "<p class=\"card-price fs-5\">Rp. " + hargaMakanan + "</p>" +
                        "</div>" +
                        "<button type=\"button\" class=\"btn btn-sm card-button ms-auto\" data-bs-toggle=\"modal\" " +
                        "data-bs-target=\"#addToCartModal" + menuCode + "\"><i class=\"fa-solid fa-cart-shopping\"></i> Tambahkan</button>" +
                        "</div>" +
                        "</div>" +
                        "</div>"); 
                }


                // Tutup koneksi dan reader
                reader.Close();
                conn.Close();

                // Tampilkan hasil query pada konten-makanan
                Response.Write(sb.ToString());
            }
        }
    }
}
