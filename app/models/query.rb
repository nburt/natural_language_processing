class Query < ActiveRecord::Base

  serialize :response_json, JSON

  validates_presence_of :response

end