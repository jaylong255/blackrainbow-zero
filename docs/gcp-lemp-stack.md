# GCP LEMP Stack

## Steps
This is a raw list of steps taken to launch a LEMP stack on GCP.

- Created a project called `Blackrainbow Zero` in the GCP console.
- Created a bucket `blackrainbow-zero-terraform-state` in Google Cloud Storage to store Terraform State.
- Authenticated with the Google Cloud CLI: `gcloud auth login`
- Attempted to initialize the backend with `terraform init`.

Got a permissions error: 
> Error: Failed to get existing workspaces: querying Cloud Storage failed: Get "https://storage.googleapis.com/storage/v1/b/blackrainbow-zero-terraform-state/o?alt=json&delimiter=%2F&endOffset=&includeTrailingDelimiter=false&pageToken=&prefix=gcp-lemp-stack%2F&prettyPrint=false&projection=full&startOffset=&versions=false": oauth2: "invalid_grant" "Bad Request"

- Added Editor role to my principle for the project `Blackrainbow Zero`
- Added `Storage Folder Admin` role to Owners of project `blackrainbow-zero` in the list of principles on the bucket(This may be more than least privilege, but not by much)
- Verified that the Cloud Storage API is enabled.
- Verified that the Cloud Logging API is enabled.
- Enabled `Storage Insights API` logs for `Admin Read`, `Data Read`, and `Data Write` log types in the `Audit Logs` tab in `IAM & Admin`
 
```bash
#Set up log delivery through the CLI with command:
gcloud storage buckets add-iam-policy-binding gs://blackrainbow-zero-terraform-state --member=group:cloud-storage-analytics@google.com --role=roles/storage.objectCreator

# Actually, I got this wrong the first time and added the binding to the Terraform state bucket. What I should have done is create a new bucket just for log delivery and added the binding to that. To undo what I just did, I ran this command:
gcloud storage buckets remove-iam-policy-binding gs://blackrainbow-zero-terraform-state --member=group:cloud-storage-analytics@google.com --role=roles/storage.objectCreator

# Set the Project
gcloud config set project blackrainbow-zero

# Create the logs bucket
gcloud storage buckets create gs://blackrainbow-logs-bucket

# Grant Cloud Storage the roles/storage.objectCreator role for the bucket:
gcloud storage buckets add-iam-policy-binding gs://blackrainbow-logs-bucket --member=group:cloud-storage-analytics@google.com --role=roles/storage.objectCreator

# Enable logging for your bucket using the --log-bucket flag:
gcloud storage buckets update gs://blackrainbow-zero-terraform-state --log-bucket=gs://blackrainbow-logs-bucket --log-object-prefix=blackrainbow_log_object
```

- abondoned all of this mess for google cloud shell terminal and editor. nooch.