function [pb,ub]=buckle(Ks,Ksigmas,nnode,node_z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Solve beam buckling equation
% File name: buckle.m
% 
% Ks		Structural stiffness matrix
% Ksigmas	Structural inital stiffness matrix
% nnode		Number of nodes
% node_z	Nodal x-coordinates
%
% pb		Matrix with eigenvalues (load factors) in diagonal
% ub		Corresponding matrix of eigenvectors (buckling modes)
% 	(Column i of ub shows the buckling mode for buckling load (i,i) in pb)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defl = zeros(nnode, 1);
teta = zeros(nnode, 1);
fi = zeros(nnode, 1);

% Calculate eigenvalues and eigenvectors

[ub, pb] = eig(Ks, -Ksigmas) %Minus because it is (K - sigma*Ksigma)
% ub eigenvectors and pb eigenvalues

% Split bending and twist modes into separate vectors

ub_twist = zeros((nnode-1)*3,nnode-1); % *3 because 3 dof times the number of elements
ub_bend = zeros((nnode-1)*3,(nnode-1)*2); % 2 modi di bending e 1 di twist...
% per ciascun nodo
flag = 0; 
k = 1;
l = 1;

% Initialize arrays to store column indices for ub_twist and ub_bend
ub_twist_column = []; 
ub_bend_column = []; 

for i = 1:((nnode-1)*3)
    for j = 1:(nnode-1)
        if ub(1+3*(j-1), i) < 1e-10
            flag = 1;
        else
            flag = 0;
            break
        end
    end
    
    if (flag == 1) && k <= (nnode-1)
        ub_twist(:,k) = ub(:, i);
        ub_twist_column = [ub_twist_column, i]; % Store column index for ub_twist
        k = k + 1;
    else
        ub_bend(:,l) = ub(:, i);
        ub_bend_column = [ub_bend_column, i]; % Store column index for ub_bend
        l = l + 1;
    end
end

% Display the results
ub_twist
ub_bend
ub_twist_column;
ub_bend_column;
disp('eigenvalues of twist:');
disp(pb(:,ub_twist_column));
disp('eigenvalues of bending:');
disp(pb(:,ub_bend_column));


% Normalise deflections, rotations and twist for plotting purposes (without risking to mix up signs or divide by zero)

defl = zeros(nnode, 1);
teta = zeros(nnode, 1);
fi = zeros(nnode, 1);

defl(1) = 0;
teta(1) = 0;
fi(1) = 0;

mode = 1; % you can choose the mode through this variable that you can change

for i=2:nnode
    defl(i) = ub(1+3*(i-2), mode);
    teta(i) = ub(2+3*(i-2), mode);
    fi(i) = ub(3+3*(i-2), mode);
end
Load = pb(mode, mode);
disp('Buckeling load (mode 1):');
disp(Load);

umax = max(abs(defl));
tmax = max(abs(teta));
fimax = max(abs(fi));

unorm = defl/umax;
tetanorm = teta/tmax;
finorm = fi/fimax;

%
defl2 = zeros(nnode, 1);
teta2 = zeros(nnode, 1);
fi2 = zeros(nnode, 1);

defl2(1) = 0;
teta2(1) = 0;
fi2(1) = 0;
mode = 2; % you can choose the mode through this variable that you can change

for i=2:nnode
    defl2(i) = ub(1+3*(i-2), mode);
    teta2(i) = ub(2+3*(i-2), mode);
    fi2(i) = ub(3+3*(i-2), mode);
end
Load = pb(mode, mode);
disp('Buckeling load (mode 2):');
disp(Load);
umax2 = max(abs(defl2));
tmax2 = max(abs(teta2));
fimax2 = max(abs(fi2));

unorm2 = defl2/umax2;
tetanorm2 = teta2/tmax2;
finorm2 = fi2/fimax2;
%
defl3 = zeros(nnode, 1);
teta3 = zeros(nnode, 1);
fi3 = zeros(nnode, 1);

defl3(1) = 0;
teta3(1) = 0;
fi3(1) = 0;
mode = 3; % you can choose the mode through this variable that you can change

for i=2:nnode
    defl3(i) = ub(1+3*(i-2), mode);
    teta3(i) = ub(2+3*(i-2), mode);
    fi3(i) = ub(3+3*(i-2), mode);
end
Load = pb(mode, mode);
disp('Buckeling load (mode 3):');
disp(Load);
umax3 = max(abs(defl3));
tmax3 = max(abs(teta3));
fimax3 = max(abs(fi3));

unorm3 = defl3/umax3;
tetanorm3 = teta3/tmax3;
finorm3 = fi3/fimax3;
%
figure
plot(node_z, unorm);
hold on
plot(node_z, unorm2);
plot(node_z, unorm3);
title('Buckle Deflection');
legend('Mode 1','Mode 2','Mode 3')

figure
plot(node_z, tetanorm)
hold on 
plot(node_z, tetanorm2)
plot(node_z, tetanorm3)
title('Buckle Rotation');
legend('Mode 1','Mode 2','Mode 3')

figure
plot(node_z, finorm)
hold on
plot(node_z, finorm2)
plot(node_z, finorm3)
title('Buckle Twist');
legend('Mode 1','Mode 2','Mode 3')

ub_bend1=[0; ub_bend(1:3:end,1)];
ub_bend2=[0; ub_bend(1:3:end,2)];
ub_bend3=[0; ub_bend(1:3:end,3)];
size(ub_bend1)
% Plot buckling modes
size(node_z)
figure(5)
plot(node_z, ub_bend1)
hold on
plot(node_z, ub_bend2)
plot(node_z, ub_bend3)
% plot(node_z(2,:), ub_bend(1:2:end,2))
% plot(node_z(2,:), ub_bend(1:2:end,3))
title('Buckle bend');
legend('Mode 1','Mode 2','Mode 3')
% Present the buckling loads
%Load = pb(mode, mode);
%disp('Buckeling load:');
%disp(Load);

