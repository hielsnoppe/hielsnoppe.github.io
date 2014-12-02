---
author: nhoppe
comments: true
date: 2010-05-12 15:27:51+00:00
layout: post
slug: suchen-in-python-ubung-2
title: Suchen in Python (Übung 2)
wordpress_id: 196
categories:
- Algorithmen und Programmierung
- Python
tags:
- AlP II
- Binärsuche
- Geburtstagsparadoxon
- Listen
- Mersenne-Zahlen
- Python
---

Meine Lösungen zum Download: [uebung2.zip](http://www.nielshoppe.de/files/downloads/inf/alp2_ss2010/uebung2.zip)

Und ein kurzer Hinweis zu Listen, der sich heute im Tutorium ergab: Da die Parameter von Funktionen "by reference" übergeben werden, macht man mit "pop" oder "append" schnell mal etwas kaputt. Schnelle Abhilfe schafft da das Kopieren der Liste mittels des Slice-Operators:

`
    
    
    def example_sort(lst):
        lst = lst[:]
        # ...
        return lst
    

`
