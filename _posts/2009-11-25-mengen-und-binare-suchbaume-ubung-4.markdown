---
author: nhoppe
comments: true
date: 2009-11-25 14:14:48+00:00
layout: post
slug: mengen-und-binare-suchbaume-ubung-4
title: Mengen und Binäre Suchbäume (Übung 4)
wordpress_id: 64
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- Haskell
- Mengen
- Suchbäume
---

Diesmal sollten Mengen als abstrakter Datentyp mit Hilfe von Listen, sowei Binäre Suchbäume als algebraischer Datentyp implementiert werden. Laut Aufgabenstellung sollten die Bäume keine Werte speichern, in unserem Tutorium haben wir uns aber darauf geeinigt, dass es sinnvoller sei, sie mit enthaltenen Daten zu implementieren.

Meine Lösungen zum Download: [uebung4.zip](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/uebung4.zip)

Interessant war der Teil mit den Bäumen, da diese ausbalanciert sein sollten. Meine Strategie, wie man in binäre Suchbäume einfügt, aus ihnen löscht und sie ausbalanciert, stelle ich hier vor:

<!-- more -->

Zuerst einmal das Grundgerüst, der Datentyp:

`
    
    
    data BinTree a = Nil | Node a (BinTree a) (BinTree a)
    	deriving (Show)
    

`

Fangen wir beim Einfachsten an, dem **Einfügen** von Elementen in einen Baum. Dazu wird der einzufügende Wert mit der Wurzel des Baumes verglichen.
Ist er kleiner, so wird in den linken Teilbaum eingefügt, ist er größer, in den rechten. Bei Gleichheit, können wir den Wert ignorieren, da in einem Suchbaum jeder Wert nur einmal vorkommt.
Wenn der Teilbaum, in den wir einfügen wollen, leer ist, wird einfach ein neuer Knoten angehängt, in den der neue Wert geschrieben wird. Sonst führen wir den Vergleich mit der Wurzel des jeweiligen Teilbaumes solange fort, bis wir endlich eine freie Stelle gefunden haben.
Und so sieht das in Haskell aus:

`
    
    
    ins :: Ord a => a -> BinTree a -> BinTree a
    ins x Nil = create x
    ins x (Node y l r)
    	| (x  y) = (Node y l (ins x r))
    	| otherwise = (Node y l r)
    

`

Das **Löschen** ist schon ein wenig schwieriger. Dabei kann es nämlich vorkommen, dass der Knoten, der gelöscht werden soll, noch Unterbäume hat, die nach dem Löschen in der Luft hängen würden. Es muss also ein Ersatz für ihn gefunden werden. Der erste Ansatz, einfach eines seiner "Kinder" aufrücken zu lassen schlägt fehl, denn wohin dann mit dem anderen Kind?
Die Lösung ist, einen sogenannten **symmetrischen Nachfolger** zu suchen. Darunter versteht man entweder den **größten Knoten des kleineren Teilbaumes**, oder den **kleinsten Knoten des größeren Teilbaumes**. Dieser kann nun problemlos an Stelle des gelöschten Knoten treten, muss aber noch aus seinem vorherigen Platz gelöscht werden, wobei es wieder zu einem kleinen Gerangel um die Erbfolge kommen kann.
In Haskell sieht das dann also so aus:

`
    
    
    del :: Ord a => a -> BinTree a -> BinTree a
    del x Nil = Nil
    del x (Node y Nil Nil)
    	| (x == y) = Nil			-- Blatt entfernen
    	| otherwise = (Node y Nil Nil)		-- Nichts entfernen
    del x (Node y l r)
    	| (x  y) = Node y l (del x r)		-- Aus rechtem Teilbaum entfernen
    	| empty l = Node syml Nil (del syml r)	-- Aus Knoten entfernen
    	| empty r = Node symr (del symr l) Nil	--	-	"	-
    	| otherwise = Node symr (del symr l) r	--		"
    	where
    		syml = sml r
    		symr = big l
    

`

Man sieht dabei, dass die Funktionen _sml_ und _big_ noch zu definieren sind. Wer das nicht schafft, kann sich ja den Quellcode herunterladen. Außerdem wird noch über Guards abgefangen, dass auch nur einer von beiden Teilbäumen leer sein kann. Dann darf man natürlich nicht versuchen, in dem leeren Teilbaum ein kleinstes oder größtes Element zu suchen...

Nun aber zum richtig spannenden Teil, dem **Balancieren**.
Dazu soll es eine Funktion "balanced" geben, die prüft, ob ein Baum balanciert ist und eine Funktion "balance", die einen Baum ausbalanciert. Diese kann dann auch von jeder Einfüge- oder Lösch-Operation aufgerufen werden, so dass Bäume immer ausbalanciert bleiben.
Die Funktion "balanced" lässt sich wir folgt definieren:

`
    
    
    balanced :: BinTree a -> Bool
    balanced (Node _ l r) = abs((depth l) - (depth r)) < 2
    

`

Beim nachträglichen Balancieren von Bäumen muss man verschiedene Fälle berücksichtigen. Zum Verständnis hilft der [Artikel zum AVL-Baum](http://de.wikipedia.org/wiki/AVL-Baum#Rebalancierung) in Wikipedia.
Die _balance_-Funktion selbst prüft erst einmal die Struktur des Baumes. Ist er zum Beispiel **leer**, so muss auch nicht balanciert werden.

`
    
    
    balance :: BinTree a -> BinTree a
    balance Nil = Nil
    ...
    

`

Ist er **bereits ausbalanciert**, muss rekursiv geprüft werden, dass auch seine Teilbäume balanciert sind.

`
    
    
    ...
    balance (Node x l r)
    	| balanced (Node x l r) = Node x (balance l) (balance r)
    	...
    

`

Ist er **keines von beidem**, so greift die wirkliche Routine zum Balancieren:

`
    
    
    ...
    	| (dl  dr) = balance (rrotate (Node x (balance l) (balance r)))
    	where
    		dl = depth l
    		dr = depth r
    

`

Je nach dem, ob nun der linke, oder der rechte Teilbaum "schwerer" ist, wird um die Wurzel rechts, oder links herum rotiert.
Das links (rechts) herum **Rotieren**, kann man sich so vorstellen, als würde der rechte (linke) Teilbaum an der Wurzel gepackt und hochgezogen. Alle mit ihm verbundenen Elemente fallen dann nach unten.
Ein Problem tritt aber immer dann auf, wenn er selbst bereits zwei Kind-Knoten hat. Dann nämlich hätte er nun drei und das ist in einem binären Suchbaum nicht erlaubt. Also muss für diesen Fall die Doppelrotation angewandt werden (s.o., Wikipedia).

Rotation folgt...
