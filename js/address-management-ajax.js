$(document).ready(function() {
    populateExistingAddresses();
});

function populateExistingAddresses() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetAddresses.php',
        dataType: 'json',
        success: function(data) {
			$.each(data, function (i, item) {
				addAddressToTable(item.address_id, item.shipping_name, item.street, item.city, item.state, item.zip_code);
			});
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
				displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
            }
        }
    });
}

function addAddressToTable(addressID, shippingName, street, city, state, zipCode) {
	var appendString = '<tr id="' + addressID + '"><td>' + shippingName + '</td><td>' + street + '</td><td>' + city + '</td><td>' + state + '</td><td>' + zipCode + '</td><td><button type="button" class="btn btn-danger" onclick="removeAddress(\'' + addressID  + '\');">Remove Address</button></td></tr>';
	$('#existing-addresses tbody').append(appendString);
}

function removeAddress(addressID) {
	
	var sendData = {address_id: addressID};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/DeleteAddress.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				$('#' + addressID).remove();
            }
            else {
                displayGeneralUserError('Unable to delete this address.  Please try again later. ');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + '\n' + thrownError);
                displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
            }
        }
    });
	
	console.log("deleting address with ID: " + addressID);
}

function addNewAddress() {
	var shippingName = $('input:text[name=shippingName]').val();
	var street = $('input:text[name=street]').val();
	var city = $('input:text[name=city]').val();
	var state = $('#state1 option:selected').val();
	var zipCode = $('input:text[name=zipCode]').val();
	
    var sendData = {shipping_name: shippingName, street: street, city: city, state: state, zip_code: zipCode};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/AddAddress.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				/* This seems wasteful, but an address is identified by ID, which isn't assigned until it's put
				into the database since it's autoincrementing, and there doesn't seem to be another easy
				way to uniquely identify an address without hashing the entirety of every field.*/
				removeAddressesFromTable();
				populateExistingAddresses();
				$("#shippingName1").val('');
				$("#street1").val('');
				$("#city1").val('');
				$("#state1").val('');
				$("#zipCode1").val('');
            }
            else {
                displayGeneralUserError('Unable to add this address.  Please try again later');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
            for (var key in serverErrorInfo) {
                console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + '\n' + thrownError);
                displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
            }
        }
    });
}

function removeAddressesFromTable() {
	$("#existing-addresses tbody").html("");
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}