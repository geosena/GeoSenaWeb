using CAD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Sesion
{
    public partial class RegistroUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fechaModificacionTextBox.Text = DateTime.Now.ToShortDateString();
            }
        }

        protected void cancelarButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void registroUsuarioButton_Click(object sender, EventArgs e)
        {
            if (!ValidaCampos())
            {
                return;
            }

           CADUsuario.InsertUsuario(apellidosTextBox.Text, nombresTextBox.Text, 
                Convert.ToInt32(identificacionTextBox.Text), usuarioTextBox.Text,
                passwordTextBox.Text, correoTextBox.Text, Convert.ToInt32(centroDropDownList.SelectedValue),
                Convert.ToDateTime(fechaModificacionTextBox.Text));
                
            mensajeOKLabel.Visible = true;
            mensajeOKLabel.Text = "Usuario " + usuarioTextBox.Text + " registrado correctamente";

            cancelarButton.Text = "Regresar";

            LimpiarCampos();

        }

        private void LimpiarCampos()
        {
            apellidosTextBox.Text = string.Empty;
            nombresTextBox.Text = string.Empty;
            identificacionTextBox.Text = string.Empty;
            usuarioTextBox.Text = string.Empty;
            passwordTextBox.Text = string.Empty;
            correoTextBox.Text = string.Empty;
            centroDropDownList.SelectedIndex = 0;
        }

        private bool ValidaCampos()
        {
            if (apellidosTextBox.Text == string.Empty)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar apellidos del usuario";
                apellidosTextBox.Focus();
                return false;
            }

            if (nombresTextBox.Text == string.Empty)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar nombres del usuario";
                nombresTextBox.Focus();
                return false;
            }

            if (identificacionTextBox.Text == string.Empty)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar el numero de identificación del usuario";
                identificacionTextBox.Focus();
                return false;
            }

            int identificacion = 0;
            if (!int.TryParse(identificacionTextBox.Text, out identificacion))
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar un numero de identificación valido numerico";
                identificacionTextBox.Focus();
                return false;
            }

            if (identificacion <= 0)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar un numero de identificación mayor a cero [0]";
                identificacionTextBox.Focus();
                return false;
            }

            if (usuarioTextBox.Text == string.Empty)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar el nombre de usuario de acceso";
                usuarioTextBox.Focus();
                return false;
            }

            if (passwordTextBox.Text == string.Empty)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar una contraseña de acceso";
                passwordTextBox.Focus();
                return false;
            }

            if (passwordTextBox.Text.Length <= 5)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar una contraseña de acceso mayor a cinco [5] carácteres ";
                passwordTextBox.Focus();
                return false;
            }

            if (correoTextBox.Text == string.Empty)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar un correo SENA";
                correoTextBox.Focus();
                return false;
            }

            RegexUtilities validador = new RegexUtilities();

            if (!validador.IsValidEmail(correoTextBox.Text))
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe ingresar un correo SENA (ejemplo@misena.edu.co)";
                correoTextBox.Focus();
                return false;
            }

            if (centroDropDownList.SelectedIndex == 0)
            {
                mensajeErrorLabel.Visible = true;
                mensajeErrorLabel.Text = "Debe seleccionar el centro de formación al que pertenece";
                centroDropDownList.Focus();
                return false;
            }

            mensajeErrorLabel.Visible = false;
            mensajeErrorLabel.Text = string.Empty;

            return true;
        }
    }
}