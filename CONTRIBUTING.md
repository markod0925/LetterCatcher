# Contributing to LetterCatcher

Thank you for your interest in contributing to LetterCatcher! We welcome contributions from the community to help improve the game. Please take a moment to review these guidelines before you start contributing.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [How to Contribute](#how-to-contribute)
   - [Reporting Issues](#reporting-issues)
   - [Suggesting Features](#suggesting-features)
   - [Code Contributions](#code-contributions)
   - [Adding Stories](#adding-stories)
   - [Adding Languages](#adding-languages)
3. [Coding Standards](#coding-standards)
4. [Pull Request Process](#pull-request-process)
5. [Additional Information](#additional-information)

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). Please read it to understand the expectations for behavior when contributing to the project.

## How to Contribute

### Reporting Issues

If you encounter any issues or bugs while playing the game, please report them on the project's GitHub issue tracker. Provide as much detail as possible to help us understand and resolve the issue.

### Suggesting Features

If you have ideas for new features or improvements to the game, feel free to suggest them on the project's GitHub issue tracker. We appreciate your feedback and suggestions!

### Code Contributions

1. Fork the repository and create a new branch for your changes.
2. Make your changes and ensure they are well-documented.
3. Submit a pull request with a clear description of your changes and why they should be merged.

### Adding Stories

1. Create a new story in the format used in the `stories.dat` file.
2. Ensure the story is appropriate for the game's target audience.
3. Submit a pull request with your new story added to the appropriate section of the `stories.dat` file.

### Adding Languages

1. Translate the game's text into a new language (e.g., XX) modifying `Assets/translations.csv`.
2. Open Godot Editor: it will automatically create a new `Assets/translations.XX.translation` file.
3. Add the new translation file to the project (Project->Project Settings...->Localization->Translation->Add).
4. Add new stories in the `stories.dat` file creating a new `XX` entry in the JSON file.
5. Submit a pull request with your new translations.

## Coding Standards

To maintain consistency and readability in the codebase, please follow these coding standards:

- Use clear and descriptive variable and function names.
- Add comments to explain the purpose and functionality of each function and variable.
- Follow the existing code style and formatting.
- Ensure your code does not introduce new issues.

## Pull Request Process

1. Ensure your changes are well-documented and follow the coding standards.
2. Make sure your code does not introduce new issues.
3. Submit a pull request with a clear description of your changes and why they should be merged.
4. Wait for a review of your pull request. It may request changes or provide feedback.
5. Once your pull request is approved, it will be merged into the main branch.

## Additional Information

For more information on how to set up and run the project, please refer to the [README.md](README.md) file. If you have any questions or need further assistance, feel free to reach out to the project maintainers.

Thank you for contributing to LetterCatcher!
