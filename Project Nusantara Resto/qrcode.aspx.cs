using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing;
using ZXing.Common;
using ZXing.QrCode;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;

namespace Project_Nusantara_Resto
{
    public partial class qrcode : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Mengecek apakah session sudah diset
            if (Session["nomor-meja"] == null && Session["nama-pemesan"] == null && Session["no-hp-pemesan"] == null && Session["orderCode"] == null)
            {
                Response.Redirect("index.aspx");
            }
            else
            {
                //removesession
                Session.Remove("nomor-meja");
                Session.Remove("nama-pemesan");
                Session.Remove("no-hp-pemesan");
                Session.Remove("orderCode");
            }

        }
    }
}