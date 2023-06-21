# AssemblyProj1
Transfer of data between peripheral I/O controllers and CPU
------------------------------------------------------------
ENG
- Write a program that loads a series of data of length Ah from the KP1 peripheral and stores it in memory starting from
from address 1000h, and then sends the loaded string to the peripheral KP2. Loading is realized by examining the ready bit
from status register, and sending using the interrupt mechanism.
At the beginning of the main program, it is necessary to initialize the IV table so that input 1 contains the address
2000h and that input corresponds to the KP2 periphery. Place the IV table in the memory starting from address 0h. The main one
the program starts at address 100h.

SRB
- Napisati program koji sa periferije KP1 učitava niz podataka dužine Ah i smešta u memoriju počev
od adrese 1000h, a zatim učitani niz šalje periferiji KP2. Učitavanje realizovati ispitivanjem bita
spremnosti, a slanje korišćenjem mehanizma prekida.
Potrebno je na početku glavnog programa inicijalizovati IV tabelu tako da se u ulazu 1 nalazi adresa
2000h i taj ulaz odgovara periferiji KP2. IV tabelu smestiti u memoriju počev od adrese 0h. Glavni
program počinje od adrese 100h.
