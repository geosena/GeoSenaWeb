<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoUsuarios.aspx.cs" Inherits="GeoSenaWeb.Informes.ListadoUsuarios" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-info">
            <div class="panel-heading">
                <h2 class="panel-title">Listado Usuarios</h2>
                <br />
                <asp:DropDownList ID="centrosDropDownList" runat="server" DataSourceID="CentrosSqlDataSource" 
                    DataTextField="Descripcion" DataValueField="IdCentroFormacion" CssClass="text-danger">
                </asp:DropDownList>
                
                <asp:Button ID="generarButton" runat="server" Text="Generar" OnClick="generarButton_Click" 
                    CssClass="btn btn-default btn-sm" />
            </div>
            <div class="panel-body center-block">
               <CR:CrystalReportViewer ID="ListadoUsuariosFormacion" runat="server" AutoDataBind="true"
                    EnableDatabaseLogonPrompt="False" ToolPanelView="None"
                    CssClass="table table-condensed center-block" DisplayStatusbar="False" EnableParameterPrompt="False" HasCrystalLogo="False" HasDrilldownTabs="False" HasToggleGroupTreeButton="False" EnableDrillDown="False" />
            </div>
        </div>
    <asp:SqlDataSource ID="CentrosSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        SelectCommand="SELECT [IdCentroFormacion], [Descripcion] FROM [CentroFormacion]
        UNION
        SELECT 0, '[Seleccione Centro de Formación]'
        ORDER BY 2"></asp:SqlDataSource>
</asp:Content>
