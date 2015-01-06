checksummer
===========

Create crc32 checksums and check if files are corrupted. Usefull for archives to fight bitrot!

Just start it in a directory you want to prepare against corruption. 
<pre><code>
$ checksummer.sh
./checksummer.sh -c       #creates crc32-checksum files
./checksummer.sh -v       #verifies crc32-checksum files
</code></pre>

It fill search all files in the current and all subdirectories. It will create (-c)
.crc32 for each file if not already present. 
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
</code></pre>

With -v these can be verified. It shows errors if the checksum don't match the previous calculated or is not there.
<pre><code>
mediacenter@mediacenter:~/bla$ ~/Downloads/compile/checksummer/checksummer.sh -v
File ./reallyimportantfiles/20141224_175410.JPG is OK
File ./reallyimportantfiles/20141224_102534.JPG is OK
File ./reallyimportantfiles/20141224_184628.JPG is corrupt OLDHASH(bla) != NEWHASH(d068ed1a)
File ./reallyimportantfiles/20141224_201829.JPG is OK
File ./reallyimportantfiles/20141224_195845.JPG is OK
File ./reallyimportantfiles/20141224_102514.JPG is OK
no ./reallyimportantfiles/20141224_174921.JPG.crc32 found!
File ./reallyimportantfiles/20141224_182419.JPG is OK
File ./file1 is OK
File ./file2 is OK
</code></pre>

