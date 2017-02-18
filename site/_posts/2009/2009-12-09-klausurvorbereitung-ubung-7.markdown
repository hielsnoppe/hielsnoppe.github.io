---
author: nhoppe
comments: true
date: 2009-12-09 17:55:19+00:00
layout: post
slug: klausurvorbereitung-ubung-7
title: Klausurvorbereitung (Übung 7)
wordpress_id: 104
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- Bubble
- Bubblesort
- foldl
- foldr
- Haskell
- Klausur
- Lambda-Kalkül
- map
- mapTree
- Permutationen
- Primzahlen
- Sieb des Eratosthenes
- sieve
- Suchbäume
---

In unserem Tutorium haben wir es leider nicht geschafft, den umfangreichen Übungszettel ganz durchzusprechen. Wenn sich jemand berufen fühlt, ein paar Lösungen zu erklären, würde ich mich über einen Kommentar freuen.

Meine Lösungen zum Download:




  * Listen und Sortieralgorithmen: [uebung7LST.zip](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/uebung7LST.zip)


  * Algebraische Datenstrukturen (1.): [uebung7ALG1.hs](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/uebung7ALG1.hs)


  * Abstrakte Datentypen: [uebung7ADT.zip](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/uebung7ADT.zip)



Und hier ein paar Erklärungen:





<!-- more -->



### Listen und Sortieralgorithmen



