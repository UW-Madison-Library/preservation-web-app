# PreservationManager::PreservationManagerApi

All URIs are relative to *http://localhost:8484/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**approve_ingest_batch**](PreservationManagerApi.md#approve_ingest_batch) | **POST** /batch/approve | Approves a batch for ingestion
[**approve_ingest_object**](PreservationManagerApi.md#approve_ingest_object) | **POST** /batch/object/approve | Approves an object for ingestion
[**cancel_job**](PreservationManagerApi.md#cancel_job) | **POST** /job/cancel | Cancels a pending job
[**create_org**](PreservationManagerApi.md#create_org) | **POST** /org/{orgName} | Creates a new organization
[**create_vault**](PreservationManagerApi.md#create_vault) | **POST** /vault | Creates a new vault for an organization
[**delete_object**](PreservationManagerApi.md#delete_object) | **POST** /object/delete | Marks the object as deleted in the database, but does not actually delete any files
[**describe_job**](PreservationManagerApi.md#describe_job) | **GET** /job/{jobId} | Gets job details
[**describe_org**](PreservationManagerApi.md#describe_org) | **GET** /org/{orgName} | Describes the specified organization and returns the current user&#x27;s permissions
[**describe_org_contact**](PreservationManagerApi.md#describe_org_contact) | **GET** /org/{orgName}/contact | Returns the primary contact for the organization.
[**describe_preservation_object**](PreservationManagerApi.md#describe_preservation_object) | **GET** /object | Retrieves details about an object version
[**describe_retrieve_request**](PreservationManagerApi.md#describe_retrieve_request) | **GET** /vault/retrieve/{requestId} | Describes a retrieve objects request
[**describe_user**](PreservationManagerApi.md#describe_user) | **GET** /user | Retrieves details about the current user
[**describe_vault**](PreservationManagerApi.md#describe_vault) | **GET** /vault/{vault}/describe | Returns details about the vault and the current user&#x27;s permissions in the vault
[**diff_batch_object**](PreservationManagerApi.md#diff_batch_object) | **GET** /batch/object/diff | Diffs the batch object against the current state of the object in the preservation system
[**disable_job_types**](PreservationManagerApi.md#disable_job_types) | **POST** /job/disable | Disables job types from being processed
[**download_job**](PreservationManagerApi.md#download_job) | **GET** /vault/retrieve/download/{jobId} | Downloads the output of a retrieve job
[**enable_job_types**](PreservationManagerApi.md#enable_job_types) | **POST** /job/enable | Enables job types from being processed
[**fail_job**](PreservationManagerApi.md#fail_job) | **POST** /job/fail | Marks an executing job as failed. This action can only be completed by a service administrator, and should only be used when a job has a state of executing but is not being executed by a worker.
[**get_ingest_event_counts**](PreservationManagerApi.md#get_ingest_event_counts) | **GET** /system/ingestEventCounts | Counts of all ingest events in the system or organization if specified.
[**get_preservation_event_counts**](PreservationManagerApi.md#get_preservation_event_counts) | **GET** /system/preservationEventCounts | Counts of all preservation events in the system or organization if specified.
[**get_system_storage**](PreservationManagerApi.md#get_system_storage) | **GET** /system/storage | Retrieves system wide storage details, including a list of all organizations in the system and their storage details
[**ingest_bag**](PreservationManagerApi.md#ingest_bag) | **POST** /ingest/bag | Ingests the objects in a BagIt bag
[**list_executing_jobs**](PreservationManagerApi.md#list_executing_jobs) | **GET** /job/executing | Lists jobs that have a state of EXECUTING
[**list_jobs**](PreservationManagerApi.md#list_jobs) | **GET** /{orgName}/job | Lists jobs
[**list_org_user_vault_permissions**](PreservationManagerApi.md#list_org_user_vault_permissions) | **GET** /vault/{orgName}/permission | List all of the vaults in an org along with the user&#x27;s permissions
[**list_org_users**](PreservationManagerApi.md#list_org_users) | **GET** /org/{orgName}/user | Retrieves a list of all of the members of an organization
[**list_user_orgs**](PreservationManagerApi.md#list_user_orgs) | **GET** /user/org | Retrieves a list of all organizations the authenticated user is an active member of
[**list_users_in_vault**](PreservationManagerApi.md#list_users_in_vault) | **GET** /vault/{vault}/user | Retrieves a list of users with read or write permissions for the given vault
[**list_vault_problems**](PreservationManagerApi.md#list_vault_problems) | **GET** /vault/{vault}/problems | Returns a list of objects within the vault for which storage problems have been identified
[**list_vaults**](PreservationManagerApi.md#list_vaults) | **GET** /vault/{orgName} | Lists all vaults for an organization
[**reject_ingest_batch**](PreservationManagerApi.md#reject_ingest_batch) | **POST** /batch/reject | Rejects a batch for ingestion
[**reject_ingest_object**](PreservationManagerApi.md#reject_ingest_object) | **POST** /batch/object/reject | Rejects an object for ingestion
[**replicate_object**](PreservationManagerApi.md#replicate_object) | **POST** /job/replicate | Replicates an object from local storage to a remote
[**restore_object**](PreservationManagerApi.md#restore_object) | **POST** /job/restore | Restores the local copy of an object from a remote source
[**retrieve_batch**](PreservationManagerApi.md#retrieve_batch) | **GET** /batch/{ingestId} | Retrieves Ingest Batch details
[**retrieve_batch_events**](PreservationManagerApi.md#retrieve_batch_events) | **GET** /batch/{ingestId}/event | Retrieves all of the events associated to the batch. This does not include events associated to objects in the batch
[**retrieve_batch_object**](PreservationManagerApi.md#retrieve_batch_object) | **GET** /batch/object | Retrieves details about an Ingest Batch Object
[**retrieve_batch_object_events**](PreservationManagerApi.md#retrieve_batch_object_events) | **GET** /batch/object/event | Retrieves all of the events associated to the object in the batch
[**retrieve_batch_object_file**](PreservationManagerApi.md#retrieve_batch_object_file) | **GET** /batch/object/file | Retrieves a specific file associated to an Ingest Batch Object
[**retrieve_batch_object_files**](PreservationManagerApi.md#retrieve_batch_object_files) | **GET** /batch/object/files | Retrieves the files associated to an Ingest Batch Object
[**retrieve_batch_objects**](PreservationManagerApi.md#retrieve_batch_objects) | **GET** /batch/{ingestId}/objects | Retrieves Ingest Batch Objects
[**retrieve_job_logs**](PreservationManagerApi.md#retrieve_job_logs) | **GET** /job/{jobId}/logs | Retrieves all of the logs associated with a job
[**retrieve_object_events**](PreservationManagerApi.md#retrieve_object_events) | **GET** /object/event | Retrieves all of the events associated with an object
[**retrieve_object_storage_problems**](PreservationManagerApi.md#retrieve_object_storage_problems) | **GET** /object/problems/storage | Retrieves details about what storage problems are affecting an object
[**retrieve_objects**](PreservationManagerApi.md#retrieve_objects) | **POST** /vault/retrieve | Requests the retrieval of preserved objects
[**retry_batch_ingest**](PreservationManagerApi.md#retry_batch_ingest) | **POST** /batch/retryIngest | Retries a batch ingest if it has failed
[**retry_batch_replicate**](PreservationManagerApi.md#retry_batch_replicate) | **POST** /batch/retryReplicate | Retries a batch replicate if it has failed
[**retry_retrieve_job**](PreservationManagerApi.md#retry_retrieve_job) | **POST** /vault/retrieve/{requestId}/retry/{jobId} | Retries a failed retrieve job
[**search_batches**](PreservationManagerApi.md#search_batches) | **GET** /batch/search | Search for batches
[**update_user_vault_permissions**](PreservationManagerApi.md#update_user_vault_permissions) | **POST** /user/vault | Updates a user&#x27;s permissions on a vault. Any existing permissions are overwritten. An empty permission list removes all permissions for the vault.
[**validate_object**](PreservationManagerApi.md#validate_object) | **POST** /job/validate | Validates the local copy of an object
[**validate_object_remote**](PreservationManagerApi.md#validate_object_remote) | **POST** /job/validateRemote | Validates a remote copy of an object

# **approve_ingest_batch**
> approve_ingest_batch(opts)

Approves a batch for ingestion

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::ApproveIngestBatchRequest.new # ApproveIngestBatchRequest | 
}

begin
  #Approves a batch for ingestion
  api_instance.approve_ingest_batch(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->approve_ingest_batch: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ApproveIngestBatchRequest**](ApproveIngestBatchRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **approve_ingest_object**
> approve_ingest_object(opts)

Approves an object for ingestion

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::ApproveIngestObjectRequest.new # ApproveIngestObjectRequest | 
}

begin
  #Approves an object for ingestion
  api_instance.approve_ingest_object(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->approve_ingest_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ApproveIngestObjectRequest**](ApproveIngestObjectRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **cancel_job**
> cancel_job(opts)

Cancels a pending job

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::CancelJobRequest.new # CancelJobRequest | 
}

begin
  #Cancels a pending job
  api_instance.cancel_job(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->cancel_job: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CancelJobRequest**](CancelJobRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **create_org**
> create_org(org_name, opts)

Creates a new organization

Service adminstrator access is required to create an organization.

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization
opts = { 
  body: PreservationManager::CreateOrgRequest.new # CreateOrgRequest | 
}

begin
  #Creates a new organization
  api_instance.create_org(org_name, opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->create_org: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 
 **body** | [**CreateOrgRequest**](CreateOrgRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **create_vault**
> create_vault(opts)

Creates a new vault for an organization

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::CreateVaultRequest.new # CreateVaultRequest | 
}

begin
  #Creates a new vault for an organization
  api_instance.create_vault(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->create_vault: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CreateVaultRequest**](CreateVaultRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **delete_object**
> delete_object(opts)

Marks the object as deleted in the database, but does not actually delete any files

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::DeleteObjectRequest.new # DeleteObjectRequest | 
}

begin
  #Marks the object as deleted in the database, but does not actually delete any files
  api_instance.delete_object(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->delete_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**DeleteObjectRequest**](DeleteObjectRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **describe_job**
> DescribeJobResponse describe_job(job_id)

Gets job details

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
job_id = 789 # Integer | The ID of the job


begin
  #Gets job details
  result = api_instance.describe_job(job_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_job: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **job_id** | **Integer**| The ID of the job | 

### Return type

[**DescribeJobResponse**](DescribeJobResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **describe_org**
> DescribeOrgResponse describe_org(org_name)

Describes the specified organization and returns the current user's permissions

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization


begin
  #Describes the specified organization and returns the current user's permissions
  result = api_instance.describe_org(org_name)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_org: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 

### Return type

[**DescribeOrgResponse**](DescribeOrgResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **describe_org_contact**
> OrganizationContactResponse describe_org_contact(org_name)

Returns the primary contact for the organization.

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization


begin
  #Returns the primary contact for the organization.
  result = api_instance.describe_org_contact(org_name)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_org_contact: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 

### Return type

[**OrganizationContactResponse**](OrganizationContactResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **describe_preservation_object**
> DescribePreservationObjectResponse describe_preservation_object(vault, external_object_id, opts)

Retrieves details about an object version

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
vault = 'vault_example' # String | The vault an object is in
external_object_id = 'external_object_id_example' # String | The external ID of the object
opts = { 
  version: 56 # Integer | The version of an object
}

begin
  #Retrieves details about an object version
  result = api_instance.describe_preservation_object(vault, external_object_id, opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_preservation_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | **String**| The vault an object is in | 
 **external_object_id** | **String**| The external ID of the object | 
 **version** | **Integer**| The version of an object | [optional] 

### Return type

[**DescribePreservationObjectResponse**](DescribePreservationObjectResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **describe_retrieve_request**
> DescribeRetrieveObjectsResponse describe_retrieve_request(request_id)

Describes a retrieve objects request

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
request_id = 789 # Integer | The ID of the request


begin
  #Describes a retrieve objects request
  result = api_instance.describe_retrieve_request(request_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_retrieve_request: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request_id** | **Integer**| The ID of the request | 

### Return type

[**DescribeRetrieveObjectsResponse**](DescribeRetrieveObjectsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **describe_user**
> DescribeUserResponse describe_user

Retrieves details about the current user

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new

begin
  #Retrieves details about the current user
  result = api_instance.describe_user
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_user: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DescribeUserResponse**](DescribeUserResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **describe_vault**
> DescribeVaultResponse describe_vault(vault)

Returns details about the vault and the current user's permissions in the vault

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
vault = 'vault_example' # String | The name of the vault


begin
  #Returns details about the vault and the current user's permissions in the vault
  result = api_instance.describe_vault(vault)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->describe_vault: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | **String**| The name of the vault | 

### Return type

[**DescribeVaultResponse**](DescribeVaultResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **diff_batch_object**
> DiffBatchObjectResponse diff_batch_object(ingest_id, external_object_id)

Diffs the batch object against the current state of the object in the preservation system

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch
external_object_id = 'external_object_id_example' # String | The external ID of the object


begin
  #Diffs the batch object against the current state of the object in the preservation system
  result = api_instance.diff_batch_object(ingest_id, external_object_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->diff_batch_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 
 **external_object_id** | **String**| The external ID of the object | 

### Return type

[**DiffBatchObjectResponse**](DiffBatchObjectResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **disable_job_types**
> disable_job_types(opts)

Disables job types from being processed

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::DisableJobTypesRequest.new # DisableJobTypesRequest | 
}

begin
  #Disables job types from being processed
  api_instance.disable_job_types(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->disable_job_types: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**DisableJobTypesRequest**](DisableJobTypesRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **download_job**
> String download_job(job_id)

Downloads the output of a retrieve job

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
job_id = 789 # Integer | The ID of the job


begin
  #Downloads the output of a retrieve job
  result = api_instance.download_job(job_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->download_job: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **job_id** | **Integer**| The ID of the job | 

### Return type

**String**

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/zip



# **enable_job_types**
> enable_job_types(opts)

Enables job types from being processed

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::EnableJobTypesRequest.new # EnableJobTypesRequest | 
}

begin
  #Enables job types from being processed
  api_instance.enable_job_types(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->enable_job_types: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**EnableJobTypesRequest**](EnableJobTypesRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **fail_job**
> fail_job(opts)

Marks an executing job as failed. This action can only be completed by a service administrator, and should only be used when a job has a state of executing but is not being executed by a worker.

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::CancelJobRequest.new # CancelJobRequest | 
}

begin
  #Marks an executing job as failed. This action can only be completed by a service administrator, and should only be used when a job has a state of executing but is not being executed by a worker.
  api_instance.fail_job(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->fail_job: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CancelJobRequest**](CancelJobRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **get_ingest_event_counts**
> SystemEventCountsResponse get_ingest_event_counts(start_date, end_date, opts)

Counts of all ingest events in the system or organization if specified.

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
start_date = Date.parse('2013-10-20') # Date | The starting date for the event counts.
end_date = Date.parse('2013-10-20') # Date | The ending date for the event counts.
opts = { 
  event_type: [PreservationManager::EventType.new], # Array<EventType> | Array of event types.
  event_outcome: [PreservationManager::EventOutcome.new], # Array<EventOutcome> | Array of event outcomes.
  organization_name: 'organization_name_example' # String | The ID of the organization.
}

begin
  #Counts of all ingest events in the system or organization if specified.
  result = api_instance.get_ingest_event_counts(start_date, end_date, opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->get_ingest_event_counts: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **start_date** | **Date**| The starting date for the event counts. | 
 **end_date** | **Date**| The ending date for the event counts. | 
 **event_type** | [**Array&lt;EventType&gt;**](EventType.md)| Array of event types. | [optional] 
 **event_outcome** | [**Array&lt;EventOutcome&gt;**](EventOutcome.md)| Array of event outcomes. | [optional] 
 **organization_name** | **String**| The ID of the organization. | [optional] 

### Return type

[**SystemEventCountsResponse**](SystemEventCountsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_preservation_event_counts**
> SystemEventCountsResponse get_preservation_event_counts(start_date, end_date, opts)

Counts of all preservation events in the system or organization if specified.

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
start_date = Date.parse('2013-10-20') # Date | The starting date for the event counts.
end_date = Date.parse('2013-10-20') # Date | The ending date for the event counts.
opts = { 
  event_type: [PreservationManager::EventType.new], # Array<EventType> | Array of event types.
  event_outcome: [PreservationManager::EventOutcome.new], # Array<EventOutcome> | Array of event outcomes.
  organization_name: 'organization_name_example' # String | The ID of the organization.
}

begin
  #Counts of all preservation events in the system or organization if specified.
  result = api_instance.get_preservation_event_counts(start_date, end_date, opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->get_preservation_event_counts: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **start_date** | **Date**| The starting date for the event counts. | 
 **end_date** | **Date**| The ending date for the event counts. | 
 **event_type** | [**Array&lt;EventType&gt;**](EventType.md)| Array of event types. | [optional] 
 **event_outcome** | [**Array&lt;EventOutcome&gt;**](EventOutcome.md)| Array of event outcomes. | [optional] 
 **organization_name** | **String**| The ID of the organization. | [optional] 

### Return type

[**SystemEventCountsResponse**](SystemEventCountsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **get_system_storage**
> SystemStorageResponse get_system_storage

Retrieves system wide storage details, including a list of all organizations in the system and their storage details

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new

begin
  #Retrieves system wide storage details, including a list of all organizations in the system and their storage details
  result = api_instance.get_system_storage
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->get_system_storage: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**SystemStorageResponse**](SystemStorageResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **ingest_bag**
> IngestBagResponse ingest_bag(opts)

Ingests the objects in a BagIt bag

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  vault: PreservationManager::Vault.new # Vault | 
  file: 'file_example' # String | 
}

begin
  #Ingests the objects in a BagIt bag
  result = api_instance.ingest_bag(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->ingest_bag: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | [**Vault**](.md)|  | [optional] 
 **file** | **String**|  | [optional] 

### Return type

[**IngestBagResponse**](IngestBagResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json



# **list_executing_jobs**
> ListJobsResponse list_executing_jobs

Lists jobs that have a state of EXECUTING

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new

begin
  #Lists jobs that have a state of EXECUTING
  result = api_instance.list_executing_jobs
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_executing_jobs: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ListJobsResponse**](ListJobsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_jobs**
> ListJobsResponse list_jobs(org_name)

Lists jobs

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization


begin
  #Lists jobs
  result = api_instance.list_jobs(org_name)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_jobs: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 

### Return type

[**ListJobsResponse**](ListJobsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_org_user_vault_permissions**
> ListVaultPermissionsResponse list_org_user_vault_permissions(org_name, opts)

List all of the vaults in an org along with the user's permissions

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization
opts = { 
  username: 'username_example' # String | A user's username in the preservation system
}

begin
  #List all of the vaults in an org along with the user's permissions
  result = api_instance.list_org_user_vault_permissions(org_name, opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_org_user_vault_permissions: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 
 **username** | **String**| A user&#x27;s username in the preservation system | [optional] 

### Return type

[**ListVaultPermissionsResponse**](ListVaultPermissionsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_org_users**
> ListOrgUsersResponse list_org_users(org_name)

Retrieves a list of all of the members of an organization

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization


begin
  #Retrieves a list of all of the members of an organization
  result = api_instance.list_org_users(org_name)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_org_users: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 

### Return type

[**ListOrgUsersResponse**](ListOrgUsersResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_user_orgs**
> ListUserOrgsResponse list_user_orgs

Retrieves a list of all organizations the authenticated user is an active member of

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new

begin
  #Retrieves a list of all organizations the authenticated user is an active member of
  result = api_instance.list_user_orgs
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_user_orgs: #{e}"
end
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ListUserOrgsResponse**](ListUserOrgsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_users_in_vault**
> ListVaultUsersResponse list_users_in_vault(vault)

Retrieves a list of users with read or write permissions for the given vault

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
vault = 'vault_example' # String | The name of the vault


begin
  #Retrieves a list of users with read or write permissions for the given vault
  result = api_instance.list_users_in_vault(vault)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_users_in_vault: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | **String**| The name of the vault | 

### Return type

[**ListVaultUsersResponse**](ListVaultUsersResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_vault_problems**
> ListVaultProblemsResponse list_vault_problems(vault)

Returns a list of objects within the vault for which storage problems have been identified

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
vault = 'vault_example' # String | The name of the vault


begin
  #Returns a list of objects within the vault for which storage problems have been identified
  result = api_instance.list_vault_problems(vault)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_vault_problems: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | **String**| The name of the vault | 

### Return type

[**ListVaultProblemsResponse**](ListVaultProblemsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **list_vaults**
> ListVaultsResponse list_vaults(org_name)

Lists all vaults for an organization

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
org_name = 'org_name_example' # String | The ID of the organization


begin
  #Lists all vaults for an organization
  result = api_instance.list_vaults(org_name)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->list_vaults: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | 

### Return type

[**ListVaultsResponse**](ListVaultsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **reject_ingest_batch**
> reject_ingest_batch(opts)

Rejects a batch for ingestion

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::RejectIngestBatchRequest.new # RejectIngestBatchRequest | 
}

begin
  #Rejects a batch for ingestion
  api_instance.reject_ingest_batch(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->reject_ingest_batch: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RejectIngestBatchRequest**](RejectIngestBatchRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **reject_ingest_object**
> reject_ingest_object(opts)

Rejects an object for ingestion

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::RejectIngestObjectRequest.new # RejectIngestObjectRequest | 
}

begin
  #Rejects an object for ingestion
  api_instance.reject_ingest_object(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->reject_ingest_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RejectIngestObjectRequest**](RejectIngestObjectRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **replicate_object**
> ReplicateObjectResponse replicate_object(opts)

Replicates an object from local storage to a remote

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::ReplicateObjectRequest.new # ReplicateObjectRequest | 
}

begin
  #Replicates an object from local storage to a remote
  result = api_instance.replicate_object(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->replicate_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ReplicateObjectRequest**](ReplicateObjectRequest.md)|  | [optional] 

### Return type

[**ReplicateObjectResponse**](ReplicateObjectResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **restore_object**
> RestorePreservationObjectResponse restore_object(opts)

Restores the local copy of an object from a remote source

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::RestorePreservationObjectRequest.new # RestorePreservationObjectRequest | 
}

begin
  #Restores the local copy of an object from a remote source
  result = api_instance.restore_object(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->restore_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RestorePreservationObjectRequest**](RestorePreservationObjectRequest.md)|  | [optional] 

### Return type

[**RestorePreservationObjectResponse**](RestorePreservationObjectResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **retrieve_batch**
> RetrieveBatchResponse retrieve_batch(ingest_id)

Retrieves Ingest Batch details

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch


begin
  #Retrieves Ingest Batch details
  result = api_instance.retrieve_batch(ingest_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 

### Return type

[**RetrieveBatchResponse**](RetrieveBatchResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_batch_events**
> RetrieveEventsResponse retrieve_batch_events(ingest_id)

Retrieves all of the events associated to the batch. This does not include events associated to objects in the batch

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch


begin
  #Retrieves all of the events associated to the batch. This does not include events associated to objects in the batch
  result = api_instance.retrieve_batch_events(ingest_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch_events: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 

### Return type

[**RetrieveEventsResponse**](RetrieveEventsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_batch_object**
> RetrieveBatchObjectResponse retrieve_batch_object(ingest_id, external_object_id)

Retrieves details about an Ingest Batch Object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch
external_object_id = 'external_object_id_example' # String | The external ID of the object


begin
  #Retrieves details about an Ingest Batch Object
  result = api_instance.retrieve_batch_object(ingest_id, external_object_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 
 **external_object_id** | **String**| The external ID of the object | 

### Return type

[**RetrieveBatchObjectResponse**](RetrieveBatchObjectResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_batch_object_events**
> RetrieveEventsResponse retrieve_batch_object_events(ingest_id, external_object_id)

Retrieves all of the events associated to the object in the batch

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch
external_object_id = 'external_object_id_example' # String | The external ID of the object


begin
  #Retrieves all of the events associated to the object in the batch
  result = api_instance.retrieve_batch_object_events(ingest_id, external_object_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch_object_events: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 
 **external_object_id** | **String**| The external ID of the object | 

### Return type

[**RetrieveEventsResponse**](RetrieveEventsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_batch_object_file**
> RetrieveBatchObjectFileResponse retrieve_batch_object_file(ingest_id, external_object_id, file_path)

Retrieves a specific file associated to an Ingest Batch Object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch
external_object_id = 'external_object_id_example' # String | The external ID of the object
file_path = 'file_path_example' # String | The object relative path of the file


begin
  #Retrieves a specific file associated to an Ingest Batch Object
  result = api_instance.retrieve_batch_object_file(ingest_id, external_object_id, file_path)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch_object_file: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 
 **external_object_id** | **String**| The external ID of the object | 
 **file_path** | **String**| The object relative path of the file | 

### Return type

[**RetrieveBatchObjectFileResponse**](RetrieveBatchObjectFileResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_batch_object_files**
> RetrieveBatchObjectFilesResponse retrieve_batch_object_files(ingest_id, external_object_id)

Retrieves the files associated to an Ingest Batch Object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch
external_object_id = 'external_object_id_example' # String | The external ID of the object


begin
  #Retrieves the files associated to an Ingest Batch Object
  result = api_instance.retrieve_batch_object_files(ingest_id, external_object_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch_object_files: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 
 **external_object_id** | **String**| The external ID of the object | 

### Return type

[**RetrieveBatchObjectFilesResponse**](RetrieveBatchObjectFilesResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_batch_objects**
> RetrieveBatchObjectsResponse retrieve_batch_objects(ingest_id, opts)

Retrieves Ingest Batch Objects

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
ingest_id = 789 # Integer | The ID for the Ingest Batch
opts = { 
  page_size: 56, # Integer | The number of results to include per page (default 20)
  page: 56, # Integer | The result page to retrieve, 0 indexed
  has_problems: 'has_problems_example' # String | Filter objects by the existence of errors or warnings. WARNINGS returns objects that only have warnings; ERRORS returns any object that has errors.
}

begin
  #Retrieves Ingest Batch Objects
  result = api_instance.retrieve_batch_objects(ingest_id, opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_batch_objects: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **ingest_id** | **Integer**| The ID for the Ingest Batch | 
 **page_size** | **Integer**| The number of results to include per page (default 20) | [optional] 
 **page** | **Integer**| The result page to retrieve, 0 indexed | [optional] 
 **has_problems** | **String**| Filter objects by the existence of errors or warnings. WARNINGS returns objects that only have warnings; ERRORS returns any object that has errors. | [optional] 

### Return type

[**RetrieveBatchObjectsResponse**](RetrieveBatchObjectsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_job_logs**
> RetrieveLogsResponse retrieve_job_logs(job_id)

Retrieves all of the logs associated with a job

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
job_id = 789 # Integer | The ID of the job


begin
  #Retrieves all of the logs associated with a job
  result = api_instance.retrieve_job_logs(job_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_job_logs: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **job_id** | **Integer**| The ID of the job | 

### Return type

[**RetrieveLogsResponse**](RetrieveLogsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_object_events**
> RetrieveEventsResponse retrieve_object_events(vault, external_object_id)

Retrieves all of the events associated with an object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
vault = 'vault_example' # String | The vault an object is in
external_object_id = 'external_object_id_example' # String | The external ID of the object


begin
  #Retrieves all of the events associated with an object
  result = api_instance.retrieve_object_events(vault, external_object_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_object_events: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | **String**| The vault an object is in | 
 **external_object_id** | **String**| The external ID of the object | 

### Return type

[**RetrieveEventsResponse**](RetrieveEventsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_object_storage_problems**
> RetrieveObjectStorageProblemsResponse retrieve_object_storage_problems(vault, external_object_id)

Retrieves details about what storage problems are affecting an object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
vault = 'vault_example' # String | The vault an object is in
external_object_id = 'external_object_id_example' # String | The external ID of the object


begin
  #Retrieves details about what storage problems are affecting an object
  result = api_instance.retrieve_object_storage_problems(vault, external_object_id)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_object_storage_problems: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **vault** | **String**| The vault an object is in | 
 **external_object_id** | **String**| The external ID of the object | 

### Return type

[**RetrieveObjectStorageProblemsResponse**](RetrieveObjectStorageProblemsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **retrieve_objects**
> RetrieveObjectsResponse retrieve_objects(opts)

Requests the retrieval of preserved objects

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::RetrieveObjectsRequest.new # RetrieveObjectsRequest | 
}

begin
  #Requests the retrieval of preserved objects
  result = api_instance.retrieve_objects(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retrieve_objects: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RetrieveObjectsRequest**](RetrieveObjectsRequest.md)|  | [optional] 

### Return type

[**RetrieveObjectsResponse**](RetrieveObjectsResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **retry_batch_ingest**
> retry_batch_ingest(opts)

Retries a batch ingest if it has failed

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::BatchRetryIngestRequest.new # BatchRetryIngestRequest | 
}

begin
  #Retries a batch ingest if it has failed
  api_instance.retry_batch_ingest(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retry_batch_ingest: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**BatchRetryIngestRequest**](BatchRetryIngestRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **retry_batch_replicate**
> retry_batch_replicate(opts)

Retries a batch replicate if it has failed

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::BatchRetryReplicateRequest.new # BatchRetryReplicateRequest | 
}

begin
  #Retries a batch replicate if it has failed
  api_instance.retry_batch_replicate(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retry_batch_replicate: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**BatchRetryReplicateRequest**](BatchRetryReplicateRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **retry_retrieve_job**
> retry_retrieve_job(request_id, job_id)

Retries a failed retrieve job

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
request_id = 789 # Integer | The ID of the request
job_id = 789 # Integer | The ID of the job


begin
  #Retries a failed retrieve job
  api_instance.retry_retrieve_job(request_id, job_id)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->retry_retrieve_job: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **request_id** | **Integer**| The ID of the request | 
 **job_id** | **Integer**| The ID of the job | 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **search_batches**
> BatchSearchResponse search_batches(opts)

Search for batches

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  org_name: 'org_name_example', # String | The ID of the organization
  vault: ['vault_example'], # Array<String> | The vault an object is in
  state: ['state_example'], # Array<String> | The state the batch is in
  page_size: 56, # Integer | The number of results to include per page (default 20)
  page: 56 # Integer | The result page to retrieve, 0 indexed
}

begin
  #Search for batches
  result = api_instance.search_batches(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->search_batches: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **org_name** | **String**| The ID of the organization | [optional] 
 **vault** | [**Array&lt;String&gt;**](String.md)| The vault an object is in | [optional] 
 **state** | [**Array&lt;String&gt;**](String.md)| The state the batch is in | [optional] 
 **page_size** | **Integer**| The number of results to include per page (default 20) | [optional] 
 **page** | **Integer**| The result page to retrieve, 0 indexed | [optional] 

### Return type

[**BatchSearchResponse**](BatchSearchResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json



# **update_user_vault_permissions**
> update_user_vault_permissions(opts)

Updates a user's permissions on a vault. Any existing permissions are overwritten. An empty permission list removes all permissions for the vault.

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::UpdateUserVaultPermissionsRequest.new # UpdateUserVaultPermissionsRequest | 
}

begin
  #Updates a user's permissions on a vault. Any existing permissions are overwritten. An empty permission list removes all permissions for the vault.
  api_instance.update_user_vault_permissions(opts)
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->update_user_vault_permissions: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**UpdateUserVaultPermissionsRequest**](UpdateUserVaultPermissionsRequest.md)|  | [optional] 

### Return type

nil (empty response body)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **validate_object**
> ValidatePreservationObjectResponse validate_object(opts)

Validates the local copy of an object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::ValidatePreservationObjectRequest.new # ValidatePreservationObjectRequest | 
}

begin
  #Validates the local copy of an object
  result = api_instance.validate_object(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->validate_object: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ValidatePreservationObjectRequest**](ValidatePreservationObjectRequest.md)|  | [optional] 

### Return type

[**ValidatePreservationObjectResponse**](ValidatePreservationObjectResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



# **validate_object_remote**
> ValidateObjectRemoteResponse validate_object_remote(opts)

Validates a remote copy of an object

### Example
```ruby
# load the gem
require 'preservation_manager'
# setup authorization
PreservationManager.configure do |config|
  # Configure API key authorization: ApiKeyAuth
  config.api_key['X-API-KEY'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['X-API-KEY'] = 'Bearer'
end

api_instance = PreservationManager::PreservationManagerApi.new
opts = { 
  body: PreservationManager::ValidateObjectRemoteRequest.new # ValidateObjectRemoteRequest | 
}

begin
  #Validates a remote copy of an object
  result = api_instance.validate_object_remote(opts)
  p result
rescue PreservationManager::ApiError => e
  puts "Exception when calling PreservationManagerApi->validate_object_remote: #{e}"
end
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ValidateObjectRemoteRequest**](ValidateObjectRemoteRequest.md)|  | [optional] 

### Return type

[**ValidateObjectRemoteResponse**](ValidateObjectRemoteResponse.md)

### Authorization

[ApiKeyAuth](../README.md#ApiKeyAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json



