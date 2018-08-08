let fileList;

function validateForm() {
	let files = document.forms['converter'][2].files;

	if (files.length !== 0) {
		getFileNames(files);
		return checkForShpFile(fileList)
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
	let fileExtension
	fileList.filter(function(file){
		fileExtension = file.indexOf('.shp') !== -1 ? true : false
	})
	return fileExtension
}
