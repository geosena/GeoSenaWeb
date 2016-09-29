<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="GeoSenaWeb.Sesion.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Ingreso GeoSena</title>
    <link href="../Content/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-3.1.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>

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
                <h1>Bienvenidos a GeoSena</h1>
            </div>
            <div class="col-lg-5">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">Ingreso Sin Login</h3>
                    </div>
                    <div class="panel-body">
                        <asp:Button ID="ingresoButton" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="ingresoButton_Click" />
                    </div>
                </div>

            </div>
            <div class="col-lg-5">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Ingreso Usuario Sena</h3>
                    </div>
                    <div class="panel-body">
                        <input id="ingresoSenaButton" type="button" value="Ingresar" class="btn btn-info " data-toggle="modal" data-target="#myModal" />
                        &nbsp;
                        <asp:Button ID="registroUsuarioButton" runat="server" Text="Registrarse" CssClass="btn btn-warning " OnClick="registroButton_Click" />
                    </div>
                </div>

            </div>
        </div>

        <!-- Modal -->
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Ingreso Usuario SENA</h4>
                    </div>

                    <div class="modal-body">
                        <asp:UpdatePanel ID="panel" runat="server">
                            <ContentTemplate>
                                <asp:Label ID="mensajeLabel" runat="server" Text="" CssClass="alert alert-dismissible alert-danger" Visible="false"></asp:Label>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="inicioButton" EventName="click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        <br />
                        <br />
                        <table class="table table-striped table-hover">
                            <tr>
                                <td>Usuario:</td>
                                <td>
                                    <asp:TextBox ID="usuarioTextBox" CssClass="usuarioTextBox form-control" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Contraseña:</td>
                                <td>
                                    <asp:TextBox ID="contraseñaTextBox" CssClass="contraseñaTextBox form-control" runat="server" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="registroButton" runat="server" Visible="false" Text="Registrarse" CssClass="btn btn-primary btn-xs" OnClick="registroButton_Click" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="inicioButton" EventName="click" />
                            </Triggers>
                        </asp:UpdatePanel> 
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="cancel" class="btn btn-default"  data-dismiss="modal">Cancelar</button>
                        <asp:Button ID="inicioButton" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="inicioButton_Click" />

                    </div>

                </div>

            </div>
        </div>
        <div class="container body-content">
            <hr />
            <footer>
                &copy; <%: DateTime.Now.Year %> GEOSENA
            </footer>
        </div>
    </form>
</body>

</html>
