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
		print_layout(seat_array)
		seat_array
	end

	def seat_position_params(num)
		params["seat#{num}"]
	end

	

	def seat_layout(new_layout)
		flash[:alert] = [] 
		success = []
		for i in 1..(@available_seats)
			position = seat_position_params(i)
			if not(position.nil?) == true
				if position.length == 2 
					x_pos = position[1].to_i
					y_pos = letter_to_num(position[0].upcase)
					if y_pos <= 0 || y_pos >= @seats_y-1 || x_pos <= 0 || x_pos >= @seats_x-1
						flash[:alert] << "#{position} Outside Boundaries" 
						success << false
					elsif new_layout[y_pos][x_pos] == @yes_seat
						flash[:alert] << "#{position} Already Entered" 
						success << false
					else
						new_layout[y_pos][x_pos] = @yes_seat
						success << true
					end
				else
					flash[:alert] << "#{position} Must be 2 Characters" 
					success << false
				end
			end
			if success.include?(false) 
				params["complete_seat_placement"] = "false"
			end
			
			
		end
		new_layout
	end

	def algorithm(new_layout, s_list_copy)
		print(s_list_copy)
		puts

		s_list_copy = s_list_copy.sort_by{|k,v| v["level"]}

		print(s_list_copy)
		puts

		# Alternating to boy girl
		#pre requesite questions 
		puts "Do you want the seating plan to have boy girl layout?  y/n"
		male_female = @gender_sort.to_s.strip.upcase

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

		print @coord 
		puts 
		student_num = 1
		new_s_list = new_s_list.to_h
		new_array_s_list = new_s_list.dup.to_a
		while (not(new_array_s_list.length <= 0) && @coord.length >= 0 )
			print new_s_list
			puts 
			id = new_array_s_list[0][0]
			print id
			puts
			print new_s_list[id]
			puts
			whitelist = new_s_list[id]["whitelist"]
			puts whitelist
			name = new_s_list[id]["name"]
			puts name
		
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

			# puts ("#{pos_right},#{pos_left},#{pos_up},#{pos_down},#{pos_ne},#{pos_nw},#{pos_sw}, #{pos_se}")
			puts 'up!!!'
			puts pos_up 
			puts "s list up"
			puts new_s_list[pos_up]
			if (x_pos != 0 && x_pos != @seats_x && y_pos != 0 && y_pos != @seats_y)
				if new_s_list[pos_left] == nil && new_s_list[pos_right] == nil && new_s_list[pos_down] == nil && new_s_list[pos_up] == nil && new_s_list[pos_nw] == nil && new_s_list[pos_ne] == nil && new_s_list[pos_se] == nil && new_s_list[pos_sw] == nil 
					puts "nothing around"
					to_place = true
				else
					if new_s_list[pos_right] != nil
						puts "r"
						if new_s_list[pos_right]["name"] == whitelist || new_s_list[pos_right]["whitelist"] == name
							puts "right"
							to_place << false
							
						end
					end
					if new_s_list[pos_left] != nil
						puts "l"
						if new_s_list[pos_left]["name"] == whitelist || new_s_list[pos_left]["whitelist"] == name
							puts "left"
							to_place << false
							
						end
					end
					if new_s_list[pos_up] != nil
						puts "u"
						if new_s_list[pos_up]["name"] == whitelist || new_s_list[pos_up]["whitelist"] == name
							puts "up"
							to_place << false
							
						end
					end
					if new_s_list[pos_down] != nil
						puts "d"
						if new_s_list[pos_down]["name"] == whitelist || new_s_list[pos_down]["whitelist"] == name
							puts "down"
							to_place << false
							
						end
					end
					if new_s_list[pos_nw] != nil
						puts "nw"
						if new_s_list[pos_nw]["name"] == whitelist || new_s_list[pos_nw]["whitelist"] == name
							puts "nw"
							to_place << false
							
						end
					end
					if new_s_list[pos_ne] != nil
						puts "ne"
						if new_s_list[pos_ne]["name"] == whitelist || new_s_list[pos_ne]["whitelist"] == name
							puts "ne"
							to_place << false
							
						end
					end
					if new_s_list[pos_se] != nil
						puts "se"
						if new_s_list[pos_se]["name"] == whitelist || new_s_list[pos_se]["whitelist"] == name
							puts "se"
							to_place << false
							
						end
					end
					if new_s_list[pos_sw] != nil
						puts "sw"
						if new_s_list[pos_sw]["name"] == whitelist || new_s_list[pos_sw]["whitelist"] == name
							puts "sw"
							to_place << false
							
						end
					end
			
					to_place = not(to_place.include? false)

				end
			elsif x_pos == 0
				puts 'x_pos = 0'
				if y_pos == 0 
					
					
				elsif y_pos == @seats_y

				end
			elsif x_pos = @seats_x
				puts 'what!'
				if y_pos == 0 
				elsif y_pos == @seats_y
				end
			end

			#noise

			#coords delete first item

			print @coord
			puts

			if to_place == true
				puts "Placed"
				new_layout[y_pos][x_pos] = id
				@coord.shift
				new_array_s_list.shift
				@coord = @coord.sort{|a,b|b[1]<=>a[1]}.reverse
			else
				puts "Cannot place here"
				@coord = @coord.rotate
			end
			student_num += 1

			print_layout(new_layout)

			puts new_array_s_list
		
		end
		puts "FINAL LAYOUT"
		print_layout(new_layout)
		print new_layout
		puts
		puts "uili"
		new_layout 
	end

	def manual_list(new_layout,s_list)
		print s_list
		puts
		print new_layout
		puts

		puts "Do you want the seating plan to have boy girl layout?  y/n"
		male_female = @gender_sort.to_s.strip.upcase

		if male_female == "Y"
			s_list = boy_girl_sort(s_list)
		else
			s_list = s_list
		end
		
		print_layout(new_layout)
		flash[:alert] = [] 
		s_list.each do  |key, value|
		
			puts "Enter Position for Name: #{value["name"]}: Must be Available seat (Black) Example: B5"
			position = @positions.shift
			puts position 
			puts 'blab'
			if position.length == 2 
				x_pos = ( position[1].to_i)
				puts x_pos
				y_pos = letter_to_num(position[0].upcase)
				puts y_pos
				if new_layout[y_pos][x_pos] == @yes_seat

					new_layout[y_pos][x_pos] = key
					print new_layout
					puts
					print_layout(new_layout)
					
				else
					flash.now[:alert] << "#{position} Is already Taken, or it is an Unavailable Seat" 
	

				end
			else 
				flash.now[:alert] << "#{position} Must be 2 characters" 

			end
		end
		
		puts "FINAL LAYOUT"
		print_layout(new_layout)
		print new_layout
		puts
		puts "uili"
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
				gender = params["student_gender#{num}"]
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


	def print_layout(seat_array)
		seat_array = seat_array.dup
		printed = []
		for row in 1..(@seats_y-2)
			if row == 1 
				print "|"
				for i in 0..(seat_array[row].length-3)	
					# print "  #{i+1}  "
					printed << " #{i+1} "
					printed = printed.join( "" ).split
				end
				printed = printed.join( "" ).split
				print "|"
				puts
				
			end
			row_array = seat_array[row].dup
			row_array.pop; row_array.shift;
			print(num_to_letter(row),row_array,num_to_letter(row))
			puts
			printed << num_to_letter(row)+(row_array.join(" "))+num_to_letter(row)
		end
		puts
		printed
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
	s_list_copy = s_list_copy.to_a
	new_s_list = []

	while loopy == true
		i = 0
		loopy2 = true

		while loopy2 == true
			if gender_loop == "M"
				if s_list_copy[i][1]["gender"] == "M"
					new_s_list << s_list_copy[i]
					s_list_copy.delete_at(i)
					loopy2 = false
				else
					i += 1
					gender_loop = "F"
				end
			else
				if s_list_copy[i][1]["gender"] == "F"
					new_s_list << s_list_copy[i]
					s_list_copy.delete_at(i)		
					loopy2 = false
				else
					i += 1
					gender_loop = "M"
				end
			end
		end
		if gender_loop == "M"
			gender_loop = "F"
		else 
			gender_loop = "M"
		end
		if s_list_copy.empty? == true 
			loopy2 = false
			loopy = false
		end
	end

	new_s_list = new_s_list.to_h
	print(new_s_list)
	puts
	new_s_list
end


