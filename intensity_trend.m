
% Change in visible area of sphere with distance
%
% Written by Vinay 
%
% Started on : 22nd November 2021
%
% Last Modified: 1st Feruary 2022
%
% Description:
%
%       Calculate the trend in visible area of a spherical body as distance
%       between it and the observer changes
%
% Mandatory Inputs:
%       flag_plot - boolean (true/false)
%                   Specifies whether to plot trend or not
%
% Optional Inputs:
%
%       radius - Requires two values to be passed in
%                * 1st is numeric value for the radius of the observed body
%                * 2nd is a string representing the name of the body
%
%       unit   - requires two values to be passed 
%                * 1st is a numeric value for the unit of distance to use 
%                   for plotting
%                * 2nd is a string value for the label for the unit to use 
%                   on the plots
%
%       distance - maximum simulation distance 
%
%       interval - interval to simulate distance at
%       
% Outputs:
%
%       area - matrix with area values
%
%       dist - matrix with distance values from observed body
%

function [dist, intensity] = intensity_trend(varargin)

    unit = 147.72e6;        % Unit length (default = 1 astronomical unit)
    distance = 147.72e6;    % Maximum simulation distance (default = 1 AU)
    interval = 10;           % Simulation interval (default = 10)
    
    dist = 0:(distance/interval)-1;     % Array for distance values
    intensity = dist;                   % Array for intensity values
    
    f_plot = true;
    
    name = "Solar";
    units = "Au";

    % Process Arguments
    n = 1; 
    while n < size(varargin,2)
        strval = lower(varargin{n});
        switch strval
            case "plot"
                f_plot = true;
            case "radius"
                n=n+1;
                radius = varargin{n}; %#ok<NASGU> 
                n=n+1;
                name = varargin{n};
            case "unit"
                n=n+1;
                unit = varargin{n};
                n=n+1;
                units = varargin{n};
            case "distance"
                distance = varargin{n};
            case "interval"
                n=n+1;
                interval = varargin{n};

        end
        n=n+1;
    end

    % Calculation loop
    for h = interval:interval:distance
        dist(h/interval) = h;
        intensity(h/interval) = intensity_blackbody(h);
    end
    
    if f_plot == true
        tit = name+" Intensity from 0 to " + dist(length(dist))/unit+units;
        figure("Name", name+" Intensity trend");
        set(gca,'FontSize',18, "fontname", "times");
        hold on; 
        plot(log(dist./unit), log(intensity),"--.", 'color', 'black');
        xlabel("log(Distance)");
        ylabel("log(Intensity) ");
        title(tit);
        drawnow
    end
    

end
