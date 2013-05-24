Spree::Order.class_eval do

	def	payment_required?
		false
	end

	def confirmation_required?
		false
	end

	def require_email
		false
	end

	checkout_flow do
	    go_to_state :address
	    go_to_state :payment, :if => lambda { |order| order.payment_required? }
	    go_to_state :confirm, :if => lambda { |order| order.confirmation_required? }
	    go_to_state :complete
	end

# If true, causes the payment step to happen during the checkout process
  def payment_required?
    return false
  end

  # If true, causes the confirmation step to happen during the checkout process
  def confirmation_required?
    return false
  end

end