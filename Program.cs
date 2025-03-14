using System;
using System.Threading;

string soma1 = Environment.GetEnvironmentVariable("SOMA_DATA1");
string soma2 = Environment.GetEnvironmentVariable("SOMA_DATA2");
Console.WriteLine($"Database Connection: {dbConnection}");

Calculadora calc = new Calculadora();
int resultado = calc.Soma(soma1, soma2);
Console.WriteLine("Resultado da soma: " + resultado);

Thread.Sleep(200000);

