<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CentrosFormacion.aspx.cs" Inherits="GeoSenaWeb.CentrosFormacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Centros de Formación</h1>
    <table class="table">
        <tr>
            <td class="text-right">Id Centro:</td>
            <td>
                <asp:TextBox ID="idTextBox" runat="server" Width="100px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">Descripción:</td>
            <td>
                <asp:TextBox ID="descripcionTextBox" runat="server" Width="600px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">Url:</td>
            <td>
                <asp:TextBox ID="urlTextBox" runat="server" Width="600px" ></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:Label ID="MensajeLabel" runat="server" Text="" CssClass="lead"></asp:Label>
     <br />
        <br />
        <asp:Button ID="consultarButton" runat="server" CssClass="btn btn-primary" Text="Consultar" OnClick="consultarButton_Click" />
        |
        <asp:Button ID="nuevoButton" runat="server" CssClass="btn btn-success" Text="Nuevo" OnClick="nuevoButton_Click" />
        |
        <asp:Button ID="modificarButton" runat="server" CssClass="btn btn-warning" Text="Modifcar" Enabled="False" OnClick="modificarButton_Click"  />
        |
        <asp:Button ID="eliminarButton" runat="server" CssClass="btn btn-danger" data-toggle="modal" data-target="#myModal" Text="Eliminar" Enabled="False" OnClick="eliminarButton_Click" />
        |
        <asp:Button ID="limpiarButton" runat="server" CssClass="btn btn-info" Text="Limpiar" OnClick="limpiarButton_Click"  />
        |
        <asp:Button ID="cancelarButton" runat="server" CssClass="btn btn-default" Text="Cancelar" Enabled="False" OnClick="cancelarButton_Click"  />
        |<br />
    <br />
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
    <asp:SqlDataSource ID="centroSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" DeleteCommand="DELETE FROM [CentroFormacion] WHERE [IdCentroFormacion] = @IdCentroFormacion" InsertCommand="INSERT INTO [CentroFormacion] ([Descripcion], [Url]) VALUES (@Descripcion, @Url)" ProviderName="<%$ ConnectionStrings:GeoSenaDBConnectionString.ProviderName %>" SelectCommand="SELECT [IdCentroFormacion], [Descripcion], [Url] FROM [CentroFormacion]" UpdateCommand="UPDATE [CentroFormacion] SET [Descripcion] = @Descripcion, [Url] = @Url WHERE [IdCentroFormacion] = @IdCentroFormacion">
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

</asp:Content>
