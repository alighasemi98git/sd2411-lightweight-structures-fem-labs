clear all;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Program  
% Beam FE-code for bending about 1-axis and St.Venant torsion
%
% Use SI units only
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definitions and input data
L=1000;		% Length [m]
E=70000;	% Youngs modulus [N/m2]
G=2.692307692307692e+04;	% Shear modulus [N/m2]
I=3e4;		% Moment of inertia about x-axis [m4]
J=386.6667;		% Torsional constant [m4]
EI=E*I;		% Bending stiffness [Nm2]
GJ=G*J;		% Torsional stiffness [Nm2]
I0=1;	% Polar moment of inertia [m4]
A=1;	% Cross-section area [m2]
ro=1;	% Material density [kg/m3]
J0=I0*ro;	% Mass moment of inertia [kgm]

% Loads and masses
m=A*ro;	% mass per unit length of elements [kg/m]
q=0;           % Distributed load [N/m]
qt=0;		% Distributed torque [Nm/m]
S=0;           % Concentrated load at end of beam [N]
T=0;		% Beam end torque [Nm]
P=1;		% Buckling load [N]

% Element input data
nelem=10;		% number of elements
le=L/nelem;		% length of elements for even distribution
ndof=3*(nelem+1);	% number of degrees of freedom
nnode=nelem+1;		% number of nodes

% Node coordinates
node_z=zeros(nnode,1);
for i=1:nnode
        node_z(i)=le*(i-1);
end

% Assemble stiffness, load and initial stress matrix of the system
[K,Q,M,Ksigma]=assemble(le,EI,GJ,I0,A,J0,q,qt,S,T,m,P,ndof,nelem);

% Apply boundary conditions
% Remove locked dofs at x=0
% K,Q,M and Ksigma are now reduced and structural matrices formed
Ks=K(4:ndof,4:ndof);
Qs=Q(4:ndof);
Ms=M(4:ndof,4:ndof);
Ksigmas=Ksigma(4:ndof,4:ndof);

% Solve beam bending and torsion equation and present results

[defl,teta,fi,wmax,tmax,fimax]=bending(Ks,Qs,K,Q,nnode,node_z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solve beam buckling equation and plot results
% The torsional buckling modes will all give identical load factors
% pb is a matrix containing the buckling load factors, in ascending order
% ub is a matrix of corresponding buckling modes (as columns)
% (Column i of ub is buckling mode of buckling load (i,i) in pb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pb,ub]=buckle(Ks,Ksigmas,nnode,node_z);

