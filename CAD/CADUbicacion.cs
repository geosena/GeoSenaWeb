using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADUbicacion
    {
        private static UbicacionTableAdapter adaptadorUbicacion = new UbicacionTableAdapter();

        /// <summary>
        /// CRUD Ubicacion
        /// </summary>
        /// <param name="Direccion"></param>
        /// <param name="Latitud"></param>
        /// <param name="Longuitud"></param>
        /// <param name="Horario"></param>
        /// <returns></returns>
        public static int InsertUbicacion(string Direccion, double Latitud, double Longuitud, string Horario)
        {
            return (int)adaptadorUbicacion.InsertUbicacion(Direccion, Latitud, Longuitud, Horario);
        }

        public static void UpdateUbicacion(string Direccion, double Latitud, double Longuitud, string Horario,
            int IdUbicacion)
        {
            adaptadorUbicacion.UpdateUbicacion(Direccion, Latitud, Longuitud, Horario, IdUbicacion);
        }

        public static void DeleteUbicacion(int IdUbicacion)
        {
            adaptadorUbicacion.DeleteUbicacion(IdUbicacion);
        }
    }
}
