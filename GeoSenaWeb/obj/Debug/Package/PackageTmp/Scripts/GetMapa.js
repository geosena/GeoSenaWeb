﻿var geocoder;
var map;
var infowindow = new google.maps.InfoWindow;
var marker = null;
var elevator;
var fromPlace = 0;
var locationFromPlace;
var addressFromPlace;
var placeName;
var defaultLatLng = new google.maps.LatLng(trans.DefaultLat, trans.DefaultLng);
var myOptions = { zoom: 10, mapTypeId: google.maps.MapTypeId.ROADMAP };
var mapLoaded = 0;
function initialize() {
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    var input = document.getElementsByClassName("address");
    var options = {};
    geocoder = new google.maps.Geocoder; setTimeout(checkMap, trans.CheckMapDelay);
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            marker = new google.maps.Marker({ map: map, position: pos });
            map.setCenter(pos);
            mapLoaded = 1;
            geocoder.geocode({ latLng: pos }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[0]) {
                        if (marker != null) marker.setMap(null);
                        marker = new google.maps.Marker({ position: pos, map: map });
                        var infoText = "<strong>" + trans.Geolocation + '</strong> <span id="geocodedAddress">' + results[0].formatted_address + "</span>";
                        infowindow.setContent(infowindowContent(infoText, position.coords.latitude, position.coords.longitude));
                        document.getElementsByClassName("latitude").value = position.coords.latitude;
                        document.getElementsByClassName("longitude").value = position.coords.longitude;
                        document.getElementsByClassName("address").value = results[0].formatted_address;
                        bookUp(results[0].formatted_address, position.coords.latitude, position.coords.longitude);
                        infowindow.open(map, marker);
                        ddversdms()
                    }
                } else {
                    if (marker != null) marker.setMap(null);
                    marker = new google.maps.Marker({ position: pos, map: map });
                    var infoText = "<strong>" + trans.Geolocation + '</strong> <span id="geocodedAddress">' + trans.NoResolvedAddress + "</span>";
                    infowindow.setContent(infowindowContent(infoText, position.coords.latitude, position.coords.longitude));
                    document.getElementsByClassName("latitude").value = position.coords.latitude;
                    document.getElementsByClassName("longitude").value = position.coords.longitude;
                    document.getElementsByClassName("address").value = trans.NoResolvedAddress;
                    bookUp(trans.NoResolvedAddress, position.coords.latitude, position.coords.longitude);
                    infowindow.open(map, marker);
                    ddversdms()
                }
            })
        }, function () { defaultMap() })
    } else { defaultMap() } google.maps.event.addListener(map, "click", codeLatLngfromclick);
    elevator = new google.maps.ElevationService
} function codeAddress() {
    var address = document.getElementsByClassName("address").value;
    if (fromPlace == 1) {
        map.setCenter(locationFromPlace);
        if (marker != null) marker.setMap(null);
        marker = new google.maps.Marker({ map: map, position: locationFromPlace });
        latres = locationFromPlace.lat(); lngres = locationFromPlace.lng();
        if (placeName != "") {
            document.getElementsByClassName("address").value = addressFromPlace;
            var addressForInfoWindow = "<strong>" + placeName + "</strong> " + addressFromPlace
        } else {
            document.getElementsByClassName("address").value = addressFromPlace;
            var addressForInfoWindow = "<strong>" + placeName + "</strong> " + addressFromPlace
        } infowindow.setContent(infowindowContent(addressForInfoWindow, latres, lngres));
        infowindow.open(map, marker);
        document.getElementsByClassName("latitude").value = latres;
        document.getElementsByClassName("longitude").value = lngres;
        bookUp(document.getElementsByClassName("address").value, latres, lngres);
        ddversdms()
    } else {
        geocoder.geocode({ address: address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                if (marker != null) marker.setMap(null)
                ; marker = new google.maps.Marker({ map: map, position: results[0].geometry.location });
                latres = results[0].geometry.location.lat();
                lngres = results[0].geometry.location.lng();
                document.getElementsByClassName("address").value = results[0].formatted_address;
                infowindow.setContent(infowindowContent(document.getElementsByClassName("address").value, latres, lngres));
                infowindow.open(map, marker);
                document.getElementsByClassName("latitude").value = latres;
                document.getElementsByClassName("longitude").value = lngres;
                bookUp(document.getElementsByClassName("address").value, latres, lngres);
                ddversdms()
            } else { alert(trans.GeocodingError + status) }
        })
    }
} function codeLatLng(origin) {
    var lat = parseFloat(document.getElementsByClassName("latitude").value) || 0;
    var lng = parseFloat(document.getElementsByClassName("longitude").value) || 0;
    var latlng = new google.maps.LatLng(lat, lng);
    if (origin == 1) ddversdms();
    geocoder.geocode({ latLng: latlng }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[0]) {
                if (marker != null) marker.setMap(null);
                marker = new google.maps.Marker({ position: latlng, map: map });
                infowindow.setContent(infowindowContent(results[0].formatted_address, lat, lng));
                infowindow.open(map, marker);
                document.getElementsByClassName("address").value = results[0].formatted_address;
                bookUp(document.getElementsByClassName("address").value, lat, lng)
            }
        } else {
            if (marker != null) marker.setMap(null);
            marker = new google.maps.Marker({ position: latlng, map: map });
            infowindow.setContent(infowindowContent(trans.NoResolvedAddress, lat, lng));
            infowindow.open(map, marker);
            document.getElementsByClassName("address").value = trans.NoResolvedAddress;
            bookUp(document.getElementsByClassName("address").value, lat, lng); alert(trans.GeocodingError + status)
        }
    }); map.setCenter(latlng); fromPlace = 0
} function codeLatLngfromclick(event) {
    var lat = event.latLng.lat();
    var lng = event.latLng.lng();
    var latlng = event.latLng; if (marker != null) marker.setMap(null);
    marker = new google.maps.Marker({ position: latlng, map: map });
    map.panTo(latlng); fromPlace = 0;
    infowindow.setContent(infowindowContent("", lat, lng));
    infowindow.open(map, marker);
    document.getElementsByClassName("address").value = "";
    document.getElementsByClassName("latitude").value = lat;
    document.getElementsByClassName("longitude").value = lng;
    bookUp(document.getElementsByClassName("address").value, lat, lng); ddversdms()
} function getElevation() {
    var elevationButton = document.getElementById("altitude");
    elevationButton.innerHTML = '<img src="' + loaderUrl + '"/>';
    var locations = [];
    var clickedLocation = new google.maps.LatLng(marker.position.lat(), marker.position.lng());
    locations.push(clickedLocation); var positionalRequest = { locations: locations };
    elevator.getElevationForLocations(positionalRequest, function (results, status) {
        if (status == google.maps.ElevationStatus.OK) {
            if (results[0]) {
                document.getElementById("altitude").innerHTML = "<strong>" + trans.Altitude + "</strong> " + Math.floor(results[0].elevation) + trans.Meters
            } else { document.getElementById("altitude").innerHTML = trans.NoResult }
        } else { document.getElementById("altitude").innerHTML = trans.ElevationFailure + status }
    })
} function ddversdms() {
    var lat, lng, latdeg, latmin, latsec, lngdeg, lngmin, lngsec;
    lat = parseFloat(document.getElementsByClassName("latitude").value) || 0;
    lng = parseFloat(document.getElementsByClassName("longitude").value) || 0;
    if (lat >= 0) document.getElementById("nord").checked = true;
    if (lat < 0) document.getElementById("sud").checked = true;
    if (lng >= 0) document.getElementById("est").checked = true;
    if (lng < 0) document.getElementById("ouest").checked = true;
    lat = Math.abs(lat);
    lng = Math.abs(lng);
    latdeg = Math.floor(lat);
    latmin = Math.floor((lat - latdeg) * 60);
    latsec = Math.round((lat - latdeg - latmin / 60) * 1e3 * 3600) / 1e3;
    lngdeg = Math.floor(lng); lngmin = Math.floor((lng - lngdeg) * 60);
    lngsec = Math.floor((lng - lngdeg - lngmin / 60) * 1e3 * 3600) / 1e3;
    document.getElementById("latitude_degres").value = latdeg;
    document.getElementById("latitude_minutes").value = latmin;
    document.getElementById("latitude_secondes").value = latsec;
    document.getElementById("longitude_degres").value = lngdeg;
    document.getElementById("longitude_minutes").value = lngmin;
    document.getElementById("longitude_secondes").value = lngsec
} function dmsversdd() {
    var lat, lng, nordsud, estouest, latitude_degres, latitude_minutes, latitude_secondes, longitude_degres, longitude_minutes, longitude_secondes;
    if (document.getElementById("sud").checked) nordsud = -1;
    else nordsud = 1;
    if (document.getElementById("ouest").checked) estouest = -1;
    else estouest = 1;
    latitude_degres = parseFloat(document.getElementById("latitude_degres").value) || 0;
    latitude_minutes = parseFloat(document.getElementById("latitude_minutes").value) || 0;
    latitude_secondes = parseFloat(document.getElementById("latitude_secondes").value) || 0;
    longitude_degres = parseFloat(document.getElementById("longitude_degres").value) || 0;
    longitude_minutes = parseFloat(document.getElementById("longitude_minutes").value) || 0;
    longitude_secondes = parseFloat(document.getElementById("longitude_secondes").value) || 0;
    lat = nordsud * (latitude_degres + latitude_minutes / 60 + latitude_secondes / 3600);
    lng = estouest * (longitude_degres + longitude_minutes / 60 + longitude_secondes / 3600);
    document.getElementsByClassName("latitude").value = Math.round(lat * 1e7) / 1e7;
    document.getElementsByClassName("longitude").value = lng;
    setTimeout(codeLatLng(2), 1e3)
} function infowindowContent(text, latres, lngres) {
    return '<div id="info_window">' + text + "<br/><strong>" + trans.Latitude + "</strong> " + Math.round(latres * 1e6) / 1e6 + " | <strong>" + trans.Longitude + "</strong> " + Math.round(lngres * 1e6) / 1e6 + '<br/><br/><span id="altitude"><button type="button" class="btn btn-primary" onclick="getElevation()">' + trans.GetAltitude + "</button></span>" + bookmark() + "</div>"
} function defaultMap() {
    map.setCenter(defaultLatLng);
    mapLoaded = 1; bookUp(trans.DefaultAddress, trans.DefaultLat, trans.DefaultLng);
    if (marker != null) marker.setMap(null); marker = new google.maps.Marker({ map: map, position: defaultLatLng });
    infowindow.setContent(infowindowContent(trans.DefaultAddress, defaultLatLng.lat(), defaultLatLng.lng()));
    infowindow.open(map, marker); document.getElementsByClassName("latitude").value = defaultLatLng.lat();
    document.getElementsByClassName("longitude").value = defaultLatLng.lng();
    document.getElementsByClassName("address").value = trans.DefaultAddress; ddversdms()
} function checkMap() { if (mapLoaded == 0) { defaultMap() } }
