#!/usr/bin/env python3
# -*- coding: utf-8 -*- 
# PAY_EXTRA_A.py

# Constantes.
maxPasajeros = 198

# List comprehension.
asientos = [[i for i in range(1,33,1)] for j in range (6)]
# Asignación de filas para el Q.A.
F,E,D,C,B,A = [fila for fila in asientos]

# Diccionario para almacenar el run y el asiento reservado.
reservaAsiento = {}

# Variables
opc = 0
i = 0
j = 0
pasajesDisponibles = 198
pasajesSolicitados = 0
runPasajeros = []
run = ""

# Asientos:
comun = 0
piernas = 0
noReclina = 0

def mapaAsientos():
    print("Filas F-E-D\n~| 28° |21°|    11°  |"," "*9,"0°"," "*8,"|"," "*22,"11°"," "*15,"|")
    for j in range(6):
        print(f"{chr(70-j)}|",end="")
        for i in range(32):
            if i < 9:
                if i == 3:
                    print(f" {asientos[j][i]} |",end='')
                else:
                    print(f"{asientos[j][i]}|",end='')
            else:
                print(f"{asientos[j][i]}".rjust(2)+"|", end='')
        if j == 2:
                print("\n!|P|P|P| P |P|C|C|C|C|NR|NR|NR|NR|NR|NR|NR|NR|PP|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|")
                print("\nFilas C-B-A\n~| 28° |21°|    11°  |"," "*9,"0°"," "*8,"|"," "*22,"11°"," "*15,"|",end='')
                
        print()
    print("!|P|P|P| P |P|C|C|C|C|NR|NR|NR|NR|NR|NR|NR|NR|PP|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|AC|")
    print("\n*Donde: P, PP: Espacio adicional para Piernas (valor: $80.000)")
    print(f"{' '*8}C, AC: Asiento Común (valor: $60.000)\n{' '*8}NR: No Reclina (valor: $50.000)\n")
    print("\n**La salida se encuentra por la fila F, entre los asientos 17 & 18.\n")

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

def compraPasaje():
        pasajesSolicitados = 0
        print("Ingrese el número de pasajes que desea comprar.")
        pasajesSolicitados = int(input())
        while pasajesSolicitados<0 or pasajesSolicitados>pasajesDisponibles:
                print(f"Error, la cantidad de pasajes disponibles es de {pasajesDisponibles}.")
                print("Reingrese el número de pasajes que desea comprar.")
                pasajesSolicitados = int(input("...: "))
        for persona in range(pasajesSolicitados):
                print(f"\nElija el asiento para el pasaje N°{persona+1}")
                mapaAsientos()
                fila = input("Ingrese FILA: ").upper()
                while fila not in ['A','B','C','D','E','F']:
                        fila = input("Error, reingrese FILA:").upper()
                print(f"Asientos disponibles en la fila {fila}")
                for disponibilidad in asientos[5-(ord(fila)-65)]:
                        print(disponibilidad, end='|')
                asiento = int(input("\nIngrese número de asiento: ")) 
                while not asiento in asientos[5-(ord(fila)-65)]:
                        asiento = int(input("Asiento no disponible, reintente con otro asiento: "))
                asientos[5-(ord(fila)-65)][asiento-1] = 'x'
                run = input("Ingrese su run: ")
                run = verificarRun(run)
                while not run.isnumeric():
                        run = input("Error, reingrese run: ")
                        run = verificarRun(run)
                run = int(run)
                reservaAsiento.update({(fila+str(asiento)):run})
                print(f"Asiento número {asiento} comprado exitosamente!")
                
def listar():
    print("Listado de pasajeros ordenado por RUN de mayor a menor.")
    print("-------------------------------------------------------")
    if reservaAsiento.values():
        print("RUN")
        print("-------------------------------------------------------")
        runPasajeros = [run for run in reservaAsiento.values()]
        runPasajeros.sort()
        for run in runPasajeros:
            print(run)
    else:
        print("¡No hay pasajeros registrados!")
    print()

