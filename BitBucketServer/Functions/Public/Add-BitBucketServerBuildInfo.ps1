function Add-BitBucketServerBuildInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Commit
        ,
        [Parameter(Mandatory)]
        [ValidateSet('InProgress', 'Successful', 'Failed')]
        [string]
        $State
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Key
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Url
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Description
    )

    $BitBucket = Get-BitBucketServer

    $Body = @{
        state = $State.ToUpper()
        key   = $Key
        url   = $Url
    }
    if ($PSBoundParameters.ContainsKey('Name')) {
        $Body.Add('name', $Name)
    }
    if ($PSBoundParameters.ContainsKey('Description')) {
        $Body.Add('description', $Description)
    }
    $Body = $Body | ConvertTo-Json

    Invoke-AuthenticatedWebRequest -Uri "$($BitBucket.Url)/rest/build-status/1.0/commits/$Commit" -Method Post -User $BitBucket.User -Token $BitBucket.Token -Headers @{'Content-Type' = 'application/json'}
}