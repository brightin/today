require 'google/api_client'

class Client
  attr_reader :api_client

  def initialize(certificate: ENV['CLIENT_P12_KEY'], password: ENV['CLIENT_P12_PASSWORD'], issuer: ENV['CLIENT_ISSUER'])
    @api_client = Google::APIClient.new(application_name: 'Brightin Today')
    authorize(
      certificate: certificate,
      password: password,
      issuer: issuer
    )
  end

  def calendar(opts = {})
    api_client.execute!(
      api_method: calendar_api.calendars.get,
      parameters: opts
    ).data
  end

  def calendar_events(opts = {})
    api_client.execute!(
      api_method: calendar_api.events.list,
      parameters: opts
    ).data.items
  end

  private

  def calendar_api
    @calendar_api ||= api_client.discovered_api('calendar', 'v3')
  end

  def authorize(certificate:, password:, issuer:)
    key = Google::APIClient::KeyUtils.load_from_pkcs12(Base64.decode64(certificate), password)
    api_client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/calendar.readonly',
      issuer: issuer,
      signing_key: key
    )
    api_client.authorization.fetch_access_token!
  end
end
