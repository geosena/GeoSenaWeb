using CAD;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb
{
    public partial class CentrosFormacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["rol"] == "")
            {
                Session["rol"] = "";
                Session["DatosUsuarioAdministrador"] = "";
                Session["DatosUsuarioUser"] = "";

                Response.Redirect("~/Sesion/Index.aspx");

            }
            else if (Session["rol"] == "Aprendiz Sena")
            {
                Session["rol"] = "";
                Session["DatosUsuarioAdministrador"] = "";
                Session["DatosUsuarioUser"] = "";

                Response.Redirect("~/Sesion/Index.aspx");
            }
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

            DSGeoSena.CentroFormacionDataTable miCentro = 
                CADCentro.GetCentroByIdCentroFormacion(Convert.ToInt32(idTextBox.Text));

            foreach (DataRow item in miCentro.Rows)
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

            idTextBox.ReadOnly = true;
        }

        protected void nuevoButton_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
            {
                return;
            }

            DSGeoSena.CentroFormacionDataTable miCentro = CADCentro.GetData();

            foreach (DataRow item in miCentro.Rows)
            {

                if (descripcionTextBox.Text == item["Descripcion"].ToString())
                {
                    MensajeLabel.Text = "El centro de formación ya existe";
                    descripcionTextBox.Focus();
                    return;
                }
            }

            CADCentro.InsertCentro(descripcionTextBox.Text, urlTextBox.Text);

            //actualizar grid tipoEmpleado
            centroGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El centro de formación fue ingresado correctamente";
        }

        private bool ValidarCampos()
        {
            if (descripcionTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar una descripción";
                descripcionTextBox.Focus();
                return false;
            }

            RegexUtilities validador = new RegexUtilities();

            if (urlTextBox.Text != string.Empty)
            {
                if (!validador.IsValidUrl(urlTextBox.Text))
                {
                    MensajeLabel.Text = "Debe ingresar una direccion url valida";
                    urlTextBox.Focus();
                    return false;
                }
            }

            return true;
        }

        protected void modificarButton_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
            {
                return;
            }

            DSGeoSena.CentroFormacionDataTable miCentro = 
                CADCentro.GetCentroByIdCentroFormacion(Convert.ToInt32(idTextBox.Text));

            foreach (DataRow item in miCentro.Rows)
            {
                if (descripcionTextBox.Text == item["Descripcion"].ToString())
                {
                    MensajeLabel.Text = "El centro de formación ya existe ya existe";
                    descripcionTextBox.Focus();
                    return;
                }
            }

            CADCentro.UpdateCentro(descripcionTextBox.Text,urlTextBox.Text, 
                Convert.ToInt32(idTextBox.Text));

            //actualizar grid tipoEmpleado
            centroGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El centro de formación fue modificado correctamente";
        }

        protected void eliminarButton_Click(object sender, EventArgs e)
        {
            try
            {
                CADCentro.DeleteCentro(Convert.ToInt32(idTextBox.Text));
                
                //actualizar grid tipoEmpleado
                centroGridView.DataBind();

                limpiarCampos();
                deshabilitarBotones();

                MensajeLabel.Text = "El centro fue eliminado correctamente";
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

            idTextBox.ReadOnly = false;
        }

        private void limpiarCampos()
        {
            idTextBox.Text = string.Empty;
            descripcionTextBox.Text = string.Empty;
            urlTextBox.Text = string.Empty;

            MensajeLabel.Text = string.Empty;
        }


        [WebMethod]
        public static string GetRecordsCentro(string criterio)
        {
            SqlConnection cn =
                new SqlConnection(ConfigurationManager.ConnectionStrings["GeoSenaDBConnectionString"].ConnectionString);

            SqlDataAdapter da =
                new SqlDataAdapter("SELECT [IdCentroFormacion], [Descripcion] FROM [CentroFormacion] WHERE Descripcion LIKE '%"
                + criterio + "%' ORDER BY Descripcion", cn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            string data = JsonConvert.SerializeObject(ds, Formatting.Indented);

            return data;
        }
    }
}