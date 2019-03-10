Write-Host "Cloning existing GitHub Pages branch"

$workingDir = "$(System.DefaultWorkingDirectory)\master"

git clone https://${env:githubusername}:$(githubaccesstoken)@github.com/${env:githubusername}/${env:repositoryname}.git --branch=master $workingDir --quiet

if ($lastexitcode -gt 0)
{
    Write-Host "##vso[task.logissue type=error;]Unable to clone repository - check username, access token and repository name. Error code $lastexitcode"
    [Environment]::Exit(1)
}

Write-Host "Deleting current documentation from branch"

Remove-Item -Path $workingDir\* -Recurse

Write-Host "Copying new documentation into branch"

Copy-Item ${env:docPath}\* $workingDir -recurse -Force

Write-Host "Committing the GitHub Pages Branch"

Set-Location $workingDir
git config core.autocrlf false
git config user.email ${env:githubemail}
git config user.name ${env:githubusername}
git add *
git commit -m ${env:commitMessage}

if ($lastexitcode -gt 0)
{
    Write-Host "##vso[task.logissue type=error;]Error committing - see earlier log, error code $lastexitcode"
    [Environment]::Exit(1)
}

Write-Host "Pushing the GitHub Pages Branch"

git push

if ($lastexitcode -gt 0)
{
    Write-Host "##vso[task.logissue type=error;]Error pushing to master branch, probably an incorrect Personal Access Token, error code $lastexitcode"
    [Environment]::Exit(1)
}
