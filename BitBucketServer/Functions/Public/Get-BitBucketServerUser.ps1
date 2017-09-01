function Get-BitBucketServerUser {
    [CmdletBinding()]
    param(
        [Parameter()]
        [switch]
        $Raw
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $User
    )

    $Groups = @()
    $Filter = ''
    if ($User) {
        $Filter = "?filter=$User"

        $Values = Invoke-BitBucketServerApi -Path "/admin/users/more-members?context=$User"
        $Groups = $Values.name
    }

    $Values = Invoke-BitBucketServerApi -Path "/admin/users$Filter"
    
    if ($Raw) {
        $Values
        return
    }

    $EpochStart = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    foreach ($Item in $Values) {
        $Timestamp = $null
        if ($Item.lastAuthenticationTimestamp) {
            $Timestamp = $EpochStart.AddSeconds($Item.lastAuthenticationTimestamp / 1000)
        }
        [pscustomobject]@{
            DisplayName       = $Item.displayName
            Name              = $Item.name
            Address           = $Item.emailAddress
            Active            = $Item.active
            Directory         = $Item.directoryName
            LastAuthenticated = $Timestamp
            Groups            = $Groups
        }
    }
}