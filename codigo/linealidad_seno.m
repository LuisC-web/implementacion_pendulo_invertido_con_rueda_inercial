% Rango de evaluación
x_rad = linspace(-pi, pi, 5000); % Alta resolución
x_deg = rad2deg(x_rad);

% Cálculo de la función real y la aproximación lineal
y_sin = sin(x_rad);
y_lin = x_rad;

% Cálculo del error relativo porcentual
error_porcentual = abs((y_sin - y_lin) ./ (x_rad + eps)) * 100;
error_porcentual(x_rad == 0) = 0; % El error en 0 es exactamente 0

tolerancias = [1, 2.5, 5, 10, 20];

% Colores fuertes y vibrantes para cada tolerancia (RGB de 0 a 1)
colores = {
    [0.0000, 0.2500, 0.8500], ... % 1%: Azul fuerte (Cobalto)
    [0.8500, 0.0500, 0.1000], ... % 2.5%: Rojo intenso (Carmesí)
    [0.1000, 0.6500, 0.1500], ... % 5%: Verde oscuro (Esmeralda)
    [0.5500, 0.0000, 0.7000], ... % 10%: Morado profundo (Púrpura)
    [0.9500, 0.4500, 0.0000]  ... % 20%: Naranja oscuro (Ámbar)
    };
% Cálculo de los ángulos máximos
angulos_max_deg = zeros(1, length(tolerancias));
angulos_max_rad = zeros(1, length(tolerancias));

for i = 1:length(tolerancias)
    tol = tolerancias(i);
    indices_validos = error_porcentual <= tol;
    angulos_max_deg(i) = max(x_deg(indices_validos));
    angulos_max_rad(i) = max(x_rad(indices_validos));
end

% Ajuste de "Zoom" ampliado para evitar que se corten los textos (margen del 50%)
zoom_lim_deg = max(angulos_max_deg) * 1.5;
zoom_lim_rad = max(angulos_max_rad) * 1.5;
zoom_ylim_amp_rad = max(angulos_max_rad) * 1.5; 

% =========================================================================
% CONFIGURACIÓN ESTÁNDAR IEEE (TAMAÑOS Y GROSORES AUMENTADOS)
% =========================================================================
ieee_font = 'Times New Roman';
ieee_fontsize = 12;      % Letra más grande (antes 10)
lw_main = 2.5;           % Grosor de las curvas principales (antes 1.5)
lw_lines = 2.0;          % Grosor de las líneas de tolerancia
lw_axes = 1.2;           % Grosor de los bordes del recuadro
deg_sym = char(176);     % Símbolo de grado nativo para evitar bugs de texto

% =========================================================================
% 1. GRÁFICAS EN GRADOS
% =========================================================================

% FIGURA 1: Linealidad (GRADOS)
fig1 = figure('Name', 'Linealidad (Grados)', 'Color', 'w');
plot(x_deg, y_sin, 'b', 'LineWidth', lw_main); hold on;
plot(x_deg, y_lin, 'r--', 'LineWidth', lw_main);

for i = 1:length(tolerancias)
    % Etiqueta con paréntesis de cierre garantizado
    label_txt = sprintf('%g%% (%.1f%c)', tolerancias(i), angulos_max_deg(i), deg_sym);
    xline(angulos_max_deg(i), ':', 'Color', colores{i}, 'LineWidth', lw_lines, 'Label', label_txt, 'LabelVerticalAlignment', 'bottom');
    xline(-angulos_max_deg(i), ':', 'Color', colores{i}, 'LineWidth', lw_lines, 'Label', label_txt, 'LabelVerticalAlignment', 'bottom');
