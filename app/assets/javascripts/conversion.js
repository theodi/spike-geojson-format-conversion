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
	alert(fileName)
	if (fileName) {
		let extension = fileName.substr((fileName.lastIndexOf('.') +1));
		return true
	} else {
		return false
	}
}
