using CAD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Sesion
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void inicioButton_Click(object sender, EventArgs e)
        {
            if (usuarioTextBox.Text == string.Empty)
            {
                mensajeLabel.Visible = true;
                mensajeLabel.Text = "Debe ingresar un usuario";
                usuarioTextBox.Focus();
                return;
            }

            if (contraseñaTextBox.Text == string.Empty)
            {
                mensajeLabel.Visible = true;
                mensajeLabel.Text = "Debe ingresar una contraseña";
                contraseñaTextBox.Focus();
                return;
            }

            if (!recaptcha.IsValid)
            {
                mensajeLabel.Visible = true;
                mensajeLabel.Text = "Recaptcha Incorrecto";
                recaptcha.Focus();
                return;
            }

            bool administrador = 
                CADAdministrador.ExisteAdministrador(usuarioTextBox.Text, contraseñaTextBox.Text);
            bool usuario = 
                CADUsuario.ExisteUsuario(usuarioTextBox.Text, contraseñaTextBox.Text);

            if (!administrador && !usuario)
            {
                registroButton.Visible = true;
                mensajeLabel.Visible = true;
                mensajeLabel.Text = "Usuario Y/O Contraseña invalidos";
                usuarioTextBox.Focus();
                return;
            }

            if (administrador)
            {
                Session["DatosUsuarioAdministrador"] = 
                    CADAdministrador.GetAdministradorByIdentificacionAndPassword(usuarioTextBox.Text, contraseñaTextBox.Text);

                mensajeLabel.Visible = true;
                Session["rol"] = "Administrador";

                Response.Redirect("~/Default.aspx");
            }
            else
            {
                Session["DatosUsuarioUser"] =
                    CADUsuario.GetUsuarioByNickAndPassword(usuarioTextBox.Text, contraseñaTextBox.Text);

                mensajeLabel.Visible = true;
                Session["rol"] = "Aprendiz Sena";

                Response.Redirect("~/Default.aspx");

            }
        }

        protected void registroButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistroUsuario.aspx");
        }

        protected void ingresoButton_Click(object sender, EventArgs e)
        {
            Session["rol"] = "";
            Session["DatosUsuarioAdministrador"] = "";
            Session["DatosUsuarioUser"] = "";

            Response.Redirect("~/Default.aspx");
        }
    }
}