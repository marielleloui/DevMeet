class ContactsController < ApplicationController
    
    # GET request to /contact-us
    # Show new contact form
    def new
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignment of form fields into Contact object
        @contact = Contact.new(contact_params)

        # Save the Contact object to the database
        if @contact.save
            # Lift data from form fields here in the controller
            # Store form fields via parameters, into variables
            name = params[:contact][:name] # Assigning a var name to params
            email = params[:contact][:email]
            body = params[:contact][:comments]
            
            # Plug variables into Contact Mailer email method and send email
            # Calling function contact_email from contact_mailer "CONTROLLER" and using the vars above as arguments
            # The .deliver method will fire off the email to the recipient
            ContactMailer.contact_email(name, email, body).deliver
            
            # Store success message in flash hash and redirect to the new action
            flash[:success] = "Message sent."
            redirect_to new_contact_path
        else
            # If Contact object doesn't save, store errors in flash hash 
            # and redirect to the new action
            flash[:danger] = @contact.errors.full_messages.join("; ")
            redirect_to new_contact_path
        end
    end
    
    private
        # To collect data from form, we need to use
        # strong parameters and whitelist the form fields (a security feature);
        # Save info to db securely
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end