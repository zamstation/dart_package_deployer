# Dart Package Deployer

This is a centralized repository that contain scripts for deploying dart packages. Use the GitHub actions to integrate the deployment tools in your ci-cd pipleine.

## GitHub Actions
- `test` - calls test phase scripts
- `build` - calls build phase scripts
- `dry_deploy` - calls deploy phase scrips with `test` arg
- `deploy` - calls deploy phase scripts with `prod` arg

## Scripts
- Prepare Phase
  - `main.sh`
- Test Phase
  - `compile.sh`
    - dart pub get
  - `lint.sh`
    - dart format
  - `analyze.sh`
    - dart analyze
  - `test.sh`
    - dart test
- Build Phase
  - `pack.sh`
- Deploy Phase
  - `validate.sh`
    - Validate Pubspec
    - Check for required files
  - `publish.sh`
    - pub publish

## Contributors
  * [Amsakanna](https://github.com/amsakanna)
