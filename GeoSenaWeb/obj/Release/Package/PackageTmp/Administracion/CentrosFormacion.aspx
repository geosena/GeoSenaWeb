<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CentrosFormacion.aspx.cs" Inherits="GeoSenaWeb.CentrosFormacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .fila{
            min-width:400px;
            max-width:700px;
        }
    </style>
    <script>

        function SelectRecordCentro(control) {

            var ID = $(control).closest("tr").find("label").html();
            $(".idTextBox").val(ID);
            $(".consultarButton").click();
            $("#dialog-search-centro").dialog("close");
        }

        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();

            $("#buscarCentroButton").click(function () {
                $("#dialog-search-centro").dialog({
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

            $("#buscarCentro2Button").click(function () {

                var pageUrl = '<%= ResolveUrl("~/Administracion/CentrosFormacion.aspx/GetRecordsCentro") %>';

                var criterio = $("#<%= criterioCentroTextBox.ClientID %>").val();

                var parameter = { "criterio": criterio }

                $.ajax({
                    url: pageUrl,
                    type: "POST",
                    data: JSON.stringify(parameter),
                    contentType: "application/json; charser=utf-8",
                    datatype: "json",
                    success: function (result) {
                        $("#dataCentro").empty();
                        var data = JSON.parse(result.d);
                        var array = data.Table;
                        var temp = "<table class='table'><tr><th>ID Centro</th><th>Descripción</th><th>Selección</th></tr>";
                        for (var i = 0; i < array.length; i++) {
                            temp += "<tr>";
                            temp += "<td><label>" + array[i].IdCentroFormacion + "</label></td>";
                            temp += "<td><label>" + array[i].Descripcion + "</label></td>";
                            temp += "<td><input itag='Select' type='button' value='Seleccionar' onclick='return SelectRecordCentro(this)'/></td>";
                            temp += "</tr>";
                        }
                        temp += "</table>";
                        $("#dataCentro").append(temp);
                    },
                    error: function (err) {
                        alert("Fail " + err);
                    }
                });
            });
        });
    </script>
    <div id="dialog-search-centro" title="Búsqueda de centros de formación" style="display:none;">
        Críterio:
        <asp:TextBox ID="criterioCentroTextBox" CssClass="criterioCentroTextBox" runat="server"></asp:TextBox>
        <input id="buscarCentro2Button" type="button" value="Buscar" />
        <br />
        <div id="dataCentro"></div>
    </div>

    <h1>Centros de Formación</h1>
    <table class="table">
        <tr>
            <td class="text-right">Id Centro:</td>
            <td>
                <asp:TextBox ID="idTextBox" runat="server" Width="100px" CssClass="idTextBox" Height="26px"></asp:TextBox>
                <input id="buscarCentroButton" type="button" value="..." />
            </td>
        </tr>
        <tr>
            <td class="text-right">Descripción:</td>
            <td>
                <asp:TextBox ID="descripcionTextBox" runat="server" CssClass="fila" Height="26px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right"><abbr data-toggle="tooltip" title="https://ejemplo.com">Url</abbr>:</td>
            <td>
                <asp:TextBox ID="urlTextBox" runat="server" CssClass="fila" Width="600px" ToolTip="https://ejemplo.com" Height="26px"></asp:TextBox>
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
            <asp:GridView ID="centroGridView" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="IdCentroFormacion" DataSourceID="centroSqlDataSource" 
        EmptyDataText="No hay registros de datos para mostrar." 
        CssClass="table table-striped table-hover" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="IdCentroFormacion" HeaderText="Id Centro Formación" ReadOnly="True" SortExpression="IdCentroFormacion" />
            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" SortExpression="Descripcion" />
            <asp:TemplateField HeaderText="Url" SortExpression="Url">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Url") %>' Width="400px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <a href='<%# Eval("Url") %>' target="_blank">
                        <span class="ui-icon-search"></span>
                        <%# Eval("Url") %>

                    </a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
       </ContentTemplate>
   </asp:UpdatePanel>
    <asp:SqlDataSource ID="centroSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        DeleteCommand="DELETE FROM [CentroFormacion] WHERE [IdCentroFormacion] = @IdCentroFormacion" 
        InsertCommand="INSERT INTO [CentroFormacion] ([Descripcion], [Url]) VALUES (@Descripcion, @Url)" 
        ProviderName="<%$ ConnectionStrings:GeoSenaDBConnectionString.ProviderName %>" 
        SelectCommand="SELECT [IdCentroFormacion], [Descripcion], [Url] FROM [CentroFormacion]" 
        UpdateCommand="UPDATE [CentroFormacion] SET [Descripcion] = @Descripcion, [Url] = @Url WHERE [IdCentroFormacion] = @IdCentroFormacion">
        <DeleteParameters>
            <asp:Parameter Name="IdCentroFormacion" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Descripcion" Type="String" />
            <asp:Parameter Name="Url" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Descripcion" Type="String" />
            <asp:Parameter Name="Url" Type="String" />
            <asp:Parameter Name="IdCentroFormacion" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
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
</asp:Content>
