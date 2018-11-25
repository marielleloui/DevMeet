class Users::RegistrationsController < Devise::RegistrationsController
    before_action :select_plan, only: :new
    
    # Extend default Devise gem behaviour so that users signing up with the
    # Pro account (plan_id 2) will be saved with a special Stripe subscription
    # function. Otherwise, Devise will sign up the user as usual.
    def create
        # Super will inherit the create action and extend it
        super do |resource|
            # Is there a parameter called plan in the url?
            if params[:plan]
                resource.plan_id = params[:plan]
                if resource.plan_id == 2
                    resource.save_with_subscription
                else
                    resource.save
                end
            end
        end
    end
    
    private
        def select_plan
            unless (params[:plan] == '1' || params[:plan] == '2')
                flash[:notice] = "Please select a membership plan to sign up."
                redirect_to root_url
            end
        end
end
                