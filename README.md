PSYC50_final_project
This repository contains the MATLAB code for analyzing data collected by the EPOC Emotiv Headset
(data is also included) as part of the PSYC50 final project. 

Data description:
2 groups in total, 2 subjects per group - each subject is in 2 conditions (musical imagery "exp", 
visual imagery "ctrl").
Group MUSICAL BACKGROUND:
  1) roman_exp.edf
     roman_ctrl.edf
  2) graham_exp.edf
     graham_ctrl.edf
Group NO MUSICAL BACKGROUND:
  1) savos_exp.edf
     savos_ctrl.edf
  2) angel_exp.edf
     angel_ctrl.edf

Data analysis pipeline description:
(note: the functionality of the .m files isn't automated - for now they must be run in the
appropriate order as listed below, with appropriate changes made manually in the code)

Run .m files as follows:
1) load_data.m
2) visualize_and_get_threshold.m
3) noise_elimination.m - need to run a total of 8 times (once per each of the 4 subjects, and once
   per each of the 2 conditions the subjects are in - make sure to make all the necessary changes in
   the code!)
4) normalize_spectra_average.m - need to run a total of 4 times to produce 4 figures (run once per 
   condition within each group - e.g., one run would be with roman_exp.edf, and graham_exp.edf; as above,
   make sure to make all the necessary changes in the code between runs... additionally, make sure to
   update labels on the figure produced with each run)
5) normalize_spectra_average.m - need to run a total of 4 times to produce 4 figures (comment in parentheses
   in 4) applies here as well)
