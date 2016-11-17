<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoCentros.aspx.cs" Inherits="GeoSenaWeb.Informes.ListadoCentros" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-info">
            <div class="panel-heading">
                <h2 class="panel-title">Listado Centros de Formacion</h2>
            </div>
            <div class="panel-body center-block">
               <CR:CrystalReportViewer ID="ListadoCentrosFormacion" runat="server" AutoDataBind="true"
                    EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" ToolPanelView="None"
                    CssClass="table table-condensed center-block" DisplayStatusbar="False" EnableDrillDown="False" HasCrystalLogo="False" HasDrilldownTabs="False" HasToggleGroupTreeButton="False" />
            </div>
        </div>
</asp:Content>
