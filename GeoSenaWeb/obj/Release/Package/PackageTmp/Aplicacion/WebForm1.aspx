<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="GeoSenaWeb.Aplicacion.WebForm1" %>
<%@ Register Assembly="GMaps" Namespace="Subgurim.Controles" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .map_canvas {
            height: 550px;
            position: relative;
        }
    </style>
    <script>
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
		 
            //obtener el seccion de la pagina donde se va a visualizar el mapa
            //var mapa = document.getElementsByClassName('mapa');
            //obtener la posicion actual por medio de la api de google maps y su metodo LatLng(latitud, longuitud)
            var origen = new google.maps.LatLng(posicion.coords.latitude, posicion.coords.longitude);

            var mapOptions = {
                zoom: 20,
                center: origen,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }

            //almacenar y dibujar el mapa en el navegador
            //var map = new google.maps.Map(subgurim_GMap1, mapOptions);

            var marker = new google.maps.Marker(
                {
                position: origen,
                map: subgurim_GMap1,
                animation: google.maps.Animation.DROP,
                title: "Mi Ubicacion Actual"
                }
            );

            subgurim_GMap1.setZoom(18);


            //var marker_subgurim_Id = new google.maps.Marker({ position: new google.maps.LatLng(10.2, 22), map: subgurim_GMap1 });
            //marker_subgurim_Id.addListener("mouseover", function () {
            //    new google.maps.InfoWindow({ content: 'Ejemplo de <b>infoWindow</b>' }).open(subgurim_GMap1, marker_subgurim_Id);
            //});
            new google.maps.InfoWindow({ content: 'Ejemplo de <b>infoWindow</b>' }).open(subgurim_GMap1, marker);
		
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
	
        }//function onload
    </script>
    <section class="map_canvas">
    <cc1:GMap ID="GMap1" runat="server" enableServerEvents="true" CssClass="mapa" ClientIDMode="AutoID" />
        </section>
</asp:Content>
