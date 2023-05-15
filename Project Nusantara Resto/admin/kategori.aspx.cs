using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_Nusantara_Resto
{
    public partial class kategori : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["adminCode"] == null)
                {
                    Response.Redirect("~/LoginAdmin.aspx?pesan=belum_login");
                }
            }
        }
    }
}