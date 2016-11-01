<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Navegacion.aspx.cs" Inherits="GeoSenaWeb.Aplicacion.Navegacion" %>

<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /*****mapa*********/
        .mapa {
            width: 100%;
            height: 100%;
            margin: 0 auto -70px;
            top: -25px;
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
            top: 30px;
        }

        footer {
            height: 10px;
            margin: 0;
        }

            footer > p {
                height: 15px;
                margin: 0;
            }
    </style>
     <script>
         var destino;
         var origen;

  window.onload = function () {
      

     if( navigator.geolocation )
        { 
            navigator.geolocation.getCurrentPosition(mostrar, errores);
        }
        else
        {
            //mensaje en caso de que el navegador no soporte la api de navegacion
            alert("Your browser does not support geolocation services.");
        }
        //mapa
        function mostrar(posicion){

            origen = new google.maps.LatLng(posicion.coords.latitude, posicion.coords.longitude);

            var marker = new google.maps.Marker(
                {
                position: origen,
                map: subgurim_GMap1,
                animation: google.maps.Animation.DROP,
                title: "Mi Ubicacion Actual"
                }
            );
            marker.addListener("click", function () {
                new google.maps.InfoWindow({ content: '<b>Mi Ubicación</b>' }).open(subgurim_GMap1, marker);
            });
            //new google.maps.InfoWindow({ content: '<b>Mi Ubicación</b>' }).click(subgurim_GMap1, marker);
            //subgurim_GMap1.setZoom(18);
		
        }//fin mostrar
		
        // errores de navegacion
        function errores(error){
		 
            switch(error.code) {
				
                case error.PERMISSION_DENIED:
                    alert("Oops! No has aceptado compartir tu posición.('User denied the request for Geolocation.')");
                    break;
                case error.POSITION_UNAVAILABLE:
                    alert("Oops! No se puede obtener la posición actual.('Location information is unavailable.')");
                    break;
                case error.TIMEOUT:
                    alert("Oops! Hemos superado el tiempo de espera.('The request to get user location timed out.')");
                    break;
                case error.UNKNOWN_ERROR:
                    alert("Oops! Algo ha salido mal.('An unknown error occurred.')");
                    break;
            }
				
        }//fin errores
	

     $("#trazarRutaButton").click(function () {

      var pageUrl = '<%= ResolveUrl("~/Aplicacion/Navegacion.aspx/GetLatLng") %>';

      var criterio = '<%= sedesDropDownList.SelectedValue%>';

      var parameter = { "criterio": criterio }

      $.ajax({
          url: pageUrl,
          type: "POST",
          data: JSON.stringify(parameter),
          contentType: "application/json; charser=utf-8",
          datatype: "json",
          success: function (result) {

              destino = result.d;

              var directionsDisplay = new google.maps.DirectionsRenderer();
              var directionsService = new google.maps.DirectionsService();

              var request = {
                  origin: origen,
                  destination: destino,
                  travelMode: google.maps.DirectionsTravelMode.DRIVING,
                  unitSystem: google.maps.DirectionsUnitSystem.METRIC,
                  provideRouteAlternatives: true
              };

              directionsService.route(request, function (response, status) {
                  if (status == google.maps.DirectionsStatus.OK) {
                      directionsDisplay.setMap(subgurim_GMap1);
                      //directionsDisplay.setPanel($("#panel_ruta").get(0));
                      directionsDisplay.setDirections(response);
                  } else {
                      if (status == 'ZERO_RESULTS') {
                          alert('No route could be found between the origin and destination.');
                      } else if (status == 'UNKNOWN_ERROR') {
                          alert('A directions request could not be processed due to a server error. The request may succeed if you try again.');
                      } else if (status == 'REQUEST_DENIED') {
                          alert('This webpage is not allowed to use the directions service.');
                      } else if (status == 'OVER_QUERY_LIMIT') {
                          alert('The webpage has gone over the requests limit in too short a period of time.');
                      } else if (status == 'NOT_FOUND') {
                          alert('At least one of the origin, destination, or waypoints could not be geocoded.');
                      } else if (status == 'INVALID_REQUEST') {
                          alert('The DirectionsRequest provided was invalid.');
                      } else {
                          alert("There was an unknown error in your request. Requeststatus: nn" + status);
                      }
                  }
              });
          },
          error: function (err) {
              alert("Fail " + err);
          }
      });
  });

         
  }//function onload

  
    </script>
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
                OnSelectedIndexChanged="sedesDropDownList_SelectedIndexChanged" Visible="False" CssClass="sedeList">
            </asp:DropDownList>
            <asp:Panel runat="server" Visible="false" ID="botonTrazador" CssClass="btn btn-xs">
                <input id="trazarRutaButton" type="button" value="Trazar Ruta" class="btn-success"  />
            </asp:Panel>
            <script>
          
            </script>
        </div>
        <section class="map_canvas">
            <cc1:GMap ID="GMap1" runat="server" Width="100%" Height="100%" CssClass="mapcanvas" 
                enableServerEvents="true" serverEventsType="GMapsAjax" ClientIDMode="AutoID" 
             />
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
