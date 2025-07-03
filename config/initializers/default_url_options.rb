Rails.application.routes.default_url_options[:host] =
  if Rails.env.production?
    "https://chris-collis.com"
  else
    "localhost:3000"
  end
