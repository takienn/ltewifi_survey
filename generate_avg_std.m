tx_in_sf0 = load('log0');
tx_in_sf1 = load('log1');
tx_in_sf5 = load('log5');
tx_in_sf0=tx_in_sf0-tx_in_sf0(1);
tx_in_sf1=tx_in_sf1-tx_in_sf1(1);
tx_in_sf5=tx_in_sf5-tx_in_sf5(1);

%load ltewifi_survey_t_to_tx_2.mat
tx_in_free = load('tmp');
tx_in_free=tx_in_free-tx_in_free(1);

figure
hold on
ecdf(diff(tx_in_sf0))
ecdf(diff(tx_in_sf1));
ecdf(diff(tx_in_sf5));

start=0.0;
finish=10.0;
step=0.01;
i=1;
for time = start:step:finish
    tx_diff=diff(tx_in_sf0);
    tx=tx_diff(find(tx_in_sf0<time));
    tx_avg_sf0(i)=mean(tx);
    tx_std_sf0(i)=std(tx);
    
    tx_diff=diff(tx_in_sf1);
    tx=tx_diff(find(tx_in_sf1<time));
    tx_avg_sf1(i)=mean(tx);
    tx_std_sf1(i)=std(tx);
    
    tx_diff=diff(tx_in_sf5);
    tx=tx_diff(find(tx_in_sf5<time));
    tx_avg_sf5(i)=mean(tx);
    tx_std_sf5(i)=std(tx);
    
    tx_diff=diff(tx_in_free);
    tx=tx_diff(find(tx_in_free<time));
    tx_avg_free(i)=mean(tx);
    tx_std_free(i)=std(tx);
    
    i=i+1;
end

figure
hold on
ecdf(tx_avg_sf0);
ecdf(tx_avg_sf1);
ecdf(tx_avg_sf5);

figure;
title('Average time to tx in three ABSF cases (0, 1, 5)');
ylabel('Average T to TX (ms)');
xlabel('Runtime (s)');
hold on;
plot(start:step:finish,1000*tx_avg_sf0, 'DisplayName', 'SF0');
plot(start:step:finish,1000*tx_avg_sf1, 'DisplayName', 'SF1');
plot(start:step:finish,1000*tx_avg_sf5, 'DisplayName', 'SF5');
plot(start:step:finish,1000*tx_avg_free, 'DisplayName', 'no LTE');

%figure;
%title('Standard Deviation for T to TX in three ABSF cases (0, 1, 5)');
%ylabel('std deviation for T to TX (ms');
%xlabel('Runtime (s)');
%hold on;
%plot(start:step:finish,1000*tx_std_sf0, 'DisplayName', 'SF0');
%plot(start:step:finish,1000*tx_std_sf1, 'DisplayName', 'SF1');
%plot(start:step:finish,1000*tx_std_sf5, 'DisplayName', 'SF5');
%plot(start:step:finish,1000*tx_std_free, 'DisplayName', 'no LTE');