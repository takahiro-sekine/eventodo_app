class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @events = user.events
    @nickname = user.nickname
    @birthday = user.birthday
    @position = user.position
  end
end