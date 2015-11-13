# Estructuras de Datos II
Universidad Cenfotec, Laboratorios

Ruby version: ruby 2.1.2p95 or greater

Lab 1 y 2 Knight Tour
* Animation could take a lot of time, I ran it more than 20 mins.
* Board is always square.
* Initial position x,y of the board, should be separated by a comma.

```ruby
ruby knight_tour.rb "board_size" "initial_position" "animation"
ruby knight_tour.rb 5 1,1 true
```

Lab 3 Jenga
```ruby
* "k" "p" = random number of pieces to take.
ruby jenga.rb "number_of_pieces" "k" "p"
ruby jenga.rb 8 3 6
```

Lab 4 Mochila
```ruby
* " weights array and values array, should be separated by a comma.
ruby mochila.rb "capacity" "weights array" "values array"
ruby mochila.rb 18 5,6,7,4 85,90,150,75
```

Lab 5 NW
```ruby
ruby needleman_warsh.rb "gapi" "gape" "mismatch" "match" "word_a" "word_b"
ruby needleman_warsh.rb -2 -2 -1 1 "ahora" "aora"
```

Lab 6 SW
```ruby
ruby smith_waterman.rb "gapi" "gape" "mismatch" "match" "word_a" "word_b"
ruby smith_waterman.rb -2 -2 -1 1 "ahora" "aora"
```