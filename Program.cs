using System;
using System.Threading;

string data1 = Environment.GetEnvironmentVariable("data1");
string data2 = Environment.GetEnvironmentVariable("data2");
// Console.WriteLine($"Database Connection: {dbConnection}");

Calculadora calc = new Calculadora();
int resultado = calc.Soma(1, 2);
int resultado = calc.Soma(data1, data2);
Console.WriteLine("Resultado da soma: " + resultado);

Thread.Sleep(200000);

