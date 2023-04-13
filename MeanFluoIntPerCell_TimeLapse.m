%% Written by Geraldine Laloux, UCLouvain, March 2023
%this script plots the mean fluorescence intensity (i.e. total fluo per cell divided by cell area)
%over time from a time-lapse cellList
% Press any key to move to the next cell.
%% INPUT
interval = 8 ; % your interval time in minutes
%% GET EXTRADATA
%% gets extradata from the meshData provided by Oufti 
% it also adds cellID
for frame=1:length(cellList.meshData)
    for cell=1:length(cellList.meshData{frame})
        if isfield (cellList.meshData{frame}{cell},'length')
            cellListExtra.meshData{frame}{cell} = cellList.meshData{frame}{cell};
        end
        if ~isfield (cellList.meshData{frame}{cell},'length')
        cellListExtra.meshData{frame}{cell} = getextradata(cellList.meshData{frame}{cell});
        end
    end
end
%% cellList renaming
cellL = cellListExtra.meshData;
%% SCRIPT
t = length(cellL); % gets the number of frames in the time-lapse
for cell = 1:length(cellL{1}) % will loop through each cell detected on the first frame
    meanFluoArray = [];
    for frame = 1:t
        if ~isempty(cellL{frame}{cell})&&length(cellL{frame}{cell}.mesh)>4&&isfield(cellL{frame}{cell},'signal2')
          cellID = cellListExtra.cellId{frame}(cell); %obtain cellID
          fluoInt = sum(cellL{frame}{cell}.signal2); %total fluo1
          cellArea = cellL{frame}{cell}.area; %cell area
          meanFluo = fluoInt/cellArea; %fluo/cell area
          meanFluoArray = [meanFluoArray meanFluo]; %populates the array
        end    
    end
    
    if isempty(meanFluoArray) % move up to the next loop (=next cell) if there was no value for meanFluo
        continue
    end
    
%% plot the mean fluo over time for the current cell
maxT = (interval*t)-interval;
c = 0:interval:maxT; % X axis
plot(c,meanFluoArray(1:t),'m')
ylabel('Fluorescence intensity, absolute image units','FontSize',20)
xlabel('Time (min)','FontSize',20)
title(['Cell' num2str(cellID)],'FontSize',20)
pause %pressing any key will keep looping one cell at a time
end
%% END
