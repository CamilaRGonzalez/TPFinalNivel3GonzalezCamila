using Dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LogicaNegocio
{
    public class UserDB
    {
        public bool RegistrarUsuario(string email, string pass)
        {
            AccesoDB datos = new AccesoDB();
            int exito;
            try
            {
                string query = "if not exists (select * from USERS where email = @email) begin insert into USERS (email,pass,admin) values (@email,@pass,0) end";
                datos.HacerConsulta(query);
                datos.InsertarParametro("@email", email);
                datos.InsertarParametro("@pass", pass);

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
    }
}
