class User::GroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_groups = User::Group.all
    respond_with(@user_groups)
  end

  def show
    respond_with(@user_group)
  end

  def new
    @user_group = User::Group.new
    respond_with(@user_group)
  end

  def edit
  end

  def create
    @user_group = User::Group.new(group_params)
    @user_group.save
    respond_with(@user_group)
  end

  def update
    @user_group.update(group_params)
    respond_with(@user_group)
  end

  def destroy
    @user_group.destroy
    respond_with(@user_group)
  end

  private
    def set_user_group
      @user_group = User::Group.find(params[:id])
    end

    def user_group_params
      params[:user_group]
    end
end
