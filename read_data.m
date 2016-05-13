dataL = zeros(256 , 72, 14);
dataR = zeros(256 , 72, 14);

for Ele = -40 : 10 : 90
    
    j = (Ele + 50) / 10;
    
    switch Ele
        case {-20, -10, 0, 10, 20},
            dAzi = 5;
        case {-30, 30},
            dAzi = 6;
        case {-40, 40},
            dAzi = 6.42;
        case 50,
            dAzi = 8;
        case 60,
            dAzi = 10;
        case 70,
            dAzi = 15;
        case 80,
            dAzi = 30;
        case 90,
            dAzi = 355;
    end

    for Azi = round(0 : dAzi : 355)    
        %% Extract data for Left channel
        if Azi == 355 && Ele == 90
            break
        end
        
        if Azi == 0
            filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e000a.dat'); 
            % IF Azi is set to 0, three 0's are placed in the file name.
        elseif Azi > 0 && Azi < 10;
            filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e00',num2str(Azi),'a.dat'); 
            %IF Azi is above 0 and less than 10, two 0's are added
        elseif Azi >= 10 && Azi < 99;
             filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e0',num2str(Azi),'a.dat'); 
             %IF Azi is >= 10 and up to 99, a single 0 is added.
        else
            filenameL = strcat('./HRIRData/elev',num2str(Ele),'/L',num2str(Ele),'e',num2str(Azi),'a.dat'); 
            % For everthing else, eg. 100 - 360, the Azimuth can be placed directly into the filename
        end
    
        % Open the defined file, and read the data within in
            i = round(Azi / dAzi) + 1;
            fpL = fopen(filenameL,'r','ieee-be'); %Opens the file as defined by the above IF function
            dataL(:,i,j) = fread(fpL, 256, 'short'); % Reads the data provided by the file
            fclose(fpL); % Closes the file again
    
        %% Extract data for Right channel
        if Azi == 0
            filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e000a.dat'); 
            % IF Azi is set to 0, three 0's are placed in the file name.
        elseif Azi > 0 && Azi < 10;
            filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e00',num2str(Azi),'a.dat'); 
            %IF Azi is above 0 and less than 10, two 0's are added
        elseif Azi >= 10 && Azi < 99;
            filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e0',num2str(Azi),'a.dat'); 
             %IF Azi is >= 10 and up to 99, a single 0 is added.
        else
            filenameR = strcat('./HRIRData/elev',num2str(Ele),'/R',num2str(Ele),'e',num2str(Azi),'a.dat'); 
            % For everthing else, eg. 100 - 360, the Azimuth can be placed directly into the filename
        end
    
        % Open the defined file, and read the data within in         
            fpR = fopen(filenameR,'r','ieee-be'); %Opens the file as defined by the above IF function
            dataR(:,i,j) = fread(fpR, 256, 'short'); % Reads the data provided by the file
            fclose(fpR); % Closes the file again
    end 
end