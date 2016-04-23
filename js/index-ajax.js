$(document).ready(function() {
    populateResults();
});

function populateResults() {
	
	var sendData = {};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetItems.php',
        dataType: 'json',
		data: sendData,
        success: function(data) {
			if( !$.isArray(data) || !data.length ){
				$('#noResults').show();
			}
			else{
					var rand1 = Math.floor((Math.random() * (data.length-1)));
					var item1 = data[rand1];
					var itemCost1;
					console.log(item1.description);
					$.ajax({
						url: PROTOCOL + ROOT_DIRECTORY + '/api/GetItemCost.php',
						dataType: 'json',
						data: {item_id: item1.item_id},
						success: function(data) {
							addItem(item1.item_id, item1.image,  item1.description, item1.name, data);
						},
						error: function(xhr, ajaxOptions, thrownError) {
							var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
							for (var key in serverErrorInfo) {
								displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
								console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
							}
						}
					});
					
					var rand2 = Math.floor((Math.random() * (data.length-1)));
					var item2 = data[rand2];
					var itemCost2;
					$.ajax({
						url: PROTOCOL + ROOT_DIRECTORY + '/api/GetItemCost.php',
						dataType: 'json',
						data: {item_id: item2.item_id},
						success: function(data) {
							addItem(item2.item_id, item2.image,  item2.description, item2.name, data);
						},
						error: function(xhr, ajaxOptions, thrownError) {
							var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
							for (var key in serverErrorInfo) {
								displayGeneralUserError(serverErrorInfo[key]['userErrorText']);
								console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
							}
						}
					});
					
					var rand3 = Math.floor((Math.random() * (data.length-1)));
					var item3 = data[rand3];
					var itemCost3;
					$.ajax({
						url: PROTOCOL + ROOT_DIRECTORY + '/api/GetItemCost.php',
						dataType: 'json',
						data: {item_id: item3.item_id},
						success: function(data) {
							addItem(item3.item_id, item3.image,  item3.description, item3.name, data);
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
	
	var appendString = '<div class="col-md-4"><div class="thumbnail"><a href="product.html?id=' + itemID +  '"><div class = "product-image" data-content="View"><img src="';
	if (image.substring(0, 4) != "http"){
		appendString += 'img/';
	}
	appendString += image + '"></div></a><div class="caption"><h4>' + description + '</h4><p style ="float: left;">' + category  + '</p>';
	appendString += '<p style ="text-align: right;"><b>' + itemCost + '</b><p></div></div></div>'
	
	$('#featured-items').append(appendString);
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}