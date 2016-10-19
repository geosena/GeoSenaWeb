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

namespace GeoSenaWeb.Administracion
{
    public partial class Administrador : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void consultarButton_Click(object sender, EventArgs e)
        {
            if (idTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar el ID del administrador";
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

            if (!CADAdministrador.ExsteAdministradorByIdAdministrador(id))
            {
                MensajeLabel.Text = "El administrador no existe";
                idTextBox.Focus();
                return;
            }

            DSGeoSena.AdministradorDataTable miAdministrador =
                CADAdministrador.GetDataByIdAdministrador(id);

            foreach (DataRow item in miAdministrador.Rows)
            {
                idTextBox.Text = item["IdAdministrador"].ToString();
                nombresTextBox.Text = item["Nombre"].ToString();
                apellidosTextBox.Text = item["Apellidos"].ToString();
                correoTextBox.Text = item["Correo"].ToString();
                identificacionTextBox.Text = item["Identificacion"].ToString();
            }

            MensajeLabel.Text = "Administrador consultado";

            habilitarBotones();
        }

        protected void nuevoButton_Click(object sender, EventArgs e)
        {
            if (!ValidaCampos())
            {
                return;
            }

            if (passwordTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar una contraseña de acceso";
                passwordTextBox.Focus();
                return;
            }

            if (passwordTextBox.Text.Length <= 5)
            {
                MensajeLabel.Text = "Debe ingresar una contraseña de acceso mayor a cinco [5] carácteres ";
                passwordTextBox.Focus();
                return;
            }

            DSGeoSena.AdministradorDataTable miAdministrador = CADAdministrador.GetData();

            foreach (DataRow item in miAdministrador.Rows)
            {

                if (identificacionTextBox.Text == item["Identificacion"].ToString())
                {
                    MensajeLabel.Text =
                        "El administrador ya existe. [La identificacion ya se encuentra registrada en sistema]";
                    identificacionTextBox.Focus();
                    return;
                }
            }

            foreach (DataRow item in miAdministrador.Rows)
            {

                if (correoTextBox.Text == item["Correo"].ToString())
                {
                    MensajeLabel.Text =
                        "El administrador ya existe. [El correo ingresado ya se encuentra registrado en el sistema]";
                    correoTextBox.Focus();
                    return;
                }
            }

            CADAdministrador.InsertAdministrador(nombresTextBox.Text,apellidosTextBox.Text,
                correoTextBox.Text, identificacionTextBox.Text, passwordTextBox.Text);

            //actualizar grid tipoEmpleado
            administradorGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "Administrador registrado correctamente";
        }

        protected void modificarButton_Click(object sender, EventArgs e)
        {
            if (!ValidaCampos())
            {
                return;
            }

            CADAdministrador.UpdateAdministrador(nombresTextBox.Text, apellidosTextBox.Text,
                correoTextBox.Text, identificacionTextBox.Text, Convert.ToInt32(idTextBox.Text));

            //actualizar grid tipoEmpleado
            administradorGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El administrador fue actualizado correctamente";
        }

        protected void eliminarButton_Click(object sender, EventArgs e)
        {
            try
            {
                CADAdministrador.DeleteAdministrador(Convert.ToInt32(idTextBox.Text));

                //actualizar grid tipoEmpleado
                administradorGridView.DataBind();

                limpiarCampos();
                deshabilitarBotones();

                MensajeLabel.Text = "El administrador fue eliminado correctamente";
            }
            catch (Exception)
            {
                MensajeLabel.Text = "No es posible borrar el administrador. Existe una referencia a otra tabla";
                throw;
            }
        }

