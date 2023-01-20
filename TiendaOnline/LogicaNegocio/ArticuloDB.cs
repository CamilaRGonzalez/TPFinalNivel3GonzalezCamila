using Dominio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class ArticuloDB
    {
        private AccesoDB datos;
        private string consulta;

        public ArticuloDB()
        {
            datos = new AccesoDB();
        }

        public List<Articulo> ListarArticulos(int id = 0)
        {
            List<Articulo> articulosLista = new List<Articulo>();

            consulta = "select A.Id,A.Codigo,A.Nombre, A.Descripcion,A.ImagenUrl,A.Precio, M.Descripcion Marca,C.Descripcion Categoria,A.IdCategoria, A.IdMarca from ARTICULOS A, CATEGORIAS C, MARCAS M where A.IdMarca = M.Id and A.IdCategoria = C.Id";

            if (id != 0)
                consulta += " and A.Id = " + id.ToString();

            try
            {
                listarDB(consulta, articulosLista);
                return articulosLista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public void AgregarArticulo(Articulo art)
        {
            consulta = "insert into ARTICULOS (Codigo,Nombre,Descripcion,IdMarca,IdCategoria,ImagenUrl,Precio) values(@cod,@nombre,@desc,@idMarca,@idCateg,@url,@precio)";
            try
            {
                AccionContraDB(consulta, art);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public void ModificarArticulo(Articulo art)
        {
            consulta = "update articulos set Codigo = @cod, Nombre = @nombre, Descripcion = @desc,IdMarca = @idMarca,IdCategoria = @idCateg ,ImagenUrl = @url,Precio = @precio  where id= @id";
            try
            {
                AccionContraDB(consulta, art);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public void EliminarArticulo(Articulo art)
        {
            consulta = "delete from ARTICULOS where Id = @id";
            try
            {
                AccionContraDB(consulta, art);
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public List<Articulo> FiltrarFrase(string frase, string campo)
        {
            List<Articulo> articulosLista = new List<Articulo>();

            consulta = "select A.Id,A.Codigo,A.Nombre, A.Descripcion,A.ImagenUrl,A.Precio, M.Descripcion Marca,C.Descripcion Categoria,A.IdCategoria, A.IdMarca from ARTICULOS A, CATEGORIAS C, MARCAS M where A.IdMarca = M.Id and A.IdCategoria = C.Id and " + campo + " like '%" + frase + "%'";
            try
            {
                listarDB(consulta, articulosLista);
                return articulosLista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public List<Articulo> FiltrarPrecio(char operador, string numero)
        {
            List<Articulo> articulosLista = new List<Articulo>();

            consulta = "select A.Id,A.Codigo,A.Nombre, A.Descripcion,A.ImagenUrl,A.Precio, M.Descripcion Marca,C.Descripcion Categoria,A.IdCategoria, A.IdMarca from ARTICULOS A, CATEGORIAS C, MARCAS M where A.IdMarca = M.Id and A.IdCategoria = C.Id and Precio " + operador + " " + numero;
            try
            {
                listarDB(consulta, articulosLista);
                return articulosLista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void listarDB(string consulta, List<Articulo> lista)
        {
            try
            {
                datos.HacerConsulta(consulta);
                datos.LeerDB();

                llenarListaArt(datos.Lector, lista);
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
        private void AccionContraDB(string consulta, Articulo art)
        {
            try
            {
                datos.HacerConsulta(consulta);
                SetearParametros(art);
                datos.EjecutarAccion();
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

        private void SetearParametros(Articulo art)
        {
            datos.InsertarParametro("@id", art.Id);
            datos.InsertarParametro("@cod", art.Codigo);
            datos.InsertarParametro("@nombre", art.Nombre);
            datos.InsertarParametro("@desc", art.Descripcion);
            datos.InsertarParametro("@idMarca", art.Marca.Id);
            datos.InsertarParametro("@idCateg", art.Categoria.Id);
            datos.InsertarParametro("@url", art.UrlImg);
            datos.InsertarParametro("@precio", art.Precio);
        }

        private void llenarListaArt(SqlDataReader lector, List<Articulo> lista)
        {
            try
            {
                while (lector.Read())
                {
                    Articulo auxiliar = new Articulo();

                    auxiliar.Id = (int)datos.Lector["Id"];
                    auxiliar.Codigo = (string)datos.Lector["Codigo"];
                    auxiliar.Nombre = (string)datos.Lector["Nombre"];
                    auxiliar.Descripcion = (string)datos.Lector["Descripcion"];

                    if (!(datos.Lector["ImagenUrl"] is DBNull))
                        auxiliar.UrlImg = (string)datos.Lector["ImagenUrl"];

                    auxiliar.Precio = (decimal)datos.Lector["Precio"];

                    auxiliar.Marca = new Caracteristica();
                    auxiliar.Marca.Id = (int)datos.Lector["IdMarca"];
                    auxiliar.Marca.Descripcion = (string)datos.Lector["Marca"];

                    auxiliar.Categoria = new Caracteristica();
                    auxiliar.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    auxiliar.Categoria.Descripcion = (string)datos.Lector["Categoria"];

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
