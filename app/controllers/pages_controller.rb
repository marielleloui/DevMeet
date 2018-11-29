class PagesController < ApplicationController
    
    # GET request for / (home page)
    def home
    # 'Home' (from VIEWS) needs to match the METHOD name 'home' in the CONTROLLER
        @basic_plan = Plan.find(1)
        @pro_plan = Plan.find(2)
    end
end