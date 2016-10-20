using GeoSenaWeb.DataSetGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GeoSenaWeb.Models
{
    public class ParqueaderoFull
    {
        private static ParqueaderoFullTableAdapter adaptadorFull = new ParqueaderoFullTableAdapter();

        public static DataSetGeoSena.ParqueaderoFullDataTable GetDataByIdParqueadero(int IdParqueadero)
        {
            return adaptadorFull.GetDataByIdParqueadero(IdParqueadero);
        }

        public static DataSetGeoSena.ParqueaderoFullDataTable GetDataByIdSede(int IdSede)
        {
            return adaptadorFull.GetDataByIdSede(IdSede);
        }
    }
}