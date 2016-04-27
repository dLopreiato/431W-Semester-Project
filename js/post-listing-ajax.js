$(document).ready(function() {
	addHeading();
});

function addHeading(){
	
	var sendData = {item_id: $.urlParam('id')};
	
	$.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetProductInfo.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data) {
				displayHeading(data.description);
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

function displayHeading(description){
	
	var appendString = '<h1>' + description + '</h1><br>';
	$('#heading').append(appendString);
	
}


function postItemAuction() {
	
	var itemID = $.urlParam('id');
	var reservePrice = $('input:text[name=reservePrice]').val();
	var numInStock = $('input:text[name=numInStock]').val();
	
    var sendData = {item_id: itemID, reserve_price: reservePrice, number_in_stock: numInStock};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/PostItemAuction.php',
        dataType: 'json',
        data: sendData,
        method: 'POST',
        success: function(data) {
            if (data) {
				displaySuccess();
				$("#reservePrice1").val('');
				$("#numInStock1").val('');
            }
            else {
                displayGeneralUserError('Unable to post this item for auction.  Please try again later');
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

function postItemSale() {
	
	var itemID = $.urlParam('id');
	var listedPrice = $('input:text[name=listedPrice]').val();
	var numInStock = $('input:text[name=numInStock2]').val();
	
    var sendData = {item_id: itemID, listed_price: listedPrice, number_in_stock: numInStock};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/PostItemSale.php',
        dataType: 'json',
        data: sendData,
        method: 'POST',
        success: function(data) {
            if (data) {
				displaySuccess();
				$("#listedPrice1").val('');
				$("#numInStock3").val('');
            }
            else {
                displayGeneralUserError('Unable to post this item for sale.  Please try again later');
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

function postItemRent() {
	
	var itemID = $.urlParam('id');
	var serialNumber = $('input:text[name=serialNumber]').val();
	var rentalTime = $('input:text[name=rentalTime]').val();
	var rentalPrice = $('input:text[name=rentalPrice]').val();
	
    var sendData = {item_id: itemID, serial_number: serialNumber, rental_time_unit: rentalTime, price_listing: rentalPrice};

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/PostItemRental.php',
        dataType: 'json',
        data: sendData,
        method: 'POST',
        success: function(data) {
            if (data) {
				displaySuccess();
				$("#serialNumber1").val('');
				$("#rentalTime1").val('');
				$("#rentalPrice1").val('');
            }
            else {
                displayGeneralUserError('Unable to post this item for sale.  Please try again later');
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


$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	if (results == null){
		return "";
	}
	else{
		return results[1];
	}
}

function displaySuccess() {
	$('#error-view').append('<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>You\'ve successfully posted this item!</div>');
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}