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
    public partial class SiteMaster : MasterPage
    {
        public bool sesionActiva = false;
        public User usuario;
        public string nombreUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            sesionActiva = Validaciones.sesionActiva(Session["Usuario"]);
            
            if (sesionActiva)
            {
                usuario = (User)Session["Usuario"];

                nombreUsuario = usuario.nombre == null ? "Usuario" : usuario.nombre;

                imgAvatar.ImageUrl = usuario.urlImagenPerfil == null ? "~/Imagenes/usuario-avatar.jpg" : "~/ImagenesPerfil/" + usuario.urlImagenPerfil;

                if (sesionActiva && usuario.admin && (Page is Favoritos))
                {
                    Response.Redirect("Default.aspx");
                }
                else if (sesionActiva && !usuario.admin && (Page is GestionArticulos || Page is FormularioArticulo))
                {
                    Response.Redirect("Default.aspx");
                }
            }

            if (!(Page is Login) && !sesionActiva)
                Response.Redirect("Login.aspx");
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string busqueda = txtBuscar.Text;
            Response.Redirect("Default.aspx?Busqueda=" + busqueda);
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Remove("Usuario");
            Response.Redirect("Login.aspx");
        }
    }
}