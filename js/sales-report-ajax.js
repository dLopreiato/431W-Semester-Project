$(document).ready(function() {
	displayHeading();
	addCategoryStats();
});

function displayHeading(){
	
	var appendString = "";
	var today = new Date();
	var lastWeek = new Date();
	lastWeek.setDate(lastWeek.getDate() - 7);
	
	appendString = '<h1>Sales Report for the week of ' + ((lastWeek.getMonth() + 1) + '/' + (lastWeek.getDate()) + '/' + (lastWeek.getFullYear())) + ' - ' + ((today.getMonth() + 1) + '/' + (today.getDate()) + '/' + (today.getFullYear())) + '</h1>'; 
	appendString += '<h4>Everything is categorized into ONLY its most specific subcateogry</h4>'
	$('#heading').append(appendString);
}

function addCategoryStats(){
	
    var sendData = {};
	
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetSalesReport.php',
        dataType: 'json',
        data: sendData,
        method: 'GET',
        success: function(data) {
            if (data.length == 0) {
				showNoPurchases();
            }
            else {
				var count = 0;
                $.each(data, function (i, item) {
                   if (item.sales != null){
					   count += parseInt(item.sales);
				   }
                });
				
				$.each(data, function (i, item) {
					var sales = 0;
					if (item.sales != null){
						sales = parseInt(item.sales);
					}
                   addCategory(item.name, sales, count);
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

function showNoPurchases(){
	var appendString = '<h4>Oh snap, no purchases were made this week:(</h4>';
    $('#categories').append(appendString);
}


function addCategory(categoryName, categorySalesCount, totalCount) {
	
	var percentage = (categorySalesCount/totalCount) * 100;

    var appendString = '<div class ="row"><h3>' + categoryName + '</h3><p>' + categorySalesCount + ' purchases this week</p>'; 
	appendString += '<p>' + percentage + ' percent of purchases</p><div class="progress"><div class="progress-bar progress-bar-info" role="progressbar"';
	appendString +=  'aria-valuenow="' + percentage + '"aria-valuemin="0" aria-valuemax="100" style="width: ' +percentage + '%">';
	appendString += '<span class="sr-only">' + percentage + '% Complete</span></div></div></div>'
	
    $('#categories').append(appendString);
}

function displayGeneralUserError(textToDisplay) {
	var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}