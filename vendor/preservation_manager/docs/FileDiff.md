# PreservationManager::FileDiff

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**path** | [**FilePath**](FilePath.md) |  | [optional] 
**new_sha256_digest** | **String** | The sha256 digest of the file in the batch | [optional] 
**old_sha256_digest** | **String** | The sha256 digest of the file in the preserved object | [optional] 
**diff** | **String** | The relationship between the batch object file and the preserved object file | [optional] 
**format_diff** | [**FormatDiff**](FormatDiff.md) |  | [optional] 
**encoding_diff** | [**EncodingDiff**](EncodingDiff.md) |  | [optional] 
**validity_diff** | [**ValidityDiff**](ValidityDiff.md) |  | [optional] 