Diese Lösung folgt dem Ansatz aus unserem Tutorium. Die Funktion "goldbach" findet ein Tupel aus zwei Primzahlen, deren Summe der erste Parameter der Funktion ist. Es muss aber noch eine Liste mit allen Primzahlen bis zu dieser Zahl mitgegeben werden. Das sollte vielleicht noch mit einer Hilfsfunktion vermieden werden. Diese Liste wird durch die Funktion "primes" erzeugt, die wiederum die Funktion "sieve" verwendet, die nach dem Prinzip des [Sieb des Eratosthenes](http://de.wikipedia.org/wiki/Sieb_des_Eratosthenes) Primzahlen erzeugt. Und so sieht sie aus:

`
    
    
    sieve :: [Int] -> [Int]
    sieve [] = []
    sieve (x:xs) = x:(sieve [y | y  0])
    

`

Zuerst nimmt die Funktion das erste Element der Liste. Dieses muss eine Primzahl sein, daher wird _sieve_ immer mit einer bei 2 beginnenden Liste aufgerufen. Daran wird rekursiv die gesiebte Liste all derer Elemente angehängt, die kein Vielfaches dieses Elementes sind.

Die Funktion "goldbach" schnappt sich nun all diese Primzahlen und geht die Liste rekursiv durch. Wenn die Differenz der mitgegebenen Zahl n und einem Element aus den Primzahlen wieder eine Primzahl ist, haben wir die beiden gesuchten Zahlen gefunden. Und so sieht das dann aus:

`
    
    
    goldbach :: Int -> [Int] -> (Int, Int)
    goldbach n (p:ps)
    	| (n  0) = error "Nur gerade Zahlen groesser 2!"
    	| (elem (n-p) (p:ps)) = ((n-p), p)
    	| otherwise = goldbach n ps
    

`

In der nächsten Aufgabe sollten alle **Permutationen einer Liste** erzeugt werden.
In der Vorlesung hat Frau Esponda eine kürzere Variante gezeigt, die aber nach dem gleichen Prinzip funktioniert, wie diese hier.
Mit foldl (++) werden die verschiedenen Permutationen zu einer Liste von Listen zusammengefügt.
In der Klammer, also als Liste, die durch fold (++) zusammengefaltet wird, wird die Unterfunktion sub auf alle Elemente der eingegebenen Liste mit map angewendet. Das erste Argument für sub ist ebenfalls die eingegebene Liste.
Die Unterfunktion sub nimmt jeweils das Element, das sie als zweites Argument bekommt, als erstes Element einer neuen Liste und fügt danach alle Permutationen der Liste an, die aus der eingegebenen Liste ohne das erste Element erzeugt werden können. Hier kommt die Rekursion ins Spiel.

`
    
    
    perm :: Eq a => [a] -> [[a]]
    perm [] = [[]]
    perm [e] = [[e]]
    perm l = foldl (++) [] (map (sub (l)) l) where
    	sub :: Eq a => [a] -> a -> [[a]]
    	sub l e = [e:y | y <- (perm (delete e l))]
    

`



### Typ-Klassen





### Algebraische Datentypen



In meiner Implementierung gibt es keine leeren Bäume. Zur Datenspeicherung sind solche aber auch unnütz.

`
    
    
    data Eq a => ABaum a = Node a [ABaum a]
    	deriving Show
    

`

Um die Kinder zu zählen, verwende ich die Funktion foldr (+). Sie addiert den Startwert length c, also die Anzahl der direkten Kinder, und die Anzahl aller Kinder der direkten Kinder. Diese ergibt sich durch die rekursive Anwendung von children mittels map auf alle direkten Kinder.

`
    
    
    children :: Eq a => ABaum a -> Int
    children (Node _ c) = (foldr (+) (length c) (map children c))
    

`

Die Tiefe eines Baumes ist die größte Tiefe eines seiner Unterbäume plus 1.

`
    
    
    depth :: Eq a => ABaum a -> Int
    depth (Node _ []) = 1
    depth (Node _ c) = 1 + maximum (map depth c)
    

`

Was find genau tun soll, weiß ich nicht. Ich gehe davon aus, es soll überprüfen, ob ein Wert in einem Baum enthalten ist. Man könnte sich aber auch vorstellen, dass ein Pfad zum Knoten, der den Wert enthält, zurückgegeben werden soll. Idee dazu? Kommentar!
Meine Lösung wendet find rekursiv mittels map auf alle Unterbäume an und faltet das Ergebnis mit foldr (||) zusammen. Das ergibt eine große Disjunktion, die wahr wird, wenn das Element in mindestens einem Unterbaum enthalten ist. Als Startwert gebe ich (x == y) mit, damit auch berücksichtigt wird, dass der Wert im Knoten selbst und nicht in einem Unterbaum enthalten ist.

`
    
    
    find :: Eq a => a -> ABaum a -> Bool
    find x (Node y c) = (foldr (||) (x == y) (map (find x) c))
    

`

Dadurch, dass die Kinder in einer Liste gespeichert werden, können wir eine Funktion einfach auf den Wert des aktuellen Knotens anwenden und danach mit map rekursiv auf alle Unterbäume.

`
    
    
    mapTree :: Eq a => Eq b => (a -> b) -> ABaum a -> ABaum b
    mapTree f (Node x c) = Node (f x) (map (mapTree f) c)
    

`



### Funktionen höherer Ordnung



Mit herzlichem Dank an Pawel, hier ein Vorschlag für die foldTree-Funktion für die Binärbäume aus der Vorlesung.

`
    
    
    data BinTree = L Int | N Int BinTree BinTree
    	deriving Show
    
    foldTree :: (Int -> Int -> Int) -> Int -> BinTree -> Int
    foldTree f n tree = foldr f n (tree2List tree)
    
    tree2List :: BinTree -> [Int]
    tree2List (L y) = [y]
    tree2List (N n links rechts) = [n] ++ (tree2List links) ++ (tree2List rechts)
    
    mapTree :: (Int -> Int) -> BinTree -> BinTree
    mapTree f (L n) = (L(f n))
    mapTree f (N k links rechts) = (N(f k)(mapTree f links)(mapTree f rechts))
    

`



### Abstrakte Datentypen



Und mein Vorschlag für den Speicher.
Zuerst einmal ein Modul zum Testen, das das eigentliche Modul lädt. Sonst wäre es ja nicht abstrakt...

`
    
    
    module U7ADT1 () where
    import Memory (meminit, store, load, delete, ma, mb, mc, md, me)
    

`

Und dann das eigentliche Modul. Bei mir ist der Speicher eine Liste von Speicherzellen, die jeweils einen Wert und eine Adresse haben.

`
    
    
    module Memory (meminit, store, load, delete, ma, mb, mc, md, me) where
    
    type Cell a = (a, Int)
    type Memory a = [(Cell a)]
    

`

Ein leerer Speicher ist eine leere Liste.

`
    
    
    meminit :: Memory a
    meminit = []
    

`

An einer festgelegten Stelle gespeichert wird, indem alle Zellen durchlaufen werden, bis die richtige gefunden wurde. Diese wird dann überschrieben. Wenn es noch keine Zelle mit der angegebenen Adresse gibt, wird eine neue eingefügt.

`
store :: a -> Int -> Memory a -> Memory a
store val add [] = [(val, add)]
store val adda (c@(_, addb):cs)
	| (adda == addb) = (val, adda):cs
	| otherwise = c:(store val adda cs)


`

Wenn man sich keine Gedanken über den Speicherort machen will, kann man mit push einen Wert in den Speicher einfügen. Das Ergebnis ist ein Tupel aus dem Speicher an zweiter Stelle und der neuen Adresse für den gerade gespeicherten Wert. Natürlich muss für diesen Vorgang erst einmal herausgefunden werden, welche Adresse gerade frei ist. Dafür gibt es freeadd.

`
push :: a -> Memory a -> (Int, Memory a)
push val mem = (add, mem ++ [(val, add)]) where
	add = freeadd mem


`

Geladen wird ein Wert aus einer Speicherzelle, indem alle Zellen durchlaufen werden, bis die gewünschte gefunden wurde. Wenn keine Zelle die gesuchte Adresse hat, gibt es einen Fehler.

`
load :: Int -> Memory a -> a
load _ [] = error "Address does not exist."
load adda ((val, addb):cs)
	| (adda == addb) = val
	| otherwise = load adda cs


`

Löschen geht fast wie Speichern.

`
delete :: Int -> Memory a -> Memory a
delete _ [] = []
delete adda (c@(_, addb):cs)
	| (adda == addb) = cs
	| otherwise = c:(delete adda cs)


`

Um eine freie Adresse zu finden, wird die größte bisher vorhandene Adresse um 1 hochgezählt.

`
freeadd :: Memory a -> Int
freeadd [] = 1
freeadd mem = (maximum (listadds mem)) + 1


`

Diese Funktion gibt eine Liste aller Adressen zurück.

`
listadds :: Memory a -> [Int]
listadds [] = []
listadds ((_, add):cs) = add:(listadds cs)


`



### Lambda-Kalkül





### Kombinatoren und Registermaschinen


Kommen nicht in der Klausur dran!
