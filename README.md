# AWS MetaData

Simplified function that can be loaded into memory or added to scripts for quick access to AWS EC2 metadata. This function does not have any dependencies.

## Dependencies

The function requires only that the AWS metadata service be running on the EC2. The are no additional software dependencies. The host OS **DOES NOT** need AWS CLI nor the AWS PowerShell tools installed.

## Use

Load the function into memory:

```powershell

iex $(iwr 'https://raw.githubusercontent.com/grolston/awsmetadata/master/AwsMetadata.ps1' -UseBasicParsing).Content

```

> **Note:** Loading this into memory does not save anything locally. The function can only be referenced in the session and once the session exits, the Get-AwsMetadata function will not persist.

## Get-AwsMetadata Command

The Get-AwsMetadata command looks to the local aws metadata service running on `http://169.254.169.254/latest/meta-data/`. The command is uses the simple ValidationSet parameter to enable tab-completion allowing the administrator to interactively view options. Currently the `Property` parameter contains the following:

- ami-id
- ami-launch-index
- ami-manifest-path
- hostname
- instance-action
- instance-id
- instance-type
- local-hostname
- local-ipv4
- mac
- profile
- public-hostname
- public-ipv4
- reservation-id
- security-groups

Output of the of the function returns a string result.

> **Note:** the deployed function also contains an alias `AWSHOSTINFO` for an intuitive reference.