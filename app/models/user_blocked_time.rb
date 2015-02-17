class UserBlockedTime < ActiveRecord::Base
  belongs_to :user

  def self.find_blocked(user_ids)
    blocked_times = UserBlockedTime.where(:user_id => user_ids)
    t = blocked_times.map do | time |
      (time.blocked_time.begin.to_time..time.blocked_time.end.to_time)
    end
    merge_ranges t
  end

  protected


  def self.sort_elements(blocked_times)
    blocked_times.sort_by { |bt| bt.begin}
  end


  def self.merge_ranges(blocks)
    sorted = sort_elements blocks
    sorted.inject([]) do | collection, value|
      unless collection.empty?
        previous = collection.last
        previous_value = previous.end
        current_value = value.first
        if(previous_value+1 <=> current_value) == -1
          collection << value
        else
          first = previous.begin
          second = [previous.end, value.end].max
          collection[-1] = [first..second]
          collection.flatten!
        end
      else
        collection << value
      end
    end
  end
end
