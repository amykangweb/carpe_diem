class PagesController < ApplicationController

  def recent
    @goals = Goal.all.where(private: false).paginate(page: params[:page],
    per_page: 20)
  end

  def api
  end
end
