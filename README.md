PSYC50_final_project
This repository contains the MATLAB code for analyzing data collected by the EPOC Emotiv Headset
(data is also included) as part of the PSYC50 final project. 

Making a clone of the remote repository will give you access to all the .m files, as well as the data 
(8 edf files) these .m files were run on. Ensure path is setup correctly:
addpath(genpath('/PSYC50_final_project/EDF_data/')); 

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

Data analysis pipeline, as well as brief description of .m file functionalities:
(note: the functionality of the .m files isn't automated - for now they must be run in the
appropriate order as listed below)

Run .m files as follows:
1) load_data.m - loads all the .edf files
2) visualize_and_get_threshold.m - sets the thresholds that have been predetermined by visualizing
				   the signals
3) noise_elimination.m - a file that applies a naive signal preprocessing algorithm to reduce number
			 of artifacts in the data (read comments in the file for more) 
4) normalize_spectra_average.m - produces plot of the averaged power spectra for each group condition
				 for each electrode (O2, T8, FC6)
5) normalize_spectra_average.m - produces plot of the averaged coherences for each group condition for
			         relevant electrode pairs (O2-T8, T8-FC6)
