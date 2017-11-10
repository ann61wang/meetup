class MeetupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destory]

  def index
    @meetups = Meetup.all
  end

  def show
    @meetup = Meetup.find(params[:id])
    @comments = @meetup.comments
  end

  def edit
    @meetup = Meetup.find(params[:id])

    if current_user != @meetup.user
      redirect_to root_path, alert: "You have no permission"
    end
  end

  def new
    @meetup = Meetup.new
  end

  def create
    @meetup = Meetup.new(meetup_params)
    @meetup.user = current_user

    if @meetup.save
      redirect_to meetups_path
    else
      render :new
    end
  end

  def update
    @meetup = Meetup.find(params[:id])

    if current_user != @meetup.user
      redirect_to root_path, alert: "You have no permission"
    end

    if @meetup.update(meetup_params)
      redirect_to meetups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @meetup = Meetup.find(params[:id])

    if current_user != @meetup.user
      redirect_to root_path, alert: "You have no permission"
    end

    @meetup.destroy
    flash[:alert] = "Meetup deleted"
    redirect_to meetups_path
  end

  private

  def meetup_params
    params.require(:meetup).permit(:title, :description)
  end
end