end
grid on;
xlim([-zoom_lim_deg, zoom_lim_deg]);
ylim([-sind(zoom_lim_deg)*1.3, sind(zoom_lim_deg)*1.3]);
title('Linealidad: sen(\theta) vs \theta', 'FontName', ieee_font, 'FontSize', ieee_fontsize + 2);
xlabel(sprintf('Ángulo \\theta (Grados %c)', deg_sym), 'FontName', ieee_font, 'FontSize', ieee_fontsize);
ylabel('Amplitud', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
legend('sen(\theta)', '\theta (aproximación)', 'Location', 'SouthEast', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
set(gca, 'FontName', ieee_font, 'FontSize', ieee_fontsize, 'LineWidth', lw_axes);
%exportgraphics(fig1, 'Fig1_Linealidad_Grados.eps', 'ContentType', 'vector');
exportgraphics(fig1, 'Fig1_Linealidad_Grados.png', 'Resolution', 600);

% FIGURA 2: Error Relativo (GRADOS)
fig2 = figure('Name', 'Error Relativo (Grados)', 'Color', 'w');
plot(x_deg, error_porcentual, 'k', 'LineWidth', lw_main); hold on;

for i = 1:length(tolerancias)
    label_txt = sprintf('%g%%', tolerancias(i));
    yline(tolerancias(i), '--', 'Color', colores{i}, 'LineWidth', lw_lines, 'Label', label_txt, 'LabelHorizontalAlignment', 'left');
end
grid on;
xlim([-zoom_lim_deg, zoom_lim_deg]);
ylim([0, max(tolerancias) * 1.3]);
title('Error de Aproximación', 'FontName', ieee_font, 'FontSize', ieee_fontsize + 2);
xlabel(sprintf('Ángulo \\theta (Grados %c)', deg_sym), 'FontName', ieee_font, 'FontSize', ieee_fontsize);
ylabel('Error Relativo (%)', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
set(gca, 'FontName', ieee_font, 'FontSize', ieee_fontsize, 'LineWidth', lw_axes);
%exportgraphics(fig2, 'Fig2_Error_Grados.eps', 'ContentType', 'vector');
exportgraphics(fig2, 'Fig2_Error_Grados.png', 'Resolution', 600);


% =========================================================================
% 2. GRÁFICAS EN RADIANES
% =========================================================================

% FIGURA 3: Linealidad (RADIANES)
fig3 = figure('Name', 'Linealidad (Radianes)', 'Color', 'w');
plot(x_rad, y_sin, 'b', 'LineWidth', lw_main); hold on;
plot(x_rad, y_lin, 'r--', 'LineWidth', lw_main);

for i = 1:length(tolerancias)
    label_txt = sprintf('%g%% (%.3f rad)', tolerancias(i), angulos_max_rad(i));
    xline(angulos_max_rad(i), ':', 'Color', colores{i}, 'LineWidth', lw_lines, 'Label', label_txt, 'LabelVerticalAlignment', 'bottom');
    xline(-angulos_max_rad(i), ':', 'Color', colores{i}, 'LineWidth', lw_lines, 'Label', label_txt, 'LabelVerticalAlignment', 'bottom');
end
grid on;
xlim([-zoom_lim_rad, zoom_lim_rad]);
ylim([-zoom_ylim_amp_rad, zoom_ylim_amp_rad]);
title('Linealidad: sen(\theta) vs \theta', 'FontName', ieee_font, 'FontSize', ieee_fontsize + 2);
xlabel('Ángulo \theta (Radianes)', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
ylabel('Amplitud', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
legend('sen(\theta)', '\theta (aproximación)', 'Location', 'SouthEast', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
set(gca, 'FontName', ieee_font, 'FontSize', ieee_fontsize, 'LineWidth', lw_axes);
%exportgraphics(fig3, 'Fig3_Linealidad_Radianes.eps', 'ContentType', 'vector');
exportgraphics(fig3, 'Fig3_Linealidad_Radianes.png', 'Resolution', 600);

% FIGURA 4: Error Relativo (RADIANES)
fig4 = figure('Name', 'Error Relativo (Radianes)', 'Color', 'w');
plot(x_rad, error_porcentual, 'k', 'LineWidth', lw_main); hold on;

for i = 1:length(tolerancias)
    label_txt = sprintf('%g%%', tolerancias(i));
    yline(tolerancias(i), '--', 'Color', colores{i}, 'LineWidth', lw_lines, 'Label', label_txt, 'LabelHorizontalAlignment', 'left');
end
grid on;
xlim([-zoom_lim_rad, zoom_lim_rad]);
ylim([0, max(tolerancias) * 1.3]);
title('Error de Aproximación', 'FontName', ieee_font, 'FontSize', ieee_fontsize + 2);
xlabel('Ángulo \theta (Radianes)', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
ylabel('Error Relativo (%)', 'FontName', ieee_font, 'FontSize', ieee_fontsize);
set(gca, 'FontName', ieee_font, 'FontSize', ieee_fontsize, 'LineWidth', lw_axes);
%exportgraphics(fig4, 'Fig4_Error_Radianes.eps', 'ContentType', 'vector');
exportgraphics(fig4, 'Fig4_Error_Radianes.png', 'Resolution', 600);

disp('Gráficas generadas con líneas extra gruesas y textos ampliados (sin textos cortados).');