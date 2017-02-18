---
author: nhoppe
comments: true
date: 2010-11-20 11:27:50+00:00
layout: post
slug: die-turme-von-hanoi
title: Die Türme von Hanoi
wordpress_id: 273
categories:
- Algorithmen und Programmierung
tags:
- AlP III
- Java
- Türme von Hanoi
---

Zum Testen verschiedener Algorithmen und Spielregeln für die [Türme von Hanoi](http://de.wikipedia.org/wiki/T%C3%BCrme_von_Hanoi) habe ich eine Java-Klasse "Tower" geschrieben. Sie überprüft bei jeder push()-Operation, dass sie die Spielregeln einhält und zählt sie für eine spätere Analyse mit.

`
    
    
    public class Tower extends Stack {
    	private static int pushes = 0;
    	private Type t;
    	public static enum Type {
    		HANOI,
    		HOLLYWOOD
    	}
    // ...
    	public static int getPushes() {
    		return pushes;
    	}
    	public static void resetPushes() {
    		pushes = 0;
    	}
    	public Integer push(Integer item) {
    // ...
    	}
    }
    

`

Sie kann hier zusammen mit einer Implementierung des Lösung für die Türme von Hanoi heruntergeladen werden:
[tuerme_von_hanoi_java.zip](http://inf.nielshoppe.de/wp-content/uploads/2010/11/tuerme_von_hanoi_java.zip)
Neben der üblichen Spielvariante gibt es auch Varianten der Spielregeln, zum Beispiel, dass zwischenzeitlich die Reihenfolge der Scheiben egal ist, sofern alle Scheiben eines Stapels kleiner sind, als die Unterste. Eine rekursive Lösung dafür ist ebenfalls enthalten. Sie benötigt für 100 Scheiben 10100 Züge. Ich würde mich freuen, wenn jemand einen schnelleren Algorithmus (rekursiv oder iterativ) findet und ihn mir schickt!
