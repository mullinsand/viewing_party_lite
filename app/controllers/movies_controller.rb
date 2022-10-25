# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_user, only: %i[show]
  def show
    @movie = MovieFacade.movie_details(params[:id])
  end
end
