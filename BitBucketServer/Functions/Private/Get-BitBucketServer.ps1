function Get-BitBucketServer {
    [CmdletBinding()]
    param()

    if (-Not (Test-BitBucketServer)) {
        throw 'Credentials not set. Please use Set-BitBucketServer first.'
    }

    @{
        Url   = $script:BitBucketServerUrl
        User  = $script:BitBucketServerUser
        Token = $script:BitBucketServerToken
    }
}