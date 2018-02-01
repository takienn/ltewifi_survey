% data0 = load('plot0.dat');
% data1 = load('plot1.dat');
% data5 = load('plot5.dat');
% 
% data0(data0(:,2)<70,:)=[];
% data1(data1(:,1)<=3773346,:)=[];
% data5(data5(:,2)<60,:)=[];

load('busy_measurements_2.mat');

i=2;
N = size(data0,1);
while i < N
    if data0(i,1) - data0(i-1,1) < 1000
        data0(i,:) = [];
    else
        i = i+1;
    end
    
    N = size(data0,1);
end

i = 2;
N = size(data1,1);
while i < N
    if data1(i,1) < 1000 + data1(i-1,1)
       data1(i,:) = [];
    else
        i=i+1;
    end
    N = size(data1,1);
end

i=2;
N = size(data5,1);
while i < N
    if data5(i,1) < 1000+ data5(i-1,1)
       data5(i,:) = []; 
    else
        i = i+1;
    end
    N = size(data5,1);
end

clear i N;
% data0 = data0(1:100, :);
% data1 = data1(118:217, :);
% data5 = data5(1:100, :);
data0(:,1) = data0(:,1)-data0(1,1);
data1(:,1) = data1(:,1)-data1(1,1);
data5(:,1) = data5(:,1)-data5(1,1);
%data0 = data0(1:100);
%data5 = data5(1:100);

%% Plot data
%avg_busy_fig = figure;
%xlim([0 60]);
%ylim([0 100]);
%hold on;
%plot(data0(:,1)./1000,data0(:,2),'MarkerEdgeColor' , 'r', ...
%    'MarkerFaceColor', 'r', 'DisplayName', 'LTE ABS0');
%plot(data1(:,1)./1000,data1(:,2),'MarkerEdgeColor' , 'g', ...
%    'MarkerFaceColor', 'g', 'DisplayName', 'LTE ABS1');
%plot(data5(:,1)./1000,data5(:,2),'MarkerEdgeColor' , 'b', ...
%    'MarkerFaceColor', 'b', 'DisplayName', 'LTE ABS5');

%title('Channel Busy % over time with different ABS types');
%xlabel('time(s)');
%ylabel('Busy %');
%legend('LTE ABS0', 'LTE ABS1', 'LTE ABS5', 'Location', 'southwest');

ecdf_busy_fig = figure;
hold on;
[f, cdf] = ecdf(data0(:,2));
plot(cdf,f,'DisplayName', 'ABS0');
[f, cdf] = ecdf(data1(:,2));
plot(cdf,f,'DisplayName', 'ABS1');
[f, cdf] = ecdf(data5(:,2));
plot(cdf,f,'DisplayName', 'ABS5');
[f, cdf] = ecdf(dataFree);
plot(cdf,f, 'DisplayName', 'no LTE');
title('ECDF of Channel Busy % with different ABS types + no LTE');
legend('LTE ABS0', 'LTE ABS1', 'LTE ABS5', 'no LTE', 'Location', 'northwest');

saveas(avg_busy_fig, 'avg_busy.png', 'png');
saveas(avg_busy_fig, 'avg_busy.fig', 'fig');
saveas(ecdf_busy_fig, 'ecdf_busy.png', 'png');
saveas(ecdf_busy_fig, 'ecdf_busy.fig', 'fig');