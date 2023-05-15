using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Project_Nusantara_Resto.admin
{
    public partial class CreateMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get admin code from session

                if (Session["adminCode"] == null)
                {
                    Response.Redirect("~/LoginAdmin.aspx?pesan=belum_login");
                }

            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            try { 
                string connString = "Server=localhost;Database=nusantara_resto;Uid=root;Pwd=;";
                MySqlConnection connection = new MySqlConnection(connString);

                
                    connection.Open();
                    string query = "INSERT INTO menu (categoryCode, menuName, menuDesc, menuStock, menuImage, menuPrice, adminCode) VALUES ( @categoryCode, @menuName, @menuDesc, @menuStock, @menuImage, @menuPrice, @adminCode)";
                    string selectedValue = ddlCategoryCode.Value;
                     MySqlCommand command = new MySqlCommand(query, connection);
                    
                        command.Parameters.AddWithValue("@categoryCode", selectedValue);
                        command.Parameters.AddWithValue("@menuName", txtMenuName.Text);
                        command.Parameters.AddWithValue("@menuDesc", txtMenuDesc.Text);

                        command.Parameters.AddWithValue("@menuStock", Convert.ToInt32(txtMenuStock.Text));
                        command.Parameters.AddWithValue("@menuPrice", Convert.ToDecimal(txtMenuPrice.Text));
                        command.Parameters.AddWithValue("@adminCode", Session["adminCode"].ToString());



                        // Upload the image file
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

                                // Add the byte array as the value of the @menuImage parameter
                                MySqlParameter menuImageParam = new MySqlParameter("@menuImage", MySqlDbType.MediumBlob);
                                menuImageParam.Value = imageData;
                                command.Parameters.Add(menuImageParam);

                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('File yg dibutuhkan adalah dengan format jpg/jpeg/png');", true);
                                return;
                            }
                        }
                        command.ExecuteNonQuery();
                // Redirect to the menu.aspx page with a success message
                Response.Redirect("menu.aspx?create=success!", false);
                Context.ApplicationInstance.CompleteRequest();

            }
            catch (Exception ex)
            {
                // Tangani pengecualian
                Response.Redirect("menu.aspx?create=error&message=" + ex.Message, false);
                Context.ApplicationInstance.CompleteRequest();

            }
        }
        }
}