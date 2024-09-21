# Git Submodule Workflow Tutorial

## Context

When managing a repository that contains both private content and a public submodule, it's crucial to follow a specific workflow to ensure proper synchronization and avoid accidental exposure of private information. This tutorial will guide you through the day-to-day routine of pushing and committing changes in both your private repository and public submodule.

## Basic Workflow

Here's a simple working example of how to manage changes in your repository:

### 1. Changes in the Private Repository

When you've made changes to files outside the Tech folder (your private content):

  ```bash
  # In your main repository
  git add .
  git commit -m "Your commit message for private changes"
  git push origin main
  ```

### 2. Changes in the Public Submodule

For changes within the Tech folder (your public submodule):

  ```bash
  # Navigate to the Tech submodule
  cd Tech

  # Make your changes, then:
  git add .
  git commit -m "Your commit message for public Tech changes"
  git push origin main

  # Return to the main repository
  cd ..

  # Update the submodule reference in the main repo
  git add Tech
  git commit -m "Update Tech submodule"
  git push origin main
  ```

### 3. Changes in Both Private and Public Parts

If you've made changes in both areas:

  ```bash
  # First, commit and push changes in the Tech submodule
  cd Tech
  git add .
  git commit -m "Your commit message for public Tech changes"
  git push origin main
  cd ..

  # Then, commit and push changes in the main repository
  git add .
  git commit -m "Your commit message for private changes and update Tech submodule"
  git push origin main
  ```

## Important Considerations

1. Always push changes in the Tech submodule before pushing in the main repository.
2. Be cautious about what you commit to the Tech submodule, as it's public.
3. When working on multiple machines, always pull changes in both the main repo and the submodule:

  ```bash
  git pull
  git submodule update --init --recursive
  ```

## Potential Pitfalls and Warnings

1. **Forgetting to push submodule changes**: If you update the submodule locally but forget to push those changes, other users (or you on another machine) might encounter issues when trying to update the main repository.

2. **Accidental exposure of private data**: Always double-check that you're not committing any private information to the public Tech submodule.

3. **Detached HEAD in submodule**: If you find yourself in a detached HEAD state in the submodule, make sure to check out a branch before making changes:

  ```bash
  cd Tech
  git checkout main
  ```

4. **Submodule updates not reflected**: Sometimes, the main repository might not immediately reflect updates to the submodule. In such cases, you may need to manually update the submodule reference:

  ```bash
  git submodule update --remote --merge
  ```

By following this workflow and keeping these considerations in mind, you'll be able to efficiently manage your repository with its public submodule while keeping your private content secure.