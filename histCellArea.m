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
%% gets relevant cell area information for each cell on each frame and creates a vector containing all area values in pixels.
n = 0;
cellL = cellListExtra.meshData;
cellArea = [];
for frame=1:length(cellL)
    for cell=1:length(cellL{frame})
        if ~isempty(cellL{frame}{cell}) && isfield(cellL{frame}{cell},'area')
            n = n + 1;
            a = (cellL{frame}{cell}.area)*px2um^2;
            cellArea = [cellArea a];
        end
    end
end
%% statistical parameters
CellNumber=n;          
Mean=mean(cellArea); 
Stdev=std(cellArea); 
CV = std(cellArea)/mean(cellArea);
%% to display statistics
disp(['cell number:' num2str(n)]);
disp(['mean:' num2str(mean(cellArea))]);
disp(['stdv:' num2str(std(cellArea))]);
disp(['CV:' num2str(CV)]);
%% creation of histogram data
c = 0:0.05:3; %this gives the range and step size of the histogram
h = hist(cellArea,c);
hPERC = 100*h/(sum(h));
%% figure
figure;
plot(c,hPERC,'k');
ylabel('Fraction of cells (%)','FontSize',20)
xlabel('Cell area (µm2)','FontSize',20)
axis square
%% creation of csv file
csvwrite('yourname.csv',cellArea)