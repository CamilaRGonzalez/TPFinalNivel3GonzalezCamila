using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class UserDB
    {
        public bool RegistrarUsuario(string email, string pass)
        {
            AccesoDB datos = new AccesoDB();

            try
            {
                string query = "if not exists (select * from USERS where email = @email) begin insert into USERS (email,pass,admin) values (@email,@pass,0) end";
                datos.HacerConsulta(query);
                datos.InsertarParametro("@email", email);
                datos.InsertarParametro("@pass", pass);

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

        public bool Login(User usuario)
        {
            AccesoDB datos = new AccesoDB();

            try
            {
                datos.HacerConsulta("select Id,email,pass, admin, urlImagenPerfil, nombre,apellido from users where email = @email and Pass = @pass");
                datos.InsertarParametro("@email", usuario.email);
                datos.InsertarParametro("@pass", usuario.pass);
                datos.LeerDB();

                while (datos.Lector.Read())
                {
                    usuario.Id = (int)datos.Lector["Id"];

                    usuario.email = (string)datos.Lector["email"];

                    usuario.admin = (bool)datos.Lector["admin"];

                    usuario.urlImagenPerfil = !(datos.Lector["urlImagenPerfil"] is DBNull) ? (string)datos.Lector["urlImagenPerfil"] : null;

                    usuario.nombre = !(datos.Lector["nombre"] is DBNull) ? (string)datos.Lector["nombre"] : null;

                    usuario.apellido = !(datos.Lector["apellido"] is DBNull) ? (string)datos.Lector["apellido"] : null;

                    return true;
                }
                return false;
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
        public void ActualizarDatos(User user)
        {
            AccesoDB datos = new AccesoDB();
 
            try
            {
                datos.HacerConsulta("update users set nombre=@nombre, apellido = @apellido, urlImagenPerfil=@urlimg where Id=@id");
                datos.InsertarParametro("@nombre", user.nombre);
                datos.InsertarParametro("@apellido", user.apellido);
                datos.InsertarParametro("@urlimg", user.urlImagenPerfil ?? (object)DBNull.Value); //si user.urlImg no es null se envia el valor y si es null se envia null
                datos.InsertarParametro("@id", user.Id);

                datos.EjecutarAccion();
                 
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
