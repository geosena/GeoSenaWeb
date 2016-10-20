using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADSede
    {
        private static SedeTableAdapter adaptador = new SedeTableAdapter();

        public static void InsertSede(int IdCentroFormacion, string Descripcion, int IdUbicacion)
        {
            adaptador.InsertSede(IdCentroFormacion, Descripcion, IdUbicacion);
        }

        public static void UpdateSede(int IdCentroFormacion, string Descripcion, int IdUbicacion,
            int IdSede)
        {
            adaptador.UpdateSede(IdCentroFormacion, Descripcion, IdUbicacion, IdSede);
        }

        public static void DeleteSede(int IdSede)
        {
            adaptador.DeleteSede(IdSede);
        }

        public static bool ExisteSede(int IdSede)
        {
            if (adaptador.ExisteSede(IdSede) == null)
            {
                return false;
            }

            return true;
        }

        public static DSGeoSena.SedeDataTable GetData()
        {
            return adaptador.GetData();
        }
    }
}
