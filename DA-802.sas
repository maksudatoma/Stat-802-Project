/* Generated Code (IMPORT) */
/* Source File: rptm_simulation_export.csv */
/* Source Path: /home/u63826292/825 */
/* Code generated on: 12/2/24, 5:12 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u63826292/825/rptm_simulation_export.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=data;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=data; RUN;


%web_open_table(data);



proc mixed data=data method=reml plots=residualpanel;
  class Batches Inoculation_Method Thickness Week;
  model Response = Inoculation_Method|Thickness|Week / ddfm=kr;
  random Batches;
  repeated Week / subject=Batches type=CS r rcorr; /* Change to Compound Symmetry */
run;

proc mixed data=data method=reml plots=residualpanel;
  class Batches Inoculation_Method Thickness Week;
  model Response = Inoculation_Method|Thickness|Week / ddfm=kr;
  random Batches;
  repeated Week / subject=Batches type=UN r rcorr; /* Unstructured */
run;

proc mixed data=data method=reml plots=residualpanel;
  class Batches Inoculation_Method Thickness Week;
  model Response = Inoculation_Method|Thickness|Week / ddfm=kr;
  random Batches;
  repeated Week / subject=Batches type=TOEP r rcorr; /* Toeplitz */
run;

proc mixed data=data method=reml plots=residualpanel;
  class Batches Inoculation_Method Thickness Week;
  model Response = Inoculation_Method|Thickness|Week / ddfm=kr;
  random Batches;
  repeated Week / subject=Batches type=AR(1) r rcorr;
run;

proc mixed data=data method=reml plots=residualpanel;
  class Batches Inoculation_Method Thickness Week;
  model Response = Inoculation_Method|Thickness|Week / ddfm=kr;
  random Batches;
  repeated Week / subject=Batches type=ANTE(1) r rcorr;
run;
