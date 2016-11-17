<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="GeoSenaWeb.Administracion.Usuarios" %>

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

                var pageUrl = '<%= ResolveUrl("~/Administracion/Usuarios.aspx/GetRecordsUsuario") %>';

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
                        var temp = "<table class='table'><tr><th>Usuario Nick</th><th>Nombres</th><th>Selección</th></tr>";
                        for (var i = 0; i < array.length; i++) {
                            temp += "<tr>";
                            temp += "<td style='display:none;'><label>" + array[i].Identificacion + "</label></td>";
                            temp += "<td><label>" + array[i].Nick + "</label></td>";
                            temp += "<td><label>" + array[i].Nombres + " " + array[i].Apellidos + "</label></td>";
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
        Críterio:
        <asp:TextBox ID="criterioUsuarioTextBox" CssClass="criterioUsuarioTextBox" runat="server"></asp:TextBox>
        <input id="buscarUsuario2Button" type="button" value="Buscar" />
        <br />
        <div id="dataUsuario"></div>
    </div>

    <h1>Usuarios</h1>


    <table class="table">
        <tr>
            <td class="text-right">Id Usuario:
            </td>
            <td>
                <asp:TextBox ID="idTextBox" runat="server" Height="26px" Width="100px"></asp:TextBox>
            </td>
            <td class="text-right">Centro de Formación</td>
            <td>
                <asp:DropDownList ID="centrosDropDownList" runat="server" DataSourceID="centroSqlDataSource"
                    DataTextField="Descripcion" DataValueField="IdCentroFormacion" Height="26px" CssClass="fila">
                </asp:DropDownList>
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
            <td>
                <asp:TextBox ID="apellidosTextBox" runat="server" Height="26px" CssClass="fila"></asp:TextBox>
            </td>
            <td class="text-right">
                <asp:Label ID="claveLabel" runat="server" Text="Clave:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="passwordTextBox" runat="server" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">Identificación</td>
            <td>
                <asp:TextBox ID="identificacionTextBox" runat="server" Height="26px" Width="280px" CssClass="idTextBox"></asp:TextBox>
            </td>
            <td class="text-right">Usuario:</td>
            <td>
                <asp:TextBox ID="usuarioTextBox" runat="server" Height="26px" Width="280px"></asp:TextBox>
                <input id="buscarUsuarioButton" type="button" value="..." />
            </td>
        </tr>
        <tr>
            <td class="text-right">Correo (MISENA):</td>
            <td>
                <asp:TextBox ID="correoTextBox" runat="server" Height="26px" Width="280px"></asp:TextBox>
            </td>
            <td class="text-right">Fecha Modificación Clave:</td>
            <td>
                <asp:TextBox ID="fechaModificacionTextBox" runat="server" Height="26px" Width="280px" ReadOnly="True"></asp:TextBox>
            </td>
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
            <asp:GridView ID="usuarioGridView" runat="server" AutoGenerateColumns="False"
        DataKeyNames="IdUsuario" DataSourceID="usuarioSqlDataSource"
        EmptyDataText="No hay registros de datos para mostrar." AllowPaging="True"
        AllowSorting="True" CssClass="table table-striped table-hover">
        <Columns>
            <asp:BoundField DataField="IdUsuario" HeaderText="Id Usuario" ReadOnly="True" SortExpression="IdUsuario" />
            <asp:BoundField DataField="Apellidos" HeaderText="Apellidos" SortExpression="Apellidos" />
            <asp:BoundField DataField="Nombres" HeaderText="Nombres" SortExpression="Nombres" />
            <asp:BoundField DataField="Identificacion" HeaderText="Identificación" SortExpression="Identificacion" />
            <asp:BoundField DataField="Nick" HeaderText="Nick" SortExpression="Nick" />
            <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" Visible="False" />
            <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
            <asp:TemplateField HeaderText="Centro Formacion" SortExpression="IdCentroFormacion">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="centroSqlDataSource" DataTextField="Descripcion" DataValueField="IdCentroFormacion" Enabled="False" SelectedValue='<%# Bind("IdCentroFormacion") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="centroFDropDownList" runat="server"
                        DataSourceID="centroSqlDataSource" DataTextField="Descripcion"
                        DataValueField="IdCentroFormacion" Enabled="False"
                        SelectedValue='<%# Bind("IdCentroFormacion") %>'>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FechaModificacionClave" HeaderText="Fecha Modificación Clave" SortExpression="FechaModificacionClave" DataFormatString="{0:D}" />
        </Columns>
    </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="usuarioSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        DeleteCommand="DELETE FROM [Usuario] WHERE [IdUsuario] = @IdUsuario" 
        InsertCommand="INSERT INTO [Usuario] ([Apellidos], [Nombres], [Identificacion], [Nick], [Password], [Correo], [IdCentroFormacion], [FechaModificacionClave]) VALUES (@Apellidos, @Nombres, @Identificacion, @Nick, @Password, @Correo, @IdCentroFormacion, @FechaModificacionClave)" 
        ProviderName="<%$ ConnectionStrings:GeoSenaDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT [IdUsuario], [Apellidos], [Nombres], [Identificacion], [Nick], [Password], [Correo], [IdCentroFormacion], [FechaModificacionClave] FROM [Usuario]" 
        UpdateCommand="UPDATE [Usuario] SET [Apellidos] = @Apellidos, [Nombres] = @Nombres, [Identificacion] = @Identificacion, [Nick] = @Nick, [Password] = @Password, [Correo] = @Correo, [IdCentroFormacion] = @IdCentroFormacion, [FechaModificacionClave] = @FechaModificacionClave WHERE [IdUsuario] = @IdUsuario">
        <DeleteParameters>
            <asp:Parameter Name="IdUsuario" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Apellidos" Type="String" />
            <asp:Parameter Name="Nombres" Type="String" />
            <asp:Parameter Name="Identificacion" Type="Int32" />
            <asp:Parameter Name="Nick" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="Correo" Type="String" />
            <asp:Parameter Name="IdCentroFormacion" Type="Int32" />
            <asp:Parameter DbType="Date" Name="FechaModificacionClave" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Apellidos" Type="String" />
            <asp:Parameter Name="Nombres" Type="String" />
            <asp:Parameter Name="Identificacion" Type="Int32" />
            <asp:Parameter Name="Nick" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="Correo" Type="String" />
            <asp:Parameter Name="IdCentroFormacion" Type="Int32" />
            <asp:Parameter DbType="Date" Name="FechaModificacionClave" />
            <asp:Parameter Name="IdUsuario" Type="Int32" />
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

    
    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-87581383-1', 'auto');
  ga('send', 'pageview');

</script>
</asp:Content>
