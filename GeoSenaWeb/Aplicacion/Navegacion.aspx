<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Navegacion.aspx.cs" Inherits="GeoSenaWeb.Aplicacion.Navegacion" %>

<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA_tz9fTL13nob8D3MPBvpjoRBlE5hfok8&signed_in=true&callback=mostrar">
    </script>
    <style>
        /*****mapa*********/
        .mapa {
            width: 100%;
            height: 100%;
            margin: 0 auto -82px;
            top: -42px;
            display: block;
            position: relative;
            padding: 0;
            border: 0.15em solid #FFFFFF;
        }

        .map_canvas {
            height: 550px;
            position: relative;
        }

        .opcion {
            position: relative;
            overflow: hidden;
            z-index: 2;
            width: 100%;
            top: 47px;
        }
        footer{
            height:10px;
            margin:0;
        }
        footer>p{
            height:15px;
            margin:0;
        }
    </style>
    <!--Section-->

    <div class="mapa">
        <!--Centros-->
        <div class="opcion">
            <asp:DropDownList ID="centrosFormacionDropDownList" runat="server"
                DataSourceID="centrosSqlDataSource" DataTextField="Descripcion"
                DataValueField="IdCentroFormacion" AutoPostBack="true"
                OnSelectedIndexChanged="centrosFormacionDropDownList_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:DropDownList ID="sedesDropDownList" runat="server"
                        DataSourceID="sedesSqlDataSource" DataTextField="Sede"
                        DataValueField="IdSede" AutoPostBack="true"
                        OnSelectedIndexChanged="sedesDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
        </div>
        <section class="map_canvas">
            <cc1:GMap ID="GMap1" runat="server" Width="100%" Height="100%" />
        </section>
    </div>

    <asp:SqlDataSource ID="centrosSqlDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>"
        SelectCommand="SELECT [IdCentroFormacion], [Descripcion] FROM [CentroFormacion]
        UNION
        SELECT 0, '[Seleccione un Centro]'
        ORDER BY 2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sedesSqlDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:GeoSenaDBConnectionString %>"
        SelectCommand="SELECT Sede.IdCentroFormacion, CentroFormacion.Descripcion AS CentroFormacion, 
            Sede.IdSede, Sede.Descripcion AS Sede, 
            Ubicacion.Direccion, Ubicacion.Latitud, Ubicacion.Longuitud, Ubicacion.Horario, Telefono.Telefono
            FROM CentroFormacion INNER JOIN
             Sede ON CentroFormacion.IdCentroFormacion = Sede.IdCentroFormacion INNER JOIN
             Ubicacion ON Sede.IdUbicacion = Ubicacion.IdUbicacion INNER JOIN
             Telefono ON Ubicacion.IdUbicacion = Telefono.IdUbicacion
             WHERE Sede.IdCentroFormacion = @IdCentroFormacion
             UNION
            SELECT 0,'',0,'[Seleccione una Sede]','',0,0,'',''
            ORDER BY 2">
        <SelectParameters>
            <asp:ControlParameter ControlID="centrosFormacionDropDownList"
                Name="IdCentroFormacion" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
