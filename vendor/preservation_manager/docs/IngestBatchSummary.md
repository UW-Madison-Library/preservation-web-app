# PreservationManager::IngestBatchSummary

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**ingest_id** | [**IngestId**](IngestId.md) |  | 
**org_name** | [**OrgName**](OrgName.md) |  | 
**vault** | [**Vault**](Vault.md) |  | 
**created_by** | **String** | The username of the user who submitted the batch | 
**reviewed_by** | [**ReviewedBy**](ReviewedBy.md) |  | [optional] 
**state** | [**IngestBatchState**](IngestBatchState.md) |  | 
**original_filename** | **String** | The name of the file as uploaded | [optional] 
**file_size** | **Integer** | Bag size in bytes | [optional] 
**has_analysis_errors** | [**AnalysisErrors**](AnalysisErrors.md) |  | [optional] 
**has_analysis_warnings** | [**AnalysisWarnings**](AnalysisWarnings.md) |  | [optional] 
**received_timestamp** | **DateTime** | UTC timestamp when the batch was received | 
**updated_timestamp** | **DateTime** | UTC timestamp when the batch was last updated | [optional] 

