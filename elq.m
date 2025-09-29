function [Qe]=elq(le,q,qt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element load vector
% File name: elq.m 
% 
% le [m]	Element length
% q  [N/m]	Element distributed load (constant in the lab)
% qt  [N]	Element distributed torque (constant in the lab)
% Qe is returned - element load vector
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Qe = [q*le/2, -q*le^2/12, qt*le/2, q*le/2, q*le^2/12, qt*le/2]';
