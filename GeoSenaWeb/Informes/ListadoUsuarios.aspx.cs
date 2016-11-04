using GeoSenaWeb.DataSetGeoSenaTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Informes
{
    public partial class ListadoUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void generarButton_Click(object sender, EventArgs e)
        {
            CRUsuarios miListado = new CRUsuarios();

            DataSetGeoSena miDS = new DataSetGeoSena();

            CentroFormacionTableAdapter miAdaptadorC = new CentroFormacionTableAdapter();
            UsuarioTableAdapter miAdaptadorU = new UsuarioTableAdapter();

            if (centrosDropDownList.SelectedIndex == 0)
            {
                miAdaptadorC.Fill(miDS.CentroFormacion);
                miAdaptadorU.Fill(miDS.Usuario);

                miListado.SetDataSource(miDS);

            }
            else
            {
                miAdaptadorC.FillByIdCentroFormacion(miDS.CentroFormacion, Convert.ToInt32(centrosDropDownList.SelectedValue));
                miAdaptadorU.FillByIdCentroFormacion(miDS.Usuario, Convert.ToInt32(centrosDropDownList.SelectedValue));

                miListado.SetDataSource(miDS);
            }

            ListadoUsuariosFormacion.ReportSource = miListado;
        }
    }
}