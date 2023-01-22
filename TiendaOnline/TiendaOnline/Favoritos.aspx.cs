using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using LogicaNegocio;

namespace TiendaOnline
{
    public partial class Favoritos : System.Web.UI.Page
    {
        private User usuario;
        private FavoritoDB datos = new FavoritoDB();
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (User)Session["Usuario"];
            if (usuario == null)
                return;
            repRepetidor.DataSource = datos.listarFavoritos(usuario.Id);
            repRepetidor.DataBind();
        }

        protected void btnUnfav_Click(object sender, EventArgs e)
        {
            string valor = ((Button)sender).CommandArgument;
            int id = int.Parse(valor);
            datos.EliminarFavorito(id,usuario.Id);
            repRepetidor.DataSource = datos.listarFavoritos(usuario.Id);
            repRepetidor.DataBind();
        }
    }
}