% Método de Gauss-Seidel
% % Método de Jacobi
% Se despeja x1 = (1/a11)(b1 - (a12x2 -+ a13x3)), x2 = (1/a22)(b2 - (a11x1 -+ a13x3)) y x3 = (1/a33)(b3 - (a11x1 -+ a12x2)) 
% Se obtiene x1 y ese valor se remplaza para hallar x2 y esos 2 valores para
% hallar x3
function gauss_seidel()
    % Solicitar la matriz A, el vector b, el vector inicial x0, la tolerancia y el máximo de iteraciones
    A = input('Ingrese la matriz A (ejemplo: [4 -1 0; -1 4 -1; 0 -1 4]): ');
    b = input('Ingrese el vector b (ejemplo: [15; 10; 10]): ');
    x0 = input('Ingrese el vector inicial x0 (ejemplo: [0; 0; 0]): ');
    tol = str2double(input('Ingrese la tolerancia: ', 's'));
    max_iter = str2double(input('Ingrese el número máximo de iteraciones: ', 's'));
    decimales = str2double(input('Ingrese el número de decimales a mostrar: ', 's'));

    n = length(b);
    x = x0;

    fprintf('\nIteración\t   x\n');
    fprintf('------------------------\n');
    
    for k = 1:max_iter
        x_old = x;
        for i = 1:n
            sum = 0;
            for j = 1:n
                if j ~= i
                    sum = sum + A(i, j) * x(j);
                end
            end
            x(i) = (b(i) - sum) / A(i, i);
        end
        
        % Mostrar resultados redondeados
        fprintf('%d\t\t', k);
        fprintf(['%.' num2str(decimales) 'f\t'], x);
        fprintf('\n');
        
        if norm(x - x_old, inf) < tol
            break;
        end
    end
    
    % Mostrar resultado final
    fprintf('La solución aproximada es:\n');
    disp(round(x, decimales));
end