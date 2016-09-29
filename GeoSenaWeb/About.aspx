<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="GeoSenaWeb.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .legendaDatos {
            border: 2px solid rgba(14,12,172,.6);
            border-radius: 0 10px 10px 10px;
            color: #08449F;
            margin-top: 20px;
        }

        legend {
            font-size: 1.4em;
            font-weight: bold;
            margin-left: 10px;
            margin-bottom: 10px;
            padding: 5px 10px;
            color: #08449F;
            border: 0;
            width: 25%;
        }

        .aprendiz {
            display: block;
            text-align: center;
            margin: 5px 0;
        }

        .aprendiz figure {
            display: inline-block;
            margin: 2px 20px;
        }

        .aprendiz h3 {
            font-size: 1.3em;
            font-style: italic;
            text-decoration: underline;
            color: #08449F;
        }

        .aprendiz img {
            border: 1px solid #08449F;
        }

        p{
            padding:10px 10px;
	        margin:2px auto 0;
            text-align:justify;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
    <div class="container-fluid">
        <fieldset class="legendaDatos">
            <legend>Que es GEO-SENA-PARQ?</legend>
            <p class="lead ">
                Este proyecto es iniciativa de tres aprendices del Sena Centro de Electricidad, Electronica y 
        Telecomunicaciones(CEET), para ayudar a los aprendices e intructores que ingresan por primera vez a un 
        centro de formación Sena; en esta aplicacion web desarrollada en
                <abbr data-toggle="tooltip" title="C# Visual Studio 2015 FrameWork 4.6">ASP.NET</abbr>; podran ubicar en el mapa de 
        google el centro de formacion que desee y sus parqueaderos.
            </p>
            <p class="lead">
                Para quienes se movilizan en vehiculos, motos, tendran la facilidad de trazar una ruta desde 
        el punto de donde se encuentran hasta su centro de formación con un solo click.
            </p>
            <p class="lead">
                Esta aplicacion fue hecha para todos, no es necesario registrarse, solo ubica tu sede e 
        iniciar tu recorrido.
            </p>

            <div class="row">
                <div class="aprendiz">
                    <h3>Aprendices</h3>
                    <figure>
                        <img src="images/consultor.jpg" class="img-thumbnail" alt="Gustavo Adolfo Moreno Muñoz" width="75" height="75" />
                        <figcaption>Gustavo Adolfo Moreno Muñoz</figcaption>
                    </figure>
                    <figure>
                        <img src="images/consultor.jpg" class="img-thumbnail" alt="Nelly Patricia Rodríguez Camen" width="75" height="75" />
                        <figcaption>Nelly Patricia Rodríguez Camen</figcaption>
                    </figure>
                    <figure>
                        <img src="images/consultor.jpg" class="img-thumbnail" alt="William Andres Hurtado Torres" width="75" height="75" />
                        <figcaption>William Andres Hurtado Torres</figcaption>
                    </figure>
                </div>
            </div>
        </fieldset>
    </div>




</asp:Content>
