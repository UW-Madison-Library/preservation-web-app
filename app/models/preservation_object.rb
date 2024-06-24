# frozen_string_literal: true

class PreservationObject
  include ActiveModel::Model

  attr_reader :vault, :id, :version, :latest_version, :state, :batch_id, :object_created,
              :version_created, :last_shallow_check, :last_deep_check, :version_storage_checks,
              :files

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def initialize(pres_obj)
    @vault = pres_obj.vault
    @id = pres_obj.external_object_id
    @version = pres_obj.version
    @latest_version = pres_obj.latest_version
    @state = pres_obj.state
    @batch_id = pres_obj.ingest_id
    @object_created = pres_obj.object_created_timestamp
    @version_created = pres_obj.version_created_timestamp
    @last_shallow_check = pres_obj.last_shallow_check
    @last_deep_check = pres_obj.last_deep_check
    @version_storage_checks = pres_obj.remote_version_check
    @files = pres_obj.files.map { |file| ObjectFile.new(file) }
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def latest_version?
    version == latest_version
  end

  def deleted?
    state == PreservationManager::PreservationObjectState::DELETED
  end

  def events(proxy_header)
    events = $preservation_manager_proxy.retrieve_object_events(vault, id, proxy_header).events

    events.map { |event| Event.new(event) }
  end

  def storage_problems(proxy_header)
    problems = $preservation_manager_proxy.retrieve_object_storage_problems(vault, id, proxy_header)
                                          .problems

    problems_arr = problems.map do |problem|
      { data_store: problem[:dataStore],
        problem: problem[:problem],
        persistence_version: problem[:persistenceVersion],
        reported_timestamp: problem[:reportedTimestamp] }
    end

    problems_arr.uniq { |prob| [prob[:data_store], prob[:problem]] }
  end

  def self.find(vault, pres_obj_id, version, proxy_header)
    opts = { version: version }.merge(proxy_header)
    pres_obj = $preservation_manager_proxy.describe_preservation_object(vault, pres_obj_id, opts)

    PreservationObject.new(pres_obj)
  end
end
