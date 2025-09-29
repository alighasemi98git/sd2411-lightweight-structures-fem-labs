function [defl,teta,fi,umax,tmax,fimax]=bending(Ks,Qs,K,Q,nnode,node_z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate deformed beam bending and torsion shape and plot results
% File name: bending.m
%
% Ks		Structural stiffness matrix
% Qs		Structural load vector
% K		    System stiffness matrix 
% Q		    System load vector
% nnode		Number of nodes
% node_z	Nodal z-coordinates
%
% defl		Deflection vector of size nnodes
% teta		Rotation vector of size nnodes
% fi		Twist vector of size nnodes
% umax		Maximum deflection
% tetamax	Maximum rotation
% fimax		Maximum twist
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defl = zeros(nnode, 1); % deflection
teta = zeros(nnode, 1);
fi = zeros(nnode, 1);

% Solve system of equations

w = zeros(nnode*3, 1); % all
wfree = Ks\Qs;  %free nodes,K * w = q ,solve...
% reduced matrices
w(4:end) = wfree;
disp('Displacement vector:');
disp(w);
F_reac = K*w - Q ;% formula FEM notes

% Present displacements at the free end

w_end2 = w(end-2);
w_end1 = w(end-1);
w_end= w(end);

disp('Displacement at free end:');
disp([w_end2, w_end1, w_end]);
% Present reaction forces

F_reac = K*w - Q;
disp('Reaction Force:');
disp(F_reac(1:3));
% Create result vector containing deflections, rotations and twist
% che è w 


% Split deflections, rotations and twist into separate vectors

for i=1:nnode
    defl(i) = w(1+3*(i-1));
    teta(i) = w(2+3*(i-1));
    fi(i) = w(3+3*(i-1));
end

% Normalise deflections, rotations and twist and plot results

umax = max(abs(defl));
tmax = max(abs(teta));
fimax = max(abs(fi));


unorm = defl/umax;
tetanorm = teta/tmax;
finorm = fi/fimax;


figure
plot(node_z, unorm)
hold on
plot(node_z, tetanorm)
plot(node_z, finorm)
legend('deflection','rotation','twist')
title('bending')

