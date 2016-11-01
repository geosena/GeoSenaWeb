using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Subgurim.Controles;
using System.Configuration;
using System.Data;
using CAD;
using Subgurim.Controles.GoogleChartIconMaker;
using System.Drawing;
using GeoSenaWeb.Models;
using System.Text;
using System.Web.Services;
using System.Data.SqlClient;

namespace GeoSenaWeb.Aplicacion
{
    public partial class Navegacion : System.Web.UI.Page
    {
        string origen = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                iniciarMapa();

                dibujarCentros();
            }
        }

        private void iniciarMapa()
        {
            double latitud = 4.752848270124457;
            double longuitud = -74.0383243560791;
            GLatLng ubicacion = new GLatLng(latitud, longuitud);
            GControl control2 = new GControl(GControl.preBuilt.MenuMapTypeControl, new GControlPosition(GControlPosition.position.Top_Right));
            GControl control = new GControl(GControl.preBuilt.LargeMapControl);
            GMap1.enableHookMouseWheelToZoom = true;
            GMap1.enableGKeyboardHandler = true;
            GMap1.enablePostBackPersistence = false;
            GMap1.Add(control);
            GMap1.Add(control2);
            GMap1.Add(new GControl(GControl.preBuilt.GOverviewMapControl, new GControlPosition(GControlPosition.position.Bottom_Left)));
            GMap1.enableRotation = true;
            GMap1.setCenter(ubicacion, 13);
        }

        private void dibujarCentros()
        {
            GLatLng gLatLng;
            GMarker marcador;
            GInfoWindow info;
            PinLetter pinLetter;

            DataSetGeoSena.SedeFullDataTable miSede = SedeFull.GetDataFull();
            DSGeoSena.CentroFormacionDataTable miCentro = CADCentro.GetData();

            foreach (DataRow item in miCentro.Rows)
            {
                for (int i = 0; i < miSede.Rows.Count; i++)
                {
                    if (item["Descripcion"].Equals(miSede.Rows[i].ItemArray[1].ToString()))
                    {
                        gLatLng = new GLatLng((double)miSede.Rows[i].ItemArray[6], (double)miSede.Rows[i].ItemArray[7]);

                        pinLetter = new PinLetter("C", Color.DarkSlateBlue, Color.White);

                        marcador = new GMarker(gLatLng, new GMarkerOptions(new GIcon(pinLetter.ToString(), pinLetter.Shadow()), true));

                        info =
                            new GInfoWindow(marcador, "<b>" + miSede.Rows[i].ItemArray[1] +
                            "</b><br /><b>Direccion: </b>" + miSede.Rows[i].ItemArray[5] +
                            "<br /><b>Horario: </b>" + miSede.Rows[i].ItemArray[8], false);

                        GMap1.enableHookMouseWheelToZoom = true;

                        GMap1.Add(info);
                        GMap1.enableRotation = true;
                        GMap1.setCenter(gLatLng, 13);
                    }
                }

            }
        }

        protected void centrosFormacionDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (centrosFormacionDropDownList.SelectedIndex == 0)
            {
                sedesDropDownList.Visible = false;
                GMap1.reset();
                iniciarMapa();
                dibujarCentros();
            }
            else
            {
                sedesDropDownList.Visible = true;
                GMap1.reset();
                iniciarMapa();
                dibujarSedes(centrosFormacionDropDownList.SelectedValue);
            }
        }

        private void dibujarSedes(string selectedValue)
        {
            GLatLng gLatLng;
            GMarker marcador;
            GInfoWindow info;
            PinLetter pinLetter;

            DataSetGeoSena.SedeFullDataTable miSede =
                SedeFull.GetDataByIdCentroFormacion(Convert.ToInt32(selectedValue));

            if (miSede.Rows.Count == 0)
            {
                return;
            }

            int idCentroFormacion = (int)miSede.Rows[0].ItemArray[2];
            DSGeoSena.CentroFormacionDataTable miCentro = 
                CADCentro.GetCentroByIdCentroFormacion(idCentroFormacion);

            foreach (DataRow item in miCentro.Rows)
            {
                for (int i = 0; i < miSede.Rows.Count; i++)
                {
                    if (item["Descripcion"].Equals(miSede.Rows[i].ItemArray[1].ToString()))
                    {
                        gLatLng = new GLatLng((double)miSede.Rows[i].ItemArray[6], (double)miSede.Rows[i].ItemArray[7]);

                        pinLetter = new PinLetter("C", Color.DarkSlateBlue, Color.White);

                        marcador = new GMarker(gLatLng, new GMarkerOptions(new GIcon(pinLetter.ToString(), pinLetter.Shadow()), true));

                        info =
                            new GInfoWindow(marcador, "<b>" + miSede.Rows[i].ItemArray[1] +
                            "</b><br /><b>Direccion: </b>" + miSede.Rows[i].ItemArray[5] +
                            "<br /><b>Horario: </b>" + miSede.Rows[i].ItemArray[8], false);

                        GMap1.enableHookMouseWheelToZoom = true;

                        GMap1.Add(info);
                        GMap1.enableRotation = true;
                        GMap1.setCenter(gLatLng, 13);
                    }
                    else
                    {
                        gLatLng = new GLatLng((double)miSede.Rows[i].ItemArray[6], (double)miSede.Rows[i].ItemArray[7]);

                        pinLetter = new PinLetter("S", Color.Yellow, Color.BlueViolet);

                        marcador = new GMarker(gLatLng, new GMarkerOptions(new GIcon(pinLetter.ToString(), pinLetter.Shadow()), true));

                        info =
                            new GInfoWindow(marcador, "<b>" + miSede.Rows[i].ItemArray[1] +
                            "</b><br /><b>Direccion: </b>" + miSede.Rows[i].ItemArray[5] +
                            "<br /><b>Horario: </b>" + miSede.Rows[i].ItemArray[8], false);

                        GMap1.enableHookMouseWheelToZoom = true;

                        GMap1.Add(info);
                        GMap1.enableRotation = true;
                        GMap1.setCenter(gLatLng, 12);
                    }
                }

            }
        }

        protected void sedesDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (sedesDropDownList.SelectedIndex == 0)
            {
                botonTrazador.Visible = false;
                GMap1.reset();
                iniciarMapa();
                dibujarSedes(centrosFormacionDropDownList.SelectedValue);
            }
            else
            {
                botonTrazador.Visible = true;
                GMap1.reset();
                iniciarMapa();
                dibujarParqueaderos(sedesDropDownList.SelectedValue);
                GMap1.Add(new GMapUI());
            }
        }

        private void dibujarParqueaderos(string selectedValue)
        {
            GLatLng gLatLng;
            GMarker marcador;
            GInfoWindow info;
            PinLetter pinLetter;

            DataSetGeoSena.SedeFullDataTable miSede =
                SedeFull.GetDataByIdSede(Convert.ToInt32(selectedValue));

            if (miSede.Rows.Count == 0)
            {
                return;
            }

            gLatLng = new GLatLng((double)miSede.Rows[0].ItemArray[6], (double)miSede.Rows[0].ItemArray[7]);

            pinLetter = new PinLetter("S", Color.Yellow, Color.BlueViolet);

            marcador = 
                new GMarker(gLatLng, new GMarkerOptions(new GIcon(pinLetter.ToString(), pinLetter.Shadow()), true));

            info =
                new GInfoWindow(marcador, "<b>" + miSede.Rows[0].ItemArray[1] +
                "</b><br /><b>Direccion: </b>" + miSede.Rows[0].ItemArray[5] +
                "<br /><b>Horario: </b>" + miSede.Rows[0].ItemArray[8], false);

            GMap1.enableHookMouseWheelToZoom = true;

            GMap1.Add(info);
            GMap1.enableRotation = true;
            GMap1.setCenter(gLatLng, 21);

            int idSede = (int)miSede.Rows[0].ItemArray[0];

            DataSetGeoSena.ParqueaderoFullDataTable miParqueadero =
                ParqueaderoFull.GetDataByIdSede(idSede);

            foreach (DataRow item in miParqueadero.Rows)
            {
                double latitud = (double)item["Latitud"];

                if (miSede.Rows[0].ItemArray[6].ToString().Equals(item["Latitud"].ToString()))
                {
                    latitud -= 0.00004;
                }

                gLatLng = 
                    new GLatLng(latitud, (double)item["Longuitud"]);

                pinLetter = new PinLetter("P", Color.AliceBlue, Color.Red);

                marcador = 
                    new GMarker(gLatLng, new GMarkerOptions(new GIcon(pinLetter.ToString(), pinLetter.Shadow()), true));

                info =
                    new GInfoWindow(marcador, "<b>" + item["Parqueadero"] +
                    "</b><br /><b>Cupo: </b>" + item["Cupo"] +
                    "<br /><b>Horario: </b>" + item["Horario"], false);

                GMap1.enableHookMouseWheelToZoom = true;

                GMap1.Add(info);
                GMap1.enableRotation = true;
                GMap1.setCenter(gLatLng, 21);

            }
        }

        protected void rutaButton_Click(object sender, EventArgs e)
        {
            DataSetGeoSena.SedeFullDataTable miSede =
                SedeFull.GetDataByIdSede(Convert.ToInt32(sedesDropDownList.SelectedValue));

            if (miSede.Rows.Count == 0)
            {
                return;
            }

            string gLatLng = miSede.Rows[0].ItemArray[6].ToString() + miSede.Rows[0].ItemArray[7].ToString();
        }

        [WebMethod]
        public static string GetLatLng(string criterio)
        {
            DataSetGeoSena.SedeFullDataTable miSede =
                SedeFull.GetDataByIdSede(Convert.ToInt32(criterio));

            string gLatLng = 
                miSede.Rows[0].ItemArray[6].ToString() + "," + miSede.Rows[0].ItemArray[7].ToString();

            return gLatLng;
        }
    }
}