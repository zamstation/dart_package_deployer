# Dart Package Deployer

This is a centralized repository that contain scripts for deploying dart packages. Clone this repository and run `main.sh` to create a workspace for deployment.

Other scripts are present in `workspace/deploy/scripts` directory.

## Workspace Structure
- workspace
  - code
  - build
  - deploy
    - scripts
      - `compile.sh`
      - `lint.sh`
      - `analyze.sh`
      - `test.sh`
      - `pack.sh`
      - `validate.sh`
      - `publish.sh`
      - `error_thrower.sh` - utility script
      - `logger.sh` - utility script

## Deployment
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
