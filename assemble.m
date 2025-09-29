function [K,Q,M,Ksigma]=assemble(le,EI,GJ,I0,A,J0,q,qt,S,T,m,P,ndof,nelem);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble system stiffness matrix, load vector, mass matrix (not necessary)
% and initial stress matrix
% File name: assemble.m
%
% K		System stiffness matrix
% Q		System load vector
% M		System mass matrix
% Ksigma       System initial stress matrix
%
% le		element length [m]
% EI		element bending stiffness [Nm2]
% GJ		element torsional stiffness [Nm2]
% I0		element polar moment of inertia [m4]
% A		element cross-section area [m2]
% J0		element mass moment of inertia [kgm]
% q		element transverse pressure load [N/m]
% qt		element torsion pressure load [Nm/m]
% S		transverse point load [N]
% T		local torque [Nm]
% m		element mass per unit length [kg/m]
% P		applied buckling load [N], positive if tensile
% ndof		number of degrees of freedom
% nelem		number of elements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q=zeros(ndof, 1);
M=zeros(ndof);
Ksigma=zeros(ndof);
K = zeros(ndof);

k = 0;
for i = 1:nelem

    Ke=elk(le,EI,GJ);
    Ksigma_e=elksigma(le,P,I0,A);
    Qe=elq(le,q,qt);

    K(k+1 : k+6, k+1 : k+6) = K(k+1 : k+6, k+1 : k+6) + Ke; % da riga/colonna...
    % 1 a 6, si mette Ke che è la element stifness matrix; la K va formata
    % sommando le varie Ke
    Ksigma(k+1 : k+6, k+1 : k+6) = Ksigma(k+1 : k+6, k+1 : k+6) + Ksigma_e;
    Q(k+1 : k+6) = Q(k+1 : k+6) + Qe;

    k = k+3; % è influenzata dal nodo precedente e quello successivo.

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add concentrated loads
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Q(end-2) = Q(end-2) + S; %primo elemento nelle triadi è sul carico concenctrato
Q(end) = Q(end) + T; % terzo elemento nella triade è torque


