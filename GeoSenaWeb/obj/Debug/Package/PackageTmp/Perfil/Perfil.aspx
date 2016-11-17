<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="GeoSenaWeb.Perfil.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />
    <table class="table">
        <tr>
            <td class="text-center" colspan="3">
                <asp:Image ID="imagenImage" runat="server" Height="200px" Width="300px" ImageAlign="Middle" />
                <br />
            </td>
        </tr>
        <tr>
            <td rowspan="6" style="width: 180px">
                &nbsp;</td>
            <td class="text-right" style="width: 111px">
                <asp:FileUpload ID="imagenFileUpload" runat="server" Width="300px" Height="26px" />
                </td>
            <td class="text-left">
                <asp:Button ID="cambiarImagenButton" runat="server" Text="Cambiar Imagen" CssClass="btn btn-info btn-sm" OnClick="cambiarImagenButton_Click" />
                <asp:Label ID="LabelMensaje" runat="server" Text="" CssClass="lead"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: 111px">Usuario:</td>
            <td class="text-left">
                <asp:Label ID="usuarioLabel" runat="server" Text="Label" Width="280px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: 111px">Nombre:</td>
            <td class="text-left">
                <asp:TextBox ID="nombreTextBox" runat="server" Width="280px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: 111px">Apellidos:</td>
            <td class="text-left">
                <asp:TextBox ID="apellidosTextBox" runat="server" Width="280px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: 111px">Correo:</td>
            <td class="text-left">
                <asp:Label ID="correoLabel" runat="server" Text="Label" Width="280px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: 111px">
                <asp:Button ID="guardarCambiosButton" runat="server" Text="Guardar Cambios" CssClass="btn btn-success btn-sm" OnClick="guardarCambiosButton_Click" />
            </td>
            <td class="text-left">
                <asp:Button ID="eliminarCuentaButton" runat="server" Text="Eliminar Cuenta" data-toggle="modal"
            data-target="#myModal" CssClass="btn btn-danger btn-sm" />
            </td>
        </tr>
        </table>

    <!-- Eliminar modal-->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Confirmacion</h4>
                </div>
                <div class="modal-body">
                    <p>Esta seguro de borrar el registro?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">NO</button>
                    <asp:Button ID="eliminarButton1" runat="server" CssClass="btn btn-primary" Text="SI"
                        OnClick="eliminarCuentaButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
