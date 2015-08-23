class TagsController < ApplicationController

def show
  @tag = Tag.find(params[:id])
  @goals = @tag.goals.all.paginate(page: params[:page], per_page: 20 )
end

end
