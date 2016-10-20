using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADParqueadero
    {
        private static ParqueaderoTableAdapter adaptadorParqueadero = new ParqueaderoTableAdapter();

        public static void InsertParqueadero(string Descripcion, double Cupo, int IdUbicacion, int IdSede)
        {
            adaptadorParqueadero.InsertParqueadero(Descripcion, Cupo, IdUbicacion, IdSede);
        }

        public static void UpdateParqueadero(string Descripcion, double Cupo, int IdUbicacion, int IdSede,
            int IdParqueadero)
        {
            adaptadorParqueadero.UpdateParqueadero(Descripcion, Cupo, IdUbicacion, IdSede, IdParqueadero);
        }

        public static void DeleteParqueadero(int IdParqueadero)
        {
            adaptadorParqueadero.DeleteParqueadero(IdParqueadero);
        }

        public static bool ExisteParqueadero(int IdParqueadero)
        {
            if (adaptadorParqueadero.ExisteParqueadero(IdParqueadero) == null)
            {
                return false;
            }

            return true;
        }

        public static DSGeoSena.ParqueaderoDataTable GetData()
        {
            return adaptadorParqueadero.GetData();
        }
    }
}
