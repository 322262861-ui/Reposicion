clc; clear; close all;
syms x y z r theta rho phi

%% 1. Calculo en Coordenadas Rectangulares
V_rect = int(int(int(1, z, 0, 3), y, -sqrt(4-x^2), sqrt(4-x^2)), x, -2, 2);

%% 2. Calculo en Coordenadas Cilindricas (Jacobiano = r)
V_cil = int(int(int(r, z, 0, 3), r, 0, 2), theta, 0, 2*pi);

%% 3. Calculo en Coordenadas Esfericas (Jacobiano = rho^2 * sin(phi))
phi_limite = atan(2/3);
V_esf_tapa  = int(int(int(rho^2 * sin(phi), rho, 0, 3*sec(phi)), phi, 0, phi_limite), theta, 0, 2*pi);
V_esf_pared = int(int(int(rho^2 * sin(phi), rho, 0, 2*csc(phi)), phi, phi_limite, pi/2), theta, 0, 2*pi);
V_esf = simplify(V_esf_tapa + V_esf_pared);

fprintf('Volumen Rectangulares: %s\n', char(V_rect));
fprintf('Volumen Cilindricas:   %s\n', char(V_cil));
fprintf('Volumen Esfericas:     %s\n', char(V_esf));

%% 4. Grafica 3D del Solido
[R_grid, Theta_grid] = meshgrid(linspace(0, 2, 30), linspace(0, 2*pi, 50));
X = R_grid .* cos(Theta_grid);
Y = R_grid .* sin(Theta_grid);

figure('Color', 'w');
hold on;
% Pared lateral
[X_lat, Y_lat, Z_lat] = cylinder(2, 50);
Z_lat = Z_lat * 3;
surf(X_lat, Y_lat, Z_lat, 'FaceColor', [0.2 0.6 0.8], 'FaceAlpha', 0.6, 'EdgeColor', 'none');

% Tapa inferior y superior
surf(X, Y, zeros(size(X)), 'FaceColor', [0.1 0.4 0.7], 'FaceAlpha', 0.8, 'EdgeColor', 'none');
surf(X, Y, 3*ones(size(X)), 'FaceColor', [0.1 0.4 0.7], 'FaceAlpha', 0.8, 'EdgeColor', 'none');

title('Simulacion 3D: Tanque Cilindrico (R = 2, H = 3, V = 12\pi)');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');
axis equal; grid on; view(45, 25);