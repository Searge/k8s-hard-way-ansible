#!/usr/bin/env bash
# The script is used to bump the version of the project. It reads the current version from the  pyproject.toml  file and asks the user to provide the new version. If the new version is not provided as an argument, the script will ask the user to provide it. The script then updates the version in the  pyproject.toml  and  CITATION.cff  files. It also generates the  CHANGELOG.md  file using  git-cliff  and commits the changes with a conventional commit message. Finally, it tags the commit and pushes the changes to the remote repository.
# The script can be executed as follows:
# $ ./scripts/bump.sh 0.2.0

# If the new version is not provided as an argument, the script will ask the user to provide it.
# $ ./scripts/bump.sh

# The script will ask the user to provide the new version.
# Enter the new version:
set -e

# Change to the project root directory.
cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
WD=$(pwd)

# Get the current version
VERSION=$(grep -oP 'version = "\K[^"]+' pyproject.toml)
# Get the new version from the user
USER_VERSION="$1"

echo "Current version: $VERSION"
# Check if the new version is provided as an argument
# If not, ask the user to provide the new version
if [ -z "$USER_VERSION" ]; then
    echo "Enter the new version: "
    echo "Example: 0.1.0"
    read NEW_VERSION
else
    NEW_VERSION=$USER_VERSION
fi
echo "Bumping version from $VERSION to v$NEW_VERSION"

# Update the version in the pyproject.toml file
sed -i "s/version = \"$VERSION\"/version = \"v$NEW_VERSION\"/g" pyproject.toml
# Update the version in the CITATION.cff file
sed -i "s/version: $VERSION/version: v$NEW_VERSION/g" CITATION.cff

# Update the CHANGELOG.md file with git-cliff
if ! command -v git-cliff &> /dev/null
then
    echo "git-cliff could not be found. Please install git-cliff to generate the CHANGELOG.md file."
    exit 1
fi

if [ -z "$USER_VERSION" ]; then
    git-cliff --tag v$NEW_VERSION --output CHANGELOG.md
else
    git-cliff --output CHANGELOG.md
fi

# Commit the changes
git add pyproject.toml CITATION.cff CHANGELOG.md
# Write the conventional commit message
git commit -m ":bookmark:: bump version to v$NEW_VERSION"
# Tag the commit
git tag "v$NEW_VERSION"

# Push the changes
git push origin v$NEW_VERSION -f

exit $?

