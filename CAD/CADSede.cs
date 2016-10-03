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

        private static UbicacionTableAdapter adaptadorUbicacion = new UbicacionTableAdapter();

        private static TelefonoTableAdapter adaptadorTelefono = new TelefonoTableAdapter();

        private static SedeFullTableAdapter adaptadorFull = new SedeFullTableAdapter();

        public static bool ExisteSede(int IdSede)
        {
            if (adaptador.ExisteSede(IdSede) == null)
            {
                return false;
            }

            return true;
        }

        public static DSGeoSena.SedeFullDataTable GetDataByIdSede(int IdSede)
        {
            return adaptadorFull.GetDataByIdSede(IdSede);
        }

        public static DSGeoSena.SedeDataTable GetData()
        {
            return adaptador.GetData();
        }

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

        /// <summary>
        /// CRUD Sede
        /// </summary>
        /// <param name="IdCentroFormacion"></param>
        /// <param name="Descripcion"></param>
        /// <param name="IdUbicacion"></param>
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
    }
}
