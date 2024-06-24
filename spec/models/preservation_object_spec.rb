# frozen_string_literal: true

require 'rails_helper'

describe PreservationObject do
  describe 'storage_problems' do
    it 'returns filtered storage problems' do
      problems = { problems: [{ dataStore: 'REMOTE',
                                problem: 'MISSING',
                                persistenceVersion: 'v1',
                                reportedTimestamp: '2022-03-22T21:02:01.488282Z' },
                              { dataStore: 'REMOTE',
                                problem: 'MISSING',
                                persistenceVersion: 'v2',
                                reportedTimestamp: '2022-03-22T21:02:02.488282Z' }] }

      allow($preservation_manager_proxy).to receive(:retrieve_object_storage_problems)
        .and_return(PreservationManager::RetrieveObjectStorageProblemsResponse.new(problems))

      pres_obj_response = PreservationManager::DescribePreservationObjectResponse.new(external_object_id: 1,
                                                                                      vault: 'vault1',
                                                                                      files: [])
      storage_problems = described_class.new(pres_obj_response).storage_problems(test_user_proxy_header)

      expected = [{ data_store: 'REMOTE',
                    problem: 'MISSING',
                    persistence_version: 'v1',
                    reported_timestamp: '2022-03-22T21:02:01.488282Z' }]

      expect(storage_problems).to eq(expected)
    end
  end

  describe 'find' do
    it 'return a preservation object' do
      pres_obj = { external_object_id: 1,
                   vault: 'vault1',
                   files: [] }

      allow($preservation_manager_proxy).to receive(:describe_preservation_object)
        .and_return(PreservationManager::DescribePreservationObjectResponse.new(pres_obj))

      actual_pres_obj = described_class.find('vault1', 1, nil, test_user_proxy_header)
      expect(actual_pres_obj).to have_attributes({ id: 1, vault: 'vault1', files: [] })
    end
  end
end
