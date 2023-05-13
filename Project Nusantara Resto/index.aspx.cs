using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Nusantara_Resto
{
    public partial class index : System.Web.UI.Page
    {
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            //ketika button pesan diklik akan menjalankan button ini

                Session["nomor-meja"] = Request.Form["nomor-meja"];
                Session["nama-pemesan"] = Request.Form["nama-pemesan"];
                Session["no-hp-pemesan"] = Request.Form["no-hp-pemesan"];
                Session["orderCode"] = "";

                string connectionString = "server=localhost;user=root;password=;database=nusantara_resto;";
                MySqlConnection connection = new MySqlConnection(connectionString);
                connection.Open();

                string query = "INSERT INTO orders (deskNumber, customerName,phoneNumber) VALUES (@desknumber, @name,@phone)";
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@deskNumber", Session["nomor-meja"]);
                command.Parameters.AddWithValue("@name", Session["nama-pemesan"]);
                command.Parameters.AddWithValue("@phone", Session["no-hp-pemesan"]);
                command.ExecuteNonQuery();


            string query1 = "SELECT orderCode from orders where customerName = @name AND phoneNumber = @phone order by orderCode Desc limit 1";
            MySqlCommand command1 = new MySqlCommand(query1, connection);
            command1.Parameters.AddWithValue("@name", Session["nama-pemesan"]);
            command1.Parameters.AddWithValue("@phone", Session["no-hp-pemesan"]);
            MySqlDataReader reader = command1.ExecuteReader();
            while (reader.Read())
            {
                Session["orderCode"] = reader["orderCode"].ToString();
            }

            connection.Close();

                Response.Redirect("pesanan.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        }
    }