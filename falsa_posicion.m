% Evaluar f(a) y f(b)
% Se saca x_new a(f(b))- b(f(a)) / f(b) - f(a)
% Se evalua f(xi)
% Se saca el nuevo intervalo
% Sacar el error x_new - x / x_new

function falsa_posicion()
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

    % Solicitar los límites del intervalo, la tolerancia, máximo de iteraciones y decimales
    a = str2double(input('Ingrese el límite inferior del intervalo: ', 's'));
    b = str2double(input('Ingrese el límite superior del intervalo: ', 's'));
    tol = str2double(input('Ingrese la tolerancia máxima: ', 's'));
    max_iter = str2double(input('Ingrese el número máximo de iteraciones: ', 's'));
    decimales = str2double(input('Ingrese el número de decimales a mostrar: ', 's'));

    % Verificar que los inputs son números válidos
    if isnan(a) || isnan(b) || isnan(tol) || isnan(max_iter) || isnan(decimales) || decimales < 1
        error('Todos los valores ingresados deben ser números válidos.');
    end

    % Crear los formatos de impresión basados en el número de decimales
    formato_tabla = sprintf('%%9d\\t%%%d.%df\\t%%%d.%df\\t%%%d.%df\\t%%%d.%df\\t%%%d.%df\\n', ...
        decimales+3, decimales, decimales+3, decimales, decimales+3, decimales, decimales+3, decimales, decimales+3, decimales);
    formato_resultado = sprintf('%%.%df', decimales);

    % Verificar si la función cambia de signo en el intervalo
    fa = f(a);
    fb = f(b);
    if ~isfinite(fa) || ~isfinite(fb)
        error('La función no está definida en uno o ambos extremos del intervalo.');
    end
    if fa * fb >= 0
        error('La función debe cambiar de signo en el intervalo [a, b]');
    end

    cont = 0;
    c = a; % Inicializar c
    error_relativo = Inf; % Inicializar el error relativo como infinito para entrar al bucle

    % Graficar la función en el intervalo [a, b]
    x_vals = linspace(a, b, 100);  % Generar 100 puntos entre a y b
    y_vals = f(x_vals);            % Evaluar la función en esos puntos
    figure;                         % Crear una nueva figura
    plot(x_vals, y_vals, 'b-', 'LineWidth', 1.5);  % Graficar la función
    hold on;                       % Mantener la gráfica
    grid on;                       % Activar la cuadrícula
    xlabel('x');                   % Etiqueta eje x
    ylabel('f(x)');                % Etiqueta eje y
    title('Gráfica de la función f(x)');  % Título de la gráfica

    % Imprimir encabezados de la tabla
    fprintf('\nIteración\t   a\t\t\t   b\t\t\t   c\t\t\t   f(c)\t\t\tError Relativo\n');
    fprintf('---------------------------------------------------------------------------------------------\n');
    
    % Bucle para encontrar la raíz usando el método de falsa posición
    while error_relativo > tol && cont < max_iter
        % Calcular el punto de intersección de la línea que conecta (a, f(a)) y (b, f(b))
        c_nuevo = (a * fb - b * fa) / (fb - fa);
        fc = f(c_nuevo);

        % Calcular el error relativo si no es la primera iteración
        if cont > 0
            error_relativo = abs((c_nuevo - c) / c_nuevo);
        end

        if fc == 0
            break
        end

        % Determinar el nuevo intervalo según el signo de f(c)
        if fa * fc < 0
            b = c_nuevo;
            fb = fc;
        else
            a = c_nuevo;
            fa = fc;
        end

        % Imprimir los valores de la tabla
        fprintf(formato_tabla, cont, a, b, c_nuevo, fc, error_relativo);
        
        % Actualizar el valor de c
        c = c_nuevo;
        cont = cont + 1;
    end

    % Graficar el punto c
    plot(c, fc, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8); % Punto c resaltado

    if cont == max_iter
        fprintf('\n\nSe alcanzó el número máximo de iteraciones. La mejor aproximación encontrada es:');
    else
        fprintf('\n\nEl método ha convergido con el error relativo especificado.\n');
    end
    fprintf(['\nLa raíz aproximada es ' formato_resultado '\n'], c);
    fprintf(['Valor de la función en la raíz: f(' formato_resultado ') = ' formato_resultado '\n'], c, fc);
    fprintf('Número de iteraciones: %d\n', cont);
    fprintf(['Error relativo final: ' formato_resultado '\n'], error_relativo);
    
    hold off;  % Liberar la figura
end
