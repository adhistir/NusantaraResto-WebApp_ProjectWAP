using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Nusantara_Resto
{
    public partial class UpdateMenu2aspx : System.Web.UI.Page
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
                    string query = "SELECT * FROM menu WHERE menuCode = @menucode";
                    using (MySqlCommand command = new MySqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@menucode", menuCode);
                        using (MySqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtMenuCode.Text = reader["menuCode"].ToString();
                                txtCategoryCode.Text = reader["categoryCode"].ToString();
                                txtMenuName.Text = reader["menuName"].ToString();
                                txtMenuDesc.Text = reader["menuDesc"].ToString();
                                txtMenuStock.Text = reader["menuStock"].ToString();
                                //txtMenuImage.Text = reader["menuImage"].ToString();
                                txtMenuPrice.Text = reader["menuPrice"].ToString();
                                txtAdminCode.Text = reader["adminCode"].ToString();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the menucode from query string
                string menuCode = Request.QueryString["id"];

                // Update the menu data in database
                string connString = "Server=localhost;Database=nusantara_resto;Uid=root;Pwd=;";
                MySqlConnection connection = new MySqlConnection(connString);

                connection.Open();

                // Check if image is uploaded
                if (imageUpload.HasFile)
                {
                    string fileName = Path.GetFileName(imageUpload.PostedFile.FileName);
                    string fileExtension = Path.GetExtension(fileName).ToLower();
                    if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                    {
                        string filePath = Server.MapPath("~/image/" + fileName);
                        imageUpload.SaveAs(filePath);

                        // Read the uploaded image into a byte array
                        byte[] imageData = File.ReadAllBytes(filePath);

                        // Update the menu data including menuImage
                        string query = "UPDATE menu SET menuCode = @menuCode, categoryCode = @categoryCode, menuName = @menuName, menuDesc = @menuDesc, menuStock = @menuStock, menuPrice = @menuPrice, menuImage = @menuImage, adminCode = @adminCode WHERE menuCode = @menuCode";
                        MySqlCommand command = new MySqlCommand(query, connection);

                        // Add the byte array as the value of the @menuImage parameter
                        MySqlParameter menuImageParam = new MySqlParameter("@menuImage", MySqlDbType.MediumBlob);
                        menuImageParam.Value = imageData;
                        command.Parameters.Add(menuImageParam);

                        command.Parameters.AddWithValue("@menuCode", menuCode);
                        command.Parameters.AddWithValue("@categoryCode", txtCategoryCode.Text);
                        command.Parameters.AddWithValue("@menuName", txtMenuName.Text);
                        command.Parameters.AddWithValue("@menuDesc", txtMenuDesc.Text);
                        command.Parameters.AddWithValue("@menuStock", txtMenuStock.Text);
                        command.Parameters.AddWithValue("@menuPrice", txtMenuPrice.Text);
                        command.Parameters.AddWithValue("@adminCode", txtAdminCode.Text);

                        command.ExecuteNonQuery();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('File yang dibutuhkan adalah dengan format jpg/jpeg/png');", true);
                        return;
                    }
                }
                else
                {
                    // Update the menu data excluding menuImage
                    string query = "UPDATE menu SET menuCode = @menuCode, categoryCode = @categoryCode, menuName = @menuName, menuDesc = @menuDesc, menuStock = @menuStock, menuPrice = @menuPrice, adminCode = @adminCode WHERE menuCode = @menuCode";
                    MySqlCommand command = new MySqlCommand(query, connection);

                    command.Parameters.AddWithValue("@menuCode", menuCode);
                    command.Parameters.AddWithValue("@categoryCode", txtCategoryCode.Text);
                    command.Parameters.AddWithValue("@menuName", txtMenuName.Text);
                    command.Parameters.AddWithValue("@menuDesc", txtMenuDesc.Text);
                    command.Parameters.AddWithValue("@menuStock", txtMenuStock.Text);
                    command.Parameters.AddWithValue("@menuPrice", txtMenuPrice.Text);
                    command.Parameters.AddWithValue("@adminCode", txtAdminCode.Text);

                    command.ExecuteNonQuery();
                }

                // Redirect to the menu.aspx page with a success message
                Response.Redirect("menu.aspx?update=success!", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                // Tangani pengecualian
                Response.Redirect("menu.aspx?update=error&message=" + ex.Message, false);
                Context.ApplicationInstance.CompleteRequest();

            }

        }

     }

}
