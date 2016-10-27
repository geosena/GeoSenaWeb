<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="GeoSenaWeb.Administracion.Administrador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .fila {
            min-width: 400px;
            max-width: 700px;
        }
    </style>
    <script>

        function SelectRecordUsuario(control) {

            var ID = $(control).closest("tr").find("label").html();
            $(".idTextBox").val(ID);
            $(".consultarButton").click();
            $("#dialog-search-Usuario").dialog("close");
        }

        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $("#buscarUsuarioButton").click(function () {
                $("#dialog-search-Usuario").dialog({
                    resizable: false,
                    height: 500,
                    width: 700,
                    modal: true,
                    buttons: {
                        "Cerrar": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });

            $("#buscarUsuario2Button").click(function () {

                var pageUrl = '<%= ResolveUrl("~/Administracion/Administrador.aspx/GetRecordsAdministrador") %>';

                var criterio = $("#<%= criterioUsuarioTextBox.ClientID %>").val();

                var parameter = { "criterio": criterio }

                $.ajax({
                    url: pageUrl,
                    type: "POST",
                    data: JSON.stringify(parameter),
                    contentType: "application/json; charser=utf-8",
                    datatype: "json",
                    success: function (result) {
                        $("#dataUsuario").empty();
                        var data = JSON.parse(result.d);
                        var array = data.Table;
                        var temp = "<table class='table'><tr><th>Correo</th><th>Nombres</th><th>Selección</th></tr>";
                        for (var i = 0; i < array.length; i++) {
                            temp += "<tr>";
                            temp += "<td style='display:none;'><label>" + array[i].IdAdministrador + "</label></td>";
                            temp += "<td><label>" + array[i].Correo + "</label></td>";
                            temp += "<td><label>" + array[i].Nombre + " " + array[i].Apellidos + "</label></td>";
                            temp += "<td><input itag='Select' type='button' value='Seleccionar' onclick='return SelectRecordUsuario(this)'/></td>";
                            temp += "</tr>";
                        }
                        temp += "</table>";
                        $("#dataUsuario").append(temp);
                    },
                    error: function (err) {
                        alert("Fail " + err);
                    }
                });
            });
        });
    </script>
    <div id="dialog-search-Usuario" title="Búsqueda de usuarios" style="display: none;">
        Correo:
        <asp:TextBox ID="criterioUsuarioTextBox" CssClass="criterioUsuarioTextBox" runat="server"></asp:TextBox>
        <input id="buscarUsuario2Button" type="button" value="Buscar" />
        <br />
        <div id="dataUsuario"></div>
    </div>

    <h1>Administradores</h1>
    <table class="table">
        <tr>
            <td class="text-right">Id Administrador:
            </td>
            <td>
                <asp:TextBox ID="idTextBox" runat="server" Height="26px" Width="100px" CssClass="idTextBox"></asp:TextBox>
                <input id="buscarUsuarioButton" type="button" value="..." /></td>
            <td class="text-right">Identificación:</td>
            <td>
                <asp:TextBox ID="identificacionTextBox" runat="server" Height="26px" Width="280px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">Nombres:</td>
            <td colspan="2">
                <asp:TextBox ID="nombresTextBox" runat="server" Height="26px" CssClass="fila"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="text-right">Apellidos:</td>
            <td colspan="2">
                <asp:TextBox ID="apellidosTextBox" runat="server" Height="26px" CssClass="fila"></asp:TextBox>
            </td>
            <td></td>
        </tr>
        <tr>
            <td class="text-right">Correo:</td>
            <td>
                <asp:TextBox ID="correoTextBox" runat="server" Height="26px" Width="280px"></asp:TextBox>
            </td>
            <td class="text-right">
                <asp:Label ID="claveLabel" runat="server" Text="Clave:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="passwordTextBox" runat="server" Height="26px" Width="280px"></asp:TextBox>
                &nbsp;</td>
        </tr>
        </table>
    <asp:Label ID="MensajeLabel" runat="server" Text="" CssClass="lead"></asp:Label>
    <br />
    <br />
    <asp:Button ID="consultarButton" runat="server" CssClass="btn btn-primary consultarButton" Text="Consultar" OnClick="consultarButton_Click" />
    |
        <asp:Button ID="nuevoButton" runat="server" CssClass="btn btn-success" Text="Nuevo" OnClick="nuevoButton_Click" />
    |
        <asp:Button ID="modificarButton" runat="server" CssClass="btn btn-warning" Text="Modifcar" Enabled="False" OnClick="modificarButton_Click" />
    |
        <asp:Button ID="eliminarButton" runat="server" CssClass="btn btn-danger" data-toggle="modal"
            data-target="#myModal" Text="Eliminar" Enabled="False" />
    |
        <asp:Button ID="cambiarClaveButton" runat="server" CssClass="btn btn-info" data-toggle="modal"
            data-target="#myModalClave" Text="Cambiar Contraseña" Visible="False" />
    |
        <asp:Button ID="limpiarButton" runat="server" CssClass="btn btn-info" Text="Limpiar" OnClick="limpiarButton_Click" />
    |
        <asp:Button ID="cancelarButton" runat="server" CssClass="btn btn-default" Text="Cancelar" Enabled="False" OnClick="cancelarButton_Click" />
    |<br />
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView ID="administradorGridView" runat="server" AllowPaging="True" 
                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="IdAdministrador" 
                DataSourceID="administradorSqlDataSource" EmptyDataText="No hay registros de datos para mostrar." 
                CssClass="table table-striped table-hover">
        <Columns>
            <asp:BoundField DataField="IdAdministrador" HeaderText="Id Administrador" ReadOnly="True" SortExpression="IdAdministrador" />
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
            <asp:BoundField DataField="Apellidos" HeaderText="Apellidos" SortExpression="Apellidos" />
            <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
            <asp:BoundField DataField="Identificacion" HeaderText="Identificación" SortExpression="Identificacion" />
            <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" Visible="False" />
        </Columns>
    </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="administradorSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        DeleteCommand="DELETE FROM [Administrador] WHERE [IdAdministrador] = @IdAdministrador" 
        InsertCommand="INSERT INTO [Administrador] ([Nombre], [Apellidos], [Correo], [Identificacion], [Password]) VALUES (@Nombre, @Apellidos, @Correo, @Identificacion, @Password)" 
        ProviderName="<%$ ConnectionStrings:GeoSenaDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT [IdAdministrador], [Nombre], [Apellidos], [Correo], [Identificacion], [Password] FROM [Administrador]" 
        UpdateCommand="UPDATE [Administrador] SET [Nombre] = @Nombre, [Apellidos] = @Apellidos, [Correo] = @Correo, [Identificacion] = @Identificacion, [Password] = @Password WHERE [IdAdministrador] = @IdAdministrador">
        <DeleteParameters>
            <asp:Parameter Name="IdAdministrador" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Apellidos" Type="String" />
            <asp:Parameter Name="Correo" Type="String" />
            <asp:Parameter Name="Identificacion" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Nombre" Type="String" />
            <asp:Parameter Name="Apellidos" Type="String" />
            <asp:Parameter Name="Correo" Type="String" />
            <asp:Parameter Name="Identificacion" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="IdAdministrador" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="centroSqlDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>"
        SelectCommand="SELECT [IdCentroFormacion], [Descripcion] FROM [CentroFormacion] 
                            UNION SELECT 0, '[Seleccione Centro de Formación]'
                            ORDER BY 2"></asp:SqlDataSource>

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
                        OnClick="eliminarButton_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Cambiar clave Modal -->
    <div class="modal" id="myModalClave">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Cambiar Contraseña</h4>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="panel" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="mensajeClaveLabel" runat="server" Text=""
                                CssClass="alert alert-dismissible alert-danger" Visible="false"></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cambioButton" EventName="click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <br />
                    <table class="table table-striped table-hover">
                        <tr>
                            <td class="text-right">Clave:</td>
                            <td>
                                <asp:TextBox ID="claveTextBox" runat="server" Height="26px" Width="280px" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-right">Confirmación Clave</td>
                            <td>
                                <asp:TextBox ID="claveConfirmacionTextBox" runat="server" Height="26px" Width="280px" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                    ControlToCompare="claveTextBox" ControlToValidate="claveConfirmacionTextBox"
                                    CssClass="alert-danger" Display="Static"
                                    ErrorMessage="Las contraseñas no coinciden">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" id="cancel" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <asp:Button ID="cambioButton" runat="server" Text="Cambiar"
                        CssClass="btn btn-primary" OnClick="cambiarClaveButton_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
