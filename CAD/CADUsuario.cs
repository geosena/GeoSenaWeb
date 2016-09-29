using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADUsuario
    {
        private static UsuarioTableAdapter adaptador = new UsuarioTableAdapter();
        private static AdministradorTableAdapter adapter = new AdministradorTableAdapter();

        public static bool ExisteUsuario(string Nick, string Password)
        {
            if (adaptador.ExisteUsuario(Nick, Password) == null)
            {
                return false;
            }

            return true;
        }

        public static bool ExisteAdministrador(string Identificacion, string Password)
        {
            if (adapter.ExisteAdministrador(Identificacion, Password) == null)
            {
                return false;
            }

            return true;
        }

        public static void InsertUsuario(string Apellidos, string Nombres, int Identificacion, string Nick,
            string Password, string Correo, int IdCentroFormacion, DateTime FechaModificacionClave)
        {
            adaptador.InsertUsuario(Apellidos, Nombres, Identificacion, Nick, Password, Correo, 
                IdCentroFormacion, FechaModificacionClave);
        }
    }
}
