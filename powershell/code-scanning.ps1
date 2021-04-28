# Initialise Script:
$github_pat = "<PAT GOES HERE>"
$github_host = "https://<GITHUB_HOSTNAME>"
$github_repo = "<GITHUB_ORG>"+ "/" +"<GITHUB_REPO_NAME>"
$git_commit = git rev-parse HEAD
$git_ref = git symbolic-ref HEAD
$codeql_runner_url = "https://github.com/github/codeql-action/releases/download/codeql-bundle-20210421/codeql-runner-win.exe"
$codeql_runner_output_file = "$PSScriptRoot\codeql-runner-win.exe"

# Vars:
#Write-Output "GitHubHost is $github_host"
#Write-Output "GitHub Repo is $github_repo"
#Write-Output "Commit is $git_commit"
#Write-Output "Ref is $git_ref"

# Download the Windows Runner
try
{
    $Response = Invoke-WebRequest -Uri $codeql_runner_url -OutFile $codeql_runner_output_file
    $StatusCode = $Response.StatusCode
    Write-Output "Download completed successfully"
}
catch
{
    $StatusCode = $_.Exception.Response.StatusCode.value__
    Write-Output "Download Failed"
}

# Initialise the Runner
& $codeql_runner_output_file init --repository $github_repo --github-url $github_host --github-auth $github_pat

# 2.1 COMPILE/BUILD
# & $codeql_runner_output_file autobuild
# OR
# Use you actual build steps here

# 3. Run the Analyse Step
& $codeql_runner_output_file analyze --repository $github_repo --github-url $github_host --github-auth $github_pat --commit $git_commit --ref $git_ref
