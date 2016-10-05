using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADTelefono
    {
        private static TelefonoTableAdapter adaptadorTelefono = new TelefonoTableAdapter();

        /// <summary>
        /// CRUD Telefono
        /// </summary>
        /// <param name="IdTipoTelefono"></param>
        /// <param name="IdUbicacion"></param>
        /// <param name="Telefono"></param>
        public static void InsertTelefono(int IdTipoTelefono, int IdUbicacion, string Telefono)
        {
            adaptadorTelefono.InsertTelefono(IdTipoTelefono, IdUbicacion, Telefono);
        }

        public static void UpdateTelefono(int IdTipoTelefono, int IdUbicacion, string Telefono,
            int IdTelefono)
        {
            adaptadorTelefono.UpdateTelefono(IdTipoTelefono, IdUbicacion, Telefono, IdTelefono);
        }

        public static void DeleteTelefono(int IdTelefono)
        {
            adaptadorTelefono.DeleteTelefono(IdTelefono);
        }
    }
}
