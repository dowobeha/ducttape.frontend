// TODO: Unfinished tutorial step
// TODO: Example of grafting multiple branches (from different branch points) using comma
// TODO: Example of one input performing a graft and another input of the same task not grafting

// Branch grafting allows the selection of exactly one branch from a branch point that
// has been defined by a task or one of its parents. At the task and input where the branch graft is requested,
// the specified branch is taken to be the only branch that will ever be used *for that task, input pair*.
// The task at which the graft was requested will then have no further visibility of that branch point -- nor
// will any dependents of that task have visibility of the branch point. 

// if we have a tokenizer that we'd like to run on the training, dev, and test set
// and then later using exactly one branch from that branch point

task tokenize : tokenizer < in=(DataSet: train=a.txt tune=b.txt test=c.txt) > out {
  $tokenizer < $in > $out
}
task build_model < in=$out@tokenize[DataSet:train] > model {
   cat < $in > $model
}
task optimize < in=$out@tokenize[DataSet:tune] > weights {
  cat < $in > $weights
}
task test < in=$out@tokenize[DataSet:test] > hyps {
  cat < $in > $hyps
}