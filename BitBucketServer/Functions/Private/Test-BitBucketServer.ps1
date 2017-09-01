function Test-BitBucketServer {
    [CmdletBinding()]
    param()

    $script:BitBucketServerUrl -and $script:BitBucketServerUser -and $script:BitBucketServerToken
}