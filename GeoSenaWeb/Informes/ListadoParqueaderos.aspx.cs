using GeoSenaWeb.DataSetGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Informes
{
    public partial class ListadoParqueaderos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void generarButton_Click(object sender, EventArgs e)
        {
            CRParqueadero miListado = new CRParqueadero();

            DataSetGeoSena miDS = new DataSetGeoSena();

            ParqueaderoFullTableAdapter miAdaptador = new ParqueaderoFullTableAdapter();

            if (sedesDropDownList.SelectedIndex == 0)
            {
                miAdaptador.Fill(miDS.ParqueaderoFull);

                miListado.SetDataSource(miDS);

            }
            else
            {
                miAdaptador.FillByIdSede(miDS.ParqueaderoFull, Convert.ToInt32(sedesDropDownList.SelectedValue));

                miListado.SetDataSource(miDS);
            }

            ListadoParqueaderosFormacion.ReportSource = miListado;
        }
    }
}