$(document).ready(function() {
	$('#subcategory1').hide();
	$('#subcategory2').hide();
	$('#subcategory3').hide();
    populateResults();
});

function populateResults() {
	
	var categoryID = -1;
	var urlCategoryID = location.search.split('id=')[1];
	console.log(urlCategoryID);
	
	if  ($('#subcategory3').is(":visible") && $('#subcategory3 option:selected').val() >=0){
		categoryID = $('#subcategory3 option:selected').val();
	}
	else if  ($('#subcategory2').is(":visible") && $('#subcategory2 option:selected').val() >=0){
		categoryID = $('#subcategory2 option:selected').val();
	}
	else if ($('#subcategory1').is(":visible") && $('#subcategory1 option:selected').val() >= 0){
		categoryID = $('#subcategory1 option:selected').val();
	}
	else if ($('#itemCategory1 option:selected').val() != -1){
		categoryID = $('#itemCategory1 option:selected').val();
	}
	else if (urlCategoryID != []){
		categoryID = urlCategoryID;
	}
	
	var sendData = {};
	
	if (categoryID >= 0){
		sendData = {category_id: categoryID};
	}
		
	$.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetItems.php',
        dataType: 'json',
		data: sendData,
        success: function(data) {
			if( !$.isArray(data) || !data.length ){
				$('#noResults').show();
			}
			else{
				$.each(data, function (i, item) {
					var itemCost;
					$.ajax({
						url: PROTOCOL + ROOT_DIRECTORY + '/api/GetItemCost.php',
						dataType: 'json',
						data: {item_id: item.item_id},
						success: function(data) {
							addItem(item.item_id, item.image,  item.description, item.name, data);
						},
						error: function(xhr, ajaxOptions, thrownError) {
							var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
							for (var key in serverErrorInfo) {
								displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
								console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
							}
						}
					});
					
				});
			}
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


function addItem(itemID, image, description, category, itemCost){
	
	var appendString = '<div class="col-md-3"><div class="thumbnail"><a href="product.html?id=' + itemID +  '"><div class = "product-image" data-content="View"><img src="';
	if (image.substring(0, 4) != "http"){
		appendString += 'img/';
	}
	appendString += image + '"></div></a><div class="caption"><h4>' + description + '</h4><p style ="float: left;">' + category  + '</p>';
	appendString += '<p style ="text-align: right;"><b>' + itemCost + '</b><p></div></div></div>'
	
	$('#filtered-results').append(appendString);
}

$(document).on("change", '#itemCategory1', function(e) {
            
		var categoryID = $(this).val();
		var sendData = {category_id: categoryID};
		
		$('#subcategory1').hide();
		$('#subcategory2').hide();
		$('#subcategory3').hide();
		
		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/GetDirectSubcategories.php',
			dataType: 'json',
			data: sendData,
			type: "GET",
			success: function(json) {
				if (json != 0){
					$('#subcategory1').show();

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
		
		$("#filtered-results").html("");
		populateResults();
});

$(document).on("change", '#itemSubcategory1', function(e) {
            
		var categoryID = $(this).val();
		var sendData = {category_id: categoryID};
		$('#subcategory2').hide();
		$('#subcategory3').hide();
		
		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/GetDirectSubcategories.php',
			dataType: 'json',
			data: sendData,
			type: "GET",
			success: function(json) {
				
				if (json != 0){
					$('#subcategory2').show();
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
		$("#filtered-results").html("");
		populateResults();
});

$(document).on("change", '#itemSubcategory2', function(e) {
            
		var categoryID = $(this).val();
		var sendData = {category_id: categoryID};
		$('#subcategory3').hide();

		$.ajax({
			url: PROTOCOL + ROOT_DIRECTORY + '/api/GetDirectSubcategories.php',
			dataType: 'json',
			data: sendData,
			type: "GET",
			success: function(json) {
				
				if (json != 0){
					$('#subcategory3').show();
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
		$("#filtered-results").html("");
		populateResults();
});

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}