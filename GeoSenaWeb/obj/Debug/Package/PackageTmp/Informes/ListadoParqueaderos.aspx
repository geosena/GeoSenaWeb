<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoParqueaderos.aspx.cs" Inherits="GeoSenaWeb.Informes.ListadoParqueaderos" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-info">
            <div class="panel-heading">
                <h2 class="panel-title">Listado Parqueaderos</h2>
                <br />
                <asp:DropDownList ID="sedesDropDownList" runat="server" DataSourceID="sedesSqlDataSource" 
                    DataTextField="Descripcion" DataValueField="IdSede" CssClass="text-danger">
                </asp:DropDownList>
                
                <asp:Button ID="generarButton" runat="server" Text="Generar"  
                    CssClass="btn btn-default btn-sm" OnClick="generarButton_Click" />
            </div>
            <div class="panel-body center-block">
               <CR:CrystalReportViewer ID="ListadoParqueaderosFormacion" runat="server" AutoDataBind="true"
                    EnableDatabaseLogonPrompt="False" ToolPanelView="None"
                    CssClass="table table-condensed center-block" DisplayStatusbar="False" EnableDrillDown="False" EnableParameterPrompt="False" HasCrystalLogo="False" HasDrilldownTabs="False" HasToggleGroupTreeButton="False" />
            </div>
        </div>
    <asp:SqlDataSource ID="sedesSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>" 
        SelectCommand="SELECT [IdSede], [Descripcion] FROM [Sede]
        UNION
        SELECT 0, '[Seleccione Sede de Formación]'
        ORDER BY 2"></asp:SqlDataSource>

    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-87581383-1', 'auto');
  ga('send', 'pageview');

</script>
</asp:Content>
