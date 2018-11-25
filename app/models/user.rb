class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :plan
  
  # Whitelisting form data so that it could be used in the code below
  attr_accessor :stripe_card_token
  
  # If Pro user passes validations (email, password, etc.), then call Stripe
  # and tell Stripe to set up a subscription upon charging the customer's card.
  # Stripe responds back with customer data
  # Customer.id will be stored as the customer token, and user will be saved
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
end
