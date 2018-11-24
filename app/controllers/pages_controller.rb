class PagesController < ApplicationController
    
    # GET request for / which is the home page
    def home # The FUNCTION, home. Though when you have functions inside of a class, you call it METHOD
    # The file name 'home' (from VIEWS) needs to match the METHOD name 'home' in the CONTROLLER
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
   
    end
    
    def about
    end
end