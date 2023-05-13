using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace Project_Nusantara_Resto
{
    public partial class pesanan : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            // Mengecek apakah session sudah diset
            if (Session["nomor-meja"] == null && Session["nama-pemesan"] == null && Session["no-hp-pemesan"] == null && Session["orderCode"] == null)
            {
                Response.Redirect("index.aspx");
            }

        }
    }
}