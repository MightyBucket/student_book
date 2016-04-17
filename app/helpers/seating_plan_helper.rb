module SeatingPlanHelper

	#implementation in the website
	# All inputs would be done by forms
	# This page would be a helper
	# all functions can be called by the view
	#implement a saving strategy
	# backup student details to a file 
	# Create a flow chart of this program before implementing to website


	def class_layout
		row_array = []
		seat_array =  []
		index_row = []
	    for y in (0..@seats_y-1)
		    for x in  (0..@seats_x-1)
		    	index_row << x + 1     
		        row_array << @no_seat
		    end
		    seat_array << row_array
		    row_array = []
		end
		seat_array
	end

	def seat_position_params(num)
		params["seat#{num}"]
	end

	

	def seat_layout(new_layout)
		flash[:alert] = [] 
		success = []
		for i in 1..(@available_seats)
			position_params = seat_position_params(i)
			if params["complete_seat_placement"] == "true"
				if not(position_params.empty?) == true
					position = position_params.scan(/\d+|\D+/)
					if position[1].to_i != 0 # Checks that the value input is in formal AA11 if == A0 or AA then will not pass
						x_pos = position[1].to_i
						y_pos = letter_to_num(position[0].upcase)
						if y_pos <= 0 || y_pos >= @seats_y-1 || x_pos <= 0 || x_pos >= @seats_x-1
							flash[:alert] << "Seat #{i}: #{position_params} Outside Boundaries" 
							success << false
						elsif new_layout[y_pos][x_pos] == @yes_seat
							flash[:alert] << "Seat #{i}: #{position_params} Already Entered" 
							success << false
						else
							new_layout[y_pos][x_pos] = @yes_seat
							success << true
						end
					else
						flash[:alert] << "Seat #{i}: #{position_params} Must be in format AA00 (Letter first, then Number)" 
						success << false
					end
				else
					flash[:alert] << "Seat #{i}: Cannot be blank" 
					success << false
				end
			end
		end
		if success.include?(false) 
			params["complete_seat_placement"] = "false"
		end
		new_layout
	end

	def algorithm(new_layout, s_list_copy)
		s_list_copy = s_list_copy.sort_by{|k,v| v["level"]}
		male_female = @gender_sort
		if male_female == "Y"
			new_s_list= boy_girl_sort(s_list_copy)
		else
			new_s_list = s_list_copy
		end

		# check for first available seats, row by row, then column by column
		@coord = []
		
		for y in 1..@seats_y-2
			for x in 1..@seats_x -1
				if new_layout[y][x] == @yes_seat
					@coord << [x,y]
				end
			end
		end

		student_num = 1
		new_s_list = new_s_list.to_h
		new_array_s_list = new_s_list.dup.to_a
		while (not(new_array_s_list.length <= 0) && @coord.length >= 0 )
			id = new_array_s_list[0][0]
			whitelist = new_s_list[id]["whitelist"]
			name = new_s_list[id]["name"]
			x_pos = @coord[0][0]
			y_pos = @coord[0][1]
					

			#positional data for array
			pos_right =new_layout[y_pos][x_pos+1].to_s
			pos_left = new_layout[y_pos][x_pos-1].to_s
			pos_up = new_layout[y_pos-1][x_pos].to_s
			pos_down = new_layout[y_pos+1][x_pos].to_s
			pos_ne = new_layout[y_pos-1][x_pos+1].to_s
			pos_nw = new_layout[y_pos-1][x_pos-1].to_s
			pos_sw = new_layout[y_pos+1][x_pos-1].to_s
			pos_se = new_layout[y_pos+1][x_pos+1].to_s

			#starting condition
			to_place = [true]

			if (x_pos != 0 && x_pos != @seats_x && y_pos != 0 && y_pos != @seats_y)
				if new_s_list[pos_left] == nil && new_s_list[pos_right] == nil && new_s_list[pos_down] == nil && new_s_list[pos_up] == nil && new_s_list[pos_nw] == nil && new_s_list[pos_ne] == nil && new_s_list[pos_se] == nil && new_s_list[pos_sw] == nil 
					to_place = true
				else
					if new_s_list[pos_right] != nil
						if new_s_list[pos_right]["name"] == whitelist || new_s_list[pos_right]["whitelist"] == name
							to_place << false			
						end
					end
					if new_s_list[pos_left] != nil
						if new_s_list[pos_left]["name"] == whitelist || new_s_list[pos_left]["whitelist"] == name
							to_place << false			
						end
					end
					if new_s_list[pos_up] != nil
						if new_s_list[pos_up]["name"] == whitelist || new_s_list[pos_up]["whitelist"] == name
							to_place << false				
						end
					end
					if new_s_list[pos_down] != nil
						if new_s_list[pos_down]["name"] == whitelist || new_s_list[pos_down]["whitelist"] == name
							to_place << false					
						end
					end
					if new_s_list[pos_nw] != nil
						if new_s_list[pos_nw]["name"] == whitelist || new_s_list[pos_nw]["whitelist"] == name
							to_place << false					
						end
					end
					if new_s_list[pos_ne] != nil
						if new_s_list[pos_ne]["name"] == whitelist || new_s_list[pos_ne]["whitelist"] == name
							to_place << false					
						end
					end
					if new_s_list[pos_se] != nil
						if new_s_list[pos_se]["name"] == whitelist || new_s_list[pos_se]["whitelist"] == name
							to_place << false	
						end
					end
					if new_s_list[pos_sw] != nil
						if new_s_list[pos_sw]["name"] == whitelist || new_s_list[pos_sw]["whitelist"] == name
							to_place << false		
						end
					end
					to_place = not(to_place.include? false)

				end
			end

			#coords delete first item

			if to_place == true
				new_layout[y_pos][x_pos] = id
				@coord.shift
				new_array_s_list.shift
				@coord = @coord.sort{|a,b|b[1]<=>a[1]}.reverse
			else
				@coord = @coord.rotate
			end
			student_num += 1		
		end
		new_layout 
	end

	def manual_list(new_layout,s_list)
		male_female = @gender_sort

		if male_female == "Y"
			s_list = boy_girl_sort(s_list)
		else
			s_list = s_list
		end
		flash[:alert] = [] 
		s_list.each do  |key, value|
			position = @positions.shift
			if position.length == 2 
				x_pos = ( position[1].to_i)
				y_pos = letter_to_num(position[0].upcase)
				if new_layout[y_pos][x_pos] == @yes_seat
					new_layout[y_pos][x_pos] = key
				else
					flash.now[:alert] << "#{position} Is already Taken, or it is an Unavailable Seat" 
				end
			else 
				flash.now[:alert] << "#{position} Must be 2 characters" 

			end
		end
		new_layout 
	end

	def student_list_params(num=false)
		if num == false
			@student_list
		else
			if params["student_gender#{num}"].upcase != "M" && params["student_gender#{num}"].upcase != "F"
				name = params["student_name#{num}"].titlecase
				flash[:alert] << "#{name}'s Gender is not M or F"
				params["complete_s_list"] = "false"
			else
				name = params["student_name#{num}"].titlecase
				gender = params["student_gender#{num}"].upcase
				level = params["student_level#{num}"]
				whitelist = params["student_whitelist#{num}"].titlecase
				@student_list.merge!("#{num}"  => {"name" => "#{name}", "gender" => "#{gender}", "level" => "#{level}", "whitelist" => "#{whitelist}"})
		
				@student_list
			end
		end
	end


	def student_list_data
		student_list
	end

	def num_to_letter(x)
		h = {}
		('A'..'ZZZ').each_with_index{|w, i| h[i+1] = w }
		h[x]
	end

	def letter_to_num(x)
		h = {}
		('A'..'ZZZ').each_with_index{|w, i| h[i+1] = w }
		h.invert[x]
	end

	def is_number?
	  self.to_f == self
	end
end

def boy_girl_sort(s_list_copy)
	
	loopy = true
	gender_loop = "M"
	s_list_copy = s_list_copy.dup.to_a
	new_s_list = []

	while loopy == true
		i = 0
		loopy2 = true
		while loopy2 == true
			if i < s_list_copy.length
				if gender_loop == "M"
					if s_list_copy[i][1]["gender"] == "M"
						new_s_list << s_list_copy[i]
						s_list_copy.delete_at(i)
						loopy2 = false
						gender_loop = "F"
					else
						i += 1
					end
				else
					if s_list_copy[i][1]["gender"] == "F"
						new_s_list << s_list_copy[i]
						s_list_copy.delete_at(i)		
						loopy2 = false
						gender_loop = "M"
					else
						i += 1	
					end
				end
			else
				if gender_loop == "M"
					gender_loop = "F"
					loopy2= false
				else 
					gender_loop = "M"
					loopy2 = false
				end
			end	
		end
		if s_list_copy.empty? == true 
			loopy2 = false
			loopy = false
		end
	end

	new_s_list = new_s_list.to_h
end


