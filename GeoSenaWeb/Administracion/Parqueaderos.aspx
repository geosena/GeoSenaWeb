<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Parqueaderos.aspx.cs" Inherits="GeoSenaWeb.Administracion.Parqueaderos" %>
<%@ register assembly="GMaps" namespace="Subgurim.Controles" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .fila{
            min-width:400px;
            max-width:700px;
        }
    </style>
    <script async defer 
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_tz9fTL13nob8D3MPBvpjoRBlE5hfok8&signed_in=true&callback=mostrar">
    </script>

    <script>

        function SelectRecordParqueadero(control) {

            var ID = $(control).closest("tr").find("label").html();
            $(".idTextBox").val(ID);
            $(".consultarButton").click();
            $("#dialog-search-Parqueadero").dialog("close");
        }

        $(document).ready(function () {

            $("#buscarParqueaderoButton").click(function () {
                $("#dialog-search-Parqueadero").dialog({
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

            $("#buscarParqueadero2Button").click(function () {

                var pageUrl = '<%= ResolveUrl("~/Administracion/Parqueaderos.aspx/GetRecordsParqueadero") %>';

                var criterio = $("#<%= criterioParqueaderoTextBox.ClientID %>").val();

                var parameter = { "criterio": criterio }

                $.ajax({
                    url: pageUrl,
                    type: "POST",
                    data: JSON.stringify(parameter),
                    contentType: "application/json; charser=utf-8",
                    datatype: "json",
                    success: function (result) {
                        $("#dataParqueadero").empty();
                        var data = JSON.parse(result.d);
                        var array = data.Table;
                        var temp = "<table class='table'><tr><th>ID Parqueadero</th><th>Descripción</th><th>Selección</th></tr>";
                        for (var i = 0; i < array.length; i++) {
                            temp += "<tr>";
                            temp += "<td><label>" + array[i].IdParqueadero + "</label></td>";
                            temp += "<td><label>" + array[i].Descripcion + "</label></td>";
                            temp += "<td><input itag='Select' type='button' value='Seleccionar' onclick='return SelectRecordParqueadero(this)'/></td>";
                            temp += "</tr>";
                        }
                        temp += "</table>";
                        $("#dataParqueadero").append(temp);
                    },
                    error: function (err) {
                        alert("Fail " + err);
                    }
                });
            });
        });
    </script>
    <div id="dialog-search-Parqueadero" title="Búsqueda de parqueaderos" style="display:none;">
        Críterio:
        <asp:TextBox ID="criterioParqueaderoTextBox" CssClass="criterioParqueaderoTextBox" runat="server"></asp:TextBox>
        <input id="buscarParqueadero2Button" type="button" value="Buscar" />
        <br />
        <div id="dataParqueadero"></div>
    </div>

    <h1>Parqueaderos</h1>
    <table class="table">
        <tr>
            <td >Id Parqueadero:</td>
            <td >
                <asp:TextBox ID="idTextBox" runat="server" Height="26px" CssClass="idTextBox"></asp:TextBox>
                <input id="buscarParqueaderoButton" type="button" value="..." />
            </td>
            <td class="text-right">Sede:</td>
            <td >
                <asp:DropDownList ID="sedeDropDownList" runat="server" Height="26px" Width="400px" DataTextField="Descripcion" DataValueField="IdSede" DataSourceID="sedeSqlDataSource">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td >Descripción:</td>
            <td colspan="2">
                <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="fila" Height="26px"></asp:TextBox>
            </td>
            <td rowspan="8" >
                <asp:Button ID="ObtenerCoordenadasButton" CssClass="btn btn-primary" runat="server" Text="Obtener Coordenadas GPS" OnClick="ObtenerCoordenadasButton_Click" />
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <cc1:gmap ID="GMap1" runat="server" Width="500px" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ObtenerCoordenadasButton" EventName="click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td >Dirección:</td>
            <td colspan="2">
                <asp:TextBox ID="direccionTextBox" runat="server" CssClass="fila address" Height="26px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td >Latitud:</td>
            <td colspan="2" >
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="latitudTextBox" runat="server" Height="26px" Width="250px" CssClass="latitude" ReadOnly="True"></asp:TextBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ObtenerCoordenadasButton" EventName="click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td >Longuitud:</td>
            <td colspan="2" >
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="longuitudTextBox" runat="server" Height="26px" Width="250px" CssClass="longitude" ReadOnly="True"></asp:TextBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ObtenerCoordenadasButton" EventName="click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td >Cupo:</td>
            <td colspan="2">
                <asp:TextBox ID="cupoTextBox" runat="server" CHeight="26px" Width="250px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td >Tipo Teléfono:</td>
            <td colspan="2" >
                <asp:DropDownList ID="tipoTelefono1DropDownList" runat="server" Height="26px" Width="250px" DataSourceID="tipoTelefonoSqlDataSource" DataTextField="Descripcion" DataValueField="IdTipoTelefono">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td >Teléfono:</td>
            <td colspan="2" >
                <asp:TextBox ID="telefono1TextBox" runat="server" Height="26px" Width="250px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td >Horario Atencion:</td>
            <td colspan="2">
                <asp:TextBox ID="horarioTextBox" runat="server" CssClass="fila" Height="52px" TextMode="MultiLine"></asp:TextBox>
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
        <asp:Button ID="modificarButton" runat="server" CssClass="btn btn-warning" Text="Modifcar" Enabled="False" OnClick="modificarButton_Click"  />
        |
        <asp:Button ID="eliminarButton" runat="server" CssClass="btn btn-danger" data-toggle="modal" data-target="#myModal" Text="Eliminar" Enabled="False" />
        |
        <asp:Button ID="limpiarButton" runat="server" CssClass="btn btn-info" Text="Limpiar" OnClick="limpiarButton_Click"  />
        |
        <asp:Button ID="cancelarButton" runat="server" CssClass="btn btn-default" Text="Cancelar" Enabled="False" OnClick="cancelarButton_Click"  />
        |<br />
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView ID="parqueaderoFullGridView" runat="server" AllowPaging="True" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="parqueaderoFullSqlDataSource" 
        EmptyDataText="No hay registros de datos para mostrar." 
        CssClass="table table-striped table-hover">
        <Columns>
            <asp:BoundField DataField="IdParqueadero" HeaderText="Id Parqueadero" InsertVisible="False" ReadOnly="True" SortExpression="IdParqueadero" />
            <asp:BoundField DataField="Parqueadero" HeaderText="Parqueadero" SortExpression="Parqueadero" />
            <asp:BoundField DataField="Cupo" HeaderText="Cupo" SortExpression="Cupo" />
            <asp:BoundField DataField="IdUbicacion" HeaderText="IdUbicacion" SortExpression="IdUbicacion" Visible="False" />
            <asp:BoundField DataField="Direccion" HeaderText="Direccion" SortExpression="Direccion" />
            <asp:BoundField DataField="Latitud" HeaderText="Latitud" SortExpression="Latitud" Visible="False" />
            <asp:BoundField DataField="Longuitud" HeaderText="Longuitud" SortExpression="Longuitud" Visible="False" />
            <asp:BoundField DataField="Horario" HeaderText="Horario" SortExpression="Horario" />
            <asp:BoundField DataField="IdSede" HeaderText="IdSede" SortExpression="IdSede" Visible="False" />
            <asp:BoundField DataField="Sede" HeaderText="Sede" SortExpression="Sede" Visible="False" />
            <asp:BoundField DataField="IdTelefono" HeaderText="IdTelefono" InsertVisible="False" ReadOnly="True" SortExpression="IdTelefono" Visible="False" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
            <asp:BoundField DataField="IdTipoTelefono" HeaderText="IdTipoTelefono" SortExpression="IdTipoTelefono" Visible="False" />
            <asp:BoundField DataField="TipoTelefono" HeaderText="TipoTelefono" SortExpression="TipoTelefono" Visible="False" />
        </Columns>
    </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>



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
                    <asp:Button ID="eliminarButton1" runat="server" CssClass="btn btn-primary" Text="SI" OnClick="eliminarButton_Click" />
                </div>
            </div>
        </div>
    </div>

    
    <asp:SqlDataSource ID="sedeSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" SelectCommand="SELECT [IdSede], [Descripcion] FROM [Sede]
UNION
SELECT 0, '[Seleccione una Sede]'
ORDER BY 2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="tipoTelefonoSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" SelectCommand="SELECT [IdTipoTelefono], [Descripcion] FROM [TipoTelefono]
UNION
SELECT 0, '[Seleccione un tipo de telefono]'
ORDER BY 2"></asp:SqlDataSource>

    <asp:SqlDataSource ID="parqueaderoFullSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        SelectCommand="SELECT Parqueadero.IdParqueadero, Parqueadero.Descripcion AS Parqueadero, 
Parqueadero.Cupo, Parqueadero.IdUbicacion, Ubicacion.Direccion, Ubicacion.Latitud, Ubicacion.Longuitud, 
 Ubicacion.Horario, 
 Parqueadero.IdSede, Sede.Descripcion AS Sede, 
 Telefono.IdTelefono, Telefono.Telefono, 
 Telefono.IdTipoTelefono, TipoTelefono.Descripcion As TipoTelefono
FROM Parqueadero INNER JOIN
 Sede ON Parqueadero.IdSede = Sede.IdSede INNER JOIN
 Ubicacion ON Parqueadero.IdUbicacion = Ubicacion.IdUbicacion INNER JOIN
 Telefono ON Ubicacion.IdUbicacion = Telefono.IdUbicacion INNER JOIN
 TipoTelefono ON Telefono.IdTipoTelefono = TipoTelefono.IdTipoTelefono"></asp:SqlDataSource>

</asp:Content>
