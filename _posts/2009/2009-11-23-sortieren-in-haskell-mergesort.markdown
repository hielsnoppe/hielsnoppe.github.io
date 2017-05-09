---
author: nhoppe
comments: true
date: 2009-11-23 13:59:07+00:00
layout: post
slug: sortieren-in-haskell-mergesort
title: 'Sortieren in Haskell: Mergesort'
wordpress_id: 31
categories:
- Haskell
tags:
- AlP I
- Haskell
- merge
- Mergesort
---

Ein weiterer Sortieralgorithmus:

`
    
    
    merge :: Ord a => [a] -> [a] -> [a]
    merge [] ys = ys
    merge xs [] = xs
    merge (x:xs) (y:ys)
    	| (x  [a] -> [a]
    mergesort [] = []
    mergesort [x] = [x]
    mergesort xs = merge (mergesort ls) (mergesort rs)
    	where
    		ls = take h xs
    		rs = drop h xs
    		n = length xs
    		h = div n 2
    

`

Informationen zu Laufzeit und Effizienz reiche ich nach.
