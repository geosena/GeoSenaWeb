using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Subgurim.Controles;
using CAD;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;
using Newtonsoft.Json;
using GeoSenaWeb.Models;

namespace GeoSenaWeb.Administracion
{
    public partial class Parqueaderos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DibujarMapa("Bogota,Colombia", 13);

                latitudTextBox.Text = string.Empty;
                longuitudTextBox.Text = string.Empty;
            }
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

        private void limpiarCampos()
        {
            idTextBox.Text = string.Empty;
            sedeDropDownList.SelectedIndex = 0;
            descripcionTextBox.Text = string.Empty;
            direccionTextBox.Text = string.Empty;
            latitudTextBox.Text = string.Empty;
            longuitudTextBox.Text = string.Empty;
            cupoTextBox.Text = string.Empty;
            tipoTelefono1DropDownList.SelectedIndex = 0;
            telefono1TextBox.Text = string.Empty;
            horarioTextBox.Text = string.Empty;

            MensajeLabel.Text = string.Empty;
        }

        protected void ObtenerCoordenadasButton_Click(object sender, EventArgs e)
        {
            string direccion = direccionTextBox.Text + ",Bogota";

            DibujarMapa(direccion, 19);

            tipoTelefono1DropDownList.Focus();
        }

        protected void consultarButton_Click(object sender, EventArgs e)
        {
            if (idTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar la identificación del parqueadero";
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

            if (!CADParqueadero.ExisteParqueadero(Convert.ToInt32(idTextBox.Text)))
            {
                MensajeLabel.Text = "El parqueadero no existe";
                idTextBox.Focus();
                return;
            }

            DataSetGeoSena.ParqueaderoFullDataTable miParqueadero =
                ParqueaderoFull.GetDataByIdParqueadero(Convert.ToInt32(idTextBox.Text));

            foreach (DataRow item in miParqueadero.Rows)
            {
                idTextBox.Text = item["IdParqueadero"].ToString();
                sedeDropDownList.SelectedValue = item["IdSede"].ToString();
                descripcionTextBox.Text = item["Parqueadero"].ToString();
                direccionTextBox.Text = item["Direccion"].ToString();
                latitudTextBox.Text = item["Latitud"].ToString();
                longuitudTextBox.Text = item["Longuitud"].ToString();
                cupoTextBox.Text = item["Cupo"].ToString();
                tipoTelefono1DropDownList.SelectedValue = item["IdTipoTelefono"].ToString();
                telefono1TextBox.Text = item["Telefono"].ToString();
                horarioTextBox.Text = item["Horario"].ToString();
            }

            ObtenerCoordenadasButton_Click(sender, e);

            MensajeLabel.Text = "Parqueadero consultado";

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

            DSGeoSena.ParqueaderoDataTable miParqueadero = CADParqueadero.GetData();

            DataSetGeoSena.ParqueaderoFullDataTable miParqueaderoFull;

            foreach (DataRow item in miParqueadero.Rows)
            {
                miParqueaderoFull =
                    ParqueaderoFull.GetDataByIdParqueadero(Convert.ToInt32(item["IdParqueadero"].ToString()));

                if (descripcionTextBox.Text == miParqueaderoFull.Rows[0].ItemArray[1].ToString()
                    && direccionTextBox.Text == miParqueaderoFull.Rows[0].ItemArray[4].ToString())
                {
                    MensajeLabel.Text = "El parqueadero ya existe";
                    descripcionTextBox.Focus();
                    return;
                }
            }

            int idUbicacion = CADUbicacion.InsertUbicacion(direccionTextBox.Text,
                Convert.ToDouble(latitudTextBox.Text), Convert.ToDouble(longuitudTextBox.Text),
                horarioTextBox.Text);

            CADTelefono.InsertTelefono(Convert.ToInt32(tipoTelefono1DropDownList.SelectedValue), idUbicacion, 
                telefono1TextBox.Text);

            CADParqueadero.InsertParqueadero(descripcionTextBox.Text, Convert.ToDouble(cupoTextBox.Text), 
                idUbicacion, Convert.ToInt32(sedeDropDownList.SelectedValue));


            //actualizar grid tipoEmpleado
            parqueaderoFullGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El parqueadero fue ingresado correctamente";
        }

        private bool ValidarCampos()
        {
            if (sedeDropDownList.SelectedIndex == 0)
            {
                MensajeLabel.Text = "Debe seleccionar una sede de formación";
                sedeDropDownList.Focus();
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

            if (cupoTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar el cupo maximo del parqueadero";
                cupoTextBox.Focus();
                return false;
            }

            float cupo = 0;
            if (!float.TryParse(cupoTextBox.Text,out cupo))
            {
                MensajeLabel.Text = "Debe ingresar un valor numerico para el cupo maximo del parqueadero.";
                cupoTextBox.Focus();
                return false;
            }

            if (cupo <= 0)
            {
                MensajeLabel.Text = "El cupo maximo del parqueadero no puede ser menor o igual a cero[0]";
                cupoTextBox.Focus();
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

            int idParqueadero = Convert.ToInt32(idTextBox.Text);
            int idSede = Convert.ToInt32(sedeDropDownList.SelectedValue);
            int idTipoTelefono = Convert.ToInt32(tipoTelefono1DropDownList.SelectedValue);

            DataSetGeoSena.ParqueaderoFullDataTable miParqueadero = 
                ParqueaderoFull.GetDataByIdParqueadero(idParqueadero);

            int idUbicacion = Convert.ToInt32(miParqueadero.Rows[0].ItemArray[3].ToString());
            int idTelefono = Convert.ToInt32(miParqueadero.Rows[0].ItemArray[10].ToString());

            CADUbicacion.UpdateUbicacion(direccionTextBox.Text, Convert.ToDouble(latitudTextBox.Text),
                Convert.ToDouble(longuitudTextBox.Text), horarioTextBox.Text, idUbicacion);

            CADTelefono.UpdateTelefono(idTipoTelefono, idUbicacion,
                telefono1TextBox.Text, idTelefono);

            CADParqueadero.UpdateParqueadero(descripcionTextBox.Text, Convert.ToInt32(cupoTextBox.Text),
                idUbicacion, idSede, idParqueadero);

            //actualizar grid tipoEmpleado
            parqueaderoFullGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El parqueadero fue actualizado correctamente";
        }

        protected void eliminarButton_Click(object sender, EventArgs e)
        {
            int idParqueadero = Convert.ToInt32(idTextBox.Text);

            DataSetGeoSena.ParqueaderoFullDataTable miCentro = 
                ParqueaderoFull.GetDataByIdParqueadero(idParqueadero);

            int idUbicacion = Convert.ToInt32(miCentro.Rows[0].ItemArray[4].ToString());
            int idTelefono = Convert.ToInt32(miCentro.Rows[0].ItemArray[9].ToString());

            CADParqueadero.DeleteParqueadero(idParqueadero);

            CADTelefono.DeleteTelefono(idTelefono);

            CADUbicacion.DeleteUbicacion(idUbicacion);

            //actualizar grid tipoEmpleado
            parqueaderoFullGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El parqueadero fue eliminado correctamente";
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

        [WebMethod]
        public static string GetRecordsParqueadero(string criterio)
        {
            SqlConnection cn =
                new SqlConnection(ConfigurationManager.ConnectionStrings["GeoSenaDBConnectionString"].ConnectionString);

            SqlDataAdapter da =
                new SqlDataAdapter("SELECT [IdParqueadero], [Descripcion] FROM [Parqueadero] WHERE Descripcion LIKE '%"
                + criterio + "%' ORDER BY Descripcion", cn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            string data = JsonConvert.SerializeObject(ds, Formatting.Indented);

            return data;
        }
    }
}