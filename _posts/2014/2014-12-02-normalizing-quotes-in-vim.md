---
title: Normalizing quotes in Vim
---

So until now we did not care about whether to use single or double
quotes while coding and just picked whatever was closest to our
fingertips.
All of a sudden a newly issued coding style guide requires the
consistent use of single quotes.
Even worse our code is written in JavaScript or PHP and we are dealing
with inlined HTML, jQuery selectors and regular expressions so we can
not simply replace all double quotes with single quotes without the
risk of breaking something.
Here is how Vim helped my out:

1. Automatically normalize quotes where it is safe:

      :g/\v^(.*")&(.*')@!/s/"/'/g

  1. Find all lines containing " but not '
  2. Replace all occurences of " with '

2. Then edit the more complicated situations by hand:

      :g/\v^(.*")&(.*')/s/"/'/gc

  1. Find all lines containing " and '
  2. For each occurence of " ask whether to replace it with '

## Also useful

      V
      :'<,'>s/"/'/g

1. Create a visual line selection starting at the current line
2. Replace all occurences of " inside visual selection with '

## Useful when using vimdiff

To jump between lines with differences use `]c` to jump forward and
`[c` to jump backward.
To ignore whitespaces while diffing enter:

    :set diffopt+=iwhite

## References

* http://stackoverflow.com/questions/26654229/how-to-select-all-lines-maching-a-pattern
* http://stackoverflow.com/questions/3883985/vim-regex-how-to-search-for-a-and-b-not-c
* http://vim.wikia.com/wiki/Power_of_g#Comments
* http://vim.wikia.com/wiki/Search_and_replace_in_a_visual_selection
* http://vim.wikia.com/wiki/Ignore_white_space_in_vimdiff

