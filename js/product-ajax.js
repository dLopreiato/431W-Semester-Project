var modalsUpdated = false;

$(document).ready(function () {
    var productId = $.urlParam('id');

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetProductInfo.php',
        dataType: 'json',
        data: {'item_id':productId},
        method: 'GET',

        success: function(data) {
            console.log(data);
            updateProductInformation(data['description'], data['image']);
            retrieveAndUpdateCategoryInformation(data['category_id']);
            retreiveAndUpdateReviews(productId);
            retreiveAndUpdateRatings(productId);
            if (data['listed_price'] != null) {
                updatePurchaseOptions(data['listed_price']);
            }
            if (data['reserve_price'] != null) {
                updateBidOptions();
            }
            if (data['rentables'] != null) {
                updateRentalOptions(data['rentables'][0]['rental_price']);
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
});

function retrieveAndUpdateCategoryInformation(category_id) {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetCategoryBackTree.php',
        dataType: 'json',
        data: {'category_id':category_id},
        method: 'GET',

        success: function(data) {
            for (dataIndex in data) {
                $('#categoryTree').append('<li><a href="browse.html?id=' + data[dataIndex]['category_id'] + '">' + data[dataIndex]['name'] + '</a></li>');
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

function retreiveAndUpdateReviews(productId) {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetReviews.php',
        dataType: 'json',
        data: {'item_id':productId},
        method: 'GET',

        success: function(data) {
            if (data != false) {
                for (dataIndex in data) {
                    addReview(data[dataIndex]['star_ranking'], data[dataIndex]['description']);
                }
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

function retreiveAndUpdateRatings(productId) {
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/GetReviewStats.php',
        dataType: 'json',
        data: {'item_id':productId},
        method: 'GET',

        success: function(data) {
            $('#averageRating').html(data['avg_rating']);
            $('#fiveRating').html(data['five_star']);
            $('#fourRating').html(data['four_star']);
            $('#threeRating').html(data['three_star']);
            $('#twoRating').html(data['two_star']);
            $('#oneRating').html(data['one_star']);
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

function submitReview() {
    var item_id = $.urlParam('id');
    var review = document.getElementById('review').value;
    var rating = $('input[name="options"]:checked').val();

    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/CreateReview.php',
        dataType: 'json',
        data: {'item_id':item_id, 'star_rating':rating, 'description':review},
        method: 'POST',

        success: function(data) {
            displayUserSuccess("Review successfully posted!");
            document.getElementById('review').value = "";
            $('#reviewEditor').hide();
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

function updateModals() {
    if (!modalsUpdated) {
        $.ajax({
            url: PROTOCOL + ROOT_DIRECTORY + '/api/GetCards.php',
            dataType: 'json',
            method: 'GET',

            success: function(data) {
                for (dataKey in data) {
                    $('#purchase-creditCard').append('<option value="' + data[dataKey]['card_number'] + '">XXXX-XXXX-XXXX-' + data[dataKey]['card_number'].substring(12) + '</option>');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
                for (var key in serverErrorInfo) {
                    displayModalUserError(serverErrorInfo[key]['userErrorText']);
                    console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
                }
            }
        });
        $.ajax({
            url: PROTOCOL + ROOT_DIRECTORY + '/api/GetAddresses.php',
            dataType: 'json',
            method: 'GET',

            success: function(data) {
                for (dataKey in data) {
                    $('#purchase-address').append('<option value="' + data[dataKey]['address_id'] + '">' + data[dataKey]['shipping_name'] + '</option>');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                var serverErrorInfo = JSON.parse(unescape(xhr.responseText));
                for (var key in serverErrorInfo) {
                    displayModalUserError(serverErrorInfo[key]['userErrorText']);
                    console.error('AJAX Error: ' + serverErrorInfo[key]['errorDescription'] + "\n" + thrownError);
                }
            }
        });
        modalsUpdated = true;
    }
}

function submitPurchase() {
    var credit_card = document.getElementById('purchase-creditCard').value;
    var address_id = document.getElementById('purchase-address').value;
    var item_id = $.urlParam('id');
    $.ajax({
        url: PROTOCOL + ROOT_DIRECTORY + '/api/Purchase.php',
        dataType: 'json',
        data: {'item_id': item_id, 'address_id': address_id, 'card_number': credit_card},
        method: 'GET',

        success: function(data) {
            displayUserSuccess('Thank you for your purchase!');
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

function updateProductInformation(name, image) {
    if (image.substring(0, 4) != "http"){
        image = 'img/' + image;
    }
    document.title = name + ' | #90s Kids R Us';
    $("#productName").html(name);
    document.getElementById("productImage").src = image;
}

function updatePurchaseOptions(price) {
    $('#unavailableNotice').hide();
    $('#purchaseOptions').removeClass('hidden');
    $('#purchaseOptions h4 span').html(price);
}

function updateBidOptions() {
    $('#unavailableNotice').hide();
    $('#bidOptions').removeClass('hidden');
}

function updateRentalOptions(lateFee) {
    $('#unavailableNotice').hide();
    $('#rentalOptions').removeClass('hidden');
    $('#rentalOptions h4 span').html(lateFee);
}

function addReview(rating, text) {
    $('#reviews').append('<h5><strong>Rating:</strong> <span class="badge">' + rating + ' / 5</span></h5><p>' + text + '</p><hr>');
}

$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    return results[1] || 0;
}

function displayGeneralUserError(textToDisplay) {
    var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}

function displayModalUserError(textToDisplay) {
   var divText = '<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
   $('.modal-error').append(divText);
}

function displayUserSuccess(textToDisplay) {
    var divText = '<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + textToDisplay + '</div>';
    $('#error-view').append(divText);
}