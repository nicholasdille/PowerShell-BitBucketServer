function Get-BitBucketServerRepository {
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
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Repository
    )

    $Filter = '/repos'
    if ($Project) {
        $Filter += "/projects/$Project/repos"

        if ($Repository) {
            $Filter += "/$Repository"
        }
    }
    $Values = Invoke-BitBucketServerApi -Path "$Filter"

    if ($Raw) {
        $Values
        return
    }

    foreach ($Item in $Values) {
        [pscustomobject]@{
            Id          = $Item.id
            Name        = $Item.name
            Slug        = $Item.slug
            State       = $Item.state
            ProjectKey  = $Item.project.key
            ProjectName = $Item.project.name
        }
    }
}