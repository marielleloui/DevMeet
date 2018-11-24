class AddStripeCustomerTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    # Users table, Stripe customer token (column), string format
    add_column :users, :stripe_customer_token, :string
  end
end
