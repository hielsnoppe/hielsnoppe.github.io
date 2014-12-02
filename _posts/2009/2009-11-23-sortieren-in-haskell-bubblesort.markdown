---
author: nhoppe
comments: true
date: 2009-11-23 13:55:32+00:00
layout: post
slug: sortieren-in-haskell-bubblesort
title: 'Sortieren in Haskell: Bubblesort'
wordpress_id: 27
categories:
- Haskell
tags:
- AlP I
- Bubble
- Bubblesort
- Haskell
---

Ein Klassiker der Sortieralgorithmen:

`
    
    
    bubble :: Ord a => [a] -> [a]
    bubble [] = []
    bubble [x] = [x]
    bubble (x:y:xs)
    	| (x  [a] -> [a]
    bubblesort [] = []
    bubblesort [x] = [x]
    bubblesort xs = bubblesort (init y) ++ [last y]
    	where y = bubble xs
    

`

Informationen zu Laufzeit und Effizienz reiche ich nach.
