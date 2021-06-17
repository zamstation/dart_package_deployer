# 0.1.0
- Added GitHub actions
  - `test`
  - `build`
  - `dry_deploy`
  - `deploy`
- Removed `main.sh`
- Moved `scripts` directory to `root`
- Added production publish command to `deploy.sh`

# 0.0.1

- Includes `main.sh` which is the entry point.
- Includes the test phase scripts
  - `compile.sh`
  - `lint.sh`
  - `analyze.sh`
  - `test.sh`
- Includes the build phase scripts
  - `pack.sh`
- Includes the deploy phase scripts
  - `validate.sh`
  - `publish.sh`
- Includes the utility scripts
  - `error_thrower.sh` - utility script
  - `logger.sh` - utility script
