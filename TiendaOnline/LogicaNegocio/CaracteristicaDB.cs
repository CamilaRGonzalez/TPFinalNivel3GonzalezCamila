using Dominio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class CaracteristicaDB
    {
        private AccesoDB datos;
        private string consulta;

        public CaracteristicaDB()
        {
            datos = new AccesoDB();
        }

        public List<Caracteristica> ListarMarcas()
        {
            List<Caracteristica> lista = new List<Caracteristica>();
            consulta = "select Id, Descripcion from MARCAS";

            Listar(consulta, lista);

            return lista;

        }

        public List<Caracteristica> ListarCategorias()
        {
            List<Caracteristica> lista = new List<Caracteristica>();
            consulta = "select Id, Descripcion from CATEGORIAS";

            Listar(consulta, lista);

            return lista;

        }

        private void Listar(string consulta, List<Caracteristica> caractLista)
        {
            try
            {
                datos.HacerConsulta(consulta);
                datos.LeerDB();

                llenarListaCaract(datos.Lector, caractLista);

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
        private void llenarListaCaract(SqlDataReader lector, List<Caracteristica> lista)
        {
            try
            {
                while (lector.Read())
                {
                    Caracteristica auxiliar = new Caracteristica();

                    auxiliar.Id = (int)datos.Lector["Id"];
                    auxiliar.Descripcion = (string)datos.Lector["Descripcion"];

                    lista.Add(auxiliar);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}
