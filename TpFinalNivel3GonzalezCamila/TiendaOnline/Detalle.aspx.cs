using Dominio;
using LogicaNegocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TiendaOnline
{
    public partial class Detalle : System.Web.UI.Page
    {
        private ArticuloDB datos = new ArticuloDB();
        public Articulo articulo;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Helper.tieneQueryString(this, "id"))
            {
                Response.Redirect("Default.aspx");
                return;
            }

            try
            {
                articulo = datos.ListarArticulos(int.Parse(Request.QueryString["id"]))[0];
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }
    }
}