using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using CAD;
using System.Data;

namespace GeoSenaWeb
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // El código siguiente ayuda a proteger frente a ataques XSRF
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Utilizar el token Anti-XSRF de la cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generar un nuevo token Anti-XSRF y guardarlo en la cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Establecer token Anti-XSRF
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validar el token Anti-XSRF
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Error de validación del token Anti-XSRF.");
                }
            }

            if (Session["rol"].Equals(""))
            {
                iniciarSesionLinkButton.Visible = true;
                adminMenuLinkButton.Visible = false;
                userMenuLinkButton.Visible = false;
                reporteMenuLinkButton.Visible = false;
                
            }
            else if (Session["rol"].Equals("Administrador"))
            {
                iniciarSesionLinkButton.Visible = false;
                adminMenuLinkButton.Visible = true;
                userMenuLinkButton.Visible = true;
                reporteMenuLinkButton.Visible = true;
                DSGeoSena.AdministradorDataTable miAdmin =
                    (DSGeoSena.AdministradorDataTable)Session["DatosUsuarioAdministrador"];

                usuarioLabel.Text =
                    miAdmin.Rows[0].ItemArray[1].ToString() + " " + miAdmin.Rows[0].ItemArray[2].ToString();
            }
            else if (Session["rol"].Equals("Aprendiz Sena"))
            {
                iniciarSesionLinkButton.Visible = false;
                adminMenuLinkButton.Visible = false;
                userMenuLinkButton.Visible = true;
                reporteMenuLinkButton.Visible = false;
                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                usuarioLabel.Text =
                    miUser.Rows[0].ItemArray[1].ToString() + " " + miUser.Rows[0].ItemArray[2].ToString();
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string str = "1.12.1";
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery.ui.combined", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-ui-" + str + ".min.js",
                DebugPath = "~/Scripts/jquery-ui-" + str + ".js",
                CdnPath = "http://ajax.aspnetcdn.com/ajax/jquery.ui/" + str + "/jquery-ui.min.js",
                CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jquery.ui/" + str + "/jquery-ui.js",
                CdnSupportsSecureConnection = true
            });

            if (Session["rol"].Equals(""))
            {
                iniciarSesionLinkButton.Visible = true;
                adminMenuLinkButton.Visible = false;
                userMenuLinkButton.Visible = false;
                reporteMenuLinkButton.Visible = false;

            }
            else if (Session["rol"].Equals("Administrador"))
            {
                iniciarSesionLinkButton.Visible = false;
                adminMenuLinkButton.Visible = true;
                userMenuLinkButton.Visible = true;
                reporteMenuLinkButton.Visible = true;
                DSGeoSena.AdministradorDataTable miAdmin =
                    (DSGeoSena.AdministradorDataTable)Session["DatosUsuarioAdministrador"];

                usuarioLabel.Text =
                    miAdmin.Rows[0].ItemArray[1].ToString() + " " + miAdmin.Rows[0].ItemArray[2].ToString();
            }
            else if (Session["rol"].Equals("Aprendiz Sena"))
            {
                iniciarSesionLinkButton.Visible = false;
                adminMenuLinkButton.Visible = false;
                userMenuLinkButton.Visible = true;
                reporteMenuLinkButton.Visible = false;
                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                usuarioLabel.Text =
                    miUser.Rows[0].ItemArray[2].ToString() + " " + miUser.Rows[0].ItemArray[1].ToString();
            }
        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }

        protected void cerrarSesionLinkButton_Click(object sender, EventArgs e)
        {
            Session["rol"] = "";
            Session["DatosUsuarioAdministrador"] = "";
            Session["DatosUsuarioUser"] = "";

            Response.Redirect("~/Sesion/Index");
        }

        protected void cambioClaveLinkButton_Click(object sender, EventArgs e)
        {
            if (claveAnteriorTextBox.Text == string.Empty)
            {
                mensajeClaveLabel.Visible = true;
                mensajeClaveLabel.Text = "Debe ingresar la clave actual";
                claveAnteriorTextBox.Focus();
                return;
            }

            if (claveTextBox.Text == string.Empty)
            {
                mensajeClaveLabel.Visible = true;
                mensajeClaveLabel.Text = "Debe ingresar una nueva contraseña de acceso";
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

            if (Session["rol"].Equals("Administrador"))
            {
                DSGeoSena.AdministradorDataTable miAdmin =
                    (DSGeoSena.AdministradorDataTable)Session["DatosUsuarioAdministrador"];

                foreach (DataRow item in miAdmin.Rows)
                {
                    if (claveAnteriorTextBox.Text != item["Password"].ToString())
                    {
                        mensajeClaveLabel.Visible = true;
                        mensajeClaveLabel.Text = "La contraseña actual ingresada no es valida";
                        claveAnteriorTextBox.Focus();
                        return;
                    }
                }

                int idAdministrador = Convert.ToInt32(miAdmin.Rows[0].ItemArray[0].ToString());

                CADAdministrador.CambioClaveAdmin(claveTextBox.Text, idAdministrador);

            }
            else if (Session["rol"].Equals("Aprendiz Sena"))
            {
                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                foreach (DataRow item in miUser.Rows)
                {
                    if (claveAnteriorTextBox.Text != item["Password"].ToString())
                    {
                        mensajeClaveLabel.Visible = true;
                        mensajeClaveLabel.Text = "La contraseña actual ingresada no es valida";
                        claveAnteriorTextBox.Focus();
                        return;
                    }
                }

                DateTime fecha = DateTime.Now;

                foreach (DataRow item in miUser.Rows)
                {

                    if (claveTextBox.Text == item["Password"].ToString())
                    {
                        fecha = Convert.ToDateTime(miUser.Rows[0].ItemArray[8].ToString());
                    }
                    else
                    {
                        fecha = DateTime.Now;
                    }
                }

                int idUsuario = Convert.ToInt32(miUser.Rows[0].ItemArray[0].ToString());

                CADUsuario.CambioClave(claveTextBox.Text,fecha, idUsuario);
            }

            Response.Redirect("Default.aspx", true);
        }
    }

}