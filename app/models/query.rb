class Query < ActiveRecord::Base
  def response
    JSON.parse(response_json)
  end

  def response=(val)
    self.response_json = val.to_json
  end
end