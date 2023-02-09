using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class FavoritoDB
    {
        public List<Articulo> listarFavoritos(int idUser)
        {
            AccesoDB datos = new AccesoDB();

            try
            {
                List<Articulo> lista = new List<Articulo>();
                string query = "select A.Id,A.Codigo,A.Nombre,A.Descripcion,C.Descripcion as Categoria,M.Descripcion as Marca,";
                query += "A.ImagenUrl, A.Precio, A.IdMarca,A.IdCategoria";
                query += " from MARCAS M,CATEGORIAS C, FAVORITOS F";
                query += " inner join ARTICULOS A on A.Id = F.IdArticulo inner join USERS U on U.Id = F.IdUser";
                query += " WHERE M.Id = A.IdMarca and C.Id = A.IdCategoria and U.Id = @idUser";

                datos.HacerConsulta(query);
                datos.InsertarParametro("@idUser", idUser);
                datos.LeerDB();

                while (datos.Lector.Read())
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

                return lista;
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

        public bool AgregarFavorito(int IdArticulo, int IdUser)
        {
            AccesoDB datos = new AccesoDB();
            int exito;
            try
            {
                string query = "IF NOT EXISTS (SELECT * FROM FAVORITOS WHERE IdArticulo = @IdArticulo AND IdUser= @IdUser) begin insert into favoritos (IdUser,IdArticulo) values (@IdUser,@IdArticulo) end";
                datos.HacerConsulta(query);
                datos.InsertarParametro("@IdArticulo", IdArticulo);
                datos.InsertarParametro("@IdUser", IdUser);

                exito = datos.EjecutarAccion();

                if (exito <= 0)
                    return false;
                return true;
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

        public void EliminarFavorito(int IdArticulo, int IdUser)
        {
            AccesoDB datos = new AccesoDB();
            try
            {
                string query = "Delete from FAVORITOS where IdArticulo = @IdArticulo and IdUser = @IdUser";
                datos.HacerConsulta(query);
                datos.InsertarParametro("@IdArticulo", IdArticulo);
                datos.InsertarParametro("@IdUser", IdUser);

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
    }
}
