CC=gcc -s -O3 -g -c -Wl,--large-address-aware
objs=avs4x264mod.o afxm_avs.o afxm_piper.o afxm_gencmd.o afxm_getopt.o afxm_consolewrap.o

all: avs4x264mod.exe

$(objs): avs4x264mod.h
avs4x264mod.o: version.h

avs4x264mod.exe: $(objs)
	gcc -o $@ $(objs) -Wl,--large-address-aware

.c.o:
	$(CC) $<

version.h: .git/FETCH_HEAD
	VER=`git rev-list HEAD | wc -l`; echo "#define VERSION_GIT $$VER" > version.h

test:
	./avs4x264mod --pipe-mt --pipe-buffer 4096 --affinity 1 --x264-affinity 2 --crf 24 -o test.mp4 test.avs

testhd:
	./avs4x264mod --pipe-mt --pipe-buffer 64 --affinity 1 --x264-affinity 2 --crf 24 --input-depth 10 -o testhd.mp4 testhd.avs

clean:
	rm -f *.o version.h avs4x264mod.exe