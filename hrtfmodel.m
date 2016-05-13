function [ output ] = hrtfmodel(input, Azi, Ele, fs)
% A function calling KEMAR derived HRIR data for a set of Azimuth and
% Elevation anges to filter a chosen input signal. Producing a headphone
% based 3D sound function.

% Inputs variables:
% Input - User defined audio file
% Azi - Azimuth angle
% Ele - Elevation angle
% fs - Sampling rate

% Outputs:
% Output - HRTF based stereo array
% NB: A stereo .wav file is also created from the output stage, it appears
% within the current folder with HRTFoutput followed by the elevation and the
% azimuth.
% eg. "HRTFoutput10e90a.wav"for an 90 and 10 for the azimuth and elevation
% respectively.

% Example calling of this function;
% hrtrmodel(wavread('trombone.wav'), 90, 10, 44100);

% Another example is provided in the sample_stereo_movement.m script.


%% Left Ear - Calling data from the left side, and processing the input source with the resulting Impulse Response

%filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e',num2str(Azi),'a.dat'); 
% Defining the filename to be used based on the Azi and Ele

%Housekeeping IF function adding zeros to the variable name, as it is
%expeced to be seen by the fread function
if Azi == 0
   filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e000a.dat'); % IF Azi is set to 0, three 0's are placed in the file name.

elseif Azi > 0 && Azi < 10;
    filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e00',num2str(Azi),'a.dat'); %IF Azi is above 0 and less than 10, two 0's are added
elseif Azi >= 10 && Azi < 99;
     filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e0',num2str(Azi),'a.dat'); %IF Azi is >= 10 and up to 99, a single 0 is added.
else
    filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e',num2str(Azi),'a.dat'); 
    % For everthing else, eg. 100 - 360, the Azimuth can be placed directly into the filename
end

% Open the defined file, and read the data within in
	fpL = fopen(filenameL,'r','ieee-be'); %Opens the file as defined by the above IF function
	dataL = fread(fpL, 256, 'short'); % Reads the data provided by the file
	fclose(fpL); % Closes the file again

	leftimp = dataL(1:2:256); % The impulse response that had been read from the file.
    
left = filter(leftimp,1,input); % The filter stage where the input source is filtered by the impulse response
left = left./max(abs(left)); % Main signal is divided by itself to bring all the data into a safe (non clipping) range.


Left_Output = [left]; %The Left Output response.



%% Right Ear - Calling data for the right side, and processing the input source with the resulting Impulse Response
%filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e',num2str(Azi),'a.dat');

%Housekeeping IF function adding zeros to the variable name, as it is
%expeced to be seen by the fread function

if Azi == 0
    filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e000a.dat'); % IF Azi is set to 0, three 0's are placed in the file name.
    
elseif Azi > 0 && Azi < 10;
    filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e00',num2str(Azi),'a.dat'); %IF Azi is above 0 and less than 10, two 0's are added
elseif Azi >= 10 && Azi < 99;
     filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e0',num2str(Azi),'a.dat'); %IF Azi is >= 10 and up to 99, a single 0 is added.
else
    filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e',num2str(Azi),'a.dat');
    % For everthing else, eg. 100 - 360, the Azimuth can be placed directly into the filename
end

% Open the defined file, and read the data within in
	fpR = fopen(filenameR,'r','ieee-be'); % Opens the file as defined by the above IF function
	dataR = fread(fpR, 256, 'short'); % Reads the data provided by the file
	fclose(fpR); % Closes the file again
    

    rightimp = dataR(1:2:256); % The impulse response that had been read from the file.
	

right = filter(rightimp, 1, input);  % The filter stage where the input source is filtered by the impulse response
right = right./max(abs(right));  % Main signal is divided by itself to bring all the data into a safe (non clipping) range.


Right_Output = [right]; % The Left Output response.

%% Output summing and wav file production

output = [Left_Output Right_Output]; % Stereo sum of the two output files

audiowrite(strcat('HRTFOutput',num2str(Ele),'e',num2str(Azi),'a.wav'), output, fs, 'BitsPerSample', 32); % Creation of a wav file of the resulting output signal

sound(output, fs); % Plays back the output source
end

