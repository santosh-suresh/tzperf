class BlocktimeController < ApplicationController

  def index
    num_users = rand(10..200)
    user_ids = rand_n num_users
    times = UserBlockedTime.find_blocked user_ids
    render json: times

  end


  private

  def rand_n(n)
    randoms = Set.new
    loop do
      randoms << rand(1..500)
      return randoms.to_a if randoms.size >= n
    end
  end
end
