<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistroUsuario.aspx.cs" Inherits="GeoSenaWeb.Sesion.RegistroUsuario" %>

<%@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Ingreso GeoSena</title>
    <link href="../Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-3.1.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>

    <style type="text/css">
        .auto-style1 {
            height: 40px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--Para obtener más información sobre cómo agrupar scripts en ScriptManager, consulte http://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Scripts de marco--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="respond" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Scripts del sitio--%>
            </Scripts>
        </asp:ScriptManager>
        <div class="container body-content">
            <div class="jumbotron">
                <h2>Registro Usuario SENA</h2>
                <div>
                    <table class="table-hover">
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Apellidos:</td>
                            <td class="auto-style1">
                                <asp:TextBox ID="apellidosTextBox" runat="server" Height="26px" Width="450px"></asp:TextBox>
                            </td>
                            <td class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Nombres:</td>
                            <td>
                                <asp:TextBox ID="nombresTextBox" runat="server" Height="26px" Width="450px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; left: 0px; top: 66px; width: 278px; height: 40px;">Identificación</td>
                            <td>
                                <asp:TextBox ID="identificacionTextBox" runat="server" Height="26px" Width="450px"></asp:TextBox>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Usuario:</td>
                            <td>
                                <asp:TextBox ID="usuarioTextBox" runat="server" Height="26px" Width="450px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Clave</td>
                            <td>
                                <asp:TextBox ID="passwordTextBox" runat="server" Height="26px" Width="450px" TextMode="Password"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Correo:</td>
                            <td>
                                <asp:TextBox ID="correoTextBox" runat="server" Height="26px" Width="450px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Centro de Formación:</td>
                            <td>
                                <asp:DropDownList ID="centroDropDownList" runat="server"
                                    DataSourceID="sedeSqlDataSource" DataTextField="Descripcion"
                                    DataValueField="IdCentroFormacion" Height="26px" Width="450px">
                                </asp:DropDownList>

                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="text-align: center;">
                            <td></td>
                            <td>
                                <recaptcha:RecaptchaControl
                                    ID="recaptcha"
                                    runat="server"
                                    lang="it"
                                    TabIndex="0"
                                    Theme="blackglass"
                                    PublicKey="6LftHQkUAAAAAHUwAko9z-_7jR1cFbOlivjJ0w4M"
                                    PrivateKey="6LftHQkUAAAAAIHDR-yyiYMVRBIbyC2Z5oXersjM" />
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right col-lg-2 control-label" style="font-size: medium; width: 278px; height: 40px;">Fecha Modificación Cave:</td>
                            <td>
                                <asp:TextBox ID="fechaModificacionTextBox" runat="server" Height="26px" ReadOnly="True" Width="450px"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <asp:Label ID="mensajeErrorLabel" runat="server" Text="" CssClass="alert alert-danger" Visible="false"></asp:Label>
                    <asp:Label ID="mensajeOKLabel" runat="server" Text="" CssClass="alert alert-success" Visible="false"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="registroUsuarioButton" runat="server" Text="Registrarse" CssClass="btn btn-success" OnClick="registroUsuarioButton_Click" />
                    <asp:Button ID="cancelarButton" runat="server" Text="Cancelar" CssClass="btn btn-warning" OnClick="cancelarButton_Click" />
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="sedeSqlDataSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>"
            SelectCommand="SELECT [IdCentroFormacion], [Descripcion] FROM [CentroFormacion] 
                            UNION SELECT 0, '[Seleccione Centro de Formación]'
                            ORDER BY 2"></asp:SqlDataSource>

        <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-87581383-1', 'auto');
  ga('send', 'pageview');

</script>
    </form>
</body>
</html>
