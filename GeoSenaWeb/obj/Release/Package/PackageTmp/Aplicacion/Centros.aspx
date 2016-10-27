<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Centros.aspx.cs" Inherits="GeoSenaWeb.Aplicacion.Centros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Centros de formación</h1>
    <asp:UpdatePanel runat="server">
       <ContentTemplate>
            <asp:GridView ID="centroGridView" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="IdCentroFormacion" DataSourceID="centroSqlDataSource" 
        EmptyDataText="No hay registros de datos para mostrar." PageSize="15" 
        CssClass="table table-striped table-hover" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="IdCentroFormacion" HeaderText="Id Centro Formación" ReadOnly="True" SortExpression="IdCentroFormacion" Visible="False" />
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
</asp:Content>
