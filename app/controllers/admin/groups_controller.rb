class Admin::GroupsController < Admin::BaseController
  before_filter :find_group, :only => [:show, :edit, :update, :destroy]
  before_filter :find_users, :only => [:new, :edit]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
  end

  def edit
  end

  def update
    @group.update_attributes(params[:group])
    user_ids = params[:user][:user_id] if params[:user]
    @group.users = User.find(user_ids) unless !user_ids || user_ids.empty?

    if @group.save
      flash[:notice] = "Group has been updated."
      redirect_to admin_groups_path
    else
      flash[:alert] = "Group has not been updated."
      render :action => "edit"
    end
  end

  def create
    @group = Group.create(params[:group]);
    user_ids = params[:user][:user_id] if params[:user]
    @group.users = User.find(user_ids) unless !user_ids || user_ids.empty?

    if @group.save
      flash[:notice] = "Group has been created."
      redirect_to admin_groups_path
    else
      flash[:alert] = "Group has not been created."
      render :action => "new"
    end
  end

	private
	def find_group
		@group = Group.find(params[:id])
	end

    def find_users
      @users = User.all
    end
end
