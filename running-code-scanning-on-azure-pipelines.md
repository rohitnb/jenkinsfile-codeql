## Running Code Scanning on Azure Pipelines:

Operating Systems - [Ubuntu](https://github.com/rohitnb/codescanning-sample-ci-scripts/blob/main/azure-pipelines-code-scanning-ubuntu.yml) and [Windows](https://github.com/rohitnb/codescanning-sample-ci-scripts/blob/main/azure-pipelines-code-scanning-windows.yml)

### Procedure:
1. Add the relevant YAML file to your repo
2. Create an Azure Pipeline using this YAML
3. Create a GitHub PAT with full repo scopes and add it to the pipeline as a secret variable - `GITHUB_PAT`
4. Run a scan of your base branches before running for any PRs
