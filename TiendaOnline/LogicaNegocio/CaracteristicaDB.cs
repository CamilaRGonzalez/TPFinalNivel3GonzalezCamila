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

        public bool agregarMarca(string marca)
        {
            try
            {
                consulta = "if not exists (select * from MARCAS where Descripcion = @marca) begin insert into MARCAS (Descripcion) values (@marca) end";
                datos.HacerConsulta(consulta);
                datos.InsertarParametro("@marca", marca);
                return datos.EjecutarAccion() > 0;
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

        public bool modificarMarca(string marca, int id)
        {
            try
            {
                consulta = "if not exists (select * from MARCAS where Descripcion = @marca) begin update MARCAS set Descripcion = @marca where Id= @id end";
                datos.HacerConsulta(consulta);
                datos.InsertarParametro("@marca", marca);
                datos.InsertarParametro("@id", id);
                return datos.EjecutarAccion() > 0;
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

        public List<Caracteristica> ListarCategorias()
        {
            List<Caracteristica> lista = new List<Caracteristica>();
            consulta = "select Id, Descripcion from CATEGORIAS";

            Listar(consulta, lista);

            return lista;

        }
        public bool agregarCategoria(string categ)
        {
            try
            {
                consulta = "if not exists (select * from CATEGORIAS where Descripcion = @categ) begin insert into CATEGORIAS (Descripcion) values (@categ) end";
                datos.HacerConsulta(consulta);
                datos.InsertarParametro("@categ", categ);
                return datos.EjecutarAccion() > 0;
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

        public bool modificarCategoria(string categ, int id)
        {
            try
            {
                consulta = "if not exists (select * from CATEGORIAS where Descripcion = @categ) begin update CATEGORIAS set Descripcion = @categ where Id = @id end";
                datos.HacerConsulta(consulta);
                datos.InsertarParametro("@categ", categ);
                datos.InsertarParametro("@id", id);
                return datos.EjecutarAccion() > 0;
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
