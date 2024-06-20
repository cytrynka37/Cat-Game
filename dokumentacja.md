# Dokumentacja klas

## Spis treści
1. [Game](#game)
2. [Player](#player)
3. [Enemy](#enemy)
3. [Wizard](#wizard)
4. [Zombie](#zombie)
5. [Bullet](#bullet)
6. [Coin](#coin)
7. [Fish](#fish)
8. [HealthBar](#healthbar)
9. [Menu](#menu)
10. [EndScreen](#endscreen)
11. [HUD](#hud)
12. [Heart](#heart)
13. [HeartsContainer](#heartscontainer)

---

## Game

Klasa `Game` rozszerza `Node2D` i zarządza główną logiką gry.
### Metody:
- `_ready()`: Inicjalizuje stan gry, ustawia początkowe zdrowie gracza i punkty, przygotowywuje interfejs oraz podłącza sygnały wrogów.
- `_on_player_took_damage(amount)`: Zmniejsza zdrowie gracza o podaną ilość i aktualizuje wyświetlane serca.
- `add_lifes(amount)`: Zwiększa zdrowie gracza o podaną ilość i aktualizuje wyświetlane serca.
- `add_score(amount)`: Zwiększa wynik o podaną ilość i aktualizuje HUD.
- `_on_enemy_died()`: Dodaje punkty do wyniku po śmierci wroga.
- `play_pause(screen)`: Pauzuje lub wznawia grę, wyświetla lub ukrywa podany ekran.
- `reset(screen)`: Resetuje bieżącą scenę gry.
- `resume(screen)`: Wznawia grę.
- `quit()`: Zamyka grę.
- `show_screen(screen)`: Wyświetla podany ekran (WinScreen lub LooseScreen).
- `_on_deathzone_body_entered(body)`: Odpowiada za to, co stanie się z graczem, gdy wpadnie w przepaść.
-  `_on_win_body_entered(body)`: Wyświetla WinScreen, gdy gracz dotrze do mety.

---

## Player

**Opis**: Klasa `Player` rozszerza `CharacterBody2D` i reprezentuje gracza.

### Metody:
- `func _physics(delta)`: Sprawdza, czy gracz może strzelać, jeśli tak, to wywołuje `shoot()`.
- `func _physics_process(delta)`: Obsługuje ruch gracza.
- `update_animations(direction)`: Aktualizuje animacje gracza.
- `shoot()`: Tworzy i odpowiednio ustawia nowy pocisk.
- `_on_timer_timeout()`: Wywoływana po upływie timera, umożliwia ponowne strzelanie.
- `take_damage(amount)`: Emituje sygnał `took_damage`, gdy gracz przyjmie obrażenia.

---

## Enemy

**Opis**: Klasa `Enemy` rozszerza `CharacterBody2D` i reprezentuje przeciwnika. Zarządza jego życiem i przyjmowaniem obrażeń.

### Metody:
- `_ready()` - Ustawia początkowe życie wroga na `max_health`, jeśli spadnie poniżej 0, to wywołuje `die()`.
- `func take_damage(amount)`: Zmniejsza zdrowie przeciwnika o podaną ilość i aktualizuje pasek zdrowia.
- `die()` - Emituje sygnał  `died`.

---

## Wizard

**Opis**: Klasa `Wizard` rozszerza `Enemy` i reprezentuje typ przeciwnika Czarodziej. Obsługuje jego strzelanie pociskami.

### Metody:
- `_ready()`: Ustawia zdrowie Czarodzieja na `max_health` i odpala timer (cooldown przed pierwszym strzałem).
- `_physics_process(delta)`: Aktualizuje stronę, w którą zwrócony jest Czarodziej w zależności od położenia gracza.
- `_process(_delta)`: Sprawdza, czy Czarodziej może strzelać, jeśli tak, to wywołuje `shoot()`.
- `shoot()`: Tworzy i odpowiednio ustawia nowy pocisk.
- `_on_timer_timeout()`: Wywoływana po upływie timera, umożliwia ponowne strzelanie.

---

## Zombie

**Opis**: Klasa `Zombie` rozszerza 'Enemy' i reprezentuje typ przeciwnika Zombie. Zarządza jego ruchem.

### Metody:
- `_process(delta)`: Aktualizuje ruch Zombie w zależności od wykrytych kolizji. Jeśli `ray_cast_right` wykryje kolizję, zmienia kierunek ruchu na lewo. Analogicznie dla `ray_cast_left`.
- `_on_hitbox_body_entered(body)`: Wywoływana, gdy jakieś ciało wejdzie w obszar kolizji Zombie.

---

## Bullet

**Opis**: Klasa `Bullet` rozszerza `Area2D` i reprezentuje pocisk.

### Metody:
- `set_damage(amount)`: Ustawia ilość zadawanych obrażeń.
- `set_direction(new_direction)`: Ustawia kierunek lotu pocisku.
- `_physics_process(delta)`: Odpowiada za ruch pocisku.
- `_on_body_entered(body)`: Wywoływana, gdy pocisk wejdzie w obszar kolizji z innym ciałem i zadaje mu obrażenia w zależności od atrybutu `damage`.

---

## Coin

**Opis**: Klasa `Coin` rozszerza `Area2D` i reprezentuje monetę.

### Metody:
- `_on_body_entered(_body)` - Wywoływana, gdy ciało wejdzie w obszar kolizji monety i aktualizuje wynik wywołując metodę `add_score(amount)` z klasy `Game`.

---

## Fish

**Opis**: Klasa `Fish` rozszerza `Area2D` i reprezentuje rybkę.

### Metody:
- `_on_body_entered(_body)` - Wywoływana, gdy ciało wejdzie w obszar kolizji ryby i aktualizuje ilość żyć gracza wywołując metodę `add_lifes(amount)` z klasy `Game`.

---

## HealthBar

**Opis**: Klasa `HealthBar` rozszerza `Control` i reprezentuje pasek zdrowia przeciwnika.

### Metody: 
- `update_health_bar(health, max_health)`: Aktualizuje szerokość paska zdrowia w zależności od parametrów. Oblicza nową szerokość paska zdrowia `fill_amount` jako proporcję `health` do `max_health` pomnożoną przez maksymalną szerokość paska `fill_max`.

---

## Menu

**Opis**: Klasa `Menu` rozszerza `Control` i zarządza wyświetlaniem menu pauzy (po wciśnięciu Esc).

### Metody:
- `_ready()`: `Node.PROCESS_MODE_ALWAYS` oznacza, że metoda `_process` jest wywoływana w każdej klatce, niezależnie od stanu gry.
- `_process(_delta)`: Sprawdza, czy przycisk `pause` był wciśnięty; jeśli tak,to aktualizuje wyświetlaną punktację i wywołuje `pause_screen` z `Game`.
- `_on_reset_pressed()`: Odpowiada za reset gry po wciśnięciu przycisku `Reset`.
- `_on_resume_pressed()`: Odpowiada za wznowienie gry po wciśnięciu przycisku `Resume`.
- `_on_quit_pressed()`: Odpowiada za wyjście z gry po wciśnięciu przycisku `Quit`.

---

## EndScreen

**Opis**: Klasa `EndScreen` rozszerza `Control` i zarządza wyświetlaniem ekranu zwycięstwa (scena WinScreen) lub przegranej (LooseScreen).

### Metody:
- `_ready()`: `Node.PROCESS_MODE_ALWAYS` oznacza, że metoda `_process` jest wywoływana w każdej klatce, niezależnie od stanu gry.
- `_process(_delta)`: Aktualizuje wyświetlaną punktację.
- `_on_reset_pressed()`: Odpowiada za reset gry po wciśnięciu przycisku `Reset`.
- `_on_quit_pressed()`: Odpowiada za wyjście z gry po wciśnięciu przycisku `Quit`.

---

## HUD

**Opis**: Klasa `HUD` rozszerza `Control` i zarządza wyświetlaniem punktacji gracza w interfejsie.

### Metody:
- `set_score(new_score)`: Ustawia nową ilość punktów na etykiecie `Score`.

---

## Heart

**Opis**: Klasa `Heart` rozszerza `Panel` i zarządza wyświetlaniem serca reprezentującego pojedyncze życie gracza w interfejsie.

### Metody:
- `update(is_visible)`: Aktualizuje widoczność serca.

---

## HeartsContainer

**Opis**: Klasa `HeartsContainer` rozszerza `HBoxContainer` i zarządza wyświetlanym w interfejsie zbiorniku serc, które reprezentują życie gracza.

### Metody:
- `set_max_hearts(max)`: Ustawia maksymalną ilość serc, które mogą się znaleźć w zbiorniku oraz tworzy ich instancje.
- `update_hearts(current_health)`: Aktualizuje życie gracza w zależności od przekazanego parametru. Dla każdego z serc wywołuje metodę `update` .