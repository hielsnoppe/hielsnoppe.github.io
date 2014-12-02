---
author: nhoppe
comments: true
date: 2009-11-23 13:54:05+00:00
layout: post
slug: sortieren-in-haskell-quicksort
title: 'Sortieren in Haskell: Quicksort'
wordpress_id: 25
categories:
- Haskell
tags:
- AlP I
- Haskell
- Quicksort
---

Einer der kürzesten Sortieralgorithmen:

`
    
    
    quicksort :: Ord a => [a] -> [a]
    quicksort [] = []
    quicksort (x:xs) =
    	quicksort [y | y <- xs, y < x]
    	++ [x]
    	++ quicksort [y | y = x]
    

`

Informationen zu Laufzeit und Effizienz reiche ich nach.
