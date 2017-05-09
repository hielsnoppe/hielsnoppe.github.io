---
author: hielsnoppe
comments: true
date: 2012-09-27 11:19:12+00:00
layout: post
slug: first-steps-with-mutt
title: First steps with mutt
wordpress_id: 496
categories:
- Computer
tags:
- Mutt
- Newsbeuter
- Taskwarrior
---

Since I discovered [task](http://taskwarrior.org) to be one of the most useful and in fact usable applications I tend to look for command line solutions to more and more of my daily tasks. First came [newsbeuter](http://newsbeuter.org/), a newsreader that can sync with your Google Reader account and is advertised as "the mutt of newsreaders". Consequently I had to check out [mutt](http://www.mutt.org/), an e-mail client for the shell. It is supposed to suck - as all mail clients do, according to the author of it - but less than the rest of them. And I guess if you get the hang of it this is true. For beginners there is a [newbie guide](http://wiki.mutt.org/index.cgi?MuttGuide) in the wiki, but as it turns out, there are some discrepancies between their idea of a newbie and what is to be found between my keyboard and chair. So for those who like me want to get started quickly without (yet) diving deep into configuration, here is how I got things going.





<!-- more -->

My prerequisites include Ubuntu 12.04. Desktop and an external mail server so I do not have installed (or at least not configured) anything like a postfix, sendmail, etc.. I wanted to use IMAP and no local storage and send my e-mail via SMTP just as I am used to with Thunderbird. Here are the steps I have taken, not mentioning the many detours.



	
  1. First I installed mutt using the Ubuntu Software Center.

	
  2. Second I created the file "~/.muttrc" and the folder "~/.mutt/".

	
  3. Next I got me "[sendmail.py](http://www.ynform.org/w/Pub/SendmailPy)" and placed it at "~/.mutt/sendmail.py". In my environment it was necessary to change the first line as follows:

    
    #! /bin/env python # original
    #! /usr/bin/python # mine




	
  4. Next I set up "~/.muttrc" to yield about the following (note that there is an absolute path at the end):

    
    set realname = "My Name"
    set from = "my.name@example.org"
    
    set spoolfile = "imaps://my-username@imap.example.org/"
    set folder = "imaps://my-username@imap.example.org/"
    
    set mbox = "+INBOX"
    set record = "+Sent"
    set postponed = "+Drafts"
    
    set sendmail = "~/.mutt/sendmail.py -t smtp.example.org -l my-username -p /home/me/.mutt/passfile"




	
  5. Finally I created the file "~/.mutt/passfile" with:

    
    me@mypc:~$ echo -n "my-email-password" > .mutt/passfile





At least for me this is all it took to get mutt up and running. Start mutt by typing "mutt" in the console and hit enter and refer to the [documentation](http://www.mutt.org/#doc) on how to use it. I am sure there are a lot more options how to do things better or just differently but for me these are yet to be discovered. Feel free to leave a comment if this was any use to you.
