! inicijalizacija simulacije
onkp false, x.1, x.1
onkp true, x.1, x.1
kpreg 1.1, r0, x.1
kpreg 1.1, r1, x.2
kpreg 1.1, r2, x.3
kpreg 1.1, r3, x.4
kpreg 1.1, r4, x.5
kpreg 1.1, r5, x.6
kpreg 1.1, r6, x.7
kpreg 1.1, r7, x.8
kpreg 1.1, r8, x.9
kpreg 1.1, r9, x.a
dc x.55, x.3000
! kraj inicijalizacije

! resenje
! glavni program
org x.100

! postavljanje IV tabele
clr r0
mvrir r0, ivtp 		! ivtp = 0
ldimm x.2000, r0
stmem x.1, r0 		! postavljanje vrednosti 2000h u ulaz 1 IV tabele

! ucitavanje sa KP1
ldimm x.1000, r0 		! r0 pokazivac gde treba smestiti ucitan podatak
ldimm x.a, r1		! r1 brojac koliko je jos podataka preostalo
ldimm x.5, r3
stmem x.f100, r3 		! upisivanje vrednosti 5h u kontrolni registar KP1
! ispitivanje biti spremnosti
ldimm x.1, r3 		! maska za proveru bita spremnosti
loop: ldmem x.f101, r4 		! citanje statusnog registra KP1
      and r4, r4, r3 		! provera statusnog bita
	beql loop			! ako je rezultat prethodne and instrukcije 0, znaci da bit spremnosti nije postavljen i ponovo se ispituje
! bit spremnosti je postavljen
	ldmem x.f103, r5		! u r5 se prebacuje podatak sa periferije KP1
	stri [r0], r5		! smesta primljeni podatak u memoriju
	inc r0			! povecava se pokazivac
	dec r1			! povecava se brojac
	bneq loop			! ako nije stigao do nule ima jos podataka za slanje
! iskljucivanje KP1
clr r0
stmem x.f100, r1

! priprema za transfer na KP2
ldimm x.1000, r0		! pokazivac na niz
ldimm x.b, r1		! brojac + 1, jer se na pocetku pr. rut. radi dekrementiranje
clr r2			! r2 semafor
ldimm x.1, r3		! r3 broj ulaza za KP2
stmem x.f202, r3		! slanje broja KP2 u entry registar
ldimm x.e, r3		! vrednost za pokretanje KP2
stmem x.f200, r3		! upis u kontrolni registar KP2

ldimm x.1, r3		! za testiranje semafora
wait:	and r2, r2, r3
	beql wait		! ako je r2 nula jos uvek prenos nije zavrsen

! kraj glavnog programa
halt

! prekidna rutina KP2, nalazi u memoriji od adrese 2000h
org x.2000
dec r1		! smanjivanje brojaca
bneq prenos
stmem x.f200, r1	! iskljucivanje periferike KP2, svi podaci poslati
ldimm x.1, r2	! postavljanje semafora da je sve poslato
jmp back
prenos:
ldrid [r0]x.0, r4 ! element niza u r4
stmem x.f203, r4	! upisavanje elementa u data registar KP2
inc r0		! povecavanje pokazivaca
back:
rti ! izlazak iz pr. rut
