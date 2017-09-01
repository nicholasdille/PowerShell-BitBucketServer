function Get-BitBucketServerGroup {
    [CmdletBinding()]
    param(
        [Parameter()]
        [switch]
        $Raw
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Group
    )

    $Members = @()
    $Filter = ''
    if ($Group) {
        $Filter = "?filter=$Group"

        $Values = Invoke-BitBucketServerApi -Path "/admin/groups/more-members?context=$Group"
        $Members = $Values.name
    }
    $Values = Invoke-BitBucketServerApi -Path "/admin/groups$Filter"

    if ($Raw) {
        $Values
        return
    }

    foreach ($Item in $Values) {
        [pscustomobject]@{
            Name    = $Item.name
            Members = $Members
        }
    }
}