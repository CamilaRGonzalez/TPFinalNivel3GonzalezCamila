using Dominio;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LogicaNegocio
{
    public class Helper
    {
        static public bool tieneQueryString(Page pagina, string queryString)
        {
            if (pagina.Request.QueryString[queryString] != null)
                return true;
            else
                return false;
        }

        static public List<Articulo> filtroRapido(string busqueda)
        {
            List<Articulo> lista = new ArticuloDB().ListarArticulos();
            string clave = busqueda.ToLower();

            lista = lista.FindAll(art => art.Nombre.ToLower().Contains(clave) || art.Descripcion.ToLower().Contains(clave) || art.Marca.Descripcion.ToLower().Contains(clave));

            return lista;
        }

        static public void llenarDdlPrecio(DropDownList ddl)
        {
            ddl.Items.Add("Menor a");
            ddl.Items.Add("Igual a");
            ddl.Items.Add("Mayor a");
        }

        static public char devolverOperador(string criterio)
        {
            if (criterio == "Menor a")
                return '<';
            else if (criterio == "Mayor a")
                return '>';
            else
                return '=';
        }

        public static bool DecimalValido(string numero)
        {
            return Regex.IsMatch(numero, @"^[0-9]*\.?[0-9]+$") || Regex.IsMatch(numero, @"^[0-9]*\,?[0-9]+$");
        }

        public static bool esConComa(string numero)
        {
            return Regex.IsMatch(numero, @"^[0-9]*\,?[0-9]+$");
        }

        public static decimal parsearDecimal(string numero)
        {
            NumberStyles style = NumberStyles.Any;
            CultureInfo culture;
            decimal numDecimal;

            if (esConComa(numero))
            {
                culture = CultureInfo.CreateSpecificCulture("es-ES");
                Decimal.TryParse(numero, style, culture, out numDecimal);
                return numDecimal;
            }
            else
            {
                culture = CultureInfo.InvariantCulture;
                Decimal.TryParse(numero, style, culture, out numDecimal);
                return numDecimal;
            }
        }

        public static bool CamposVacios(TextBox[] arr)
        {
            foreach (TextBox txt in arr)
            {
                if (txt.Text == "")
                    return true;
            }
            return false;
        }
    }
}
