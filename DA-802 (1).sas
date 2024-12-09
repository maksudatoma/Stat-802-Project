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

proc glimmix data=data plots=residualpanel;
    class Batches Inoculation_Method Thickness Week;
    model Response = Inoculation_Method|Thickness|Week;
    random intercept / subject=Batches;
    random Week / subject=Batches*Inoculation_Method*Thickness type=ar(1) residual;
    lsmeans Inoculation_Method*Thickness*Week / adjust=tukey cl;
    lsmeans Inoculation_Method*Thickness / slice=Inoculation_Method slice=Thickness pdiff cl;
    lsmeans Inoculation_Method*Week / slice=Inoculation_Method slice=Week pdiff cl;
    lsmeans Thickness*Week / slice=Thickness slice=Week pdiff cl;
    
    /* Define main effect contrasts */
    contrast 'Dry vs Wet' 
        Inoculation_Method 1 -1;
    contrast '1/4 vs 1/8 inches' 
        Thickness 1 -1;

    /* Define interaction contrasts */
   contrast 'Dry vs Wet at 1/4 Inches' 
        Inoculation_Method 1 -1 Inoculation_Method*Thickness 1 0 -1 0; 
    contrast 'Dry vs Wet at 1/8 Inches' 
        Inoculation_Method 1 -1 Inoculation_Method*Thickness 0 1 0 -1; 
    contrast '1/4 vs 1/8 inches for Dry inoculation'
        Thickness 1 -1 Inoculation_Method*Thickness 1 -1 0 0;
    contrast '1/4 vs 1/8 inches for Wet inoculation'
        Thickness 1 -1 Inoculation_Method*Thickness 0 0 1 -1;
               
    ods output contrasts=f_contrast tests3=f_anova;
run;

