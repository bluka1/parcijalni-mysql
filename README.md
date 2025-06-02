# Parcijalni ispit - mysql

# 🧾 Zadatak: Izrada baze podataka za upravljanje narudžbama u restoranu

## 🆕 Početak
1. klonirati repozitorij
2. kreirati vlastiti branch
3. napraviti rješenje
4. screenshotati ER dijagrame (zajedno s datumom i prikazom vašeg imena na screenu)
5. kod i slike dodati na vaš branch
6. pushati na repozitorij

## 📋 Opis zadatka

Restoran želi razviti relacijsku bazu podataka radi vođenja evidencije o:
- Jelima
- Kategorijama jela
- Konobarima
- Stolovima
- Narudžbama

Svako jelo pripada jednoj kategoriji (npr. predjelo, glavno jelo, desert), a konobari zaprimaju narudžbe koje su vezane uz određeni stol. Jedna narudžba uključuje jedno jelo, a više narudžbi može biti zaprimljeno za isti stol.

Cilj je dizajnirati i implementirati bazu koja omogućuje učinkovito praćenje svih narudžbi po stolu, jelu i konobaru, te omogućuje generiranje osnovnih izvještaja.

---

## ✅ Zadatak

1. Kreirajte **Chenov reducirani dijagram** baze podataka. [draw.io](https://app.diagrams.net)
2. Kreirajte **ER dijagram** (model baze). [draw.io](https://app.diagrams.net)
3. Normalizirajte bazu podataka (do 3NF).
4. Implementirajte bazu podataka u MySQL-u. (SQL upiti - sql file)
5. Popunite sve tablice s nekoliko testnih podataka. (SQL upiti - sql file)
6. Dohvatite sve narudžbe s imenima konobara, stolovima i nazivima jela. (SQL upiti - sql file)
7. Dohvatite broj narudžbi po stolu. (SQL upiti - sql file)
8. Kreirajte pohranjenu proceduru koja prikazuje broj narudžbi po kategoriji jela. (SQL upiti - sql file)
9. Dohvatite sve stolove koji trenutno nemaju niti jednu narudžbu. (SQL upiti - sql file)