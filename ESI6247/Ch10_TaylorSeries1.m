% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Taylor Series Demo 1 - Response Surface Methodology

function Ch10_TaylorSeries1

fig = figure('WindowButtonDownFcn',@wbdcb);
ah = axes('DrawMode','fast');
xpts = -6:0.03:6;
f = cos(xpts);
func_plot = plot(xpts,f,'k','linewidth',2);
text(0,1.7,'< CLICK ON ME >',...
    'horiz','center', ...
    'fontweight','bold',...
    'color','b');
axis([-6 6 -2 2]);
title('Taylor Series Demo','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

    function wbdcb(src,evnt)
        if strcmp(get(src,'SelectionType'),'normal')
            set(src,'pointer','circle')
            cp = get(ah,'CurrentPoint');
            
            axes(ah);
            func_plot = plot(xpts,f,'k','linewidth',2); hold on;
            text(0,1.7,'< CLICK ON ME >',...
                'horiz','center', ...
                'fontweight','bold',...
                'color','b');
            axis([-6 6 -2 2]);
            title('Taylor Series Demo','FontSize',10,'FontWeight','bold');
            set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
            
            x = cp(1,1);
            fo = cos(x);
            
            fn = cos(xpts);
            f0 = fo + zeros(size(xpts));
            f1 = f0 - sin(x)*(xpts-x);
            f2 = f1 - cos(x)*((xpts-x).^2)/2;
            f3 = f2 + sin(x)*((xpts-x).^3)/6;
            f4 = f3 + cos(x)*((xpts-x).^4)/24;
            
            % PLOT APPROXIMATION
            plot(xpts,f0,'r','LineWidth',2);
            plot(xpts,f1,'--c','LineWidth',2);
            plot(xpts,f2,'g','LineWidth',2);
            plot(xpts,f3,'-.b','LineWidth',2);
            plot(xpts,f4,':m','LineWidth',2);
            circle_size = 10;
            plot(x,fo,'ok','markersize',circle_size);
            plot(x,fo,'ow','markersize',circle_size+2);
            plot(x,fo,'ok','markersize',circle_size+4);
            legend('cos(x)','order 0','order 1','order 2','order 3','order 4','Location','NorthEast')
            hold off;
            
        end
        
    end
end