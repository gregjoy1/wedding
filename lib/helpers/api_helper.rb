module ApiHelper

  def self.serialize_response(error, data)
    {
      :error => error,
      :data => data
    }
  end

  def self.render_response(error, data)
    self.serialize_response(error, data).to_json
  end

end
