# ruder-et-al-2020
combine_DTR_DREADD.ipynb: notebook combining the DREADD and DTR analysis for the LOF handling plots

gof_analys.ipynb: notebook containing analysis and plotting code for GOF kinematics
	
AllUnitsLeverFinalBL.m allows for the extraction of the neuronal spiking data in the behaviour relavant time windows from the spiking data of all the neurons 
recorded from all the animals arranged in a data structure of the form of Animal<x>_<y> -> Session<l>_<m> -> Tasks <i.e. PelletReaching, OpenField, LeverPressing> 
->Time points of behaviors and spiking data obtained from NeuroExplorer <SPK<rs>>
<x> and <y> indicate the animal IDs, <l> and <m> session IDs (which matched the depth of the probe)
The arguments passed to the fuction are the time window before and after the relevant behavior time point to define the window of behavior relavant neuronal activity to be 
analysed, the size of a bin in seconds, alignment parameter where by alignment =1 aligns to the start of the behaviors,sppiking frequency cutoff to be considered
behaviorally relevant, Threshold for defining task tuned units in number of standard deviations of the baseline and plotting toggle and data file select toggle (1 - ON, 0 - OFF).
This data can be used for a variety of analyses and plotting of neruonal data

AllUnitsLeverFinal_Directional.m similarly allows for extraction of the neural activity in the directional reaching task and additionally creates data structures 
for lateral vs medial reaches and allows to plot the directional tuning of the neurons.

FiberPhotometry.m allows for the plotting of the photometry data from the reto photometry experiments described in Ruder et. al 2020. The file containing the photometry 
data from CineLyzer along with the behavior time points from the CinePlex are given as inputs to obtain the relevant photometry traces in behvaior vs shuffled data. 

OpenFieldFinal.m This function extracts a number of different locomotor parameters from an open field experiment by cutting the the extracted trajectories into 
defined locomotor episodes / bouts.Parameters assessed are maximum speed, maximum speed (highest 5), Stability / Curvature, Time of a locomotor bout, 
Time the animal is moving, Tracklength, Distance of a locomotor bout.
Inputs: A (data), FrameRate (acquired Frequency in frames/sec), FrameDef (How long should one locomotor be at the minimum in frames/sec?), AcTime (How long should
the analyzed time window be?) Outputs: LocomotorParameters (averages or values for the described locomotor parameters)
