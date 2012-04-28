It seems the agreed upon answer, at least the answer provided by
services like RunDeck, MCollective, etc., is commands executed in
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
a "game of chess" and much less sense when describing RunDeck, et. al.
