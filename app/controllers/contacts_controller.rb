class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
        @contact = Contact.new(contact_params) # params is kind of like mass assignment; refers to things we are passing through form fields or links; contact_params is a function that we previously defined and is found below
        if @contact.save
            # This is how we lift data from form fields here in the controller
            name = params[:contact][:name] # Assigning a var name to params
            email = params[:contact][:email]
            body = params[:contact][:comments]
            ContactMailer.contact_email(name, email, body).deliver # Calling function contact_email from contact_mailer "CONTROLLER" and using the vars above as arguments. The .deliver method will fire off the email to the recipient
            flash[:success] = "Message sent."
            redirect_to new_contact_path
        else
            flash[:danger] = @contact.errors.full_messages.join("; ")
            redirect_to new_contact_path
        end
    end
    
    private # Make sure that we're saving things to our database securely
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end