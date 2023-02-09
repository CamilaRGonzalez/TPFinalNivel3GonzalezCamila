using Dominio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace LogicaNegocio
{
    public class HelperFiltros
    {
        public static void limpiarCampos(DropDownList criterio, TextBox filtro)
        {
            filtro.Text = "";
            criterio.Items.Clear();
            criterio.Enabled = true;
            filtro.Enabled = true;
        }

        public static void responderIndexChanged(DropDownList campo, DropDownList criterio, TextBox filtro)
        {
            string value = campo.SelectedValue;

            if (value == "Precio")
                Helper.llenarDdlPrecio(criterio);
            else if (value == "Nombre")
                criterio.Enabled = false;
            else if (value == "Todos")
            {
                criterio.Enabled = false;
                filtro.Enabled = false;
            }               
            else if (value == "M.Descripcion")
            {
                HelperCaracteristica.llenarDDL(criterio, "marca");
                filtro.Enabled = false;
            }
            else
            {
                HelperCaracteristica.llenarDDL(criterio, "categoria");
                filtro.Enabled = false;
            }
        }

        public static List<Articulo> obtenerFiltrados(DropDownList campo, DropDownList criterio, TextBox txtfiltro)
        {
            string value = campo.SelectedValue;
            string filtro;
            ArticuloDB datos = new ArticuloDB();
            List<Articulo> listaArt;

            if (value == "Precio")
            {
                filtro = txtfiltro.Text;
                if (!(Helper.DecimalValido(filtro)) || filtro == "")
                {
                    return null;
                }
                decimal num = Helper.parsearDecimal(filtro);
                filtro = num.ToString(CultureInfo.CreateSpecificCulture("en-US"));
                char operador = Helper.devolverOperador(criterio.SelectedItem.ToString());
                listaArt = datos.FiltrarPrecio(operador, filtro);
            }
            else if (value == "Todos") 
            {
                listaArt = datos.ListarArticulos();
            }
            else if (value == "Nombre")
            {
                filtro = txtfiltro.Text;
                if (filtro == "")
                    return null;
                listaArt = datos.FiltrarFrase(filtro, value);
            }
            else
            {
                filtro = criterio.SelectedItem.ToString();
                listaArt = datos.FiltrarFrase(filtro, value);
            }

            return listaArt;
        }
    }
}
