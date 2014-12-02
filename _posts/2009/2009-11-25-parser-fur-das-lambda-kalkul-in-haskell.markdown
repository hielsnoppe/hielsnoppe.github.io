---
author: nhoppe
comments: true
date: 2009-11-25 17:16:39+00:00
layout: post
slug: parser-fur-das-lambda-kalkul-in-haskell
title: Parser für das Lambda-Kalkül in Haskell
wordpress_id: 77
categories:
- Algorithmen und Programmierung
- Haskell
tags:
- AlP I
- Haskell
- Lambda-Kalkül
- Parser
---

An dieser Stelle werde ich den von Frau Prof. Dr. Esponda in der Vorlesung vorgestellten Parser auseinandernehmen.
Ebenfalls interessant ist der [Parser von Herrn Prof. Dr. Rojas](http://www.inf.fu-berlin.de/lehre/SS09/PI02/docs/LambdaExpression.hs), der wohl als Grundlage diente.
Der Code, den ich aus ihren Folien zusammengeschrieben habe, zum Download: [Lambda.hs](http://www.nielshoppe.de/files/downloads/inf/alp1_ws0910/Lambda.hs)

<!-- more -->

Aus der Prelude-Bibliothek werden die beiden Hilfsfunktionen "break" und "span" verwendet.
Die _break_-Funktion spaltet eine Liste beim ersten Vorkommen einer Bedingung in zwei Listen und ist wie folgt definiert:

`
    
    
    break :: (a -> Bool) -> [a] -> ([a],[a])
    break p xs = span p' xs
    	where p' x = not (p x)
    

`

Was die _span_-Funktion so treibt, muss ich noch herausfinden. So jedenfalls sieht sie aus:

`
    
    
    span p [] = ([],[])
    span p xs@(x:xs') -- xs wird als Synonym von (x:xs') verwendet
    	| p x = (x:ys, zs)
    	| otherwise = ([],xs)
    	where (ys, zs) = span p xs'
    

`

An diesem Artikel bin ich gerade dran...
