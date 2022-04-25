
/* TRANSACTIONS VARS DIFFERENT VALUES */

%let db = TRANSACTIONS;

proc sql noprint;
    select NAME
    into: varlist separated by " "
    from dictionary.columns
    where upcase(libname)="WORK" and upcase(memname)="&db.";
quit;

** loop over each variable **;
%macro loop_through(varlist);
    %do i=1 %to %sysfunc(countw(&varlist.));;
        %let var=%scan(&varlist.,&i.);

        /* output the frequency for each variable only keeping the value */
        proc freq data = &db. noprint;
            table &var. / out=freq_&var.(keep=&var.);
        run;

        /* merge that output with the same dataset each iteration */
        data freq1_&var.; set freq_&var.;
            temp_var = "temp";
        run;

        data merged;
            merge freq1:;
            by temp_var;
        run;
    %end;

    /* remove duplicates after merging */
    %do i=1 %to %sysfunc(countw(&varlist.));;
        %let var=%scan(&varlist.,&i.);
        data merged; set merged;
            if lag(&var.) = &var. then &var. = .;
        run;
    %end;

    /* delete individual frequency datasets */
    proc datasets nolist; delete freq:; quit;

    /* output final dataset */
    data final; set merged;
        drop temp_var;
    run;
%mend;

%loop_through(&varlist.);