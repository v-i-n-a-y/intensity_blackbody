% Written by Vinay Williams
%
% Solar Radiation pressure on the dust grains
%
% Written on 4th February 2022
%
% Mandatory Inputs:
%
%	d - distance from the radiating body
%
% Optional Inputs:
%
%	r - radius of the radiating body
%	t - effective temperature of the radiating body
%
% Outputs:
%
%	i - intensity of radius at the input distance
%

function i = intensity_blackbody(d, varargin)
	
	% Default Values
	r = 696349; 	    % Radius of the sun
	k = 5.567037e-8;    % Steffan-Boltzmann constant
    i0 = 6.2999e+07;    % Intensity at solar surface

	% Process the inputs
	n=1;
	
	while n<size(varargin, 2)
		strval = lower(varargin{n});
		switch strval
			case "temperature"
				n=n+1;
				t = varargin{n};
                i0 = k*t^4;
			case "radius"
				n=n+1;
				r = varargin{n};
		end
		n=n+1;
    end
	i = (r/d)^2 * i0; 
end
