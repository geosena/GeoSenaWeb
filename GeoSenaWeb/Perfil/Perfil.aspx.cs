using CAD;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GeoSenaWeb.Perfil
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["rol"].Equals(""))
            {
                Session["rol"] = "";
                Session["DatosUsuarioAdministrador"] = "";
                Session["DatosUsuarioUser"] = "";

                Response.Redirect("~/Sesion/Index.aspx");

            }
            else if (Session["rol"].Equals("Administrador"))
            {
                imagenFileUpload.Visible = false;
                cambiarImagenButton.Visible = false;
                eliminarCuentaButton.Visible = false;

                DSGeoSena.AdministradorDataTable miAdmin =
                    (DSGeoSena.AdministradorDataTable)Session["DatosUsuarioAdministrador"];

                if (!IsPostBack)
                {
                    usuarioLabel.Text =
                    miAdmin.Rows[0].ItemArray[1].ToString() + " " + miAdmin.Rows[0].ItemArray[2].ToString();

                    nombreTextBox.Text = miAdmin.Rows[0].ItemArray[1].ToString();
                    apellidosTextBox.Text = miAdmin.Rows[0].ItemArray[2].ToString();
                    correoLabel.Text = miAdmin.Rows[0].ItemArray[3].ToString();
                    imagenImage.ImageUrl = "~/Images/AKASHI SEIJURO.jpg";
                }


            }
            else if (Session["rol"].Equals("Aprendiz Sena"))
            {
                imagenFileUpload.Visible = true;
                cambiarImagenButton.Visible = true;
                eliminarCuentaButton.Visible = true;

                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                if (!IsPostBack)
                {
                    usuarioLabel.Text =
                    miUser.Rows[0].ItemArray[4].ToString();
                    nombreTextBox.Text = miUser.Rows[0].ItemArray[2].ToString();
                    apellidosTextBox.Text = miUser.Rows[0].ItemArray[1].ToString();
                    correoLabel.Text = miUser.Rows[0].ItemArray[6].ToString();

                    string image = Server.MapPath("\\") + "Images\\" + miUser.Rows[0].ItemArray[9].ToString();

                    if (File.Exists(image))
                    {
                        imagenImage.ImageUrl = "~/Images/" + miUser.Rows[0].ItemArray[9].ToString();
                    }
                    else
                    {
                        imagenImage.ImageUrl = string.Empty;
                    }
                }
            }
        }

        protected void cambiarImagenButton_Click(object sender, EventArgs e)
        {
            if (imagenFileUpload.FileName == string.Empty)
            {
                LabelMensaje.Text = "Debe seleccionar una imagen";
                imagenFileUpload.Focus();
                return;
            }

            if ((imagenFileUpload.PostedFile != null) && (imagenFileUpload.PostedFile.ContentLength > 0))
            {
                string nombreArchivo = System.IO.Path.GetFileName(imagenFileUpload.PostedFile.FileName);

                string rutaGuardar = Server.MapPath("\\") + "Images\\" + nombreArchivo;

                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                int idUsuario = Convert.ToInt32(miUser.Rows[0].ItemArray[0].ToString());
                try
                {
                    imagenFileUpload.PostedFile.SaveAs(rutaGuardar);
                    CADUsuario.UpdateImagen(nombreArchivo, idUsuario);
                    imagenImage.ImageUrl = "~/Images/" + nombreArchivo;
                    LabelMensaje.Text = ("El archivo se ha cargado");
                }
                catch (Exception ex)
                {
                    LabelMensaje.Text = ("Error: " + ex.Message);
                }
                DSGeoSena.UsuarioDataTable miUserImage =
                   (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                int identificacion = Convert.ToInt32(miUserImage.Rows[0].ItemArray[3].ToString());

                usuarioLabel.Text =
                        miUserImage.Rows[0].ItemArray[4].ToString();
                nombreTextBox.Text = miUserImage.Rows[0].ItemArray[2].ToString();
                apellidosTextBox.Text = miUserImage.Rows[0].ItemArray[1].ToString();
                correoLabel.Text = miUserImage.Rows[0].ItemArray[6].ToString();

                string image = Server.MapPath("\\") + "Images\\" + miUserImage.Rows[0].ItemArray[9].ToString();

                if (File.Exists(image))
                {
                    imagenImage.ImageUrl = "~/Images/" + miUserImage.Rows[0].ItemArray[9].ToString();
                }
                else
                {
                    imagenImage.ImageUrl = string.Empty;
                }

                Session["DatosUsuarioUser"] = CADUsuario.GetDataByIdentificacion(identificacion);
            }

            
        }

        protected void guardarCambiosButton_Click(object sender, EventArgs e)
        {
            if (nombreTextBox.Text == string.Empty)
            {
                LabelMensaje.Text = "Debe ingresar un nombre";
                nombreTextBox.Focus();
                return;
            }

            if (apellidosTextBox.Text == string.Empty)
            {
                LabelMensaje.Text = "Debe ingresar un apellido";
                apellidosTextBox.Focus();
                return;
            }

            if (Session["rol"].Equals("Administrador"))
            {
                DSGeoSena.AdministradorDataTable miAdmin =
                    (DSGeoSena.AdministradorDataTable)Session["DatosUsuarioAdministrador"];

                string identificacion = miAdmin.Rows[0].ItemArray[4].ToString();
                int idAdministrador = Convert.ToInt32(miAdmin.Rows[0].ItemArray[0].ToString());

                CADAdministrador.UpdateAdministrador(nombreTextBox.Text, apellidosTextBox.Text, correoLabel.Text,
                    identificacion, idAdministrador);

                DSGeoSena.AdministradorDataTable miAdmin1 =
                    CADAdministrador.GetDataByIdAdministrador(idAdministrador);

                usuarioLabel.Text =
                    miAdmin1.Rows[0].ItemArray[1].ToString() + " " + miAdmin1.Rows[0].ItemArray[2].ToString();

                nombreTextBox.Text = miAdmin1.Rows[0].ItemArray[1].ToString();
                apellidosTextBox.Text = miAdmin1.Rows[0].ItemArray[2].ToString();
                correoLabel.Text = miAdmin1.Rows[0].ItemArray[3].ToString();
                imagenImage.ImageUrl = "~/Images/AKASHI SEIJURO.jpg";

                Session["DatosUsuarioAdministrador"] = CADAdministrador.GetDataByIdAdministrador(idAdministrador);
                Response.Redirect("Perfil.aspx");
            }
            else if (Session["rol"].Equals("Aprendiz Sena"))
            {
                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                int identificacion = Convert.ToInt32(miUser.Rows[0].ItemArray[3].ToString());
                int idCentro = Convert.ToInt32(miUser.Rows[0].ItemArray[7].ToString());
                DateTime fecha = Convert.ToDateTime(miUser.Rows[0].ItemArray[8].ToString());
                int idUsuario = Convert.ToInt32(miUser.Rows[0].ItemArray[0].ToString());

                CADUsuario.UpdateUsuario(apellidosTextBox.Text, nombreTextBox.Text, identificacion,
                    usuarioLabel.Text, correoLabel.Text, idCentro, fecha, idUsuario);

                DSGeoSena.UsuarioDataTable miUser1 = CADUsuario.GetDataByIdentificacion(identificacion);

                usuarioLabel.Text =
                    miUser1.Rows[0].ItemArray[4].ToString();
                nombreTextBox.Text = miUser1.Rows[0].ItemArray[2].ToString();
                apellidosTextBox.Text = miUser1.Rows[0].ItemArray[1].ToString();
                correoLabel.Text = miUser1.Rows[0].ItemArray[6].ToString();

                string image = Server.MapPath("\\") + "Images\\" + miUser1.Rows[0].ItemArray[9].ToString();

                if (File.Exists(image))
                {
                    imagenImage.ImageUrl = "~/Images/" + miUser1.Rows[0].ItemArray[9].ToString();
                }
                else
                {
                    imagenImage.ImageUrl = string.Empty;
                }

                Session["DatosUsuarioUser"] = CADUsuario.GetDataByIdentificacion(identificacion);

                Response.Redirect("Perfil.aspx");
            }
        }

        protected void eliminarCuentaButton_Click(object sender, EventArgs e)
        {
            try
            {
                DSGeoSena.UsuarioDataTable miUser =
                    (DSGeoSena.UsuarioDataTable)Session["DatosUsuarioUser"];

                int idUsuario = Convert.ToInt32(miUser.Rows[0].ItemArray[0].ToString());

                CADUsuario.DeleteUsuario(Convert.ToInt32(idUsuario));

                Session["rol"] = "";
                Session["DatosUsuarioAdministrador"] = "";
                Session["DatosUsuarioUser"] = "";

                Response.Redirect("~/Sesion/Index");
            }
            catch (Exception)
            {
                LabelMensaje.Text = "No es posible borrar el usuario. Existe una referencia a otra tabla";
                throw;
            }
        }
    }
}