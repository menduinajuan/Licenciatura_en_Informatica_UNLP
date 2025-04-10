# DEPENDENCIAS
import numpy as np
import matplotlib.pyplot as plt

# FUNCIÓN DE ROSENBROCK
def function(x, y, a=1, b=100):
    return (a - x)**2 + b * (y - x**2)**2

# GRÁFICO DE LA FUNCIÓN DE ROSENBROCK
x = np.linspace(-2, 2, 400)
y = np.linspace(-1, 3, 400)
X, Y = np.meshgrid(x, y)
Z = function(X, Y)
fig = plt.figure()
ax = fig.add_subplot(111, projection = "3d")
ax.plot_surface(X, Y, Z, cmap = "viridis")
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("f (X, Y)")
ax.scatter(1, 1, function(1, 1), color = "red", label = "Mínimo Global (1, 1)")
ax.text(0, 0, 2500, "Mínimo Global (1, 1)", color = "red")
ax.set_title("Función de Rosenbrock (para a=1 y b=100)")
plt.show()

# GRADIENTE DE LA FUNCIÓN OBJETIVO
def gradient(x, y, a=1, b=100):
    df_dx = 2 * (a - x) * (-1) + 2 * b * (y - x**2) * (-2 * x)
    df_dy = 2 * b * (y - x**2)
    return (np.array([df_dx, df_dy]))

# MÉTODO DE DESCENSO DEL GRADIENTE
def gradient_descent(x_init, eta, tolerance=0.0001, max_iterations=1000):

    x = np.array(x_init)
    f_prev = function(x[0], x[1])

    for iteration in range(max_iterations):

        grad = gradient(x[0], x[1])
        x_new = x - eta * grad
        f_new = function(x_new[0], x_new[1])

        print(f"Iteración {iteration + 1}:")
        print(f"x = {x}")
        print(f"grad = {grad}")
        print(f"x_new = {x_new}")
        print(f"f(x) = {f_prev}")
        print(f"f(x_new) = {f_new}")
        print(f"Δf = {abs(f_new - f_prev)}")
        print()

        if (abs(f_new - f_prev) < tolerance):
            print(f"Convergencia alcanzada en la iteración {iteration + 1} para eta = {eta}")
            print()
            break

        x = x_new
        f_prev = f_new

    else:
        print(f"No se alcanzó la convergencia dentro del número máximo de iteraciones ({max_iterations}) para eta = {eta}")

# PARÁMETROS
tolerance = 0.0001
max_iterations = 1000

# EJERCICIO 3 - TRABAJO PRÁCTICO

x_init = [1.01, 1.01]
eta = 0.005
gradient_descent(x_init, eta, tolerance, max_iterations) # No converge

x_init = [1.01, 1.01]
eta = 0.001
gradient_descent(x_init, eta, tolerance, max_iterations) # Converge