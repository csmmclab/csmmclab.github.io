% Dr. Hui Yang
% prepared for  ESI 6247 Statistical Design Models
% Deaprtment of Industrial and Management Systems Engineering
% University of South Florida
% Email: huiyang@usf.edu

% Performance optimization (conjugate gradient + steepest descent) - Response Surface Methodology

function Ch10_ConjugateGradient

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

a=[2 1;1 2];
b=[0 0];
c=0;

lr = 0.03;
lr_min = 0;
lr_max = 0.2;

F = (a(1,1)*X.^2 + (a(1,2)+a(2,1))*X.*Y + a(2,2)*Y.^2)/2 ...
    + b(1)*X + b(2)*Y +c;

fig = figure('Position',[107 240 801 420],'WindowButtonDownFcn',@wbdcb);
% LEFT AXES
left = subplot(1,2,1);
contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);
text(0,1.7,'< CLICK ON ME >',...
    'horiz','center', ...
    'fontweight','bold',...
    'color','b');
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick);
title('steepest descent','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

% RIGHT AXES
right = subplot(1,2,2);
contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);
set(gca, ...
    'xlim',xlim,'xtick',xtick, ...
    'ylim',ylim,'ytick',ytick);
title('conjugate gradient','FontSize',10,'FontWeight','bold');
set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');

    function wbdcb(src,evnt)
        if strcmp(get(src,'SelectionType'),'normal')
            set(src,'pointer','circle')
            cp = get(left,'CurrentPoint');
            x = cp(1,1);
            y = cp(1,2);

            % OPTIMIZE
            x1 = [x; y];                    % Steepest descent point
            x2 = x1;                        % Conjugate gradient point

            % LEFT AXES
            left = subplot(1,2,1);
            contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);hold on;
            text(0,1.7,'< CLICK ON ME >',...
                'horiz','center', ...
                'fontweight','bold',...
                'color','b');
            % STEEPEST DESCENT
            for i=1:5
                grad = a*x1+b';
                p = -grad;
                hess = a;
                lr = -grad'*p/(p'*hess*p);
                dx1 = -lr*grad;
                nx1 = x1 + dx1;
                h1 = plot([x1(1) nx1(1)],[x1(2) nx1(2)],...
                    'color','r');
                h2 = plot([x1(1) nx1(1)],[x1(2) nx1(2)],'o',...
                    'color','b');
                x1 = nx1;
            end
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick);
            title('steepest descent','FontSize',10,'FontWeight','bold');
            set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
            hold off;


            % RIGHT AXES
            right = subplot(1,2,2);
            contour(xpts,ypts,F,[1.01 2 3 4 6 8 10]);hold on;
            % CONJUGATE GRADIENT
            for i=1:2
                if (i==1)
                    grad = a*x2+b';
                    p = -grad;
                else
                    grad_old = grad;
                    grad = a*x2+b';
                    beta = (grad'*grad)/(grad_old'*grad_old);
                    p = -grad + beta*p;
                end
                hess=a;
                lr = -grad'*p/(p'*hess*p);
                dx2 = lr*p;
                nx2 = x2 + dx2;
                h1 = plot([x2(1) nx2(1)],[x2(2) nx2(2)],...
                    'color','r');
                h2 = plot([x2(1) nx2(1)],[x2(2) nx2(2)],'o',...
                    'color','b');
                x2 = nx2;
            end
            set(gca, ...
                'xlim',xlim,'xtick',xtick, ...
                'ylim',ylim,'ytick',ytick);
            title('conjugate gradient','FontSize',10,'FontWeight','bold');
            set(gca,'LineWidth',2,'FontSize',10,'FontWeight','bold');
            hold off;
        end

    end
end