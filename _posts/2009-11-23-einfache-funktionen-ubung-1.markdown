---
author: nhoppe
comments: true
date: 2009-11-23 13:00:25+00:00
layout: post
slug: einfache-funktionen-ubung-1
title: Einfache Funktionen (Übung 1)
wordpress_id: 5
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- Haskell
- Komplexe Zahlen
- Quadratische Gleichung
---

Bei dieser Übung ging es darum, erste eigene Funktionen zu schreiben und grundlegende Strukturen von Haskell zu üben.

Meine Lösungen zum Download: [uebung1.zip](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/uebung1.zip)

Die **letzte Aufgabe** hatte es ein wenig in sich. Darum stelle ich meinen Lösungsansatz an dieser Stelle noch einmal etwas genauer vor.

<!-- more -->

Gefordert ist die Lösung einer quadratischen Gleichung, von der die Parameter _a_, _b_ und _c_ der Normalenform _0 = ax^{2}+bx+c_ als Parameter an die Funktion übergeben werden.

**Das Problem** liegt darin, dass es nicht immer reelle Lösungen für quadratische Gleichungen gibt. Daher ist der erste Lösungsansatz mittels bekannter p-q-Formel nicht anwendbar. Die Lösung und damit der Rückgabewert der Funktion muss ein Tupel zweier komplexer Zahlen sein.

**Die Lösung** quadratischer Gleichungen mit komplexen Zahlen wird auf der folgenden Seite der Universität Würzburg erklärt: [Komplexe Zahlen als Lösungen quadratischer Gleichungen](http://www.physik.uni-wuerzburg.de/~muellerm/quadrgl/quad.html).

Dieser Lösungsansatz baut auf einer Fallunterscheidung auf. Der Term _d = b^{2} - 4ac_ wird dabei als Diskriminante bezeichnet. Man unterscheidet die Fälle _d \geq 0_ und _d < 0_.

Zur **Umsetzung in Haskell** wird die Berechnung der Diskriminante in eine where-Anweisung ausgelagert. Zusammen mit dem Typsynonym für komplexe Zahlen und der Signatur ergibt sich folgendes Gerüst:

`
    
    
    type Complex = (Double, Double)
    
    quadrat :: Double -> Double -> Double -> (Complex, Complex)
    quadrat a b c
    	| (d >= 0) = ...
    	| otherwise = ...
    	where
    		d = b*b-4*a*c
    

`

Die genaue Berechnung der Werte lässt sich der Übersichtlichkeit halber in die Berechning des Realteils und des Imaginärteils aufteilen, die dann je nach Fall zu den Endergebnissen zusammengefügt werden. Diese Berechnung wird ebenfalls in die where-Anweisung ausgelagert:

`
    
    
    ...
    	where
    		r = (-1) * (b / 2*a)
    		i = sqrt(abs(d)) / (2*a)
    		...
    

`

Für den Fall _d \geq 0_ heißt das, dass Realteil und Imaginärteil addiert (_x_{1}_) beziehungsweise subtrahiert (_x_{2}_) werden, ansonsten werden sie an die jeweilige Stelle der Lösung gesetzt:

`
    
    
    ...
    	| (d >= 0) = ((r+i, 0), (r-i, 0))
    	| otherwise = ((r, i), (r, (-i)))
    ...
    

`
