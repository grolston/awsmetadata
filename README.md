# AWS MetaData

Simplified function that can be loaded into memory or added to scripts for quick access to AWS EC2 metadata. This function does not have any dependencies.

## Use

Load the function into memory:

```powershell

iex $(iwr https://raw.githubusercontent.com/grolston/awsmetadata/master/AwsMetadata.ps1 -UseBasicParsing).Content

```
