class HomeController < ApplicationController
	def home
		@items_to_reorder = Item.need_reorder.all
	end

	def about
	end

	def contact
	end

	def privacy
	end
end
