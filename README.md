# Mastermind

Mastermind in an orchestration service that provides a simple way of performing routine procedures in an automated manner. Currently, Mastermind works with the Amazon EC2 for servers, Chef for configuration management, and SSH for remote execution. Plans to include addition services like Puppet and Rackspace Cloud are in the works.

Mastermind automates tasks that may be difficult to automate otherwise by conventional means (it can also automate tasks that are trivial, of course). Here's a quick use case: Whenever your monitoring service detects that your app servers are overloaded, you want to spin up an additional app server. To automate this process, you create a task that defines the process for provisioning, configuring, and connecting a new box to your infrastructure. Mastermind provides a URL for your newly created task. Point your monitoring service to call the Mastermind API and the next time that event occurs, Mastermind will execute the task.

## Terminology

* Heist - the plan of action, a list of jobs. Hires goons to execute jobs on targets
* Goon - the main actor, carries out a job on the target. 
* Job - the details of how the goon should execute the target.
* Target - the resource upon which we execute an action
