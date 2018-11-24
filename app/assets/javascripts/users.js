/* global $, Stripe */

// Document ready (jQuery's document ready function) - JS will fire only after the document is loaded
$(document).on('turbolinks:load', function() {
    var theForm = $('#pro_form');
    var signupBtn = $('#form-signup-btn');

    // Set Stripe public key
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    
    // When user clicks the Submit button, user will be prevented from submitting
    signupBtn.click(function(event) {
        // (prevent default submission behavior)
        event.preventDefault();
        
        // Collect credit card fields
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        // Send card information to Stripe
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
    });
    
    
    // Stripe will return a card token
    // Inject card token as hidden field into form
    // Submit form to Rails application

})
