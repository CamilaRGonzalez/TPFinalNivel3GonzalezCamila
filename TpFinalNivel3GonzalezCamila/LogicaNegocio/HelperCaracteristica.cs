using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace LogicaNegocio
{
    public class HelperCaracteristica
    {
        public static void llenarDDL(DropDownList ddl, string tipo)
        {
            CaracteristicaDB datos = new CaracteristicaDB();

            if (tipo == "marca")
                ddl.DataSource = datos.ListarMarcas();
            else
                ddl.DataSource = datos.ListarCategorias();

            ddl.DataValueField = "Id";
            ddl.DataTextField = "Descripcion";
            ddl.DataBind();
        }
    }
}
