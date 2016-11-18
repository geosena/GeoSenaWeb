<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UsoAplicacion.aspx.cs" Inherits="GeoSenaWeb.Informes.UsoAplicacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        /* Google Embed API */
        (function (w, d, s, g, js, fjs) {
            g = w.gapi || (w.gapi = {});
            g.analytics = {
                q: [], ready: function (cb) { this.q.push(cb) }
            };
            js = d.createElement(s);
            fjs = d.getElementsByTagName(s)[0];
            js.src = 'https://apis.google.com/js/platform.js';
            fjs.parentNode.insertBefore(js, fjs);
            js.onload = function () { g.load('analytics') };
        }
        (window, document, 'script'));
    </script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- YOUR API ID, CREATE YOURS IN GOOGLE APIs CONSOLE -->
    <script>var GOOGLE_API_CLIENT_ID = '769688108262-i3bukpo02u32pmv1qb5bq6kb52no1ur4.apps.googleusercontent.com'; </script>
    <script src="../Scripts/bootboard.0.2.min.js"></script>
    <span id="auth-button"></span>
    <!-- DASHBOARD HEADER -->
    <main class="container theme-showcase" role="main">
        
        <div class="page-header">
            <h1>Google Analytics Dashboard</h1>
            <p>Define tus propios gráficos</p>
        </div>

        <div class="row">
            <div class="col-xs-12 panel panel-defailt">
                <div class="panel-body" id="view-selector"></div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-xs-12">
                <a class="btn btn-info" data-toggle="collapse" href="#filters" aria-expanded="false" aria-controls="collapseExample">Segmentos</a>
                <div id="filters" class="collapse panel panel-default">
                    <div class="panel-body">
                        <div class="col-xs-12 form-inline">
                            <div class="form-group">
                                <label for="medium-selector"><span class="glyphicon glyphicon-filter"></span>Filter By Medium</label>
                                <select id="medium-selector" class="segment-selector form-control">
                                    <option value="">All Mediums</option>
                                    <option value="ga:medium=~^\((none|not set)\)$">Direct</option>
                                    <option value="ga:medium==organic">SEO</option>
                                    <option value="ga:medium==cpc">SEM</option>
                                    <option value="ga:medium==referral">Referral</option>
                                    <option value="ga:medium!~\((none|not set)\);ga:medium!~^(organic|cpc|referral)$">Others</option>
                                </select>
                            </div>
                            &nbsp;
            <div class="form-group">
                <label for="device-selector"><span class="glyphicon glyphicon-filter"></span>Filter By Devices</label>
                <select id="device-selector" class="segment-selector form-control">
                    <option value="">All Devices</option>
                    <option value="ga:deviceCategory==desktop">Desktop</option>
                    <option value="ga:deviceCategory==tablet">Tablet</option>
                    <option value="ga:deviceCategory==mobile">Mobile</option>
                    <option value="ga:deviceCategory=~(desktop|tablet)">Desktop & Tablet</option>
                    <option value="ga:deviceCategory=~(mobile|tablet)">Mobile & Tablet</option>
                </select>
            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /DASHBOARD HEADER -->

        <!-- DASHBOARD CHARTS -->
        <div id="dashboard" class="row">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="panel panel-default ">
                        <div class="panel-body">
                            <div class="ga-chart xsmall-height "
                                title="Nuevos Usuarios"
                                data-type="metric"
                                data-dimensions=""
                                data-metrics="ga:newUsers"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-colors="#666"
                                data-template="{data} <span class='glyphicon glyphicon-user'></span>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="panel panel-default ">
                        <div class="panel-body">
                            <div class="ga-chart xsmall-height "
                                title="Total Paginas Visitadas"
                                data-type="metric"
                                data-dimensions=""
                                data-metrics="ga:pageviews"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-colors="#666"
                                data-template="{data} <span class='glyphicon glyphicon-signal'></span>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="panel panel-default ">
                        <div class="panel-body">
                            <div class="ga-chart xsmall-height "
                                title="Páginas/Sesión"
                                data-type="metric"
                                data-dimensions=""
                                data-metrics="ga:pageviewsPerSession"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-colors="#666"
                                data-template="{data} <span class='glyphicon glyphicon-ok'></span>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 col-xs-12">
                    <div class="panel panel-default ">
                        <div class="panel-body">
                            <div class="ga-chart xsmall-height "
                                title="Transacciones"
                                data-type="metric"
                                data-dimensions=""
                                data-metrics="ga:transactions"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-colors="#DC3912"
                                data-template="{data} <span class='glyphicon glyphicon-shopping-cart'></span>">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- .row -->

            <div class="row">
                <div class="col-md-12 col-xs-12">
                    <div class="panel panel-default ">
                        <div class="panel-heading">Tendencia del tráfico con controles</div>
                        <div class="panel-body">
                            <div class="col-md-2 col-xs-12">
                                <select class="ga-chart-control form-control"
                                    data-queryvar="metrics"
                                    data-targetids="trend-chart">
                                    <option value="ga:sessions" data-colors="#0099C6">Sesiones</option>
                                    <option value="ga:transactions" data-colors="#DC3912">Transacciones</option>
                                </select>
                                <select class="ga-chart-control form-control"
                                    data-queryvar="dimensions"
                                    data-targetids="trend-chart">
                                    <option value="ga:date">Por Días</option>
                                    <option value="ga:yearWeek">Por semanas</option>
                                </select>
                            </div>
                            <div class="col-md-10 col-xs-12">
                                <div class="ga-chart small-height" id="trend-chart"
                                    title="Últimos 30 días"
                                    data-type="line"
                                    data-dimensions="ga:date"
                                    data-metrics="ga:sessions"
                                    data-start-date="30daysAgo"
                                    data-end-date="yesterday"
                                    data-filter=""
                                    data-segment=""
                                    data-colors="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- .row -->

            <div class="row">
                <div class="col-md-4 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Distribución por medios</div>
                        <div class="panel-body">
                            <div class="ga-chart"
                                title=""
                                data-type="donut"
                                data-dimensions="ga:userType"
                                data-metrics="ga:sessions"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-colors="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Distribución por Navegadores</div>
                        <div class="panel-body">
                            <div class="ga-chart"
                                title=""
                                data-type="TABLE"
                                data-dimensions="ga:browser"
                                data-metrics="ga:sessions"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-onselect="segment">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Distribución por dispositivos</div>
                        <div class="panel-body">
                            <div class="ga-chart"
                                title=""
                                data-type="column"
                                data-dimensions="ga:deviceCategory"
                                data-metrics="ga:sessions,ga:transactions"
                                data-start-date="30daysAgo"
                                data-end-date="yesterday"
                                data-filter=""
                                data-segment=""
                                data-colors="#f60">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- .row -->

        </div>
        <!-- End Dashboard -->
    </main>
    <!-- /DASHBOARD CHARTS -->
</asp:Content>
