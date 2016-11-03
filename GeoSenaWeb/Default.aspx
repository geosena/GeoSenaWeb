<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GeoSenaWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .carousel-inner > .item > img,
        .carousel-inner > .item > a > img {
            margin: auto;
            height:250px;
        }
    </style>
    <div class="container">
        <div class="jumbotron">
        <div class="row">
            <div class="col-sm-6">
        <h1>Geo Sena Parq</h1>
        <p class="lead">Sistema de Georreferenciación Web para la ubicación de centros, sedes de formación y 
            parqueaderos aledaños a cada uno de ellos.</p>
                <p>
        <a href="Aplicacion/About.aspx" class="btn btn-primary">Leer Mas... &raquo;</a>
            </p>
                </div>
            <div class="col-sm-6" style="height:300px;">
                <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
                <li data-target="#myCarousel" data-slide-to="3"></li>
            </ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="Images/Logo_sena.png" alt="Sena">
                </div>

                <div class="item">
                    <img src="Images/aspnet.jpg" alt="Asp">
                </div>

                <div class="item">
                    <img src="Images/google-maps.jpeg" alt="Maps">
                </div>

                <div class="item">
                    <img src="Images/java.jpg" alt="Java">
                </div>
            </div>

            <!-- Left and right controls -->
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
            </div>
            </div>
            </div>
    </div>
</asp:Content>
