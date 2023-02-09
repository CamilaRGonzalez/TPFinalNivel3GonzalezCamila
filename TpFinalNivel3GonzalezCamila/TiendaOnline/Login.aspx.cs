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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Helper.tieneQueryString(this, "Registro"))
                btnIngresar.Text = "Registrarse";

            if (Helper.tieneQueryString(this, "Success"))
            {
                if (Request.QueryString["Success"] == "true")
                    lblMensajeExito.Text = "Registrado con éxito! Ya puede loguearse";
                else
                    txtMensajeError.Text = "Ya existe una cuenta asociada al email";
            }

        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            UserDB datos = new UserDB();
            string email = txtEmail.Text;
            string pass = txtPass.Text;

            bool vacio = email == "" || pass == "";
            bool emailInvalido = !Validaciones.MailValido(email);

            if (vacio || emailInvalido)
                return;

            if (Helper.tieneQueryString(this, "Registro"))
            {
                bool registro = datos.RegistrarUsuario(email, pass);
                if (registro)
                    Response.Redirect("Login.aspx?Success=true");
                else
                    Response.Redirect("Login.aspx?Registro=true&Success=false");
            }
            else
            {
                User usuario = new User();
                usuario.email = email;
                usuario.pass = pass;

                bool login = datos.Login(usuario);
                if (!login)
                {
                    txtMensajeError.Text = "Usuario o contraseña incorrecta";
                }
                else
                {
                    Session.Add("Usuario", usuario);
                    Response.Redirect("Default.aspx");
                }
            }


        }
    }
}