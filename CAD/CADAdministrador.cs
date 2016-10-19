using CAD.DSGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CAD
{
    public class CADAdministrador
    {
        private static AdministradorTableAdapter adaptadorAdmin = new AdministradorTableAdapter();

        public static bool ExisteAdministrador(string Identificacion, string Password)
        {
            if (adaptadorAdmin.ExisteAdministrador(Identificacion, Password) == null)
            {
                return false;
            }

            return true;
        }

        public static DSGeoSena.AdministradorDataTable GetData()
        {
            return adaptadorAdmin.GetData();
        }

        public static DSGeoSena.AdministradorDataTable GetDataByIdAdministrador(int IdAdministrador)
        {
            return adaptadorAdmin.GetDataByIdAdministrador(IdAdministrador);
        }

        public static void DeleteAdministrador(int IdAdministrador)
        {
            adaptadorAdmin.DeleteAdministrador(IdAdministrador);
        }

        public static void InsertAdministrador(string Nombre, string Apellidos, string Correo, 
            string Identificacion, string Password)
        {
            adaptadorAdmin.InsertAdministrador(Nombre, Apellidos, Correo, Identificacion, Password);
        }

        public static void UpdateAdministrador(string Nombre, string Apellidos, string Correo,
            string Identificacion, int IdAdministrador)
        {
            adaptadorAdmin.UpdateAdministrador(Nombre, Apellidos, Correo, Identificacion, IdAdministrador);
        }

        public static bool ExsteAdministradorByIdAdministrador(int IdAdministrador)
        {
            if (adaptadorAdmin.ExsteAdministradorByIdAdministrador(IdAdministrador) == null)
            {
                return false;
            }

            return true;
        }

        public static void CambioClaveAdmin(string Password, int IdAdministrador)
        {
            adaptadorAdmin.CambioClaveAdmin(Password, IdAdministrador);
        }

        public static DSGeoSena.AdministradorDataTable 
            GetAdministradorByIdentificacionAndPassword(string Identificacion, string Password)
        {
            return adaptadorAdmin.GetAdministradorByIdentificacionAndPassword(Identificacion, Password);
        }
    }
}
