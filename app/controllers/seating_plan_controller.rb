class SeatingPlanController < ApplicationController
	before_filter :ensure_log_in, only: [:index]
	include SeatingPlanHelper
	def index()
		@student_list = Hash.new
		@seating_plan_done = false
		@seats_x = params[:seats_x]
		@seats_y = params[:seats_y]
		@available_seats = params[:available_seats]
		@class_name = params[:class_name]
		@student_num = params[:student_num].to_i
		@gender_sort = params[:gender_option]
		@decision = params[:process_option]

		flash[:alert] = []

		# 0 are available seats.
		@seats_x = @seats_x.to_i + 2
		@seats_y = @seats_y.to_i + 2
		@available_seats = @available_seats.to_i

		@yes_seat = "\u25CB"
		@no_seat = "\u25C9"

		if params["complete_seat_dimensions"] == "true" 
			if @seats_x == 2|| @seats_y == 2|| @available_seats == 2
				flash[:alert] << "Cannot be blank"
				params["complete_seat_dimensions"] = "false"
			else
			
				if @available_seats > (@seats_x-2) * (@seats_y-2)
					flash[:alert] << "Number of seats is greater than possible seat placements"
					params["complete_seat_dimensions"] = "false"
				else 
					@seat_layout = seat_layout(class_layout)
				end
			end
		end

		if params["complete_gender_selection"] == "true"
			if @gender_sort != "Y" && @gender_sort != "N"
				flash[:alert] << "Must Select Option"
				params["complete_gender_selection"] = "false"
			end
		end
		
		if params["complete_process_selection"] == "true"
			if @decision != "M" && @decision != "A"
				flash[:alert] << "Must Select Option"
				params["complete_process_selection"] = "false"
			end
		end
		

		if (@student_num > 0)&& params["complete_s_list"]
			for i in 1..@student_num
				@s_list = student_list_params(i)
			end
			@s_list_dup = @s_list.dup
			
			if not(@decision.nil?)
			
				if @decision.strip.upcase== 'M'
					@positions = []
					for i in 1..@student_num
						@positions << params["student_seat#{i}"]
					end
					if not(@positions.include?(nil))
						@seat_layout = manual_list(@seat_layout, @s_list_dup)
						@seating_plan_done = true
					end
				elsif @decision.strip.upcase == "A"
					@seat_layout = algorithm(@seat_layout, @s_list_dup)
					@seating_plan_done = true
				end
			end
		end
	end
	private 
	def ensure_log_in
        if logged_in? == false
            redirect_to login_path
        end
   	end
end
