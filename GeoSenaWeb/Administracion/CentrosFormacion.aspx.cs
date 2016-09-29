using CAD;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb
{
    public partial class CentrosFormacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void consultarButton_Click(object sender, EventArgs e)
        {
            if (idTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar la identificacon del centro";
                idTextBox.Focus();
                return;
            }

            int id = 0;

            if (!int.TryParse(idTextBox.Text, out id))
            {
                MensajeLabel.Text = "Debe ingresar un valor numerico";
                idTextBox.Focus();
                return;
            }

            if (id <= 0)
            {
                MensajeLabel.Text = "Debe ingresar un valor numerico mayor a cero [0]";
                idTextBox.Focus();
                return;
            }

            if (!CADCentro.ExisteCentro(Convert.ToInt32(idTextBox.Text)))
            {
                MensajeLabel.Text = "El centro no existe";
                idTextBox.Focus();
                return;
            }

            DSGeoSena.CentroFormacionDataTable miEmpleado = 
                CADCentro.GetCentroByIdCentroFormacion(Convert.ToInt32(idTextBox.Text));

            foreach (DataRow item in miEmpleado.Rows)
            {
                idTextBox.Text = item["IdCentroFormacion"].ToString();
                descripcionTextBox.Text = item["Descripcion"].ToString();
                urlTextBox.Text = item["Url"].ToString();
            }

            MensajeLabel.Text = "Centro de formación consultado";

            habilitarBotones();
        }

        private void habilitarBotones()
        {
            modificarButton.Enabled = true;
            eliminarButton.Enabled = true;
            consultarButton.Enabled = false;
            nuevoButton.Enabled = false;
            limpiarButton.Enabled = false;
            cancelarButton.Enabled = true;
        }

        protected void nuevoButton_Click(object sender, EventArgs e)
        {

        }

        protected void modificarButton_Click(object sender, EventArgs e)
        {

        }

        protected void eliminarButton_Click(object sender, EventArgs e)
        {
            try
            {
                CADCentro.DeleteCentro(Convert.ToInt32(idTextBox.Text));
                MensajeLabel.Text = "El centro fue eliminado correctamente";

                //actualizar grid tipoEmpleado
                centroGridView.DataBind();

                limpiarCampos();
                deshabilitarBotones();
            }
            catch (Exception)
            {
                MensajeLabel.Text = "No es posible borrar el centro. Existe una referencia a otra tabla";
                throw;
            }
        }

        protected void limpiarButton_Click(object sender, EventArgs e)
        {
            limpiarCampos();
        }

        protected void cancelarButton_Click(object sender, EventArgs e)
        {
            limpiarCampos();
            deshabilitarBotones();
        }

        private void deshabilitarBotones()
        {
            modificarButton.Enabled = false;
            eliminarButton.Enabled = false;
            consultarButton.Enabled = true;
            nuevoButton.Enabled = true;
            limpiarButton.Enabled = true;
            cancelarButton.Enabled = false;
        }

        private void limpiarCampos()
        {
            idTextBox.Text = string.Empty;
            descripcionTextBox.Text = string.Empty;
            urlTextBox.Text = string.Empty;

            MensajeLabel.Text = string.Empty;
        }
    }
}