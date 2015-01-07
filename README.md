checksummer
===========

Create crc32 checksums and check if files are corrupted. Usefull for archives to fight bitrot!

Prerequisites:
<pre><code>
crc32
</code></pre>
can be installed under Ubuntu via 
<pre><code>
sudo apt-get install crc32
</code></pre>

Just start it in a directory you want to prepare against corruption. 
<pre><code>
$ checksummer.sh
./checksummer.sh -c       #creates crc32-checksum files
./checksummer.sh -v       #verifies crc32-checksum files
</code></pre>

It will search all files in the current and all subdirectories. It will create (-c) .crc32 for each file if not already present. 
<pre><code>
$ checksummer.sh -c
./file1.crc32 written
./file2.crc32 written
./reallyimportantfiles/20141224_175410.JPG.crc32 written
./reallyimportantfiles/20141224_102534.JPG.crc32 written
./reallyimportantfiles/20141224_184628.JPG.crc32 written
./reallyimportantfiles/20141224_201829.JPG crc32-file found - nothing to do
./reallyimportantfiles/20141224_195845.JPG.crc32 written
./reallyimportantfiles/20141224_102514.JPG.crc32 written
./reallyimportantfiles/20141224_174921.JPG.crc32 written
./reallyimportantfiles/20141224_182419.JPG.crc32 written

$ ls -a reallyimportantfiles/
20141201_121336.JPG
.20141201_121336.JPG.crc32
20141201_145730.JPG
.20141201_145730.JPG.crc32
20141201_150128.JPG
.20141201_150128.JPG.crc32
20141201_152440.JPG
</code></pre>

The timestamp will also be written to the the file :
<pre><code>
$ cat .20141201_121336.JPG.crc32
8d933d2c
2015-01-07_10-22-45
</code></pre>


With -v these can be verified. It shows errors if the checksum don't match the previous calculated or is not there.
<pre><code>
mediacenter@mediacenter:~/bla$ ~/Downloads/compile/checksummer/checksummer.sh -v
File ./reallyimportantfiles/20141224_175410.JPG is OK
File ./reallyimportantfiles/20141224_102534.JPG is OK
File ./reallyimportantfiles/20141224_184628.JPG is corrupt OLDHASH(d432ed3b) != NEWHASH(d068ed1a)
File ./reallyimportantfiles/20141224_201829.JPG is OK
File ./reallyimportantfiles/20141224_195845.JPG is OK
File ./reallyimportantfiles/20141224_102514.JPG is OK
no ./reallyimportantfiles/20141224_174921.JPG.crc32 found!
File ./reallyimportantfiles/20141224_182419.JPG is OK
File ./file1 is OK
File ./file2 is OK
</code></pre>

Checksummer is creating two logfiles:
<pre><code>
/tmp/checksummer.sh.log
/tmp/checksummer.sh.err
</code></pre>

I use it in a cron-job which checks periodic all my pictures. If /tmp/checksummer.sh.err is present it sends me mail so a can react.
If a picture is corrupt it can be restored from a backup.

