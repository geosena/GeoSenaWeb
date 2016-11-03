using CAD;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Subgurim.Controles;
using System.Text;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using Newtonsoft.Json;
using GeoSenaWeb.Models;

namespace GeoSenaWeb.Administracion
{
    public partial class Sedes : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                DibujarMapa("Bogota,Colombia", 13);

                latitudTextBox.Text = string.Empty;
                longuitudTextBox.Text = string.Empty;
            }
        }

        protected void consultarButton_Click(object sender, EventArgs e)
        {
            if (idTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar la identificación de la sede";
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

            if (!CADSede.ExisteSede(Convert.ToInt32(idTextBox.Text)))
            {
                MensajeLabel.Text = "La sede no existe";
                idTextBox.Focus();
                return;
            }

            DataSetGeoSena.SedeFullDataTable miCentro =
                SedeFull.GetDataByIdSede(Convert.ToInt32(idTextBox.Text));

            foreach (DataRow item in miCentro.Rows)
            {
                idTextBox.Text = item["IdSede"].ToString();
                centroFormacionDropDownList.SelectedValue = item["IdCentroFormacion"].ToString();
                descripcionTextBox.Text = item["Sede"].ToString();
                direccionTextBox.Text = item["Direccion"].ToString();
                latitudTextBox.Text = item["Latitud"].ToString();
                longuitudTextBox.Text = item["Longuitud"].ToString();
                tipoTelefono1DropDownList.SelectedValue = item["IdTipoTelefono"].ToString();
                telefono1TextBox.Text = item["Telefono"].ToString();
                horarioTextBox.Text = item["Horario"].ToString();
            }

            ObtenerCoordenadasButton_Click(sender, e);

            MensajeLabel.Text = "Sede de formación consultada";

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

            DSGeoSena.SedeDataTable miCentro = CADSede.GetData();

            foreach (DataRow item in miCentro.Rows)
            {

                if (descripcionTextBox.Text == item["Descripcion"].ToString())
                {
                    MensajeLabel.Text = "La sede de formación ya existe";
                    descripcionTextBox.Focus();
                    return;
                }
            }

            int idUbicacion = CADUbicacion.InsertUbicacion(direccionTextBox.Text, Convert.ToDouble(latitudTextBox.Text),
                Convert.ToDouble(longuitudTextBox.Text), horarioTextBox.Text);

            CADTelefono.InsertTelefono(Convert.ToInt32(tipoTelefono1DropDownList.SelectedValue), idUbicacion,
                telefono1TextBox.Text);

            CADSede.InsertSede(Convert.ToInt32(centroFormacionDropDownList.SelectedValue), descripcionTextBox.Text,
                idUbicacion);

            //actualizar grid tipoEmpleado
            sedeFullGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "La sede de formación fue ingresado correctamente";
        }

        private bool ValidarCampos()
        {
            if (centroFormacionDropDownList.SelectedIndex == 0)
            {
                MensajeLabel.Text = "Debe seleccionar un centro de formación";
                centroFormacionDropDownList.Focus();
                return false;
            }

            if (descripcionTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar una descripción";
                descripcionTextBox.Focus();
                return false;
            }

            if (direccionTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar una dirección";
                direccionTextBox.Focus();
                return false;
            }

            if (latitudTextBox.Text == string.Empty || longuitudTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe obtener las coordenadas de la dirección, PRESIONE el boton <strong>Obtener Coordenadas GPS</strong>";
                ObtenerCoordenadasButton.Focus();
                return false;
            }

            if (tipoTelefono1DropDownList.SelectedIndex == 0)
            {
                MensajeLabel.Text = "Debe seleccionar un tipo de teléfono";
                tipoTelefono1DropDownList.Focus();
                return false;
            }

            if (horarioTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar un horario de atención";
                horarioTextBox.Focus();
                return false;
            }

            return true;
        }

        protected void modificarButton_Click(object sender, EventArgs e)
        {
            if (!ValidarCampos())
            {
                return;
            }

            int idSede = Convert.ToInt32(idTextBox.Text);
            int idCentroFormacion = Convert.ToInt32(centroFormacionDropDownList.SelectedValue);
            int idTipoTelefono = Convert.ToInt32(tipoTelefono1DropDownList.SelectedValue);

            DataSetGeoSena.SedeFullDataTable miCentro = SedeFull.GetDataByIdSede(idSede);

            int idUbicacion = Convert.ToInt32(miCentro.Rows[0].ItemArray[4].ToString());
            int idTelefono = Convert.ToInt32(miCentro.Rows[0].ItemArray[9].ToString());

            CADUbicacion.UpdateUbicacion(direccionTextBox.Text, Convert.ToDouble(latitudTextBox.Text),
                Convert.ToDouble(longuitudTextBox.Text), horarioTextBox.Text,idUbicacion);

            CADTelefono.UpdateTelefono(idTipoTelefono, idUbicacion,
                telefono1TextBox.Text,idTelefono);

            CADSede.UpdateSede(idCentroFormacion, descripcionTextBox.Text,
                idUbicacion, idSede);

            //actualizar grid tipoEmpleado
            sedeFullGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "La sede de formación fue actualizada correctamente";
        }

        protected void eliminarButton_Click(object sender, EventArgs e)
        {
            int idSede = Convert.ToInt32(idTextBox.Text);

            DataSetGeoSena.SedeFullDataTable miCentro = SedeFull.GetDataByIdSede(idSede);

            int idUbicacion = Convert.ToInt32(miCentro.Rows[0].ItemArray[4].ToString());
            int idTelefono = Convert.ToInt32(miCentro.Rows[0].ItemArray[9].ToString());

            CADSede.DeleteSede(idSede);

            CADTelefono.DeleteTelefono(idTelefono);

            CADUbicacion.DeleteUbicacion(idUbicacion);

            //actualizar grid tipoEmpleado
            sedeFullGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "La sede de formación fue eliminada correctamente";
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

        private void limpiarCampos()
        {
            idTextBox.Text = string.Empty;
            centroFormacionDropDownList.SelectedIndex = 0;
            descripcionTextBox.Text = string.Empty;
            direccionTextBox.Text = string.Empty;
            latitudTextBox.Text = string.Empty;
            longuitudTextBox.Text = string.Empty;
            tipoTelefono1DropDownList.SelectedIndex = 0;
            telefono1TextBox.Text = string.Empty;
            horarioTextBox.Text = string.Empty;

            MensajeLabel.Text = string.Empty;
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

        protected void ObtenerCoordenadasButton_Click(object sender, EventArgs e)
        {
            string direccion = direccionTextBox.Text + ",Bogota";

            DibujarMapa(direccion, 19);

            tipoTelefono1DropDownList.Focus();
        }

        private void DibujarMapa(string direccion, int zoom)
        {
            try
            {
                GeoCode GeoCode;

                string skey = ConfigurationManager.AppSettings["googlemaps.subgurim.net"];

                GeoCode = GMap.geoCodeRequest(direccion, skey);

                if (GeoCode.valid)
                {
                    latitudTextBox.Text = GeoCode.Placemark.coordinates.lat.ToString();
                    longuitudTextBox.Text = GeoCode.Placemark.coordinates.lng.ToString();

                    GLatLng gLatLng =
                        new GLatLng(GeoCode.Placemark.coordinates.lat, GeoCode.Placemark.coordinates.lng);

                    GMarker icono = new GMarker(gLatLng, new GMarkerOptions(new GIcon(), true));

                    GInfoWindow window = new GInfoWindow(icono, "" + direccion, true);

                    GMap1.enableHookMouseWheelToZoom = true;

                    GMap1.Add(window);
                    GMap1.enableRotation = true;
                    GMap1.setCenter(gLatLng, zoom);
                }
                else
                {
                    MensajeLabel.Text = "No es posible encontrar la ubicación";
                }
            }
            catch (Exception ex)
            {

                MensajeLabel.Text = "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string GetRecordsSede(string criterio)
        {
            SqlConnection cn =
                new SqlConnection(ConfigurationManager.ConnectionStrings["GeoSenaDBConnectionString"].ConnectionString);

            SqlDataAdapter da =
                new SqlDataAdapter("SELECT [IdSede], [Descripcion] FROM [Sede] WHERE Descripcion LIKE '%"
                + criterio + "%' ORDER BY Descripcion", cn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            string data = JsonConvert.SerializeObject(ds, Formatting.Indented);

            return data;
        }

    }
}