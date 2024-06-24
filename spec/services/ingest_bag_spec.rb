# frozen_string_literal: true

require 'rails_helper'

describe IngestBag do
  let(:vault) do
    'test_vault'
  end

  describe 'ingest bag' do
    context 'with valid parameters' do
      before do
        allow($preservation_manager_proxy).to receive(:ingest_bag)
          .and_return(PreservationManager::IngestBagResponse.new({ ingest_id: 1 }))
      end

      it 'ingests bag' do
        tempfile = Tempfile.new(['original', '.zip'])

        upload = Struct.new(:original_filename, :tempfile).new('original.zip', tempfile)

        bag_ingest = described_class.new({ bag: upload, vault: vault },
                                         test_user_proxy_header).call

        expect(bag_ingest).to have_attributes({ success?: true, batch_id: 1 })
      end

      it 'deletes files when the processing is complete' do
        tempfile = Tempfile.new(['original', '.zip'])
        tempfile_path = tempfile.path

        upload = Struct.new(:original_filename, :tempfile).new('original.zip', tempfile)
        described_class.new({ bag: upload, vault: vault }, test_user_proxy_header).call

        # Check that the files were deleted
        expect(File.exist?(tempfile_path)).to be(false)
        expect(Dir.glob("#{Dir.tmpdir}/#{described_class::TMPDIR_PREFIX}*")).to eq([])
      end
    end

    # When invalid parameters are passed to the IngestBag service, it should return early and
    # NOT make an api call
    context 'with invalid parameters' do
      it 'returns an error message when vault is nil' do
        tempfile = Tempfile.new(['original', '.zip'])
        upload = Struct.new(:original_filename, :tempfile).new('original.zip', tempfile)

        bag_ingest = described_class.new({ bag: upload, vault: nil },
                                         test_user_proxy_header).call

        expect(bag_ingest).to have_attributes({ success?: false,
                                                error: described_class::MISSING_PARAM_MESSAGE })
      end

      it 'returns an error message when bag is nil' do
        bag_ingest = described_class.new({ bag: nil, vault: 'vault' },
                                         test_user_proxy_header).call

        expect(bag_ingest).to have_attributes({ success?: false,
                                                error: described_class::MISSING_PARAM_MESSAGE })
      end

      it 'returns an error message when vault and bag are nil' do
        bag_ingest = described_class.new({ bag: nil, vault: nil },
                                         test_user_proxy_header).call

        expect(bag_ingest).to have_attributes({ success?: false,
                                                error: described_class::MISSING_PARAM_MESSAGE })
      end
    end

    context 'when preservation manager returns BadRequest' do
      before do
        allow($preservation_manager_proxy).to receive(:ingest_bag)
          .and_raise(PreservationManagerProxy::BadRequest)
      end

      it 'returns error message' do
        tempfile = Tempfile.new(['original', '.zip'])
        upload = Struct.new(:original_filename, :tempfile).new('original.zip', tempfile)

        bag_ingest = described_class.new({ bag: upload, vault: vault },
                                         test_user_proxy_header).call

        expect(bag_ingest).to have_attributes({ success?: false,
                                                error: described_class::BAD_REQUEST_MESSAGE })
      end

      it 'errors gracefully when file is deleted mid process' do
        upload = fixture_file_upload('single-valid.zip')
        File.delete(upload.tempfile.path)

        bag_ingest = described_class.new({ bag: upload, vault: vault },
                                         test_user_proxy_header).call

        expect(bag_ingest).to have_attributes({ success?: false,
                                                error: described_class::BAD_REQUEST_MESSAGE })
      end
    end
  end
end
