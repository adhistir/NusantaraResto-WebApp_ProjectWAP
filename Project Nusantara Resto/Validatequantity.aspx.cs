using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Nusantara_Resto
{
    public partial class Validatequantity : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //validate quantity, insert to cart on database,validate if cart is empty return false
            try
            {
                string menuCode = Request.Form["menuCode"];
                int quantity = int.Parse(Request.Form["quantity"]);
                string connectionString = "server=localhost;database=nusantara_resto;uid=root;pwd=;";

                // Connect to MySQL database
                MySqlConnection connection = new MySqlConnection(connectionString);
                connection.Open();

                // Retrieve the stock quantity for the selected menu item
                MySqlCommand command = new MySqlCommand("SELECT menuStock FROM menu WHERE menuCode = @menuCode", connection);
                command.Parameters.AddWithValue("@menuCode", menuCode);
                int stock = (int)command.ExecuteScalar();

                // Check if the requested quantity is greater than the available stock
                if (quantity > stock)
                {
                    // Return error message
                    Response.Write("error");
                }
                else
                {

                    // Get the order code from session
                    string orderCode = Session["orderCode"].ToString();

                    // Insert the item into the database
                    MySqlCommand insertCommand = new MySqlCommand("INSERT INTO cart (orderCode, menuCode, Quantity) VALUES (@orderCode, @menuCode, @quantity)", connection);
                    insertCommand.Parameters.AddWithValue("@orderCode", orderCode);
                    insertCommand.Parameters.AddWithValue("@menuCode", menuCode);
                    insertCommand.Parameters.AddWithValue("@quantity", quantity);
                    insertCommand.ExecuteNonQuery();

                    Response.Write("success");



                }
                connection.Close();

                Response.End();

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
                
            }
        }

    }
}