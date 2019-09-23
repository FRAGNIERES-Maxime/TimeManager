defmodule City.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :City,
  module: City.Guardian,
  error_handler: City.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