        protected void cambiarClaveButton_Click(object sender, EventArgs e)
        {
            if (claveTextBox.Text == string.Empty)
            {
                mensajeClaveLabel.Visible = true;
                mensajeClaveLabel.Text = "Debe ingresar una contraseña de acceso";
                claveTextBox.Focus();
                return;
            }

            if (claveTextBox.Text.Length <= 5)
            {
                mensajeClaveLabel.Visible = true;
                mensajeClaveLabel.Text = "Debe ingresar una contraseña de acceso mayor a cinco [5] carácteres ";
                claveTextBox.Focus();
                return;
            }

            if (claveConfirmacionTextBox.Text == string.Empty)
            {
                mensajeClaveLabel.Visible = true;
                mensajeClaveLabel.Text = "Debe confirmar la contraseña de acceso";
                claveConfirmacionTextBox.Focus();
                return;
            }

            if (!claveTextBox.Text.Equals(claveConfirmacionTextBox.Text))
            {
                mensajeClaveLabel.Visible = true;
                mensajeClaveLabel.Text = "Las contraseñas ingresadas no coinciden";
                claveTextBox.Focus();
                return;
            }

            DSGeoSena.AdministradorDataTable miAdministrador =
                CADAdministrador.GetDataByIdAdministrador(Convert.ToInt32(idTextBox.Text));

            int IdAdministrador = Convert.ToInt32(miAdministrador.Rows[0].ItemArray[0].ToString());

            CADAdministrador.CambioClaveAdmin(claveTextBox.Text, IdAdministrador);

            //actualizar grid
            administradorGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            Response.Redirect("Administrador.aspx", true);

            MensajeLabel.Text = "La contraseña fue cambiada";
        }

        protected void limpiarButton_Click(object sender, EventArgs e)
        {
            limpiarCampos();
            deshabilitarBotones();
        }

        protected void cancelarButton_Click(object sender, EventArgs e)
        {
            limpiarCampos();
            deshabilitarBotones();
        }

        private void habilitarBotones()
        {
            modificarButton.Enabled = true;
            eliminarButton.Enabled = true;
            consultarButton.Enabled = false;
            nuevoButton.Enabled = false;
            limpiarButton.Enabled = false;
            cancelarButton.Enabled = true;
            cambiarClaveButton.Visible = true;
            claveLabel.Visible = false;

            idTextBox.ReadOnly = true;
            passwordTextBox.Visible = false;
        }

        private void deshabilitarBotones()
        {
            modificarButton.Enabled = false;
            eliminarButton.Enabled = false;
            consultarButton.Enabled = true;
            nuevoButton.Enabled = true;
            limpiarButton.Enabled = true;
            cancelarButton.Enabled = false;
            cambiarClaveButton.Visible = false;
            claveLabel.Visible = true;

            idTextBox.ReadOnly = false;
            passwordTextBox.Visible = true;
        }

        private void limpiarCampos()
        {
            apellidosTextBox.Text = string.Empty;
            nombresTextBox.Text = string.Empty;
            identificacionTextBox.Text = string.Empty;
            claveTextBox.Text = string.Empty;
            claveConfirmacionTextBox.Text = string.Empty;
            correoTextBox.Text = string.Empty;

            idTextBox.Text = string.Empty;
        }

        private bool ValidaCampos()
        {
            if (nombresTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar nombres del usuario";
                nombresTextBox.Focus();
                return false;
            }

            if (apellidosTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar apellidos del usuario";
                apellidosTextBox.Focus();
                return false;
            }


            if (identificacionTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar el numero de identificación del usuario";
                identificacionTextBox.Focus();
                return false;
            }

            int identificacion = 0;
            if (!int.TryParse(identificacionTextBox.Text, out identificacion))
            {
                MensajeLabel.Text = "Debe ingresar un numero de identificación valido numerico";
                identificacionTextBox.Focus();
                return false;
            }

            if (identificacion <= 0)
            {
                MensajeLabel.Text = "Debe ingresar un numero de identificación mayor a cero [0]";
                identificacionTextBox.Focus();
                return false;
            }

            if (correoTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar un correo";
                correoTextBox.Focus();
                return false;
            }

            RegexUtilities validador = new RegexUtilities();

            if (!validador.IsValidEmailOther(correoTextBox.Text))
            {
                MensajeLabel.Text = "Debe ingresar un correo valido";
                correoTextBox.Focus();
                return false;
            }

            return true;
        }

        [WebMethod]
        public static string GetRecordsAdministrador(string criterio)
        {
            SqlConnection cn =
                new SqlConnection(ConfigurationManager.ConnectionStrings["GeoSenaDBConnectionString"].ConnectionString);

            SqlDataAdapter da =
                new SqlDataAdapter("SELECT [IdAdministrador], [Correo], [Nombre], [Apellidos] FROM [Administrador] WHERE Correo LIKE '%"
                + criterio + "%' ORDER BY Correo", cn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            string data = JsonConvert.SerializeObject(ds, Formatting.Indented);

            return data;
        }
    }
}