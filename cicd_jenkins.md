# CICD with Jenkins
## Intro
### What is CI/Benefits
- Continous Integration
  - updated code pushed on a specified branch
  - (trigger) push to dev branch and feature branches
  - git workflow determines how this is set up
  - Code needs testing, if code passes test, then merge/integration with main code.
  - Benefit: Automate testing of code and integration of new changes.
### What is CD/Benefits
- Continuous Delivery
  - Build the software turn it into an artifact, artifact is delivered/saved ready for deployment
  - Deployment usually requires manual approval
- Continuous Deployment
  - Deploy Application (straight to prod)
  - End users benefitr very quickly from code updates
### Why Jenkins
#### Advantages
- Automation
- Extensibility
- Scalability
- Community Support
- Cross Platform
#### Disadvantages
- Complex
- Dated
- Can be resource intensive
  
### CI/CD stages with Jenkins
1. CI: Source Code Management (SCM)
2. CI: Build Code
3. CI: Run tests on the code
4. CD: Packaging into a deployable artifact
5. CD: The actual deployment
6. CD: Monitoring

### Alternaitves to Jenkins

- Gitlab
- Azure Devops
- Travis CI
- Bamboo
- GoCD
- TeamCity
- Github Actions

### Why build a pipeline?

- Deliver frequent updates to code in an incremental manner

## How Does Jenkins CICD Work?

- Master node which spins up agent nodes to run jobs
- CICD pipeline
Imagine a system with Job 1 > Job 2 > Job 3
- Job 1 will test the code in dev branch
- IF Job 1 passes, Job 2 Merges it onto the main branch
- IF Job 2 passes, Job 3 deploys and packages the code.

Can authenticate using ssh in deploying the code, master node needs a key
Master node also needs Git credentials to merge code.

## Example of setting up a jenkins pipeline.

### 0. Running any commands on jenkins.

- One can create a project by clicking new item in the top right.

![New item on jenkins](jenkins_new_item.png)

- Then clicking freestyle project.

![Freestyle project](jenkins_freestyle_project.png)

You can also see at the bottom of the previous image, that you can copy an old project using the UI, and use this as a template to create  new project.

- A Basic Jenkins project can be to run a simple bash script.
- This can be done by:
  1.  Going to the build steps section
  1.  Adding a build step
  1.  A pop up menu will appear. Select Execute Shell
  1.  You can then enter bash commands in the text box which appears

![Jenkins Bash](jenkins_bash.png)

- You can also determine how previous builds are logged, which is important in evaluating their success.
  - By tick the 'discard old builds' box, and setting 'max # of builds to keep' as 5, we can keep information on the last 5 builds 

![old builds jenkins](old_builds_jenkins.png)



### 1. Setting up automated tests

- One can set up jenkins to run a test (or any other command) on a branch whenever a push is made to it.
- To do this we'll be taking advantage of (github) webhooks

1.  Create a github webhook
    1.  Go to the settings menu of the relevant branch on github
    2.  In the webhooks section, there is a button at the top right which says add webhook
    3.  In the payload URL, enter the URL of the jenkins master node.
    4.  You can also determine which events trigger this webhook here. We use the 'Just the push event' option for our needs.
2.  Create a new project
    1.  Set up the build logging as was done before.
    2.  At the top, one also needs to tick the Github Project box
    1.  You also need to enter the github project **without** the `.git` in the URL
3. We need to specify which project we will build for our test 