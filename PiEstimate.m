function piEstimate = PiEstimate(sigFig)
if nargin < 1
    error('Please provide the number of significant figures.');
end

tolerance = 10^(-sigFig);

insideCircle = 0;
numPoints = 0;
prevEstimate = 0;
currEstimate = 0;

figure;
hold on;
axis equal;
title('Estimation of pi');
xlabel('x');
ylabel('y');
legend('Points inside circle', 'Points outside circle', 'Location', 'Best');
theta = linspace(0,2*pi,100);
xUnitCircle = cos(theta);
yUnitCircle = sin(theta);
plot(xUnitCircle, yUnitCircle,'k--','LineWidth',1.5)

tic;
maxPoints = 1e7;

while true
    x = rand()*2-1;
    y = rand()*2-1;

    if x^2+y^2<=1
        insideCircle = insideCircle+1;
        plot(x,y,'go');
    else
        plot(x,y,'ro');
    end
    numPoints = numPoints+1;
    currEstimate = 4*insideCircle/numPoints;
    if numPoints > 1 && abs(currEstimate-prevEstimate)<tolerance
        break;
    end

    prevEstimate = currEstimate;
    if numPoints >= maxPoints
        warning('Maximum number of points reached without achieving the desired precision');
        break;
    end
end

    executionTime = toc;
    fprintf('Estimated value of π: %.10f\n', currEstimate);
    fprintf('Number of points used: %d\n', numPoints);
    fprintf('Execution time: %.2f seconds\n', executionTime);
    fprintf('Precision level achieved: %.0e\n', tolerance);

    text(0, 0, sprintf('Estimated π = %.10f', currEstimate), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
        'FontSize', 12, 'FontWeight', 'bold', 'BackgroundColor', 'white');

    piEstimate = currEstimate;
end

