#!/usr/bin/env python3
# -*- coding: utf-8 -*- 
# PAY_EXTRA_B.py
# Integrantes: Francisco Marfull & Daniela Quintana.

# Declaración de variables.
opc = 0
run = ''
resp = ''

# Lista
dptos = [[ piso +1 for piso in range(10)] for tipo in range(4)]
A,B,C,D = [piso for piso in dptos]

# Lista
compradores = list()

# Declaración de módulos.

# Mostrar Depas.
def mapaDepa ():
    print("piso \tTipo")
    print("     A- B- C- D")
    for i in range(9,-1,-1):
        print(f" {i+1:2}  ",end='')
        for j in range(4):
            print(f"{dptos[j][i]}".ljust(3),end='')
        print()

def verificarRun(run):
    if len(run) < 7:
        return "incorrecto"
    run = run.replace('.','')
    if run[-2] == '-':
        run = run[:-2]
    if run.isnumeric():        
        return run
    else:
        return "incorrecto"

def comprarDepartamento (): # opc 1
    piso = 0 # 1 -10
    depa = '' # A - D
    print("Departamentos disponibles:")
    mapaDepa()
    print("\nIngrese piso (1-10)")
    piso = int(input())
    while piso < 1 or piso > 10:
        print("\nReingrese piso (Entre 1 hasta 10): ")
        piso = int(input())
    print("Ingrese departamento (A-B-C-D): ")
    depa = input().upper()
    while depa not in ['A','B','C','D']:
        print("Reingrese departamento (A-B-C-D): ")
        depa = input().upper()
    if dptos[ord(depa)-65][piso-1] == 'X':
        print("Departamento no disponible.")
    else:
        dptos[ord(depa)-65][piso-1] = 'X'
        print("Porfavor, ingrese su run")
        run = input()
        run = verificarRun(run)
        while not run.isnumeric():
                run = input("Error, reingrese run: ")
                run = verificarRun(run)
        run = int(run)

        compradores.append({"run":run, "piso":piso, "depa":depa})

        print("Felicidades a comprado su departamento con exito!")

def mostrarDepartamento (): # opc 2
    print("departamentos disponibles: ")
    mapaDepa()

def verListado(): # opc 3
    if not compradores:
        print("no hay compradores")
    else : 
        print("Listados de compradores")
        for comprador in compradores:
            for datos in comprador:
                print(f"{datos}: {comprador[datos]}", end=' ')
            print()
                
def buscarComprador (): # opc 4
    if compradores:
        print("Buscar comprador")
        print("Ingrese run del comprador:")
        run = input()
        run = verificarRun(run)
        while not run.isnumeric():
            run = input("Error, reingrese run: ")
            run = verificarRun(run)
        run = int(run)
        for comprador in compradores:
            if run == comprador["run"]:
                print(f'RUN encontrado con éxito. piso {comprador["piso"]}, depa {comprador["depa"]}')
                run = "" # Se limpia el RUN para especificar que SI se encontró.
        if run:
            print("No se encontró el run")
    else :
        print("No hay datos")

def reasignarCompra (): # opc 5
    if  not compradores:
        print("No hay compradores")
    else : 
        print("Ingrese run del comprador ")
        run = input()
        run = verificarRun(run)
        while not run.isnumeric():
            run = input("Error, reingrese run: ")
            run = verificarRun(run)
        run = int(run)
        runComprador = run

        run = ''
        print("Ingrese run del cambio") 
        run = input()
        run = verificarRun(run)
        while not run.isnumeric():
            run = input("Error, reingrese run: ")
            run = verificarRun(run)
        run = int(run)
        runCambio = run

        for comprador in compradores:
            if runComprador == comprador["run"]:
                resp = input(f"piso {comprador['piso']}, depa {comprador['depa']}, ¿realizar cambio? s/n: ").upper()
                if resp == 'S':
                    comprador["run"] = runCambio
                    input("¡Departammento reasignado correctamente!")
                    break

        print("Cambio con exito!")


def mostrarGanancias (): # opc 6
    departamentosVendidos= 0
    total= 0
    #Departamentos
    tipoA= 0
    tipoB= 0
    tipoC= 0
    tipoD= 0
    valorAgregado = 0

    recargoA = 0
    recargoB = 0
    recargoC = 0
    recargoD = 0
    
    print("Ganancias:")

    print("Tipo de departamento.", "Cantidad","Total", "Recargo por piso")
    for j in range (4):
        for i in range(10):
            if dptos[j][i] == 'X':
                departamentosVendidos += 1
                if j == 0:
                    tipoA = tipoA + 1
                if j == 1:
                    tipoB = tipoB + 1
                if j == 2:
                    tipoC = tipoC + 1
                if j == 3:
                    tipoD = tipoD + 1
                if i == 0 or i == 1:
                    valorAgregado += 0
                else:
                    valorAgregado += ((i * 100) - 100)
                    if j == 0:
                        recargoA += ((i * 100) - 100)
                    if j == 1:
                        recargoB += ((i * 100) - 100)
                    if j == 2:
                        recargoC += ((i * 100) - 100)
                    if j == 3:
                        recargoD += ((i * 100) - 100)
                        
                
    print("Tipo A".ljust(12), "3800 UF".ljust(7) , str(tipoA).ljust(9), str(3800*tipoA).ljust(10), recargoA)
    print("Tipo B".ljust(12), "3000 UF".ljust(7) , str(tipoB).ljust(9), str(3000*tipoB).ljust(10), recargoB)
    print("Tipo C".ljust(12), "2800 UF".ljust(7) , str(tipoC).ljust(9), str(2800*tipoC).ljust(10), recargoC)
    print("Tipo D".ljust(12), "3500 UF".ljust(7) , str(tipoD).ljust(9), str(3500*tipoD).ljust(10), recargoD)
    totalCantidad = tipoA +tipoB + tipoC + tipoD
    totalUFDepas = (3800 * tipoA) + (3000 * tipoB) + (2800 * tipoC) + (3500 * tipoD)
    totalRecargos = recargoA + recargoB + recargoC + recargoD
    print("TOTAL".ljust(12), " "*7, str(departamentosVendidos).ljust(9), str(totalUFDepas).ljust(10), str(totalRecargos).ljust(7), totalUFDepas + totalRecargos)

while opc != 7:
    # Menu
    print("Sistema de compra de departamentos")
    print("----------------------------------")
    print("1) Comprar departamento")
    print("2) Mostrar departamentos disponibles")
    print("3) Ver listado de compradores")
    print("4) Buscar comprador")
    print("5) Reasignar compra")
    print("6) Mostrar ganacias totales")
    print("7) Salir")

    print("\nIngrese opcion")
    opc=int(input())
    if opc == 1:
        comprarDepartamento()
    elif opc == 2:
        mostrarDepartamento ()
    elif opc == 3:
        verListado ()
    elif opc == 4:
        buscarComprador ()
    elif opc == 5:
        reasignarCompra ()
    elif opc == 6:
        mostrarGanancias ()
    elif opc == 7:
        input("\nprograma finalizado!")
    if opc != 7: 
        input("Presione ENTER para volver al menú principal.")
