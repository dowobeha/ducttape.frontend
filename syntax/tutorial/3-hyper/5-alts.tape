# TODO: Flesh out this example

# Using "Alt" branches

# "Alt" branches can add exactly one additional branch point to a task
# Whereas the (BranchPoint: branch) syntax could add arbitrarily many
# The name of the branch point is taken to be the name of the task itself
# In this example the task "whichThing" adds a branch point called "whichThing"
# with branches "choiceA" (the baseline), "choiceB" (an alternative), and "choiceC" (another alternative).
#
# Important: Inline alternative branches do NOT have the option of adding outputs
# since all tasks must have exactly the same set of outputs

branchpoint whichThing < a=foo > aOut :: paramA=bar {
  # TODO: Need a better way of specifying individual inputs to packed realizations
  # (later output references get too complicated otherwise)
  baseline choiceA < b="hi" :: param=$paramA {
    cat $a $b $aOut
  }
  branch choiceB :: param=$x {
    ln -s $a $aOut
  }
  branch choiceC :: param=$x {
    ln -s $a $aOut
  }
}
