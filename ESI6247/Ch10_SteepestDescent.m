% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Performance optimization (steepest descent) - Response Surface Methodology

function Ch10_SteepestDescent

max_update = 20;
xlim = [-2 2]; dx = 0.2;
ylim = [-2 2]; dy = 0.2;
zlim = [0 12];
xpts = xlim(1):dx:xlim(2);
ypts = ylim(1):dy:ylim(2);
[X,Y] = meshgrid(xpts,ypts);
xtick = [-2 0 2];
ytick = [-2 0 2];
ztick = [0 6 12];
circle_size = 8;

lr = 0.03;
lr_min = 0;
lr_max = 0.2;


fig = figure('WindowButtonDownFcn',@wbdcb);
ah = axes('DrawMode','fast');
F = (Y-X).^4 + 8*X.*Y - X + Y + 3;
[dummy,func_cont] = contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);
cont_color = ['k'; 'r'; 'g'];
for i=1:length(func_cont)
    set(func_cont(i),'edgecolor',cont_color(rem(i,3)+1,:),'linewidth',1);
end
text(0,1.7,'< CLICK ON ME >',...
    'horiz','center', ...
    'fontweight','bold',...
    'color','b');
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick);
title('Performance optimization (steepest descent)','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

    function wbdcb(src,evnt)
        if strcmp(get(src,'SelectionType'),'normal')
            set(src,'pointer','circle')
            cp = get(ah,'CurrentPoint');
            x = cp(1,1);
            y = cp(1,2);

            % PLOT CONTOUR
            axes(ah);
            [dummy,func_cont] = contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);hold on;
            cont_color = ['k'; 'r'; 'g'];
            for i=1:length(func_cont)
                set(func_cont(i),'edgecolor',cont_color(rem(i,3)+1,:),'linewidth',1);
            end
            text(0,1.7,'< CLICK ON ME >',...
                'horiz','center', ...
                'fontweight','bold',...
                'color','b');

            plot(x,y,'ok','markersize',circle_size);
            plot(x,y,'ow','markersize',circle_size+2);
            plot(x,y,'ok','markersize',circle_size+4);
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick);
            title('Performance optimization (steepest descent)','FontSize',10,'FontWeight','bold');
            set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
            
            % OPTIMIZE
            xx = [x zeros(1,max_update)];
            yy = [y zeros(1,max_update)];
            for i=1:max_update
                gx = -4*(y-x)^3 + 8*y - 1;
                gy = 4*(y-x)^3 + 8*x + 1;
                nx = x-lr*gx;
                ny = y-lr*gy;
                xx(i+1) = nx;
                yy(i+1) = ny;
                x = nx;
                y = ny;
            end

            % PLOT PATH
            path1 = plot(xx,yy,...
                'color','r');
            xx(1) = [];
            yy(1) = [];
            path2 = plot(xx,yy,'o',...
                'color','b'); 
            hold off;
        end

    end
end