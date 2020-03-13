% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = linspace(0.325,1,10);           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 1;        % grid size (horizontal)
dy = 1;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

neff_arr = [];
for j = 1:length(rw)
    ridge_width = rw(j);
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                                rh,ridge_width,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
    neff_arr = [neff_arr, neff];
    fprintf(1,'neff = %.6f\n',neff);

    for i = 1:nmodes
        figure();
        subplot(121);
        contourmode(x,y,Hx(:,:,i));
        title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
        for v = edges, line(v{:}); end

        subplot(122);
        contourmode(x,y,Hy(:,:,i));
        title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
        for v = edges, line(v{:}); end
    end
end
figure()
plot(rw, neff_arr)
title('neff vs. ridge half-width')
