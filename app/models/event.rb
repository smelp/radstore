class Event < ActiveRecord::Base

  attr_accessible :target_id, :event_type, :signature, :user_timestamp, :info

end
