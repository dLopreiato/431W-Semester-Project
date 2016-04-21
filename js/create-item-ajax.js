$(document).ready(function() {
	$('#subcategory1').hide();
	$('#subcategory2').hide();
	$('#subcategory3').hide();
	$('#br1').hide();
	$('#br2').hide();
	$('#br3').hide();
});

function submitNewItem() {
	var description = $('input:text[name=itemDescription]').val();
	var location = $('input:text[name=itemLocation]').val();
	var image = $('input:text[name=itemImage]').val();
	
	var categoryID = -1;
	
	
	if  ($('#subcategory3').is(":visible") && $('#subcategory3 option:selected').val() != -1){
		categoryID = $('#subcategory3 option:selected').val();
	}
	else if  ($('#subcategory2').is(":visible") && $('#subcategory2 option:selected').val() != -1){
		categoryID = $('#subcategory2 option:selected').val();
	}
	else if ($('#subcategory1').is(":visible") && $('#subcategory1 option:selected').val() != -1){
		categoryID = $('#subcategory1 option:selected').val();
	}
	else if ($('#itemCategory1 option:selected').val() != -1){
		categoryID = $('#itemCategory1 option:selected').val();
	}
		
	if (categoryID !=  -1 && description != "" && location != "" && image != ""){
	
		var sendData = {description: description, location: location, category_id: categoryID, image: image};

		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/CreateItem.php',
			dataType: 'json',
			data: sendData,
			method: 'POST',
			success: function(data) {
				if (data) {
					$("#description1").val('');
					$("#location1").val('');
					$("#image1").val('');
					displaySuccess();
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
	else{
		displayGeneralUserError('Please complete all fields before submitting.');
	}
}

$(document).on("change", '#itemCategory1', function(e) {
            
		var categoryID = $(this).val();
		var sendData = {category_id: categoryID};
		
		$('#subcategory1').hide();
		$('#subcategory2').hide();
		$('#subcategory3').hide();
		$('#br1').hide();
		$('#br2').hide();
		$('#br3').hide();
		
		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/GetDirectSubcategories.php',
			dataType: 'json',
			data: sendData,
			type: "GET",
			success: function(json) {
				if (json != 0){
					$('#subcategory1').show();
					$('#br1').show();

					var $el = $("#itemSubcategory1");
					$el.empty(); 
					$el.append($("<option></option>")
							.attr("value", '-1').text('Please Select'));
					$.each(json, function(value, key) {
						$el.append($("<option></option>")
								.attr("value", key.category_id).text(key.name));
					});		   
				}
			}
		});
});

$(document).on("change", '#itemSubcategory1', function(e) {
            
		var categoryID = $(this).val();
		var sendData = {category_id: categoryID};
		$('#subcategory2').hide();
		$('#subcategory3').hide
		$('#br2').hide();
		$('#br3').hide();
		

		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/GetDirectSubcategories.php',
			dataType: 'json',
			data: sendData,
			type: "GET",
			success: function(json) {
				
				if (json != 0){
					$('#subcategory2').show();
					$('#br2').show();
					var $el = $("#itemSubcategory2");
					$el.empty(); 
					$el.append($("<option></option>")
							.attr("value", '-1').text('Please Select'));
					$.each(json, function(value, key) {
						$el.append($("<option></option>")
								.attr("value", key.category_id).text(key.name));
					});
		  
				}
			}
		});
});

$(document).on("change", '#itemSubcategory2', function(e) {
            
		var categoryID = $(this).val();
		var sendData = {category_id: categoryID};
		$('#subcategory3').hide();
		$('#br3').hide();

		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/GetDirectSubcategories.php',
			dataType: 'json',
			data: sendData,
			type: "GET",
			success: function(json) {
				
				if (json != 0){
					$('#subcategory3').show();
					$('#br3').show();
					var $el = $("#itemSubcategory3");
					$el.empty(); 
					$el.append($("<option></option>")
							.attr("value", '-1').text('Please Select'));
					$.each(json, function(value, key) {
						$el.append($("<option></option>")
								.attr("value", key.category_id).text(key.name));
					});
		  
				}
			}
		});
});

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}

function displaySuccess() {
	$('#error-view').append('<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>You\'ve successfully added this item!</div>');
}