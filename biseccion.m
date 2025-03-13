% Primero debemos sacar m = b+a/2
% Evaluar f(a), f(b) y f(m)
% Definir el nuevo intervalo con el signo de f(m)
% Error b-a/2
function metodo_biseccion()
    % Solicitar la función al usuario
    f_input = input('Ingrese la función (ejemplo: x.^2 - 2): ', 's');
    
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
        error('Todos los valores ingresados deben ser números válidos. Los decimales deben ser al menos 1.');
    end

    % Crear los formatos de impresión basados en el número de decimales
    formato_tabla = sprintf('%%9d\\t%%%d.%df\\t%%%d.%df\\t%%%d.%df\\t%%%d.%df\\n', ...
        decimales+3, decimales, decimales+3, decimales, decimales+3, decimales, decimales+3, decimales);
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

    fprintf('\nIteración\t   a\t\t\t   b\t\t\t   m\t\t\t   Error Relativo\n');
    fprintf('--------------------------------------------------------------------------------\n');
    
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
    
    % Inicializar el punto medio y el error relativo
    m = (a + b) / 2;
    fm = f(m);
    error_relativo = abs(b - a) / 2;
    
    % Bucle para encontrar la raíz usando el método de bisección
    while (error_relativo > tol) && (cont < max_iter) && (fm ~= 0)
        m = (a + b) / 2;           % Punto medio
        fm = f(m);                 % Evaluar la función en el punto medio
        error_relativo = abs(b - a) / 2; % Calcular el error relativo
        
        fprintf(formato_tabla, cont, a, b, m, error_relativo);
        
        % Determinar el nuevo intervalo según el signo de f(m)
        if fa * fm < 0
            b = m;
            fb = fm;
        else
            a = m;
            fa = fm;
        end
        
        cont = cont + 1;
    end

    if cont == max_iter
        fprintf('\nSe alcanzó el número máximo de iteraciones.\n');
    else
        fprintf('\nSe encontró una raíz con la tolerancia especificada.\n');
    end

    % Graficar el punto m
    plot(m, fm, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8); % Punto medio resaltado

    fprintf(['\nLa raíz aproximada es ' formato_resultado '\n'], m);
    fprintf(['Valor de la función en la raíz: f(' formato_resultado ') = ' formato_resultado '\n'], m, fm);
    fprintf('Número de iteraciones: %d\n', cont);
    fprintf(['Error relativo final: ' formato_resultado '\n'], error_relativo);

    hold off;  % Liberar la figura
end
