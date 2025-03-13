function graficar_funcion()
    % Solicitar la función al usuario
    f_input = input('Ingrese la función (ejemplo: x^2 - 2): ', 's');
    
    % Convertir la cadena en una función anónima
    try
        f = str2func(['@(x) ' f_input]);
        % Probar la función para asegurarse de que se puede evaluar
        f(1);
    catch
        error('Error al crear la función. Asegúrese de que la sintaxis sea correcta.');
    end
    
    % Solicitar los límites del intervalo y el número de puntos
    x_min = str2double(input('Ingrese el límite inferior del intervalo en x: ', 's'));
    x_max = str2double(input('Ingrese el límite superior del intervalo en x: ', 's'));
    num_points = str2double(input('Ingrese el número de puntos a graficar (ejemplo: 100): ', 's'));

    % Verificar que los inputs son números válidos
    if isnan(x_min) || isnan(x_max) || isnan(num_points) || num_points < 2
        error('Los límites del intervalo y el número de puntos deben ser números válidos.');
    end

    % Generar los puntos y evaluar la función
    x_vals = linspace(x_min, x_max, num_points);
    y_vals = arrayfun(f, x_vals);

    % Graficar la función
    figure;
    plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5);
    grid on;
    xlabel('x');
    ylabel('f(x)');
    title(['Gráfica de la función: ', f_input]);
    hold on;

    % Resaltar los puntos donde la función cruza el eje x
    zero_crossings = x_vals(y_vals == 0);
    plot(zero_crossings, zeros(size(zero_crossings)), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');

    % Indicar el rango de la gráfica
    xlim([x_min, x_max]);
    hold off;
end