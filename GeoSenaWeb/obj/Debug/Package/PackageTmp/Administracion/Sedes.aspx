<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Sedes.aspx.cs" Inherits="GeoSenaWeb.Administracion.Sedes" %>
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

        function SelectRecordSede(control) {

            var ID = $(control).closest("tr").find("label").html();
            $(".idTextBox").val(ID);
            $(".consultarButton").click();
            $("#dialog-search-sede").dialog("close");
        }

        $(document).ready(function () {

            $("#buscarSedeButton").click(function () {
                $("#dialog-search-sede").dialog({
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

            $("#buscarSede2Button").click(function () {

                var pageUrl = '<%= ResolveUrl("~/Administracion/Sedes.aspx/GetRecordsSede") %>';

                var criterio = $("#<%= criterioSedeTextBox.ClientID %>").val();

                var parameter = { "criterio": criterio }

                $.ajax({
                    url: pageUrl,
                    type: "POST",
                    data: JSON.stringify(parameter),
                    contentType: "application/json; charser=utf-8",
                    datatype: "json",
                    success: function (result) {
                        $("#dataSede").empty();
                        var data = JSON.parse(result.d);
                        var array = data.Table;
                        var temp = "<table class='table'><tr><th>ID Sede</th><th>Descripción</th><th>Selección</th></tr>";
                        for (var i = 0; i < array.length; i++) {
                            temp += "<tr>";
                            temp += "<td><label>" + array[i].IdSede + "</label></td>";
                            temp += "<td><label>" + array[i].Descripcion + "</label></td>";
                            temp += "<td><input itag='Select' type='button' value='Seleccionar' onclick='return SelectRecordSede(this)'/></td>";
                            temp += "</tr>";
                        }
                        temp += "</table>";
                        $("#dataSede").append(temp);
                    },
                    error: function (err) {
                        alert("Fail " + err);
                    }
                });
            });
        });
    </script>
    <div id="dialog-search-sede" title="Búsqueda de sedes de formación" style="display:none;">
        Críterio:
        <asp:TextBox ID="criterioSedeTextBox" CssClass="criterioSedeTextBox" runat="server"></asp:TextBox>
        <input id="buscarSede2Button" type="button" value="Buscar" />
        <br />
        <div id="dataSede"></div>
    </div>


    <h1>Sedes de Formación</h1>
    <table class="table">
        <tr>
            <td >Id Sede:</td>
            <td >
                <asp:TextBox ID="idTextBox" runat="server" Height="26px" CssClass="idTextBox"></asp:TextBox>
                <input id="buscarSedeButton" type="button" value="..." />
            </td>
            <td class="text-right">Centro de Formación:</td>
            <td >
                <asp:DropDownList ID="centroFormacionDropDownList" runat="server" Height="26px" Width="400px" 
                    DataSourceID="centrosSqlDataSource" DataTextField="Descripcion" 
                    DataValueField="IdCentroFormacion">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td >Descripción:</td>
            <td colspan="2">
                <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="fila" Height="26px"></asp:TextBox>
            </td>
            <td rowspan="7" >
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
            <asp:GridView ID="sedeFullGridView" runat="server" AllowPaging="True" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="SedeFullSqlDataSource" 
        EmptyDataText="No hay registros de datos para mostrar." 
        CssClass="table table-striped table-hover">
        <Columns>
            <asp:BoundField DataField="IdSede" HeaderText="Id Sede" InsertVisible="False" ReadOnly="True" SortExpression="IdSede" />
            <asp:BoundField DataField="IdCentroFormacion" HeaderText="IdCentroFormacion" SortExpression="IdCentroFormacion" Visible="False" />
            <asp:BoundField DataField="Sede" HeaderText="Sede" SortExpression="Sede" />
            <asp:BoundField DataField="Direccion" HeaderText="Dirección" SortExpression="Direccion" />
            <asp:BoundField DataField="Latitud" HeaderText="Latitud" SortExpression="Latitud" DataFormatString="{0:N8}" Visible="False" />
            <asp:BoundField DataField="Longuitud" HeaderText="Longuitud" SortExpression="Longuitud" Visible="False" />
            <asp:BoundField DataField="Horario" HeaderText="Horario" SortExpression="Horario" />
            <asp:BoundField DataField="IdTipoTelefono" HeaderText="IdTipoTelefono" SortExpression="IdTipoTelefono" Visible="False" />
            <asp:BoundField DataField="TipoTelefono" HeaderText="Tipo Telefono" SortExpression="TipoTelefono" Visible="False" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
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



    <asp:SqlDataSource ID="SedeFullSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        SelectCommand="SELECT 
                Sede.IdSede, 
                Sede.IdCentroFormacion, 
                Sede.Descripcion AS Sede, 
                Ubicacion.Direccion, 
                Ubicacion.Latitud, 
                Ubicacion.Longuitud, 
                Ubicacion.Horario, 
                Telefono.IdTipoTelefono, 
                TipoTelefono.Descripcion AS TipoTelefono, 
                Telefono.Telefono
                FROM Sede INNER JOIN
                 Ubicacion ON Sede.IdUbicacion = Ubicacion.IdUbicacion 
                 INNER JOIN
                 Telefono ON Ubicacion.IdUbicacion = Telefono.IdUbicacion 
                 INNER JOIN
                 CentroFormacion ON Sede.IdCentroFormacion = CentroFormacion.IdCentroFormacion 
                 INNER JOIN
                 TipoTelefono ON Telefono.IdTipoTelefono = TipoTelefono.IdTipoTelefono">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="centrosSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        SelectCommand="SELECT [IdCentroFormacion], [Descripcion] FROM [CentroFormacion]
                        UNION
                        SELECT 0, '[Seleccione un centro de formacion]'
                        ORDER BY 2">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="tipoTelefonoSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        SelectCommand="SELECT [IdTipoTelefono], [Descripcion] FROM [TipoTelefono]
                        UNION SELECT 0,'[Seleccione un tipo de telefono]'
                        ORDER BY 2">
    </asp:SqlDataSource>

    
    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-87581383-1', 'auto');
  ga('send', 'pageview');

</script>
</asp:Content>
