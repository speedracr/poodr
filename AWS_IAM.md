# AWS IAM Policy
YouTube talk: https://www.youtube.com/watch?v=Du478i9O_mc

## Core concept: "Policy language"

Start with "Policy generator". Here, you set which services the policy
applies to and which actions you are granting or denying access to
through the policy.
ARN: can be skipped by entering "*" /*

Example: Deny running instances other than t1, t2, m3:
```
Condition: StringNotLike
Key: ec2:InstanceType
Value: t1.*, t2.*, m3.*
```

Clean-up: Remove [ ] brackets, SID
Then: Validate policy.

To apply, attach the policy to the user.

Permissions == statement
(Principal - Action - Resource - Condition) - Effect
or: PARC + Effect (allow or deny)

**Principal**: the actor or entity, identified by their ARN, like users,
groups and roles. But: can also be another AWS account or user, a
federated user like accounts.google.com or even an AWS service.

**Action**: one or more actions (encapsulate in array if several). Can
also be defined with wildcards like `"Action":"iam":"*AccessKey*"`
Related: `NotAction`, e.g. for allowing everything but IAM actions:
```
"Statement": [ {
  "Effect": "Allow",
  "NotAction": "iam:*",
  "Resource": "*"
} ]
```
And: `NotAction` is not a deny! Only if you have an explicit `Deny`
statement will that user never be able to call that action. With
`NotAction`, you may still add them to a group which has access to the
action that your `NotAction` statement excluded for them on their
individual account. (In other words, a separate policy could still grant
access to the action.)

**Resource**: like Buckets, queues, but also for examples all instances
in an AWS region: `"Resource":
"arn:aws:ec2:us-east-1:12345678:instance/*"`

**Condition**: Allow for adding an additional criterion. Will be
evaluated according to logic statements, for example to add a DateTime
restriction to the policy.

### Policy variables
Lets you re-use existing keys as variables (- since you currently cannot
define your own variables). If you use variables: Make sure to include a
`"Version": "2016-01-01"` version statement.

### Policies
Managed policies are the way to go.

### Examples
1) Create a home directory on S3 for each user.
We start out by creating a group that we can add all relevant users to.
Then, it's just a matter of attaching a policy to that group:
```
"Version": "2016-01-01",
"Statement": [
  {"Sid": "AllowGroupToSeeBucketListInManagementConsole",
  "Action": " ["s3:ListAllMyBuckets", "s3:GetBucketLocation"],
  "Effect": "Allow",
  "Resource": ["arn:aws:s3:::"]},
  {"Sid": "AllowRootLevelListingOfThisBucketAndHomePrefix",
  "Action": "["s3:ListBucket"],
  "Effect": "Allow",
  "Resource": ["arn:aws:s3:::myBucket"],
  "Condition": {"StringEquals":{"s3:prefix":["",
  "home/"],"s3:delimiter":["/"]}}},
  ## ^^ necessary for console access ^^ ##

  {"Sid":"AllowListBucketofASpecificUserPrefix",
  "Action": ["s3:ListBucket"],
  "Effect": "Allow",
  "Resource": ["arn:aws:s3:::myBucket"],
  "Condition": {"StringLike":
  {"s3:prefix":["home/${aws:username}/*"]}}},

  {"Sid":"AllowUserFullAccesstoJustSpecificUserPrefix",
  "Action": ["s3:*"],
  "Effect": "Allow",
  "Resource": ["arn:aws:s3:::myBucket/home/${aws:username}",
              "arn:aws:s3:::myBucket/home/${aws:username}/*"]}
  ...
```
