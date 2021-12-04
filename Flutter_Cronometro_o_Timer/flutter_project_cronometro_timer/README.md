# App Flutter

## _Cronometro e Timer_

Contenuto dell'app:
- main.dart contenente metodo per switchare tra cronometro e timer con una BottomNavBar;
- stopwatch.dart contenente tutte le relative funzioni del cronometro;
- timer.dart contenente tutte le relative funzioni del timer.

## Caratteristiche main.dart

Widget class contenente una navbar che attraverso icone ti fa selezionare la funzinoe desiderata, per una maggiore intuibilità da parte del cliente, inoltre, metodo per switchare tra le HomePage delle due funzioni. Avendo creato la classe in questo modo, sono stato in grado di evitare la creazione di due applicazioni distinte, proprio per rendere l'applicazione il più simile possibile ad un'app android ufficiale.

## Caratteristiche stopwatch.dart

Widget class contenente un cronometro ma con l'aggiunta di personali metodi per poter utilizzare solamente due bottoni al posto di quattro, cos' facendo ho assegnato ad un bottone le tre funzioni _Start_, _Pause_ e _Resume_, mentre all'altro solo la funzione di _Reset_.

## Caratteristiche timer.dart

Widget class contenente bottoni per l'incrementazione e la decrementazione di ore minuti e secondi, per far scegliere direttamente dall'utente quanto far durare il timer. Anche quì ho ottimizzato gli spazzi e abbellito la grafica attraverso l'utilizzo di soli 2 bottoni per le funzioni _Start_, _Pause_, _Resume_ e _Reset_. Ho implementato, inoltre, un metodo il quale, non solo una volta raggiunto lo scadere del timer viene notificato da un DialogWindow, ma rende la scritta in negativo, inverte lo stream per farlo incrementare e non più decrementare e rende la scritta rossa. In tal modo sembra che il timer aumenti in negativo. Ho creato tale funzione in modo tale che, una volta scaduto il timer, l'utente potesse guardare di quanti secondi sforasse il _Reset_ del timer dalla sua effettiva scadenza.