%% Written by Géraldine Laloux, UCLouvain, Feb 2020
%% This script 1)produces a figure with histogram of cell lengths; 2)displays cell number, mean cell length and STDV.
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
%% gets relevant cell length information for each cell on each frame and creates a vector containing all length values in pixels.
n = 0;
cellL = cellListExtra.meshData;
cellLength = [];
for frame=1:length(cellL)
    for cell=1:length(cellL{frame})
        if ~isempty(cellL{frame}{cell}) && isfield(cellL{frame}{cell},'length')
            n = n + 1;
            l = px2um*(cellL{frame}{cell}.length);
            cellLength = [cellLength l];
        end
    end
end
%% statistical parameters
CellNumber=n;          
Mean=mean(cellLength); 
Stdev=std(cellLength); 
CV = (std(cellLength)/mean(cellLength)); 
%% to display statistics
disp(['cell number:' num2str(n)]);
disp(['mean:' num2str(mean(cellLength))]);
disp(['stdv:' num2str(std(cellLength))]);
disp(['CV: ' num2str(CV)]);
%% creation of histogram data
c = 0:0.08:10; %this gives the range and step size of the histogram
h = hist(cellLength,c);
hPERC = 100*h/(sum(h));
%% figure
figure;
plot(c,hPERC,'K')
ylabel('Fraction of cells (%)','FontSize',20)
xlabel('Cell length (µm)','FontSize',20)
axis square
%% creation of csv file
csvwrite('yourname.csv',cellLength)