using Dominio;
using LogicaNegocio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TiendaOnline
{
    public partial class _Default : Page
    {
        public List<Articulo> listaArt;
        private ArticuloDB datos = new ArticuloDB();
        public CaracteristicaDB caractDB = new CaracteristicaDB();
        public User user;
        public bool noRepetido = true;
        public bool favorito = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = (User)Session["Usuario"];
            try
            {
                if (Helper.tieneQueryString(this, "Busqueda"))
                {
                    string busqueda = Request.QueryString["Busqueda"];
                    listaArt = Helper.filtroRapido(busqueda);
                }

                if (!IsPostBack)
                    listaArt = datos.ListarArticulos();
                else if (Session["ListaFiltrada"] != null)
                    listaArt = (List<Articulo>)Session["ListaFiltrada"];
                else
                   listaArt = datos.ListarArticulos();
               
                repRepetidor.DataSource = listaArt;
                repRepetidor.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }            
        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            HelperFiltros.limpiarCampos(ddlCriterio, txtFiltro);

            try
            {
                HelperFiltros.responderIndexChanged(ddlCampo, ddlCriterio, txtFiltro);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            try
            {              
                listaArt = HelperFiltros.obtenerFiltrados(ddlCampo, ddlCriterio, txtFiltro);
                if(listaArt != null)
                    Session.Add("ListaFiltrada", listaArt);
                Page_Load(sender, e);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }          
        }

        protected void btnVerDetalle_Click(object sender, EventArgs e)
        {
            string valor = ((Button)sender).CommandArgument;
            string urlRuta = "Detalle.aspx?id=" + valor;
            Response.Redirect(urlRuta);
        }

        protected void btnFav_Click(object sender, EventArgs e)
        {
            
            favorito = true;
            string valor = ((Button)sender).CommandArgument;
            int id = int.Parse(valor);
            FavoritoDB datos = new FavoritoDB();
            noRepetido = datos.AgregarFavorito(id,user.Id);                      
        }
    }
}