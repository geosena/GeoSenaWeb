using GeoSenaWeb.DataSetGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Informes
{
    public partial class ListadoSedes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void generarButton_Click(object sender, EventArgs e)
        {
            CRSedes miListado = new CRSedes();

            DataSetGeoSena miDS = new DataSetGeoSena();

            SedeFullTableAdapter miAdaptador = new SedeFullTableAdapter();

            if (centrosDropDownList.SelectedIndex == 0)
            {
                miAdaptador.Fill(miDS.SedeFull);

                miListado.SetDataSource(miDS);
                
            }
            else
            {
                miAdaptador.FillByIdCentroFormacion(miDS.SedeFull, Convert.ToInt32(centrosDropDownList.SelectedValue));

                miListado.SetDataSource(miDS);
            }

            ListadoSedesFormacion.ReportSource = miListado;
        }
    }
}