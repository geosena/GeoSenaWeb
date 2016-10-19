using CAD;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Administracion
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fechaModificacionTextBox.Text = DateTime.Now.ToShortDateString();
            }
        }

        protected void consultarButton_Click(object sender, EventArgs e)
        {
            if (identificacionTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar la identificación del usuario";
                identificacionTextBox.Focus();
                return;
            }

            int id = 0;

            if (!int.TryParse(identificacionTextBox.Text, out id))
            {
                MensajeLabel.Text = "Debe ingresar un valor numerico";
                identificacionTextBox.Focus();
                return;
            }

            if (id <= 0)
            {
                MensajeLabel.Text = "Debe ingresar un valor numerico mayor a cero [0]";
                identificacionTextBox.Focus();
                return;
            }

            if (!CADUsuario.ExisteUsuarioByIdentificacion(id))
            {
                MensajeLabel.Text = "El usuario no existe";
                idTextBox.Focus();
                return;
            }

            DSGeoSena.UsuarioDataTable miUsuario =
                CADUsuario.GetDataByIdentificacion(id);

            foreach (DataRow item in miUsuario.Rows)
            {
                idTextBox.Text = item["IdUsuario"].ToString();
                centrosDropDownList.SelectedValue = item["IdCentroFormacion"].ToString();
                nombresTextBox.Text = item["Nombres"].ToString();
                apellidosTextBox.Text = item["Apellidos"].ToString();
                usuarioTextBox.Text = item["Nick"].ToString();
                correoTextBox.Text = item["Correo"].ToString();
                fechaModificacionTextBox.Text = string.Format("{0:D}", item["FechaModificacionClave"]);
            }

            MensajeLabel.Text = "Usuario consultado";

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
            cambiarClaveButton.Visible = true;
            claveLabel.Visible = false;

            idTextBox.ReadOnly = true;
            passwordTextBox.Visible = false;
        }

        protected void nuevoButton_Click(object sender, EventArgs e)
        {
            if (!ValidaCampos())
            {
                return;
            }

            DSGeoSena.UsuarioDataTable miUsuario = CADUsuario.GetData();

            foreach (DataRow item in miUsuario.Rows)
            {

                if (identificacionTextBox.Text == item["Identificacion"].ToString())
                {
                    MensajeLabel.Text = 
                        "El usuario ya existe. [La identificacion ya se encuentra registrada en sistema]";
                    identificacionTextBox.Focus();
                    return;
                }
            }

            foreach (DataRow item in miUsuario.Rows)
            {

                if (usuarioTextBox.Text == item["Nick"].ToString())
                {
                    MensajeLabel.Text = 
                        "El usuario ya existe. [El Nick ingresado ya se encuentra registrado en el sistema]";
                    usuarioTextBox.Focus();
                    return;
                }
            }

            foreach (DataRow item in miUsuario.Rows)
            {

                if (correoTextBox.Text == item["Correo"].ToString())
                {
                    MensajeLabel.Text = 
                        "El usuario ya existe. [El correo ingresado ya se encuentra registrado en el sistema]";
                    correoTextBox.Focus();
                    return;
                }
            }

            CADUsuario.InsertUsuario(apellidosTextBox.Text, nombresTextBox.Text,
                 Convert.ToInt32(identificacionTextBox.Text), usuarioTextBox.Text,
                 passwordTextBox.Text, correoTextBox.Text, Convert.ToInt32(centrosDropDownList.SelectedValue),
                 DateTime.Now);

            //actualizar grid tipoEmpleado
            usuarioGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "Usuario " + usuarioTextBox.Text + " registrado correctamente";
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
            usuarioTextBox.Text = string.Empty;
            claveTextBox.Text = string.Empty;
            claveConfirmacionTextBox.Text = string.Empty;
            correoTextBox.Text = string.Empty;
            fechaModificacionTextBox.Text = string.Empty;
            centrosDropDownList.SelectedIndex = 0;

            idTextBox.Text = string.Empty;
        }

        private bool ValidaCampos()
        {
            if (centrosDropDownList.SelectedIndex == 0)
            {
                MensajeLabel.Text = "Debe seleccionar el centro de formación al que pertenece";
                centrosDropDownList.Focus();
                return false;
            }

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

            if (usuarioTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar el nombre de usuario de acceso";
                usuarioTextBox.Focus();
                return false;
            }

            if (correoTextBox.Text == string.Empty)
            {
                MensajeLabel.Text = "Debe ingresar un correo SENA";
                correoTextBox.Focus();
                return false;
            }

            RegexUtilities validador = new RegexUtilities();

            if (!validador.IsValidEmail(correoTextBox.Text))
            {
                MensajeLabel.Text = "Debe ingresar un correo SENA (ejemplo@misena.edu.co)";
                correoTextBox.Focus();
                return false;
            }

            return true;
        }

        protected void modificarButton_Click(object sender, EventArgs e)
        {
            if (!ValidaCampos())
            {
                return;
            }

            DateTime fecha = Convert.ToDateTime(fechaModificacionTextBox.Text);

            CADUsuario.UpdateUsuario(apellidosTextBox.Text, nombresTextBox.Text,
                Convert.ToInt32(identificacionTextBox.Text), usuarioTextBox.Text,
                correoTextBox.Text, Convert.ToInt32(centrosDropDownList.SelectedValue), fecha,
                Convert.ToInt32(idTextBox.Text));

            //actualizar grid tipoEmpleado
            usuarioGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            MensajeLabel.Text = "El usuario fue actualizado correctamente";
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

        [WebMethod]
        public static string GetRecordsUsuario(string criterio)
        {
            SqlConnection cn =
                new SqlConnection(ConfigurationManager.ConnectionStrings["GeoSenaDBConnectionString"].ConnectionString);

            SqlDataAdapter da =
                new SqlDataAdapter("SELECT [Identificacion], [Nick], [Nombres], [Apellidos] FROM [Usuario] WHERE Nick LIKE '%"
                + criterio + "%' ORDER BY Nick", cn);

            DataSet ds = new DataSet();

            da.Fill(ds);

            string data = JsonConvert.SerializeObject(ds, Formatting.Indented);

            return data;
        }

        protected void eliminarButton_Click(object sender, EventArgs e)
        {
            try
            {
                CADUsuario.DeleteUsuario(Convert.ToInt32(idTextBox.Text));

                //actualizar grid tipoEmpleado
                usuarioGridView.DataBind();

                limpiarCampos();
                deshabilitarBotones();

                MensajeLabel.Text = "El usuario fue eliminado correctamente";
            }
            catch (Exception)
            {
                MensajeLabel.Text = "No es posible borrar el usuario. Existe una referencia a otra tabla";
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

            DSGeoSena.UsuarioDataTable miUsuario =
                CADUsuario.GetDataByIdentificacion(Convert.ToInt32(identificacionTextBox.Text));

            DateTime fecha = DateTime.Now;

            foreach (DataRow item in miUsuario.Rows)
            {

                if (claveTextBox.Text == item["Password"].ToString())
                {
                    fecha = Convert.ToDateTime(fechaModificacionTextBox.Text);
                }
                else
                {
                    fecha = DateTime.Now;
                }
            }

            int idUsuario = Convert.ToInt32(miUsuario.Rows[0].ItemArray[0].ToString());

            CADUsuario.CambioClave(claveTextBox.Text, fecha, idUsuario);

            //actualizar grid
            usuarioGridView.DataBind();

            limpiarCampos();
            deshabilitarBotones();

            Response.Redirect("Usuarios.aspx", true);

            MensajeLabel.Text = "La contraseña fue cambiada";
        }

    }
}