using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class AccesoDB
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public AccesoDB()
        {
            string cadena = ConfigurationManager.AppSettings["cadenaConexion"];
            conexion = new SqlConnection(cadena);
            comando = new SqlCommand();
        }

        public SqlDataReader Lector //getter para usar al lector en otras clases que requieran leer datos desde DB
        {
            get
            {
                return lector;
            }
        }

        public void HacerConsulta(string query)
        {
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = query;
        }

        public void LeerDB()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                lector = comando.ExecuteReader();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int EjecutarAccion()
        {
            comando.Connection = conexion;
            try
            {
                conexion.Open();
                return comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void CerrarConexion()
        {
            if (lector != null)
                lector.Close();
            conexion.Close();
        }

        public void InsertarParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor);
        }
    }
}
