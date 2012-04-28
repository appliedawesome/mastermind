Every job has three attributes: a `name`, a `target_name` and an `action`. The `name` is unique to the heist, and is how we reference jobs. The `action` is the reference to the method we will call when executing the target. The `target_name` is a reference to the `type` attribute on the target, which we then use to find and instantiate a target object.

Jobs can be:

* observation
* execution
* and more!
