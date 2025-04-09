#!/usr/bin/env python3
import argparse

def access_secret_version(project_id, secret_id, version_id):
    """
    Access the payload for the given secret version if one exists. The version
    can be a version number as a string (e.g. "5") or an alias (e.g. "latest").
    """

    # Import the Secret Manager client library.
    from google.cloud import secretmanager

    # Create the Secret Manager client.
    client = secretmanager.SecretManagerServiceClient()

    # Build the resource name of the secret version.
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"

    # Access the secret version.
    response = client.access_secret_version(request={"name": name})

    payload = response.payload.data.decode("UTF-8")
    print(format(payload))

# Build command line parser 
parser = argparse.ArgumentParser()

# Accept argument flag for Vault ID from Ansible
parser.add_argument("--projectId")
parser.add_argument("--secretId")
parser.add_argument("--secretIdVersion")
args = parser.parse_args()

access_secret_version(args.projectId, args.secretId, args.secretIdVersion)
