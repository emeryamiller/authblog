class Admin::GroupsController < Admin::BaseController
  def index
    @groups = Group.all
  end

  def new
    @users = User.all
    @group = Group.new
  end

  def create
    @group = Group.create(params[:group]);
    if @group.save
      flash[:notice] = "Group has been created."
      redirect_to admin_groups_path
    else
      flash[:alert] = "Group has not been created."
      render :action => "new"
    end
  end
end
