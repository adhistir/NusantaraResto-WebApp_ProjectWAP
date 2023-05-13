using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Nusantara_Resto
{
    public partial class makeorder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                Session["nomor-meja"] = Request.Form["nomor-meja"];
                Session["nama-pemesan"] = Request.Form["nama-pemesan"];
                Session["no-hp-pemesan"] = Request.Form["no-hp-pemesan"];

                string connectionString = "server=localhost;user=root;password=;database=nusantara_resto;";
                MySqlConnection connection = new MySqlConnection(connectionString);
                connection.Open();

                string query = "INSERT INTO orders (deskNumber, customerName,phoneNumber) VALUES (@desknumber, @name,@phone)";
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@deskNumber", Session["nomor-meja"]);
                command.Parameters.AddWithValue("@name", Session["nama-pemesan"]);
                command.Parameters.AddWithValue("@phone", Session["no-hp-pemesan"]);
                command.ExecuteNonQuery();

                connection.Close();

                Response.Redirect("pesanan.aspx");
            
        }
    }
}