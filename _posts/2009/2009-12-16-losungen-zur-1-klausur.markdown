---
author: nhoppe
comments: true
date: 2009-12-16 12:02:18+00:00
layout: post
slug: losungen-zur-1-klausur
title: Lösungen zur 1. Klausur
wordpress_id: 124
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- filter
- foldl
- Haskell
- Klausur
- Lambda-Kalkül
- Quicksort
- Suchbäume
---

Hier meine Lösungen zur ersten Klausur in AlP I, soweit ich sie noch erinnere.
Mit persönlicher Widmung _für Mika_. ;-)

<!-- more -->



### Quicksort


`
    
    
    qsort :: [[a]] -> [[a]]
    qsort [] = []
    qsort [x] = [x]
    qsort (x:xs) = (qsort [y | y <- xs, (length y < length x)])
    	++ [x]
    	++ (qsort [y | y = length x)])
    

`



### Durchschnitt


Funktioniert wegen Typ-Problemen leider nicht. Die Division in der ersten Zeile scheint keine zwei unterschiedlichen Parameter zu akzeptieren.
`
    
    
    durchschnitt :: [Double] -> Double -> Double -> Double
    durchschnitt l a b = (foldl (+) 0 f) / (length f)
    	where
    		f = filter iv l
    		iv :: Double -> Bool
    		iv x = (x >= a) && (x <= b)
    

`



### Baum


`
    
    
    -- a)
    data Ord a => BinTree a = Nil | Node a (BinTree a) (BinTree a)
    	deriving Show
    -- b)
    find :: Ord a => a -> BinTree a -> Bool
    find _ Nil = False
    find x (Node y lft rght)
    	| (x == y) = True
    	| (x  y) = find x rght
    -- c)
    tree2list :: Ord a => BinTree a -> [a]
    tree2list Nil = []
    tree2list (Node x lft rght) = (tree2list lft) ++ [x] ++ (tree2list rght)
    

`



### Wechselgeld


`
    
    
    -- gegeben
    coins :: [Int]
    coins = [50, 20, 10, 5, 2, 1]
    -- gesucht
    change :: Int -> [Int]
    change 0 = []
    change x = coin:(change rest)
    	where
    		coin = maximum (filter (x >=) coins)
    		rest = x - coin
    

`



### Lambda


War Murks, gucke ich mir noch einmal an. :-)
