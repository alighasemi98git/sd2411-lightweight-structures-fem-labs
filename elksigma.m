function [Kesigma]=elksigma(le,P,I0,A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble element initial stress stiffness matrix
% File name: elksigma.m
% 
% le [m]	Element length
% P  [N]	"Tensile" buckling load
% Kesigma is returned - element initial stress matrix
%
% Make sure the initial stress matrix is symmetric!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Kesigma = [36/30*P/le , -3/30*P , 0 , -36/30*P/le , -3/30*P , 0;
           -3/30*P , 4/30*P*le , 0 , 3/30*P , -P/30*le , 0;
           0 , 0 , I0*P/(A*le) , 0 , 0 , -I0*P/(A*le);
           -36/30*P/le , +3/30*P , 0 , 36/30*P/le , 3/30*P , 0;
           -3/30*P , -P/30*le , 0 , 3/30*P , 4/30*P*le , 0;
           0 , 0 , -I0*P/(A*le) , 0 , 0 , I0*P/(A*le)];
