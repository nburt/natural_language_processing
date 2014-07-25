class Query < ActiveRecord::Base

  serialize :response_json, JSON

end