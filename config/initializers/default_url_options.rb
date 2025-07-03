Rails.application.routes.default_url_options = if Rails.env.production?
  {
    host: "chris-collis.com",
    protocol: "https"
  }
else
  {
    host: "localhost:3000",
    protocol: "http"
  }
end
