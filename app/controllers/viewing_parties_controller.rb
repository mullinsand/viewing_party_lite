class ViewingPartiesController < ApplicationController
  before_action :set_user, only: %i[new create]
  def new
    @viewing_party = ViewingParty.new
    @movie = Movie.new(MovieService.get_movie_data(params[:movie_id]))
    @all_users = User.all
  end

  def create
    @viewing_party = ViewingParty.new(viewing_party_params)
    if @viewing_party.save
      params[:viewing_party][:invited_users].each do |user_id|
        ViewingPartyUser.create!(viewing_party_id: @viewing_party.id, user_id: user_id) if User.find(user_id)
      end
      redirect_to dashboard_path(@user)
    else
      redirect_to new_user_movie_viewing_party_path(@user, @viewing_party.movie_id)
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  private

  def viewing_party_params
    params[:viewing_party][:start_time] =
      "#{params[:viewing_party][:date]} #{params[:viewing_party][:time]}".to_datetime
    params.require(:viewing_party).permit(:host, :image_path, :movie_title, :start_time, :duration, :movie_id)
  end
end
