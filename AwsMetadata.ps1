Function Get-AwsMetadata {
<#
.Synopsis
   Simplified command to get local host information from an EC2
.DESCRIPTION
   Simplified command to access the AWS metadata of the EC2. The function
   requires no additional configuration beyond having an EC2 running the
   metadata services which is typically running by default on launch of
   an EC2 instance within AWS environment.
   Information available can be found at
   https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instancedata-data-categories.html
.EXAMPLE
   Get-AwsMetadata -Property "ami-id"
.EXAMPLE
   AwsHostInfo "ami-id"
#>
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        # Property or category of metadata to access
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [ValidateSet("ami-id",
                     "ami-launch-index",
                     "ami-manifest-path",
                     "hostname",
                     "instance-action",
                     "instance-id",
                     "instance-type",
                     "local-hostname",
                     "local-ipv4",
                     "mac",
                     "profile",
                     "public-hostname",
                     "public-ipv4",
                     "reservation-id",
                     "security-groups"
                     )]
        [string]
        $Property
    )

    Begin{
        $base_url = 'http://169.254.169.254/latest/meta-data/'
        try {
            $response = iwr -uri $base_url -UseBasicParsing -ErrorAction Stop
        }
        catch {
            write-error "The system is not running on AWS EC2" -ErrorAction Stop
        }
    }
    Process{
        $url = $base_url + $Property
        $result = (iwr -UseBasicParsing $url).Content
    }
    End
    {
        return $result
    }
}

New-Alias -Name "AwsHostInfo" -Value Get-AwsMetadata -Description "Intuitive simple name for Get-AwsMetadata" -Option ReadOnly
