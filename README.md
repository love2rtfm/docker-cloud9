# docker-cloud9
A container image that is ready to have Cloud9 install via SSH

This is based on https://docs.aws.amazon.com/cloud9/latest/user-guide/sample-docker.html
with minor fixes dealing with dependency drift, etc...

place an "authorized_keys" file in the current directory before building the container image; these keys will be authorized to ssh in as ubuntu
