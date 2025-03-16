using System;
using System.Threading;

int data1 = int.Parse(Environment.GetEnvironmentVariable("data1"));
int data2 = int.Parse(Environment.GetEnvironmentVariable("data2"));

Console.WriteLine("Data 1: " + data1);
Console.WriteLine("Data 2: " + data2);

Calculadora calc = new Calculadora();
//int resultado = calc.Soma(1, 2);
int resultado = calc.Soma(data1, data2);
Console.WriteLine("Resultado da soma: " + resultado);

Thread.Sleep(200000);

