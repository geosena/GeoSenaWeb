using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADCentro
    {
        private static CentroFormacionTableAdapter adaptador = new CentroFormacionTableAdapter();
        public static void DeleteCentro(int IdCentroFormacion)
        {
            adaptador.DeleteCentro(IdCentroFormacion);
        }

        public static bool ExisteCentro(int IdCentroFormacion)
        {
            if (adaptador.ExisteCentro(IdCentroFormacion) == null)
            {
                return false;
            }

            return true;
        }

        public static DSGeoSena.CentroFormacionDataTable GetCentroByIdCentroFormacion(int IdCentroFormacion)
        {
            return adaptador.GetCentroByIdCentroFormacion(IdCentroFormacion);
        }
    }
}
