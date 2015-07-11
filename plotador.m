names = {'panel'; 'vase'; 'penguin'; 'shell'};
prefix = strcat(pwd, '/images/');
alltimes = [];
allres = [];
alliter = [];


for i = 1:length(names)
    current_times = [];
    curres = [];
    curiter = [];
    for lambda = 0.0:0.1:1.0
        [time, relres, iter] = object_lsqr(names{i}, lambda);
        current_times = [ current_times time];
        curres = [curres relres];
        curiter = [curiter iter];
    end
    alltimes = [ alltimes; current_times];
    allres = [allres; curres];
    alliter = [alliter; curiter];
    
    figure
    plot(0.0:0.1:1.0, curiter,'g+', 0.0:0.1:1.0, curres,'c-');
    legend('Iteracoes', 'Residuo');
    title( strcat('Iteracoes e Residuos -', names{i}) );
    xlabel('lambda');
    grid on;
    print(strcat(strcat(prefix, names{i}), 'iter_ress_lsqr'), '-dpng');

    
end



for i = 1:4
figure
plot(0.0:0.1:1.0, alltimes(i, :),'bo');
legend('LSQR');
title( strcat('Tempo-', names{i}) );
ylabel('s');
xlabel('lambda');
grid on;
print(strcat(strcat(prefix, names{i} ) , '_lsqr'), '-dpng');

end
%%
qralltimes = [];
qrallres = [];

for i = 1:length(names)
    qrcurrent_times = [];
    qrcurres = [];
    for lambda = 0.0:0.1:1.0
        time = object_qr(names{i}, lambda);
        qrcurrent_times = [ qrcurrent_times time];
        qrcurres = [qrcurres relres];
    end
    qralltimes = [ qralltimes; qrcurrent_times];
    qrallres = [qrallres; qrcurres];
end

for i = 1:4
figure
plot(0.0:0.1:1.0, alltimes(i, :),'r*');
legend('QR');
title( strcat('Tempo-', names{i}) );
xlabel('lambda');
ylabel('s');
grid on;
print(strcat(strcat(prefix, names{i} ) , '_qr'), '-dpng');
end

for i = 1:4
figure
plot(0.0:0.1:1.0, alltimes(i, :),'bo',0.0:0.1:1.0, qralltimes(i, :),'r*');
legend('LSQR','QR');
title( strcat('Tempo-', names{i}) );
xlabel('lambda');
ylabel('s');
grid on;
print(strcat(strcat(prefix, names{i} ) , '_all'), '-dpng');
end
%%

for i = 1:length(names);
    current_times = [];
    curres = [];
    curiter = [];
    for lambda = 0.0:0.1:1.0
        [time, relres, iter] = object_guess(names{i}, lambda);
        current_times = [ current_times time];
        curres = [curres relres];
        curiter = [curiter iter];
    end
    alltimes = [ alltimes; current_times];
    allres = [allres; curres];
    alliter = [alliter; curiter];
    
    figure
    plot(0.0:0.1:1.0, curiter,'g+', 0.0:0.1:1.0, curres,'c-');
    legend('Iteracoes', 'Residuo');
    title( strcat('Iteracoes e Residuos -', names{i}) );
    xlabel('lambda');
    grid on;
    print(strcat(strcat(prefix, names{i}), 'iter_res_guess'), '-dpng');
    
    figure
    plot(0.0:0.1:1.0, current_times,'p*');
    legend(strcat('Tempo-', name) );
    title( strcat('Tempo com initial guess -', names) );
    xlabel('lambda');
    ylabel('s');
    grid on;
    print(strcat(strcat(prefix, names{i}), 'tempo_guess'), '-dpng');
    
end

% prefix = strcat(pwd, '/images/time_');
% 
% time_penguin = [];
% time_vase = [];
% time_shell = [];
% time_panel = [];
% 
% for lambda = 0.0:0.1:1.0
%     time = penguin_lsqr( lambda ) ;
%     time_penguin = [time_penguin time];
%     
%     time = vase_lsqr( lambda ) ;
%     time_vase = [time_vase time];
%     
%     time = shell_lsqr( lambda ) ;
%     time_shell = [time_shell time];
%     
%     time = panel_lsqr( lambda ) ;
%     time_panel = [time_panel time];
% end
% 
% %plot times here
% figure
% plot(0.0:0.1:1.0, time_penguin,'bo');
% legend('LSQR','QR');
% title('Tempo Pensguin');
% grid on;
% print(strcat(prefix, 'penguin_lsqr'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0, time_vase,'bo');
% legend('LSQR','QR');
% title('Tempo Vase');
% grid on;
% print(strcat(prefix, 'vase_lsqr'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0, time_shell,'bo');
% legend('LSQR','QR');
% title('Tempo Shell');
% grid on;
% print(strcat(prefix, 'shell_lsqr'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0, time_panel,'bo');
% legend('LSQR','QR');
% title('Tempo Panel');
% grid on;
% print(strcat(prefix, 'panel_lsqr'), '-dpng');
% 
% 
% time_penguin_qr = [];
% time_vase_qr = [];
% time_shell_qr = [];
% time_panel_qr = [];
% 
% for lambda = 0.0:0.1:1.0
%     time = penguin_qr( lambda ) ;
%     time_penguin_qr = [time_penguin time];
%     
%     time = vase_qr( lambda ) ;
%     time_vase_qr = [time_vase time];
%     
%     time = shell_qr( lambda ) ;
%     time_shell_qr = [time_shell time];
%     
%     time = panel_qr( lambda ) ;
%     time_panel_qr = [time_panel time];
% end
% 
% % plot QR
% 
% figure
% plot(0.0:0.1:1.0,time_penguin_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Pensguin');
% grid on;
% print(strcat(prefix, 'penguin_qr'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0,time_vase_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Vase');
% grid on;
% print(strcat(prefix, 'vase_qr'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0,time_shell_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Shell');
% grid on;
% print(strcat(prefix, 'shell_qr'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0,time_panel_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Panel');
% grid on;
% print(strcat(prefix, 'panel_qr'), '-dpng');
% 
% 
% 
% %plot times here ALL
% figure
% plot(0.0:0.1:1.0, time_penguin,'bo',0.0:0.1:1.0,time_penguin_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Pensguin');
% grid on;
% print(strcat(prefix, 'penguin'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0, time_vase,'bo',0.0:0.1:1.0,time_vase_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Vase');
% grid on;
% print(strcat(prefix, 'vase'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0, time_shell,'bo',0.0:0.1:1.0,time_shell_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Shell');
% grid on;
% print(strcat(prefix, 'shell'), '-dpng');
% 
% figure
% plot(0.0:0.1:1.0, time_panel,'bo',0.0:0.1:1.0,time_panel_qr,'r*');
% legend('LSQR','QR');
% title('Tempo Panel');
% grid on;
% print(strcat(prefix, 'panel'), '-dpng');
