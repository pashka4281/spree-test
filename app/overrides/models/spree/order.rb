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

end