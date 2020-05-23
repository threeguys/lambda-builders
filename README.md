# lambda-builders
Builder docker images for lambda packages

This repo houses a set of dockerfiles for creating images to build deployment packages for AWS Lambda functions.
It doesn't really do anything measurably different (or actually better, it's less...) but it does do it
with very few dependencies and a pretty universal build platform, all you need is docker.

# Creating a builder image
In order to build your packages, you should create a builder image in order to be able to generate zip
files to be uploaded to Lambda.

```
$ docker build -t lambda-builder:py37 -f Dockerfile.builder-py37 .
  ...
Successfully built 02cb6803c71d
Successfully tagged lambda-builder:py37
$
```

# Building your image
A very simple lambda function, contained in **lambda_handler.py**
```python
def lambda_handler.handler(event, context):
    return { 'msg': 'Hello World!' }
```

The build command for this would be:
```
$ docker run -it --rm -v $(pwd):/src lambda-builder:py3 my-code
  ...

Build complete!
8144747 /src/build/lambda-my-code.zip
```

At this point, there should be a file **build/lambda-my-code.zip** that is ready to be uploaded to Lambda for deployment.
One thing to note, the argument is optional, if none is supplied, the default filename is **build/lambda-package.zip**.

# License
This is really only docker files and some short shell scripts, however I need to give some sort of license
if folks want to use it. Please refer to the <a href="LICENSE">LICENSE</a> file for more information
(spoiler alert: It's Apache 2.0).

# Contributing
Please make a pull request, file an issue, email me, or complain loudly in the comments. After some consideration, I may
close your bug without answering (j/k, I will try my best but this is a hobby).
