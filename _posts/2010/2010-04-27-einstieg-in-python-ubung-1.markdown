---
author: nhoppe
comments: true
date: 2010-04-27 07:48:47+00:00
layout: post
slug: einstieg-in-python-ubung-1
title: Einstieg in Python (Übung 1)
wordpress_id: 187
categories:
- Algorithmen und Programmierung
- Python
tags:
- AlP II
- math
- Matrix
- Matrizenmultiplikation
- Python
- Randomwalker
- Summe
---

Meine Lösungen zum Download: [uebung1.zip](http://www.nielshoppe.de/files/downloads/inf/alp2_ss2010/uebung1.zip)

Und ein paar kleine Kommentare dazu, die sich auch aus der heutigen Nachbesprechung ergaben:

<!-- more -->



### 1. Aufgabe: Wochentage



Hier war besonders zu beachten, dass die ganzzahlige Division (`//`) anstelle der normalen Division (`/`) verwendet werden musste.

`
    
    
    def wochentag(d, m, y, output=True):
    	"""
    		Gibt den Wochentag eines Datums zurueck.
    		Der optionale Parameter `output' kann standardmaessig auf `False' gesetzt werden, um die Ausgabe zu unterdruecken.
    	"""
    	yn = y - (14 - m) // 12
    	x = yn + yn // 4 - yn // 100 + yn // 400
    	mn = m + 12 * ((14 - m) // 12) - 2
    	dn = (d + x + (31 * mn) // 12) % 7
    	days = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"]
    	if(output):
    		print("Der "+str(d)+"."+str(m)+"."+str(y)+" ist ein "+days[dn]+".")
    	return dn
    

`



### 2. Aufgabe: Reihensumme



Der Knackpunkt hier lag - jedenfalls bei mir - darin, dass die Funktion `range(n)` eine Liste von 0 bis n-1 erzeugt. Zu Verwenden war also `range(1, n+1)`.

`
    
    
    def reihensumme(n):
    	"""
    		Berechnet die Reihensumme gemaess Aufgabenblatt.
    		Fuer n -> \infinity: reihensumme(n) -> 0.425841128...
    	"""
    	import math
    	result = 0
    	for i in range(1, n+1):
    		result += (math.sin(i*math.pi/2)/(i*i+1))
    	return result
    

`



### 3. Aufgabe: Matrizenmultiplikation



Später.



### 4. Aufgabe: Randomwalker



Auch.
