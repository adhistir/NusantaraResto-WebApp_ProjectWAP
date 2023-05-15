using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Nusantara_Resto
{
    public partial class DeleteMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the menucode from query string
                string menuCode = Request.QueryString["id"];
                // Retrieve the menu data from database
                string connString = "Server=localhost;Database=nusantara_resto;Uid=root;Pwd=;";
                using (MySqlConnection connection = new MySqlConnection(connString))
                {
                    connection.Open();
                    string query = "SELECT * FROM menu WHERE menuCode = @menuCode";
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@menuCode", menuCode);
                        using (MySqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtMenuCode.Text = reader["menuCode"].ToString();
                                txtCategoryCode.Text = reader["categoryCode"].ToString();
                                txtMenuName.Text = reader["menuName"].ToString();
                                txtMenuDesc.Text = reader["menuDesc"].ToString();
                                txtMenuStock.Text = reader["menuStock"].ToString();
                                txtMenuPrice.Text = reader["menuPrice"].ToString();
                                txtAdminCode.Text = reader["adminCode"].ToString();

                                // Get image as Base64 string
                                byte[] bytes = (byte[])reader["menuImage"];
                                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);

                                // Set Base64 string to variable
                                string imageBase64String = "data:image/jpeg;base64," + base64String;
                                imgMenu.ImageUrl = imageBase64String;
                            }
                            else
                            {
                                Response.Redirect("menu.aspx");


                            }
                        }
                    }
                }

                // Get admin code from session

                if (Session["adminCode"] == null)
                {
                    Response.Redirect("~/LoginAdmin.aspx?pesan=belum_login");
                }
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // Get the menucode from query string
            string menuCode = Request.QueryString["id"];

            // Delete the menu data in database
            string connString = "Server=localhost;Database=nusantara_resto;Uid=root;Pwd=;";
            using (MySqlConnection connection = new MySqlConnection(connString))
            {
                connection.Open();
                string query = "DELETE FROM menu WHERE menucode = @menucode";
                using (MySqlCommand command = new MySqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@menucode", menuCode);
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        // Redirect to the menu.aspx page with a success message
                        Response.Redirect("menu.aspx?delete=success!");
                    }
                    else
                    {
                        // Redirect to the menu.aspx page with an error message
                        Response.Redirect("menu.aspx?delete=error");
                    }
                }
            }
        }
    }
}

