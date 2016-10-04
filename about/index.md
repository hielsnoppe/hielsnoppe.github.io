---
layout: page
title: About
---

My name is Niels and I work, study, [dance](/about/dance), live in Berlin, where I was born in 1991.
Find a kind of resume and curriculum vitae in the following.
{% include cv-show-hide-text.html %}
Feel free to [contact me](/contact) if you like.

<p class="small">A note for recruiters: I am open to being contacted, but please be aware that I am currently a student, employed and quite happy with my job.</p>

## Education

{% for item in site.data.cv.hasEducation.hasEducation %}
{% include cv-hasEducation.html edu=item %}
{% endfor %}

## Work and Teaching Experience

{% for item in site.data.cv.hasWorkHistory.hasWorkHistory %}
{% include cv-hasWorkHistory.html work=item %}
{% endfor %}
