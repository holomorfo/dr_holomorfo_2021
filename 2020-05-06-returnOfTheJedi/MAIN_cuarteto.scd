/*****************************
Formato para cuarteto de cuerdas
Cristian Bañuelos
Marzo, 2016

La idea de este programa es que puedan improvisar en vivo
y todo se guarde automáticamente en una partitura que se
exporta a fomus. Deben tener instalada la versión de SuperFomus
editada que les adjunto.
*/
MIDIClient.init;

(
// Aquí eligen el dispositivo midi a usar
~mid = MIDIOut(0);
// Para partitura poner los instrumentos de arriba
// hacia abajo
// Para ver los instrumentos reconocidos por fomus
// abrir el archivo adjunto "FomusInstruments.txt"
// Pueden poner mas o menos, y cada uno se identifica
// en su pdef con el número en el arreglo
// violin: 0, viola: 1, etc... o como ustedes los
// acomoden.
~instrumentos = [\violin,\viola,\cello,\contrabass];
)

//================================================
// para cambiar el tempo
~t.tempo=4;
// para callar todas las notas si se queda una colgada
16.do({|i|~mid.allNotesOff(i);})
//================================================


// Deben correr esta linea cada que quieran iniciar a grabar
// todo lo que graben se pondrá ya acomodado en la partitura
// De momento lo hace sólo en 4/4
("f_pdefs.scd").loadRelative;
//***********************************************
// Corran cada grupito a la vez
// pueden modificar cada parte independiente ya sea
// duración o notas, sin afectar a los demás

//Example 2
u=UniversoTonal();
~str=
"C,m:  I V7/VI VI V VI II II7 IV VII7 I
E,m: V7 I IV V7/V I
C,m: V7/V V7 I
";
~chords=u.getListaArmonias(~str);
~arrayNotes=~chords.collect({arg ar; ar.notasArmonia[0..3]});

Pdef(\0).stop
Pdef(\0).play(~t);// Violin
~notas[0].source =Pseq(2+[1,3,0,3,7,9].reverse-3,inf).trace;
~durs[0].source =Pseq([0.5],inf);
~amps[0].source = Pbrown(0.1,1,0.1,inf);

Pdef(\1).stop;// Viola
Pdef(\1).play(~t);// Viola
~notas[1].source =Pseq([0,2,3,7,3,9]-12,inf).trace;
~durs[1].source =Pseq([0.25],inf);
~amps[1].source = Pbrown(0.1,1,0.1,inf);

Pdef(\2).stop
Pdef(\2).play(~t);// Chello
~notas[2].source =Pbrown(36-60,76-60,5,inf).trace;
~durs[2].source =Pseq([1],inf);
~amps[2].source = Pbrown(0.1,1,0.1,inf);

Pdef(\3).stop
Pdef(\3).play(~t);// Contabajo
~notas[3].source =Pbrown(28-60,67-60,1,inf).trace;
~durs[3].source =Pseq([2],inf);
~amps[3].source = Pbrown(0.1,1,0.1,inf);


// Aquí para terminar cada línea
Pdef(\0).stop;
Pdef(\1).stop;
Pdef(\2).stop;
Pdef(\3).stop;

//*****************************************
// Crear la partitura
// Deben tener instalada la extensión fomus que les mando aqui
// La modifiqué para que automáticamente
("f_fomus.scd").loadRelative;