def buscar():
    if reservaAsiento.values():
        runPasajeros = [run for run in reservaAsiento.values()]
    else:
        print("¡No hay pasajeros registrados!")
        return False
    run = input("Ingrese el RUN que desea buscar: ")
    run = verificarRun(run)
    while not run.isnumeric():
        run = input("Error, reingrese RUN: ")
        run = verificarRun(run)
    run = int(run)
    if run in runPasajeros:
        print(f"El RUN {run} si se encuentra en la lista de pasajaros.")
    else:
        print(f"No hay coincidencias.")

def reasignar():
    # Se revisa que existan pasajeros registrados.
    if reservaAsiento.values():
        runPasajeros = [run for run in reservaAsiento.values()]
    else:
        print("¡No hay pasajeros registrados!")
        return False
    # Se pide el primer RUN, se valida que esté correcto y que tenga un asiento.
    oldRun = input("Ingrese RUN de la persona que compró el asiento: ")
    oldRun = verificarRun(oldRun)
    while not oldRun.isnumeric():
        oldRun = input("Error, reingrese RUN: ")
        oldRun = verificarRun(oldRun)
    oldRun = int(oldRun)
    if oldRun not in runPasajeros:
        oldRun = input("Error, no existe en la lista.")
        return False
    # Se pide el segundo RUN, se valida que esté bien escrito.
    newRun = input("Ingrese RUN de quien tomará el asiento: ")
    newRun = verificarRun(newRun)
    while not newRun.isnumeric():
        newRun = input("Error, reingrese RUN: ")
        newRun = verificarRun(newRun)
    newRun = int(newRun)
    # Se procede a hacer el cambio de asiento.
    for asiento,run in reservaAsiento.items():
        if run == oldRun:
            resp = input(f"Asiento {asiento}, ¿realizar cambio? s/n: ").upper()
            
            if resp == 'S':
                reservaAsiento[asiento] = newRun
                input("¡Asiento reasignado correctamente!")
                break

def ganancias():
	asientosVendidos = 0
	total = 0
	# Asientos:
	comun = 0
	piernas = 0
	noReclina = 0
	print("Ganancias:")
	print("Tipo de Asiento".ljust(30), "Cantidad ", "Total")
	for fila in range(len(asientos)):
		for asiento in range(len(asientos[fila])):
			if asientos[fila][asiento] == 'x':
				asientosVendidos += 1
				if (asiento > (0-1) and asiento < (6-1)) or asiento == (18-1):
					piernas += 1
				elif (asiento > (5-1) and asiento < (10-1)) or (asiento > (18-1) and asiento < (34-1)):
					comun += 1
				elif (asiento > (9-1) and asiento < (18-1)):
					noReclina += 1
				else:
					print(f"Error en asientos[fila][asiento], [{fila}], [{asiento}],, [{asientos[fila][asiento]}]")
		#print()
	total = 60000*comun + 80000*piernas + 50000 * noReclina
	print("Asiento Común".ljust(21), "$60.000".ljust(8) , str(comun).ljust(9), 60000*comun)
	print("Espacio para piernas".ljust(21), "$80.000".ljust(8) , str(piernas).ljust(9), 80000 * piernas)
	print("No Reclina".ljust(21), "$50.000".ljust(8) , str(noReclina).ljust(9), 50000 * noReclina)
	print(f"TOTAL".ljust(30), str(asientosVendidos).ljust(9), total)

while opc != 7:
        print("Sistema de ventas, Aerolíneas FLASH")
        print("-----------------------------------")
        print("1) Comprar pasajes.")
        print("2) Mostrar ubicaciones disponibles.")
        print("3) Ver listado de pasajeros.")
        print("4) Buscar pasajero.")
        print("5) Reasignar asiento.")
        print("6) Mostrar ganancias totales")
        print("7) Salir")
        print()
        print("Ingrese opción:")
        opc = int(input("...:"))
        if opc == 1:
                compraPasaje()
        elif opc == 2:
                print("Ubicaciones disponibles:")
                mapaAsientos()
        elif opc == 3:
                listar()
        elif opc == 4:
                buscar()
        elif opc == 5:
                reasignar()
        elif opc == 6:
                ganancias()
        elif opc == 7:
                input("\nEjecucion finalizada!")
        if opc != 7:
                input("Tecla ENTER para volver al menú principal.")

