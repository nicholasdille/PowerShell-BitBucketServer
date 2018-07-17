#requires -Version 4
#requires -Modules WebRequest

function Invoke-BitBucketServerApi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
        ,
        [Parameter()]
        [ValidateSet('Delete', 'Get', 'Post', 'Put')]
        [string]
        $Method = 'Get'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers = @{}
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Accept = 'application/json'
    )

    if ($Headers.ContainsKey('Accept')) {
        $Headers.Accept = $Accept

    } else {
        $Headers.Add('Accept', $Accept)
    }

    $BitBucket = Get-BitBucketServer
    $AuthString = Get-BasicAuthentication -User $BitBucket.User -Token $BitBucket.Token
    $Headers.Add('Authorization', "Basic $AuthString")

    $Separator = '?'
    if ($Path.IndexOf($Separator) -gt -1) {
        $Separator = '&'
    }
    $BaseUri = "$($BitBucket.Url)/rest/api/1.0$Path" ### PAGINATION WHITELIST???
    $Offset = 0
    $IsLastPage = $False
    $Values = @()
    while (-not $IsLastPage) {
        try {
            $Response = Invoke-WebRequest -Uri "$($BaseUri)$($Separator)start=$Offset" -Method $Method -Headers $Headers

        } catch [System.Net.WebException] {
            throw "Request to $($BaseUri)$($Separator)start=$Offset returned $($_.Exception.Response.StatusCode.Value__)"
        }

        $Json = $Response.Content | ConvertFrom-Json
        if (-not $Json.size -and -not $Json.limit -and -not $Json.start) {
            return $Json
        }
        $Values += $Json.values

        $IsLastPage = $Json.isLastPage
        $Offset = $Json.nextPageStart
    }
    $Values
}