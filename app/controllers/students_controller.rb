class StudentsController < ApplicationController
	before_action :ensure_log_in, only: [:create, :new, :destroy,:show]
		def new
			@student = Student.new
		end
		def index
			@students = Student.all
			@group = Group.all
		end
	  def create
	    @student = Student.new(student_params)
		id = @student.group_id
	      if (@student.save)
	        redirect_to "/groups/#{id}"
	    else
	      render  "/dashboard"
	    end
	  end

	  def show

	  	@student = Student.find(params[:id])

	  end
	   def destroy
	    student = Student.find(params[:id])
	    param_id = student.group_id
	    student.destroy
	    redirect_to "/groups/#{param_id}"
	  end

	 private
	   def student_params
	    params.require(:student).permit(:id,:forename, :surname, :grade_predicted, :group_id, :user_id)
	  end

	def ensure_log_in
        if logged_in? == false
            redirect_to login_path
        end
   	end
end
