fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios create
```
fastlane ios create
```
Create in app store
### ios createEnterprise
```
fastlane ios createEnterprise
```
Create for enterprise
### ios certsPushProfiles
```
fastlane ios certsPushProfiles
```

### ios certificates
```
fastlane ios certificates
```

### ios match_appstore
```
fastlane ios match_appstore
```

### ios match_development
```
fastlane ios match_development
```

### ios match_adhoc
```
fastlane ios match_adhoc
```

### ios match_enterprise
```
fastlane ios match_enterprise
```

### ios match_enterprise_dev
```
fastlane ios match_enterprise_dev
```

### ios match_enterprise_release
```
fastlane ios match_enterprise_release
```

### ios push_dev_enterprise
```
fastlane ios push_dev_enterprise
```
Generate Dev certs
### ios push_prod_enterprise
```
fastlane ios push_prod_enterprise
```
Generate Dev certs
### ios push_dev
```
fastlane ios push_dev
```
Generate Dev certs
### ios push_prod
```
fastlane ios push_prod
```
Generate Prod Push certs
### ios push_demo
```
fastlane ios push_demo
```
Generate Demo Push certs
### ios build_app
```
fastlane ios build_app
```
Build app
### ios test_app
```
fastlane ios test_app
```
Test app
### ios test
```
fastlane ios test
```
Runs all the tests
### ios screenshots
```
fastlane ios screenshots
```
Takes screenshots for configured devices/languages
### ios metadata
```
fastlane ios metadata
```
Update App Store metadata
### ios uploadIpa
```
fastlane ios uploadIpa
```
Deploy a new version to the App Store
### ios deploy
```
fastlane ios deploy
```
Deploy a new version to the App Store

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
