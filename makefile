
CFLAGS= -g
HTSDIR = ../htslib
HTSLIB = $(HTSDIR)/libhts.a

all: pbwt

test:
	./test/test.pl

PBWT_OBJS = pbwtMain.o pbwtCore.o pbwtSample.o pbwtIO.o pbwtMatch.o pbwtImpute.o pbwtPaint.o pbwtLikelihood.o pbwtMerge.o pbwtGeneticMap.o pbwtHtslib.o

pbwt:  $(PBWT_OBJS) utils 
	gcc $(CFLAGS) -o pbwt $(PBWT_OBJS) hash.o dict.o array.o utils.o $(HTSLIB) -lpthread -lz -lm

autozygExtract: autozygExtract.o
	gcc $(CFLAGS) -o autozygExtract autozygExtract.o utils.o $(HTSLIB) -lpthread -lz -lm

pbwtMain.o: pbwtMain.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtMain.c

pbwtCore.o: pbwtCore.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtCore.c

pbwtSample.o: pbwtSample.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtSample.c

pbwtIO.o: pbwtIO.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtIO.c

pbwtMatch.o: pbwtMatch.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtMatch.c

pbwtImpute.o: pbwtImpute.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtImpute.c

pbwtLikelihood.o: pbwtLikelihood.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtLikelihood.c

pbwtPaint.o: pbwtPaint.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtPaint.c

pbwtMerge.o: pbwtMerge.c pbwt.h utils.h
	gcc $(CFLAGS) -c pbwtMerge.c

pbwtGeneticMap.o: pbwtGeneticMap.c pbwt.h utils.h 
	gcc $(CFLAGS) -c pbwtGeneticMap.c

pbwtHtslib.o: pbwtHtslib.c pbwt.h utils.h 
	gcc $(CFLAGS) -I$(HTSDIR) -c pbwtHtslib.c

autozygExtract.o: autozygExtract.c
	gcc $(CFLAGS) -I$(HTSDIR) -c autozygExtract.c

#################################

utils: hash.o dict.o array.o utils.o
	touch utils

utils.h: hash.h dict.h array.h

hash.o: hash.c utils.h
	gcc $(CFLAGS) -c hash.c

dict.o: dict.c utils.h
	gcc $(CFLAGS) -c dict.c

array.o: array.c utils.h
	gcc $(CFLAGS) -c array.c

utils.o: utils.c utils.h
	gcc $(CFLAGS) -c utils.c

clean:
	rm -f *.o pbwt *~

.PHONY: all test clean

