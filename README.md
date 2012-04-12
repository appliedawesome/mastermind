# Mastermind

Mastermind in an orchestration service that provides a simple way of performing routine procedures in an automated manner. Currently, Mastermind works with the Amazon EC2 for servers, Chef for configuration management, and SSH for remote execution. Plans to include addition services like Puppet and Rackspace Cloud are in the works.

Mastermind automates tasks that may be difficult to automate otherwise by conventional means (it can also automate tasks that are trivial, of course). Here's a quick use case: Whenever your monitoring service detects that your app servers are overloaded, you want to spin up an additional app server. To automate this process, you create a task that defines the process for provisioning, configuring, and connecting a new box to your infrastructure. Mastermind provides a URL for your newly created task. Point your monitoring service to call the Mastermind API and the next time that event occurs, Mastermind will execute the task.

## What is system orchestration?

It seems the agreed upon answer, at least the answer provided by
services like Rundeck, MCollective, etc., is commands executed in
parallel across nodes that meet a certain criteria (generalized, of
course, for brevity's sake). While certainly useful, I can't shake the
notion that these services are not really "orchestration", in the
sense that my mind understand the term, but rather an easier ssh-in-a-
for-loop (again, generalized).

For me, orchestration is a calculated series of steps. To analogize,
orchestration is a game of chess. You don't (and can't) move all pawns
forward at once. You move a piece. Depending on the response garnered
by that move, you either retreat or advance. In infrastructure terms:
you provision a new node. If provisioning is successful, you configure
the node; if not, you'd retry the provision step. If I apply this
analogy to orchestration services as they exist, it doesn't fit.

I would argue that orchestration makes a lot more sense when defining
a "game of chess" and much less sense when describing Rundeck, et. al.

## Common tasks

Don't execute commands at once, split jobs into tasks and send them to actors after each one completes.

## Terminology

* Henchman (Henchman.run, Henchman.fire)
* Henchman



### Henchman

A henchman is hired gun. He carries out the task delegated to him by the plot.

 of an object in your system, be it a server instance, an IP address, or even a Chef client. A henchman has an associated Provider, which contains methods that define various actions that can be performed on a henchman

Every henchman has two attributes: a name and an action. The name is used as the identifier of the henchman, unique to the task. The action is a reference to the method that will be called on the henchman's provider. to the

### P
### Project

A project is a 

## Architecture

