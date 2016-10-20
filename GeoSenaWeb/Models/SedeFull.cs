using GeoSenaWeb.DataSetGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GeoSenaWeb.Models
{
    public class SedeFull
    {
        private static SedeFullTableAdapter adaptadorFull = new SedeFullTableAdapter();

        public static DataSetGeoSena.SedeFullDataTable GetDataByIdSede(int IdSede)
        {
            return adaptadorFull.GetDataByIdSede(IdSede);
        }

        public static DataSetGeoSena.SedeFullDataTable GetDataByIdCentroFormacion(int IdCentroFormacion)
        {
            return adaptadorFull.GetDataByIdCentroFormacion(IdCentroFormacion);
        }

        public static DataSetGeoSena.SedeFullDataTable GetDataFull()
        {
            return adaptadorFull.GetData();
        }

    }
}