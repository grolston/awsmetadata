echo "loading function"

function Get-AwsMetadata {
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
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

if(!(Get-Alias -Name "AwsHostInfo" -ErrorAction Ignore)){
    New-Alias -Name "AwsHostInfo" -Value Get-AwsMetadata -Description "Intuitive simple name for Get-AwsMetadata" -Option ReadOnly
}
