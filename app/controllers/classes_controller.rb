class ClassesController < ApplicationController
	before_filter :ensure_correct_user, only: [:show]
	def new
			@classes = Group.new
		end
	def show
		@classes = Group.new
		@student = Student.new
		@group = Group.find(params[:id])
	end

	  def create
	    @classes = Group.new(class_params)
	
	      if (@classes.save)
	        redirect_to "/dashboard"
	    else
	      render  "/dashboard"
	    end
	  end
	  def destroy
	    classes = Group.find(params[:id])
	    classes.destroy
	    redirect_to "/dashboard"
	  end

	 private
	   def class_params
	    params.require(:group).permit(:title, :color_t, :user_id)
	  end
	  def ensure_correct_user
        arr = []
        Group.where(user_id: current_user.id.to_s).each do |classes|
        	arr << classes.id
        end
        if arr.include?(params[:id].to_i) == true
        else
        	flash[:success]= []
             flash[:success] <<  'That was not your class.'
            redirect_to dashboard_index_path
        end
	  end
end
