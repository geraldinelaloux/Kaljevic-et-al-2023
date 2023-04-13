 %% Written by Géraldine Laloux, UCLouvain, February 2020...
...This script opens a figure and plots a bar graph of the histogram of nucleoid area
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
nucleoidArea = [];
for frame=1:length(cellL)
    for cell=1:length(cellL{frame})
        if isfield(cellL{frame}{cell},'objects')
        if ~isempty(cellL{frame}{cell}) && isfield(cellL{frame}{cell}.objects,'area') 
            if length(cellL{frame}{cell}.objects.area) == 1;
            n = n + 1;
            na = cellL{frame}{cell}.objects.area{1};
            nucleoidArea = [nucleoidArea na*px2um^2];
            end
        end
        end
    end
end
%% Statistical parameters
CellNumber=n;        
Mean=mean(nucleoidArea); 
Stdev=std(nucleoidArea); 
CV = std(nucleoidArea)/mean(nucleoidArea); 
%% to display statistics
disp(['cell number:' num2str(n)]);
disp(['mean: ' num2str(mean(nucleoidArea))]);
disp(['stdv ratio: ' num2str(std(nucleoidArea))]);
disp(['CV: ' num2str(CV)]);
%% creation of histogram data
c = 0:0.025:0.8; % this gives the range and step size of the histogram
h = hist(nucleoidArea,c);
hPERC = 100*h/(sum(h));
%% figure
figure;
plot(c,hPERC,'k')
ylabel('Fraction of cells (%)','FontSize',20)
xlabel('Nucleoid area (µm2)','FontSize',20)
axis square
%% creation of csv file
csvwrite('yourname.csv',nucleoidArea)