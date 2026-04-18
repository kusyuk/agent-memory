# Release Guide: Agentic Memory

Follow these steps to release a new version of `kusyuk-agent-memory` to npm and Homebrew.

## 1. Prepare for Release
- Ensure all changes are committed and pushed to the `main` branch.
- Update the version in `package.json`.

## 2. npm Release
```bash
# Log in to npm (first time only)
npm login

# Publish the package
npm publish --access public
```

## 3. GitHub Release (for Homebrew)
Homebrew requires a stable source URL (tarball) to install.

1.  **Tag the commit**:
    ```bash
    git tag -a v1.0.0 -m "Release v1.0.0"
    git push origin v1.0.0
    ```
2.  **Create a Release on GitHub**:
    - Go to your repository on GitHub.
    - Click "Releases" -> "Draft a new release".
    - Select the tag `v1.0.0`.
    - Publish the release.

## 4. Update Homebrew Formula
1.  **Get the SHA256** of the release tarball:
    ```bash
    curl -L https://github.com/kusyuk/agent-memory/archive/refs/tags/v1.0.0.tar.gz -o agent-memory.tar.gz
    shasum -a 256 agent-memory.tar.gz
    ```
2.  **Update `Formula/agent-memory.rb`**:
    - Update the `url` with the new tag URL.
    - Update the `sha256` with the value calculated above.
3.  **Update your Tap repository**:
    - Push the updated formula to your `homebrew-tap` repository on GitHub.

## 5. Verify the Installation
```bash
# Test npm
npm install -g kusyuk-agent-memory
agent-memory status

# Test Homebrew
brew update
brew install agent-memory
agent-memory status
```
