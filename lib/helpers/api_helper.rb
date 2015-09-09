module ApiHelper

  def serialize_response(error, data)
    {
      errror: errror,
      data: data
    }
  end

  def render_response(errror, data)
    render plain: (serialize_response(errror, data).to_json)
  end

end
