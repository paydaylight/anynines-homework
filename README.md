# Anynines Applicant Homework

### Notes after completion

## Ruby Homework

* Script that initialized db is `./ruby/bin/create_db` with `./ruby/docker/.db.env` DB env file.
Note that I have docker context from OrbStack set up locally
* GET articles route can be improved by adding a pagination, but I was not sure if it is out of the scope for this assignment

## Bosh Homework

* I wasn't sure if I was supposed to modify `./bosh/ruby-app-release/.final_builds/packages/ruby-2.7/index.yml`, but after downloading official
ruby 2.7.0 release (even though unit-test folder was locked with ruby 2.7.3 I've decided to stick with what supposed to be ruby-2.7 since web app does not specify ruby version in gemfile)
sha1 did not match (and blobstore_id of course) so I've modified sha1 and blobstore_id after uploading blobs to local storage with `bosh add-blob`.
Then github refused to accept ruby 2.7 tar file (either because of file size or for other reasons) so I've git ignored it
* I've tried to create a deployment from bosh ruby release, but I could not properly install virtualbox 7 on my intel Mac (MacOS 15)
where it would prompt me to allow kernel extensions
