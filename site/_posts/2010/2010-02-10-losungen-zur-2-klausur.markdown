---
author: nhoppe
comments: true
date: 2010-02-10 12:42:53+00:00
layout: post
slug: losungen-zur-2-klausur
title: Lösungen zur 2. Klausur
wordpress_id: 152
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- Haskell
- Klausur
- Kombinatorische Logik
- Komplexitätsanalyse
- Lambda-Kalkül
- Primitive Rekursion
- Registermaschine
- SKI
- strukturelle Induktion
- Turingmaschine
- Zweierkomplement
---

Hier meine Lösungen zur zweiten Lösung in AlP I, soweit ich sie noch erinnere.
Im Augenblick schreibe ich noch daran...





<!-- more -->



### Lambda-Kalkül und Kombinatorische Logik



Es soll gezeigt werden, dass gilt:

    
    λx.y(xy) = S (Ky) (S I (Ky))



Gleichheit wird durch Umformung des Lambda-Ausdruckes in einen Ausdruck der Kombinatorischen Logik gezeigt:

    
    [elim x] (y(xy))
    S ([elim x] y) ([elim x] (xy))
    S (Ky) (S ([elim x] x) ([elim x] y))
    S (Ky) (S I (Ky))
    





### Registermaschine




    
    
    CMPL C =		CLR T1
    		loop:	INC C
    			BRZ C end
    			INC T1
    			GOTO loop
    		end:	MOVE T1 C
    





### Turingmaschine





### Strukturelle Induktion



Behauptung: length (filter p xs) <= length xs
Definitionen:
`
    
    
    filter p [] = []				filter.1
    filter p (x:xs) = if p x then x:ys else ys	filter.2
    	where
    		ys = filter p xs
    

`

**Induktionsanker**


    
    
    xs := []
    length (filter p [])	<= length []	 filter.1
    length []		<= length []
    



**Induktionsvoraussetzung**

Bis zu einem xs beliebiger aber fester Länge gilt die Behauptung length (filter p xs)	<= length xs.

**Induktionsschritt**


    
    
    xs -> (x:xs)
    length (filter p (x:xs))	<= length (x:xs)	 filter.2
    



Fallunterscheidung

1. Fall: p x == True

    
    
    length (x:(filter p xs))	<= length (x:xs)
    


Nach IV gilt filter p xs <= length xs. Da auf beiden Seiten genau ein Element hinzukommt, gilt die Ungleichung weiterhin.

2. Fall: p x == False

    
    
    length (filter p xs)		<= length (x:xs)
    


Nach IV gilt filter p xs <= length xs. Da nur auf der größeren Seite genau ein Element hinzukommt, gilt die Ungleichung weiterhin.

QED.



### Komplexitätsanalyse



Definitionen:
`
    
    
    data Menge a = Menge [a]
    
    insertSet x (Menge m)
    	| inSet x (Menge m) = Menge m
    	| otherwise = Menge (x:m)
    
    union (Menge []) m = Menge m
    union (Menge (x:xs)) m = insertSet x (union (Menge xs) m)
    
    subSet _ (Menge []) = False
    subSet (Menge []) _ = True
    subSet (Menge (x:xs)) m = (inSet x m) && (subSet (Menge xs) m)
    

`

insertSet: O(n)
union: O(n²)
subSet O(n²)



### Primitive Rekursion



Hat das jemand? Freue mich über einen Kommentar!
