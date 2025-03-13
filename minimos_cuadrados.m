% Método de Mínimos Cuadrados
% Se hace la tabla con xi, yi, xi^2, xi*yi
% Se halla a0 = ((Sumxi^2 * Sumyi)- (Sumxiyi * Sumxi)/(m(xi^2) - (xi)^2)
% Se halla a1 = (m(Sumxiyi) - (Sumxi*Sumyi)/(m(xi^2) - (xi)^2)
% Error = Sum (yi - (a1*xi _ a0))^2
% Transpuesta
% Inversa
function minimos_cuadrados()
    % Solicitar los datos para la regresión
    x = input('Ingrese el vector de valores x (ejemplo: [1; 2; 3; 4]): ');
    y = input('Ingrese el vector de valores y (ejemplo: [2; 3; 5; 7]): ');

    % Calcular la longitud del vector y las sumas necesarias
    n = length(x);
    sum_x = sum(x);
    sum_y = sum(y);
    sum_xy = sum(x .* y);
    sum_x2 = sum(x .^ 2);
    
    % Cálculo de la pendiente (m) y la intersección (b)
    m = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x^2);
    b = (sum_y - m * sum_x) / n;

    % Calcular el error cuadrático (E)
    y_pred = m * x + b; % Valores predichos por la recta
    E = sum((y - y_pred).^2); % Suma de los errores al cuadrado

    % Mostrar la ecuación de la recta y el error cuadrático
    fprintf('La ecuación de la recta es: y = %.4fx + %.4f\n', m, b);
    fprintf('El error cuadrático es: E = %.4f\n', E);

    % Graficar los datos y la recta
    figure;
    scatter(x, y, 'filled'); % Graficar los puntos
    hold on;
    x_vals = linspace(min(x), max(x), 100);
    y_vals = m * x_vals + b; % Evaluar la línea de regresión
    plot(x_vals, y_vals, 'r-', 'LineWidth', 2); % Graficar la recta de regresión
    grid on;
    xlabel('x');
    ylabel('y');
    title('Regresión Lineal por Mínimos Cuadrados');
    legend('Datos', 'Recta de Regresión');
    hold off;
end