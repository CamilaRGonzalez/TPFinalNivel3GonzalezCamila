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
    public partial class GestionArticulos : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!IsPostBack)
                {
                    ArticuloDB datos = new ArticuloDB();
                    dgvArticulos.DataSource = datos.ListarArticulos();
                    dgvArticulos.DataBind();
                }
                           
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }          
        }

        protected void dgvArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvArticulos.SelectedDataKey.Value.ToString();
            Response.Redirect("FormularioArticulo.aspx?id=" + id);
        }

        protected void dgvArticulos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ArticuloDB datos = new ArticuloDB();
            dgvArticulos.DataSource = datos.ListarArticulos();
            dgvArticulos.PageIndex = e.NewPageIndex;
            dgvArticulos.DataBind();
        }

        protected void btnNuevoArt_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormularioArticulo.aspx");
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
                List<Articulo> lista = HelperFiltros.obtenerFiltrados(ddlCampo, ddlCriterio, txtFiltro);
                if (lista != null)
                {
                    dgvArticulos.DataSource = lista;
                    dgvArticulos.DataBind();
                }                    
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
            }
            
        }
    }
}