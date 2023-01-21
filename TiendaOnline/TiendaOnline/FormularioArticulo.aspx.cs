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
    public partial class FormularioArticulo : System.Web.UI.Page
    {
        public int idArticulo = 0;
        public Articulo articulo;
        private ArticuloDB datos = new ArticuloDB();
        public CaracteristicaDB caractDB = new CaracteristicaDB();
        protected void Page_Load(object sender, EventArgs e)
        {
            lblEliminar.CssClass = "d-none";
            btnEliminarDef.CssClass = "btn btn-danger btn-sm d-none";

            if (!IsPostBack) //para que no se vuelvan a cargar los ddl al hacer postback
            {
                HelperCaracteristica.llenarDDL(ddlMarca, "marca");
                HelperCaracteristica.llenarDDL(ddlCategoria, "categoria");
            }


            if (Helper.tieneQueryString(this, "id"))
            {
                idArticulo = int.Parse(Request.QueryString["id"]);
                articulo = datos.ListarArticulos(idArticulo)[0];

                if (IsPostBack) //para que no vuelva a cargar la info original al hacer postack (nunca se actualiza la info)
                    return;
                imgProducto.ImageUrl = articulo.UrlImg;
                txtNombre.Text = articulo.Nombre;
                txtDescripcion.Text = articulo.Descripcion;
                txtPrecio.Text = articulo.Precio.ToString();
                txtCodigo.Text = articulo.Codigo;
                txtIMG.Text = articulo.UrlImg;
                ddlCategoria.SelectedValue = articulo.Categoria.Id.ToString();
                ddlMarca.SelectedValue = articulo.Marca.Id.ToString();
            }
        }

        protected void txtIMG_TextChanged(object sender, EventArgs e)
        {
            string url = txtIMG.Text;
            imgProducto.ImageUrl = url;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            TextBox[] arr = new TextBox[] { txtCodigo, txtNombre, txtDescripcion, txtPrecio, txtIMG };

            bool precioInvalido = !Helper.DecimalValido(txtPrecio.Text);
            bool camposVacios = Helper.CamposVacios(arr);

            if (precioInvalido || camposVacios)
                return;

            Articulo art = new Articulo();
            art.Precio = Helper.parsearDecimal(txtPrecio.Text);
            art.Nombre = txtNombre.Text;
            art.Descripcion = txtDescripcion.Text;
            art.Codigo = txtCodigo.Text;
            art.UrlImg = txtIMG.Text;
            art.Categoria.Id = int.Parse(ddlCategoria.SelectedValue);
            art.Marca.Id = int.Parse(ddlMarca.SelectedValue);

            if (idArticulo == 0)
                datos.AgregarArticulo(art);
            else
            {
                art.Id = idArticulo;
                datos.ModificarArticulo(art);
            }
            Response.Redirect("GestionArticulos.aspx");
        }

        protected void btnEliminarDef_Click(object sender, EventArgs e)
        {
            datos.EliminarArticulo(articulo);
            Response.Redirect("GestionArticulos.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            lblEliminar.CssClass = "";
            btnEliminarDef.CssClass = "btn btn-danger btn-sm";
        }
    }
}