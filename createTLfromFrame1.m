%% Written by Géraldine Laloux, UCLouvain, March 2023.
% This scripts uses the cell outlines and meshes of all cells on the first frame of a time lapse, 
% to creates a new cellList where the outlines are copied in all frames. 
% This new cellList can be used as mesh input into Oufti, for integration of fluorescence signal acquired in time-lapse, for
% example. 
%% INPUT : 
% a cellList file from Oufti where cell outlines were detected on the first
% frame
n = 113; % number of frames
%% OUTPUT : 
% a new cellList named cellListTL
% READ INSTRUCTIONS AT THE END OF THE SCRIPT TO MAKE IT OUFTI-REUSABLE!
%% SCRIPT : 
%creates a new cellList named cellListTL with the same structure as the
%initial cellList
cellListTL = cellList;
% creates empty cell arrays (number given by n in the input)
cellListTL.meshData = cell(1,n);
cellListTL.cellId = cell(1,n);
% populates each empty cell array with the meshData array from frame 1 of
% the initial cellList
for frame = 1:n
    cellListTL.meshData(frame) = cellList.meshData(1);
    cellListTL.cellId(frame) = cellList.cellId(1);
end
% replaces the value of the parameter "timelapse" by 0 for all cells on all
% frame of the new cellList 
for frame = 1:n
    for cell = 1:length(cellListTL.meshData{frame})
        cellListTL.meshData{frame}{cell}.timelapse = 1;
    end
end
% rename cellListTL as cellList, so it can be reused in Oufti
cellList = cellListTL;
%% END
%% WHAT TO DO NEXT TO REUSE THE MESHES IN OUFTI
% 1) in the workspace window, delete the following items: cell, cellListTL, frame, n
% 2) still in the workspace, select all items, right click, "Save as", and
% give it a name. This constitutes the file that you can reuse in Oufti