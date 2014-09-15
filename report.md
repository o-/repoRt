# Src

The main repository is found at https://github.com/o-/Rexperiments

The new GC implementation resides in the branch new_gc, all data is based on 1c25a79d07666f649b04d07a9854928b37d1872a.

The baseline is svn commit 66436 (8276bb2108dcf6093f508b21e7e1f73d6d4213f6).

# Recording

For tools see: https://github.com:o-/benchR (run-experiments, run-experiment.rb)

# Benchmarks

The following two sources are used for benchmarks:

* benchR:  https://github.com/allr/benchR.git
* benchmarks: https://github.com/rbenchmark/benchmarks.git

# Comparing Runtime against baseline R

## Runtime

Overall Wall time

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/runtime-mmap.png)

### Posix Memalign version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/runtime-posix-memalign.png)

## GC Time

Time spent in GC

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_time-mmap.png)

### Posix Memalign version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_time-posix-memalign.png)

## GC Cycles

Number of GCs (minor & full)

### Mmap version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_cycles-mmap.png)

### Posix Memalign version

![](https://raw.githubusercontent.com/o-/repoRt/master/data/experiments/gc_cycles-posix-memalign.png)

# Comparing Heapsize

Overall Heapsize of the R process sequentially running a suite of benchmarks.

![](https://raw.githubusercontent.com/o-/repoRt/master/data/memusg/memusg.png)

We see that the new gc using posix memalign terminates faster than baseline R, but uses twice as much memory. The memory available to the runtime is exactly the same in the posix memalign and the mmap version. This shows the potential performance of the new gc, but highlights the need for a two level memory manager to get large chunks of aligned memory from the OS.

Additionally we see the new gc (in the mmap version) using the same ammount of memory as baseline, even though we save two pointers per object. The reason is, that power of two byte-size buckets do not align well to actual R vectors. A better solution for heap segmentation would be required, or maybe differently sized objects should be allocated on the same page.
