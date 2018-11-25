/* global $, Stripe */

// Document ready (jQuery's document ready function) - JS will fire only after the document is loaded
$(document).on('turbolinks:load', function() {
    var theForm = $('#pro-form');
    var submitBtn = $('#form-signup-btn');

    // Set Stripe public key
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    
    // When user clicks the Submit button, user will be prevented from submitting
    submitBtn.click(function(event) {
        // (prevent default submission behavior)
        event.preventDefault();
        // Disabling the submit button while it is processing
        submitBtn.val("Processing").prop('disabled', true);
        
        // Collect credit card fields
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        // Use Stripe JS library to check for card errors (Error handling)
        var error = false;
        
        // Validate card number
        if(!Stripe.card.validateCardNumber(ccNum)) {
            error = true;
            alert('The credit card number appears to be invalid');
        }
        
        // Validate CVC number
        if(!Stripe.card.validateCVC(cvcNum)) {
            error = true;
            alert('The CVC number appears to be invalid');
        }
        
         // Validate expiration date
        if(!Stripe.card.validateExpiry(expMonth, expYear)) {
            error = true;
            alert('The expiration date appears to be invalid');
        }
        
        if (error) {
            // If there are card errors, don't send to Stripe
            submitBtn.prop('disabled', false).val("Sign Up");
        } else {
            // Send card information to Stripe
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
        }
        return false;
    });
    
    // Stripe will return a card token
    function stripeResponseHandler(status, response) {
        // Get the token from the response
        var token = response.id;

        // Inject the card token as a hidden field in the form
        theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    
        // Submit form to Rails application  
        theForm.get(0).submit();
    }
});
