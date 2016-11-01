using GeoSenaWeb.DataSetGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Informes
{
    public partial class ListadoCentros : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CRListadoCentros miListado = new CRListadoCentros();

            DataSetGeoSena miDS = new DataSetGeoSena();

            CentroFormacionTableAdapter miAdaptador = new CentroFormacionTableAdapter();

            miAdaptador.Fill(miDS.CentroFormacion);

            miListado.SetDataSource(miDS);

            ListadoCentrosFormacion.ReportSource = miListado;
        }
    }
}