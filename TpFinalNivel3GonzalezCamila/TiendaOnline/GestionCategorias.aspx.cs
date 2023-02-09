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
    public partial class GestionCategorias : System.Web.UI.Page
    {
        public bool abrirModal = false;
        public int id = 0;
        private CaracteristicaDB datos = new CaracteristicaDB();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";
            if (!IsPostBack)
            {   
                dgvCateg.DataSource = datos.ListarCategorias();
                dgvCateg.DataBind();
            }
        }

        protected void btnNuevaCateg_Click(object sender, EventArgs e)
        {
            abrirModal = true;
            txtID.Text = "0";
            txtCateg.Text = "";
        }

        protected void dgvCateg_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvCateg.DataSource = datos.ListarCategorias();
            dgvCateg.PageIndex = e.NewPageIndex;
            dgvCateg.DataBind();
        }

        protected void dgvCateg_SelectedIndexChanged(object sender, EventArgs e)
        {
            abrirModal = true;
            id = (int)dgvCateg.SelectedDataKey.Value;
            txtID.Text = dgvCateg.SelectedDataKey.Value.ToString(); 
            Caracteristica categoria = (Caracteristica)datos.ListarCategorias().Where(c => c.Id == id).FirstOrDefault();
            txtCateg.Text = categoria.Descripcion;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string texto = txtCateg.Text;
            bool exito;
            
            if (texto == "")
                return;

            if (txtID.Text == "0")
            {
                exito = datos.agregarCategoria(texto);
                id = 0;
            }              
            else
            {
                id = int.Parse(txtID.Text);
                exito = datos.modificarCategoria(texto, id);
            }


            if (exito)
            {
                lblError.Text = "";
                Response.Redirect("GestionCategorias.aspx");
            }
            else
            {
                lblError.Text = "Ya existe la categoría " + txtCateg.Text;
                abrirModal = true;
            }
                
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionCategorias.aspx");
        }
    }
}