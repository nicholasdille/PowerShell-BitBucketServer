function Get-BitBucketServerProject {
    [CmdletBinding()]
    param(
        [Parameter()]
        [switch]
        $Raw
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Project
    )

    $Groups = @()
    $Users = @()
    $Filter = ''
    if ($Project) {
        $Filter = "/$Project"

        $Values = Invoke-BitBucketServerApi -Path "/projects$Filter/groups"
        $Groups = $Values.name
        $Values = Invoke-BitBucketServerApi -Path "/projects$Filter/users"
        $Users  = $Values.name
    }

    $Values = Invoke-BitBucketServerApi -Path "/projects$Filter"
    
    if ($Raw) {
        $Values
        return
    }

    foreach ($Item in $Values) {
        [pscustomobject]@{
            Name        = $Item.name
            Key         = $Item.key
            Description = $Item.description
            Groups      = $Groups
            Users       = $Users
        }
    }
}