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
    public partial class GestionMarcas : System.Web.UI.Page
    {
        public bool abrirModal = false;
        public int id = 0;
        private CaracteristicaDB datos = new CaracteristicaDB();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";
            if (!IsPostBack)
            {
                dgvCateg.DataSource = datos.ListarMarcas();
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
            dgvCateg.DataSource = datos.ListarMarcas();
            dgvCateg.PageIndex = e.NewPageIndex;
            dgvCateg.DataBind();
        }

        protected void dgvCateg_SelectedIndexChanged(object sender, EventArgs e)
        {
            abrirModal = true;
            id = (int)dgvCateg.SelectedDataKey.Value;
            txtID.Text = dgvCateg.SelectedDataKey.Value.ToString();
            Caracteristica marca = (Caracteristica)datos.ListarMarcas().Where(m => m.Id == id).FirstOrDefault();
            txtCateg.Text = marca.Descripcion;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string texto = txtCateg.Text;
            bool exito;

            if (texto == "")
                return;

            if (txtID.Text == "0")
            {
                exito = datos.agregarMarca(texto);
                id = 0;
            }
            else
            {
                id = int.Parse(txtID.Text);
                exito = datos.modificarMarca(texto, id);
            }


            if (exito)
            {
                lblError.Text = "";
                Response.Redirect("GestionMarcas.aspx");
            }
            else
            {
                lblError.Text = "Ya existe la marca " + txtCateg.Text; 
                abrirModal = true;
            }

        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionMarcas.aspx");
        }
    }
}