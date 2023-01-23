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
    public partial class Perfil : System.Web.UI.Page
    {
        private User usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (User)Session["Usuario"];
            if (usuario == null)
                return;

            if(!IsPostBack)
            {
                txtNombre.Text = usuario.nombre == null ? "" : usuario.nombre;
                txtApellido.Text = usuario.apellido == null ? "" : usuario.apellido;
                txtEmail.Text = usuario.email;
                imgPerfil.ImageUrl = usuario.urlImagenPerfil == null ? "~/Imagenes/sin-imagen.jpg" : "~/ImagenesPerfil/" + usuario.urlImagenPerfil;
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            TextBox[] arr = new TextBox[] { txtNombre, txtApellido };

            if (Helper.CamposVacios(arr))
                return;

            try
            {
                UserDB datos = new UserDB();

                if (inputFoto.PostedFile.FileName != "") //si el usuario sube una foto
                {
                    string ruta = Server.MapPath("./ImagenesPerfil/"); //mappath mapea toda la ruta hasta la carpeta actual
                    inputFoto.PostedFile.SaveAs(ruta + "Perfil-" + usuario.Id + ".jpg"); //se toma el archivo q subió el usuario y se guarda en la ruta con nombre dinámico según ID
                    usuario.urlImagenPerfil = "Perfil-" + usuario.Id + ".jpg";
                }
                
                usuario.nombre = txtNombre.Text;
                usuario.apellido = txtApellido.Text;

                datos.ActualizarDatos(usuario);

                if (usuario.urlImagenPerfil != null)
                {
                    Image img = (Image)Master.FindControl("imgAvatar");
                    img.ImageUrl = "~/ImagenesPerfil/" + usuario.urlImagenPerfil;
                    imgPerfil.ImageUrl = "~/ImagenesPerfil/" + usuario.urlImagenPerfil;
                    Page_Load(sender, e);

                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }

            
        }
    }
}