# PreservationManager::DescribePreservationObjectResponse

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**vault** | [**Vault**](Vault.md) |  | [optional] 
**external_object_id** | [**ExternalObjectId**](ExternalObjectId.md) |  | [optional] 
**version** | [**Version**](Version.md) |  | [optional] 
**latest_version** | [**Version**](Version.md) |  | [optional] 
**state** | [**PreservationObjectState**](PreservationObjectState.md) |  | [optional] 
**ingest_id** | [**IngestId**](IngestId.md) |  | [optional] 
**object_created_timestamp** | **DateTime** | Timestamp the first version of the object was created | [optional] 
**version_created_timestamp** | **DateTime** | Timestamp this object version was created | [optional] 
**last_shallow_check** | **DateTime** | Timestamp the object last had a shallow validation check | [optional] 
**last_deep_check** | **DateTime** | Timestamp the object last had a deep validation check | [optional] 
**remote_version_check** | [**Array&lt;RemoteVersionCheck&gt;**](RemoteVersionCheck.md) | When this object version was last checked in remote storage locations | [optional] 
**files** | [**Array&lt;ObjectFile&gt;**](ObjectFile.md) | The files contained in this version of the object | [optional] 

