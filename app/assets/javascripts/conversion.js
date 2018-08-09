// Validation of file upload and form submission

let fileList;

function validateForm() {
	let files = document.forms['converter'][2].files;

	if (files.length !== 0) {
		getFileNames(files);
		return checkForShpFile(fileList);
	} else {
		document.querySelector('form').onsubmit = function(e) {
		  e.preventDefault();
		}
	}
}

function getFileNames(files) {
	fileList = [];
	for (let i = 0; i < files.length; i++) {
		fileList.push(files[i].name);
	}
}

function checkForShpFile(fileList) {
 	let fileName = fileList.find(function(element) {
		return element.includes('.shp');
	})
	return fileName ? fileName.substr((fileName.lastIndexOf('.') +1)) : false;
}

// Leaflet.js mapping
$( document ).ready(function() {
	let map = L.map('mapid').setView([0, 0], 5);

	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: '&copy; <a href=”http://osm.org/copyright”>OpenStreetMap</a> contributors'
	}).addTo(map);

	$.getJSON("geojson/tmp.geojson",function(data){
		let datalayer = L.geoJson(data ,{
			onEachFeature: function(feature, featureLayer) {
				featureLayer.bindPopup(feature.properties);
			}
		}).addTo(map);
		map.fitBounds(datalayer.getBounds());
	});
});
