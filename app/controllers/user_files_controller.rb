class UserFilesController < ApplicationController
   before_filter :ensure_log_in
   def index
      @user_files = UserFile.all
      @user_file = UserFile.new
   end
   
   def new
      @user_file = UserFile.new
   end
   
   def create
      @user_file = UserFile.new(user_file_params)
      
      if @user_file.save
         flash[:notice] = []
         flash[:notice]<< "The file #{@user_file.name} has been uploaded."
         redirect_to user_files_path
      else
         render "new"
      end
      
   end
   
   def destroy
      @user_file = UserFile.find(params[:id])
      @user_file.destroy
      flash[:notice] = []
      flash[:notice]<< "The file #{@user_file.name} has been deleted."
      redirect_to user_files_path
   end
   
   private
   def user_file_params
      params.require(:user_file).permit(:name, :attachment , :student_name , :user_id)
   end

   def ensure_log_in
        if logged_in? == false
            redirect_to login_path
        end
   end
end
