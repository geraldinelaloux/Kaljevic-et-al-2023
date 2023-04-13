%% Written by Géraldine Laloux, UCLouvain, Feb 2020
%% Microscope resolution (pixels to um conversion) 
px2um = 0.07; 
%% gets extradata from the meshData provided by Oufti 
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
%% script
n = 0;
cellL = cellListExtra.meshData;
spotNumber = [];
cellLength = [];
for frame=1:length(cellL)
    for cell=1:length(cellL{frame})
        if isfield(cellL{frame}{cell},'spots')
            n = n + 1;
            spots = length(cellL{frame}{cell}.spots.l);
            spotNumber = [spotNumber spots];   
        end
    end
end
%% histogram settings
c = 0:1:3; % this gives the range and step size of the histogram 
h = hist(spotNumber,c);
hPERC = 100*h/(sum(h));
%% figure
figure1 = figure;
bar(c,hPERC,'k') % this gives the range and step size of the histogram
xlabel('Number of foci per cell','FontSize',20);
ylabel('Fraction of cells (%)','FontSize',20);
%% Display number of cells 
disp(['cell number:' num2str(n)]);