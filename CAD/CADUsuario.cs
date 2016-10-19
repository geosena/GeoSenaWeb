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

        public static bool ExisteUsuario(string Nick, string Password)
        {
            if (adaptador.ExisteUsuario(Nick, Password) == null)
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

        public static void UpdateUsuario(string Apellidos, string Nombres, int Identificacion, string Nick,
            string Correo, int IdCentroFormacion, DateTime FechaModificacionClave, int IdUsuario)
        {
            adaptador.UpdateUsuario(Apellidos, Nombres, Identificacion, Nick, Correo,
                IdCentroFormacion, FechaModificacionClave, IdUsuario);
        }

        public static void DeleteUsuario(int IdUsuario)
        {
            adaptador.DeleteUsuario(IdUsuario);
        }

        public static DSGeoSena.UsuarioDataTable GetData()
        {
            return adaptador.GetData();
        }

        public static DSGeoSena.UsuarioDataTable GetDataByIdentificacion(int Identificacion)
        {
            return adaptador.GetUsuarioByIdentificacion(Identificacion);
        }

        public static bool ExisteUsuarioByIdentificacion(int Identificacion)
        {
            if (adaptador.ExisteUsuarioByIdentificacion(Identificacion) == null)
            {
                return false;
            }

            return true;
        }

        public static void CambioClave(string Password, DateTime FechaModificacionClave, int IdUsuario)
        {
            adaptador.CambioClave(Password, FechaModificacionClave, IdUsuario);
        }

        public static DSGeoSena.UsuarioDataTable
           GetUsuarioByNickAndPassword(string Nick, string Password)
        {
            return adaptador.GetUsuarioByNickAndPassword(Nick, Password);
        }

        public static void UpdateImagen(string Imagen, int IdUsuario)
        {
            adaptador.UpdateImagen(Imagen, IdUsuario);
        }
    }
}
