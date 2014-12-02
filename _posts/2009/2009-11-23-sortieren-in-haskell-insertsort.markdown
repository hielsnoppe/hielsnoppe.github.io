---
author: nhoppe
comments: true
date: 2009-11-23 13:57:41+00:00
layout: post
slug: sortieren-in-haskell-insertsort
title: 'Sortieren in Haskell: Insertsort'
wordpress_id: 29
categories:
- Haskell
tags:
- AlP I
- Haskell
- Insert
- Insertionsort
- Insertsort
---

Ein weiterer Sortieralgorithmus:

`
    
    
    insert :: Ord a => a -> [a] -> [a]
    insert y [] = y:[]
    insert y (x:xs)
    	| (y = x) =  x:(insert y xs)
    
    insertsort :: Ord a => [a] -> [a]
    insertsort [] = []
    insertsort (x:xs) = insert x (insertsort xs)
    

`

Informationen zu Laufzeit und Effizienz reiche ich nach.
