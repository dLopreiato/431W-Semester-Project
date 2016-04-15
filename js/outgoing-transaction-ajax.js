$(document).ready(function() {
    populateTables();
});

function populateTables() {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetOutgoingTransactions.php',
        dataType: 'json',
        success: function(data) {
			var purchaseData = data.purchases;
			var rentalData = data.rentals;
			$.each(purchaseData, function (i, item) {
				addPurchaseToTable(item.sale_id, item.item_id, item.description, item.amount, item.shipping_name, item.street, item.city, item.state, item.zip_code, item.sent, item.received);
			});
			$.each(rentalData, function (i, item) {
				addRentalToTable(item.item_id, item.rental_id, item.description, item.serial_number, item.shipping_name, item.street, item.city, item.state, item.zip_code, item.sent, item.due_date, item.received, item.was_returned);
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

function addPurchaseToTable(saleID, itemID, description, amount, shippingName, street, city, state, zipCode, sent, received){
	
	var address = shippingName + " " + street + ", " + city + ", " + state + " " + zipCode;
	 
	var appendString = '<tr id="' + saleID + '"><td><a href="product.html?id=' + itemID +  '">' + description + '</a></td><td>' + amount +  '</td><td>' + address + '</td>';

	if (sent != null){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><button type="button" class="btn btn-warning" onclick="markPurchaseSent(\'' + saleID + "\', \'" + itemID + "\', \'" + description + "\', \'" + amount + "\', \'" + shippingName + "\', \'" + street + "\', \'" + city + "\', \'" + state + "\', \'" + zipCode + "\', \'"+ sent + "\', \'" + received  + '\');">Mark Sent</button></td>';
	}
	
	if (received != null){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></td>';
	}
	
	appendString += '</tr>';
	
	$('#purchased-table tbody').append(appendString);
}


function markPurchaseSent(saleID, itemID, description, amount, shippingName, street, city, state, zipCode, sent, received) {
	
	var sendData = {sale_id: saleID};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/MarkSent.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				$('#' + saleID).remove();
				addPurchaseToTable(saleID, itemID, description, amount, shippingName, street, city, state, zipCode, 1, received);
            }
            else {
                displayGeneralUserError('Unable to mark this purchase as sent.  Please try again later. ');
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

function addRentalToTable(itemID, rentalID, description, serialNumber, shippingName, street, city, state, zipCode, sent, dueDate, received, wasReturned){

			
	var address = shippingName + " " + street + ", " + city + ", " + state + " " + zipCode;

	var appendString = '<tr id="' + rentalID + '"><td><a href="product.html?id=' + itemID +  '">' + description + '</a></td><td>' + serialNumber +  '</td><td>' + address + '</td><td>' + dueDate +  '</td>';
	
	if (sent == 1){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><button type="button" class="btn btn-warning" onclick="markRentalSent(\'' + itemID + "\', \'" + rentalID + "\', \'" + description + "\', \'" + serialNumber  + "\', \'" + shippingName + "\', \'" + street + "\', \'" + city + "\', \'" + state + "\', \'"+ zipCode +  "\', \'" + sent + "\', \'" + dueDate +  "\', \'"  + received  + "\', \'" + wasReturned  + '\');">Mark Sent</button></td>';
	}
	
	if (received == 1){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></td>';
	}
	
	if (wasReturned == 1){
		appendString += '<td><span class="glyphicon glyphicon-ok" aria-hidden="true"></span></td>';
	}
	else{
		appendString += '<td><button type="button" class="btn btn-warning" onclick="markRentalReturned(\'' + itemID + "\', \'" + rentalID + "\', \'" + description + "\', \'" + serialNumber  + "\', \'" + shippingName + "\', \'" + street + "\', \'" + city + "\', \'" + state + "\', \'"+ zipCode +  "\', \'" + sent + "\', \'" + dueDate +  "\', \'"  + received  + "\', \'" + wasReturned  + '\');">Mark Returned</button></td>';
	}
	
	appendString += '</tr>';
	
	$('#rented-table tbody').append(appendString);
}

function markRentalSent(itemID, rentalID, description, serialNumber, shippingName, street, city, state, zipCode, sent, dueDate, received, wasReturned) {
	
	var sendData = {rental_id: rentalID};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/MarkSent.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				$('#' + rentalID).remove();
				addRentalToTable(itemID, rentalID, description, serialNumber, shippingName, street, city, state, zipCode, 1, dueDate, received, wasReturned);
            }
            else {
                displayGeneralUserError('Unable to mark this rental as sent.  Please try again later. ');
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

function markRentalReturned(itemID, rentalID, description, serialNumber, shippingName, street, city, state, zipCode, sent, dueDate, received, wasReturned) {
	
	var sendData = {rental_id: rentalID};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/ReturnRental.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				$('#' + rentalID).remove();
				addRentalToTable(itemID, rentalID, description, serialNumber, shippingName, street, city, state, zipCode, sent, dueDate, received, 1);
            }
            else {
                displayGeneralUserError('Unable to mark this rental as sent.  Please try again later. ');
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

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}