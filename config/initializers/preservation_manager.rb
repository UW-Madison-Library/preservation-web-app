require Rails.root.join('lib', 'preservation_manager_proxy')

PreservationManager.configure do |config|
  # This api key is for running the preservation service locally.
  # Do NOT commit actual api keys in a git repository.
  config.api_key['X-API-KEY'] = 'e1d14690ec5c01ab456a5ecd900fc81a690f5c8363d2fb353ddb9ff9cbfa4288'
  config.scheme = 'http'
  config.host = 'localhost:8484'
  config.base_path = 'api'
end

$preservation_manager_proxy = PreservationManagerProxy::PreservationManagerProxy.new(
  PreservationManager::PreservationManagerApi.new
)
