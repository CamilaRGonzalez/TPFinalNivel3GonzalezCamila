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
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Helper.tieneQueryString(this, "Busqueda"))
                {
                    string busqueda = Request.QueryString["Busqueda"];
                    listaArt = Helper.filtroRapido(busqueda);
                }
                else
                    listaArt = datos.ListarArticulos();
            }                 
            else
            {
                if(Session["ListaFiltrada"] != null)
                {
                    listaArt = (List<Articulo>)Session["ListaFiltrada"];
                }
                else
                    listaArt = datos.ListarArticulos();
            }
                
            repRepetidor.DataSource = listaArt;
            repRepetidor.DataBind();
            
        }

        protected void ddlCampo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string value = ddlCampo.SelectedValue;
            txtFiltro.Text = "";
            ddlCriterio.Items.Clear();
            ddlCriterio.Enabled = true;
            txtFiltro.Enabled = true;

            if (value == "Precio")
                Helper.llenarDdlPrecio(ddlCriterio);
            else if (value == "Nombre")
                ddlCriterio.Enabled = false;
            else if (value == "M.Descripcion")
            {
                HelperCaracteristica.llenarDDL(ddlCriterio, "marca");
                txtFiltro.Enabled = false;
            }
            else
            {
                HelperCaracteristica.llenarDDL(ddlCriterio, "categoria");
            }

        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            string value = ddlCampo.SelectedValue;
            string filtro;

            if (value == "Precio")
            {
                filtro = txtFiltro.Text;
                if (!(Helper.DecimalValido(filtro)) || filtro == "")
                    return;

                decimal num = Helper.parsearDecimal(filtro);
                filtro = num.ToString(CultureInfo.CreateSpecificCulture("en-US"));
                char operador = Helper.devolverOperador(ddlCriterio.SelectedItem.ToString());
                listaArt = datos.FiltrarPrecio(operador, filtro);
            }
            else if (value == "Todos")
            {
                listaArt = datos.ListarArticulos();
            }
            else if (value == "Nombre")
            {
                filtro = txtFiltro.Text;
                if (filtro == "")
                    return;
                listaArt = datos.FiltrarFrase(filtro, value);
            }
            else
            {
                filtro = ddlCriterio.SelectedItem.ToString();
                listaArt = datos.FiltrarFrase(filtro, value);
            }

            Session.Add("ListaFiltrada", listaArt);
            Page_Load(sender, e);
        }

        protected void btnVerDetalle_Click(object sender, EventArgs e)
        {
            string valor = ((Button)sender).CommandArgument;
            string urlRuta = "Detalle.aspx?id=" + valor;
            Response.Redirect(urlRuta);
        }
    }
}