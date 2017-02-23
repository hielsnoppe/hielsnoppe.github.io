---
author: nhoppe
comments: true
date: 2009-11-23 13:03:32+00:00
layout: post
slug: typsynonyme-mengen-und-bit-register-ubung2
title: Typsynonyme, Mengen und Bit-Register (Übung2)
wordpress_id: 8
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- Haskell
- Mengen
- mengendiff
- mengendifferenz
- schnittmenge
- teilmenge
- vereinigung
---

In der ersten Aufgabe sollte geprüft werden, ob zwei achsenparallele Rechtecke sich überlappen, in der zweiten sollten Bit-Register in Form von Listen aus Nullen und Einsen addiert und multipliziert werden und in der dritten Mengen als Listen von ganzen Zahlen mit den entsprechenden Mengenfunktionen implementiert werden.

Meine Lösungen zum Download: [uebung2.zip](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/uebung2.zip)

Die Mengen bereiteten wenigen Probleme, die ersten beiden Aufgaben dagegen etwas mehr. Daher hier meine Lösungsansätze:





<!-- more -->

Diese Aufgabe hat zwar bei den Meisten funktioniert, die Lösung war aber oft sehr schreibintensiv.
Ich habe anstelle eines riesigen Booleschen Termes versucht, aus den Koordinaten "Muster" zu bauen, die ich dann vergleiche. Mit Mustern meine ich Zeichenketten aus den beiden Buchstaben _A_ und _B_, die für die Position der Kanten zueinander stehen. Zum Beispiel heißt "ABAB", die Rechtecke überlappen, "AABB", die Rechtecke überlappen nicht und "ABBA", das Rechteck _A_ enthält das Rechteck _B_.

Der Datentyp für die Rechtecke sieht bei mir so aus:

`
    
    
    type Point = (Double, Double)
    type Rectangle = (Point, Double, Double)
    

`

Die Funktion "overlap" führt nur den Vergleich der Muster durch:

`
    
    
    overlap :: Rectangle -> Rectangle -> Bool
    overlap a b = not ((x == "AABB" || x == "BBAA") && (y == "AABB" || y = "BBAA"))
    	where (x, y) = coords2list a b
    

`

Nun brauchen wir die Funktion "coords2list", die ein Tupel aus zwei "Mustern" erzeugt. Eines für die x-Koordinate und eines für die y-Koordinate:

`
    
    
    coords2list :: Rectangle -> Rectangle -> ([Char], [Char])
    coords2list ((xa, ya), ba, ha) ((xb, yb), bb, hb) = (xcoords, ycoords)
    ...
    

`

Die Variablen "xcoords" und "ycoords" sind jeweils die beiden Muster. Erzeugt werden sie von der Funktion "sort". Diese nimmt eine Liste von Tupeln aus Zahlenwerten und Buchstaben entgegen und gibt die Buchstaben in der Reihenfolge ihrer zugeordneten Zahlen als Zeichenkette zurück. Daher müssen wir solche Tupel erst einmal erzeugen:

`
    
    
    	where
    		xcoords = sort [(xa, 'A'), ((xa+ba), 'A'), (xb, 'B'), ((xb+bb), 'B')]
    		ycoords = sort [(ya, 'A'), ((ya+ha), 'A'), (yb, 'B'), ((yb+hb), 'B')]
    

`

Die _sort_-Funktion basiert auf Quicksort. Nur, dass sie nicht mit einfachen Zahlen arbeitet, sondern mit Tupeln umgehen muss:

`
    
    
    sort :: [(Double, Char)] -> [Char]
    sort [] = []
    sort ((x, c):xs) =
    	sort [(y,z) | (y,z) <- xs, y < x]
    	++ [c]
    	++ sort [(y,z) | (y,z) = x]
    

`

Den Lösungsansatz zur **zweiten Aufgabe** stelle ich später bereit...
