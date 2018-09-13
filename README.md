This is a just a test project that can be used to stress test and benchmark different memory managers.

Please note that the results of these tests are NOT the final verdict over which memory manager is best.

What is best depends completely on your own code, so make sure to test many memory managers under different conditions.

In this app there are two modes: You can run it without locks or with threads sharing a common TCriticalSection, which is used a lot.

Interestingly, FastMM with its default settings is by far slowest when run with no locks but it's the fastest when the lock is used.

To switch between memory managers, uncomment the one you want to test in MemSpeedTest.dpr
If you use FastMM, also check the project's conditional defines.

Related discussion: https://www.facebook.com/groups/137012246341854/permalink/1991744470868613

Some sample results:

Delphi default
Running with 4 threads
Mean time per thread: 00.09.602
Running with 4 threads with locks
Mean time per thread: 00.10.859
Running with 8 threads
Mean time per thread: 00.09.320
Running with 8 threads with locks
Mean time per thread: 00.10.634
Memory usage 1.5 -> 3,4 MB

FastMM - Never
Running with 4 threads
Mean time per thread: 00.05.959
Running with 4 threads with locks
Mean time per thread: 00.18.154
Running with 8 threads
Mean time per thread: 00.05.301
Running with 8 threads with locks
Mean time per thread: 00.28.555
Memory usage 1.5 -> 3.4 MB

FastMM - Never & Switch
Running with 4 threads
Mean time per thread: 00.06.855
Running with 4 threads with locks
Mean time per thread: 00.18.283
Running with 8 threads
Mean time per thread: 00.06.576
Running with 8 threads with locks
Mean time per thread: 00.30.712
Memory usage 1.5 -> 3.5 MB

BrainMM
Running with 4 threads
Mean time per thread: 00.04.284
Running with 4 threads with locks
Mean time per thread: 00.18.994
Running with 8 threads
Mean time per thread: 00.03.764
Running with 8 threads with locks
Mean time per thread: 00.28.601
Memory usage 1.5 -> 5.6 MB

ScaleMM
Running with 4 threads
Mean time per thread: 00.04.327
Running with 4 threads with locks
Mean time per thread: 00.19.586
Running with 8 threads
Mean time per thread: 00.03.749
Running with 8 threads with locks
Mean time per thread: 00.29.568
Memory usage 1.5 -> 14.5 MB

tcmalloc
Running with 4 threads
Mean time per thread: 00.04.847
Running with 4 threads with locks
Mean time per thread: 00.22.755
Running with 8 threads
Mean time per thread: 00.03.881
Running with 8 threads with locks
Mean time per thread: 00.33.090
Memory usage 2.2 -> 11.9 MB

Memory usage tests with lots of threads:

FastMM
Running with 40 threads
Mean time per thread: 00.08.896
-> 3.5 MB

ScaleMM
Running with 40 threads
Mean time per thread: 00.03.535
-> 48.9 MB

BrainMM
Running with 40 threads
Mean time per thread: 00.03.491
-> 5.7 MB

tcmalloc
Running with 40 threads
Mean time per thread: 00.03.259
-> 35.9 MB