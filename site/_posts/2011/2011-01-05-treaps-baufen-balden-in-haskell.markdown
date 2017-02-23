---
author: nhoppe
comments: true
date: 2011-01-05 13:44:08+00:00
layout: post
slug: treaps-baufen-balden-in-haskell
title: Treaps / Baufen / Balden in Haskell
wordpress_id: 280
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP III
- Haskell
- Treap
---

Die Datenstruktur des Binären Suchbaumes ist wohl den Meisten bekannt und die des Heaps auch. Die Kombination aus beiden ergibt den Treap (aus Tree und Heap) bzw. Baufen (aus Baum und Haufen), oder auch die Balde (aus Baum und Halde). Jeder Knoten besteht hat dabei einen Schlüssel und eine Priorität. Diese Datenstruktur eignet sich besonders zur Implementierung von Prioritätswarteschlangen.
In einer Übung in Algorithmen und Programmierung III sollten nun Funktionen zum Einfügen in einen und Löschen aus einem Treap entwickelt werden.



<!-- more -->
Dazu schreiben wir drei Funktionen in Haskell: Zum Einfügen `insert`, zum Löschen `delete` und als Hilfsfunktion `rotate`. Sie arbeiten jeweils rekursiv auf der Daten-
struktur des Treaps, die wir wie folgt definieren:
`
    
    
    data (Ord a, Real b) => Treap a b
    	= Nil
    	| Node (a, b) (Treap a b) (Treap a b)
    

`
`insert` fügt ein neues Tupel aus Schlüssel und Priorität in einen Treap ein. Dazu wird es zuerst als neues Blatt wie in einem Binären Suchbaum eingefügt, dann wird der entsprechende Ast rekursiv vom neuen Blatt in Richtung Wurzel so rotiert, dass die Heap-Eigenschaft wiederhergestellt wird.
`
    
    
    insert :: (Ord a, Real b) => (a, b) -> Treap a b -> Treap a b
    -- als neues Blatt einfügen
    insert	tup	Nil		= Node tup Nil Nil
    -- in Richtung der Blätter durch reichen und durch Rotation Struktur reparieren
    insert	(k, p)	(Node (l, q) lft rgt)
    	| k  l			= rotate (Node (l, q) lft (insert (k, p) rgt))
    	| k == l		= Node (k, p) lft rgt
    

`
delete entfernt ein Tupel mit einem gegebenen Schlüssel aus einem Treap. Dazu wird es gesucht, seine Priorität nach und nach vergrößert, so dass es an das Ende des Treaps sinkt und es dann als Blatt gelöscht.
`
    
    
    delete :: (Ord a, Real b) => a -> Treap a b -> Treap a b
    -- Löschen aus einem Blatt
    delete	k	leaf@(Node (l, q) Nil Nil)
    	| k == l	= Nil
    	| otherwise	= leaf
    -- Ist nur ein linkes Kind vorhanden, wird links weiter gesucht, falls der zu
    -- löschende Schlüssel kleiner als der des Knotens ist, sonst wird die Suche
    -- abgebrochen. Wurde der Schlüssel gefunden, wird er gelöscht.
    delete	k	node@(Node (l, q)
    			lft@(Node (m, r) ll lr)
    			Nil
    		)
    	| k  l		= node
    	| otherwise	= rotate (delete k (rotate (Node (l, (r + 1)) lft Nil)))
    -- Ist nur ein rechtes Kind vorhanden, wird rechts weiter gesucht, falls der zu
    -- löschende Schlüssel größer als der des Knotens ist, sonst wird die Suche
    -- abgebrochen. Wurde der Schlüssel gefunden, wird er gelöscht.
    delete	k	node@(Node (l, q)
    			Nil
    			rgt@(Node (n, s) rl rr)
    		)
    	| k  l		= (Node (l, q) Nil (delete k rgt))
    	| otherwise	= rotate (delete k (rotate (Node (l, (s + 1)) Nil rgt)))
    -- Sind ein linkes und ein rechtes Kind vorhanden, wird erst links, dann rechts
    -- weiter gesucht, falls der zu löschende Schlüssel kleiner bzw. größer als der
    -- des Knotens ist. Wurde der Schlüssel gefunden, wird er gelöscht.
    delete	k	(Node (l, q)
    			lft@(Node (m, r) ll lr)
    			rgt@(Node (n, s) rl rr)
    		)
    	| k  l		= (Node (l, q) lft (delete k rgt))
    	| otherwise	= rotate (delete k (rotate (Node (l, (max r s + 1)) lft rgt)))
    

`
rotate rotiert um einen Knoten, um die Heap-Eigenschaft wiederherzustellen. Es wird vorausgesetzt, dass sie nur in einem Teilbaum gestört ist.
`
    
    
    rotate :: (Ord a, Real b) => Treap a b -> Treap a b
    -- An einem Blatt verändert sich Nichts
    rotate	(Node tup Nil Nil)	= Node tup Nil Nil
    -- Ist nur ein linkes Kind vorhanden, wird die Heap-Eigenschaft geprüft und wenn
    -- nötig nach rechts rotiert.
    rotate	(Node (k, p) lft@(Node (l, q) ll lr) Nil)
    	| p > q		= Node (l, q) ll (Node (k, p) lr Nil)
    	| otherwise	= Node (k, p) lft Nil
    -- Ist nur ein rechtes Kind vorhanden, wird die Heap-Eigenschaft geprüft und
    -- wenn nötig nach links rotiert.
    rotate	(Node (k, p) Nil rgt@(Node (m, r) rl rr))
    	| p > r		= Node (m, r) (Node (k, p) Nil rl) rr
    	| otherwise	= Node (k, p) Nil rgt
    -- Sind ein linkes und ein rechtes Kind vorhanden, wird erst links, dann rechts
    -- die Heap-Eigenschaft geprüft und wenn nötig in die entsprechende Richtung
    -- rotiert. Die Heap-Eigenschaft darf nur auf einer Seite nicht gegeben sein!
    rotate	(Node (k, p)
    		lft@(Node (l, q) ll lr)
    		rgt@(Node (m, r) rl rr)
    	)
    	| p > q		= Node (l, q) ll (Node (k, p) lr rgt)
    	| p > r		= Node (m, r) (Node (k, p) lft rl) rr
    	| otherwise	= Node (k, p) lft rgt
    

`
