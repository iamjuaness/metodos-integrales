% Se saca la primera y segunda derivada
% Se evalua en el x0 f(x), f'(x) y f''(x)
% Se evalua la convergencia f(x0)*f''(x0)/(f'(x0))^2
% Sacar el error x_new - x / x_new

function newton_raphson()
    % Solicitar la función y su derivada al usuario
    f_input = input('Ingrese la función f(x) (ejemplo: x^2 - 2): ', 's');
    df_input = input('Ingrese la derivada f''(x) (ejemplo: 2*x): ', 's');
    d2f_input = input('Ingrese la segunda derivada f"(x) (ejemplo: 2): ', 's');
    
    % Convertir las cadenas en funciones anónimas
    try
        f = str2func(['@(x) ' f_input]);
        df = str2func(['@(x) ' df_input]);
        d2f = str2func(['@(x) ', d2f_input]);
        % Probar las funciones para asegurarse de que se pueden evaluar
        f(1); df(1); d2f(1);
    catch
        error('Error al crear las funciones. Asegúrese de que la sintaxis sea correcta.');
    end

    % Solicitar los parámetros del método
    x0 = str2double(input('Ingrese el punto inicial x0: ', 's'));
    tol = str2double(input('Ingrese la tolerancia: ', 's'));
    max_iter = str2double(input('Ingrese el número máximo de iteraciones: ', 's'));
    decimales = str2double(input('Ingrese el número de decimales a mostrar: ', 's'));

    % Verificar que los inputs son números válidos
    if isnan(x0) || isnan(tol) || isnan(max_iter) || isnan(decimales) || decimales < 1
        error('Todos los valores ingresados deben ser números válidos. Los decimales deben ser al menos 1.');
    end

    % Crear los formatos de impresión basados en el número de decimales
    formato_tabla = sprintf('%%9d\t%%%d.%df\t%%%d.%df\t%%%d.%df\t%%%d.%df\n', decimales+3, decimales, decimales+3, decimales, decimales+3, decimales, decimales+3, decimales);
    formato_resultado = sprintf('%%.%df', decimales);

    % Implementación del método de Newton-Raphson
    x = x0;
    iter = 0;
    fprintf('\nIteración\t     x\t\t       f(x)\t\t     f''(x)\t     Error Relativo\n');
    fprintf('--------------------------------------------------------------------------------------------\n');

    % Verificar la condición de convergencia inicial
    if ((f(x) * d2f(x))/(df(x))^2) > 1
        fprintf('\nLa función no converge.\n');
        return;
    end

    % Bucle iterativo para el método de Newton-Raphson
    while iter < max_iter
        fx = f(x);
        dfx = df(x);
        
        % Calcular el siguiente valor de x usando la fórmula de Newton-Raphson
        x_new = x - fx / dfx;

        % Calcular el error relativo
        error_relativo = abs((x_new - x) / x_new);

        % Imprimir la iteración, el valor actual de x, f(x), f'(x) y el error relativo
        fprintf(formato_tabla, iter, x, fx, dfx, error_relativo);

        % Verificar si el error relativo es menor que la tolerancia
        if error_relativo < tol
            x = x_new; % Actualizar x para la impresión final de la raíz
            fx = f(x);
            dfx = df(x);
            iter = iter + 1;
            fprintf(formato_tabla, iter, x, fx, dfx, 0);
            fprintf('\nSe alcanzó la convergencia con la tolerancia especificada.\n');
            break;
        end

        % Actualizar el valor de x y la iteración
        x = x_new;
        iter = iter + 1;
    end

    % Comprobar si se alcanzó el número máximo de iteraciones
    if iter == max_iter
        fprintf('\nSe alcanzó el número máximo de iteraciones.\n');
    end

    % Imprimir los resultados finales
    fprintf(['\nLa raíz aproximada es ' formato_resultado '\n'], x);
    fprintf(['Valor de la función en la raíz: f(' formato_resultado ') = ' formato_resultado '\n'], x, f(x));
    fprintf('Número de iteraciones: %d\n', iter + 1);
    fprintf(['Tolerancia alcanzada: ' formato_resultado '\n'], error_relativo);

    % Graficar la función y la solución
    x_vals = linspace(x - 3, x + 3, 100); % Valores para graficar la función
    y_vals = arrayfun(f, x_vals); % Evaluar la función en esos valores
    
    figure; % Crear una nueva figura
    plot(x_vals, y_vals, 'b-', 'LineWidth', 2); % Graficar la función
    hold on; % Mantener la gráfica
    plot(x, f(x), 'ro', 'MarkerSize', 8); % Marcar la raíz encontrada
    grid on; % Añadir cuadrícula
    xlabel('x');
    ylabel('f(x)');
    title('Método de Newton-Raphson');
    legend('f(x)', 'Raíz encontrada');
    hold off; % Liberar la gráfica
end
