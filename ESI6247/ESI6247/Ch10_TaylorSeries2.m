% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Taylor Series Demo 2 - Response Surface Methodology

function Ch10_TaylorSeries2

xlim = [-2 2]; dx = 0.2;
ylim = [-2 2]; dy = 0.2;
zlim = [0 12];
xpts = xlim(1):dx:xlim(2);
ypts = ylim(1):dy:ylim(2);
[X,Y] = meshgrid(xpts,ypts);
xtick = [-2 0 2];
ytick = [-2 0 2];
ztick = [0 6 12];
circle_size = 10;

fig = figure('WindowButtonDownFcn',@wbdcb);
% BOTTOM LEFT AXES
subplot(2,2,3)
F = (Y-X).^4 + 8*X.*Y - X + Y + 3;
F = min(max(F,zlim(1)),zlim(2));
func_mesh = mesh(xpts,ypts,F);
set(func_mesh,...
    'edgecolor','k', ...
    'facecolor','w')
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick,...
    'zlim',zlim,'ztick',ztick);
view(3)

% TOP LEFT AXES
ah = subplot(2,2,1);
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick);
[dummy,func_cont] = contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);
cont_color = ['k'; 'r'; 'g'];
for i=1:length(func_cont)
    set(func_cont(i),'edgecolor',cont_color(rem(i,3)+1,:),'linewidth',1);
end
text(0,1.7,'< CLICK ON ME >',...
    'horiz','center', ...
    'fontweight','bold',...
    'color','b');

% BOTTOM RIGHT AXES
subplot(2,2,4);
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick,...
    'zlim',zlim,'ztick',ztick);
view(3)

% TOP RIGHT AXES
subplot(2,2,2);
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick);


    function wbdcb(src,evnt)
        if strcmp(get(src,'SelectionType'),'normal')
            set(src,'pointer','circle')
            cp = get(ah,'CurrentPoint');
            
            x = cp(1,1);
            y = cp(1,2);
            Fo = (y-x).^4 + 8*x.*y - x + y + 3;
            
            % FIND GRADIENT AT POINT
            gx = -4*(y-x)^3 + 8*y - 1;
            gy = 4*(y-x)^3 + 8*x + 1;
            grd = [gx; gy];
            
            % CREATE HESSIAN
            temp = 12*(y-x)^2;
            hes = [temp 8-temp;8-temp temp];
            
            % CREATE APPROXIMATION
            dX = X - x;
            dY = Y - y;
            
            order = 2;
            if order == 0
                Fa = zeros(size(X)) + Fo;
            elseif order == 1
                Fa = grd(1)*dX + grd(2)*dY + Fo;
            else
                Fa = (hes(1,1)*dX.^2 + (hes(1,2)+hes(2,1))*dX.*dY + hes(2,2)*dY.^2)/2 +...
                    grd(1)*dX + grd(2)*dY + Fo;
            end
            Fa = min(max(Fa,zlim(1)),zlim(2));
            
            % BOTTOM LEFT AXES
            subplot(2,2,3)
            F = (Y-X).^4 + 8*X.*Y - X + Y + 3;
            F = min(max(F,zlim(1)),zlim(2));
            func_mesh = mesh(xpts,ypts,F);
            set(func_mesh,...
                'edgecolor','k', ...
                'facecolor','w')
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick,...
                'zlim',zlim,'ztick',ztick);
            view(3)
            
            % TOP LEFT AXES
            subplot(2,2,1);            
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
            plot(x,y,'ok','markersize',circle_size+4);hold off;
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick);
            
            % TOP RIGHT AXES
            subplot(2,2,2);
            [dummy,func_cont] = contour(xpts,ypts,Fa,[1 2 3 4 6 8 10]);hold on;
            cont_color = ['k'; 'r'; 'g'];
            for i=1:length(func_cont)
                set(func_cont(i),'edgecolor',cont_color(rem(i,3)+1,:),'linewidth',1);
            end
            plot(x,y,'ok','markersize',circle_size);
            plot(x,y,'ow','markersize',circle_size+2);
            plot(x,y,'ok','markersize',circle_size+4);hold off;
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick);
            
            
            % BOTTOM RIGHT AXES
            subplot(2,2,4);
            func_mesh = mesh(xpts,ypts,Fa);
            set(func_mesh,...
                'edgecolor','k', ...
                'facecolor','w')
            view(3)
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick,...
                'zlim',zlim,'ztick',ztick);
            view(3)
            
            
        end
        
    end
end