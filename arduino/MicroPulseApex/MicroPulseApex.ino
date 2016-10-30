//MICRO-PULSE

//declarar los relays
int RelayBoard1[] = {
  13, 12, 11, 10, 9, 8} 
;
//declarar las mcf
long randNumber;
int count = 0;

//declarar los valores
int bio = 0;
int value;
int timer = 30;
int p = 0;

void setup() {
  Serial.begin(9600);
  for (int p = 0; p < 7; p++) {
    pinMode(RelayBoard1[p], OUTPUT); // declare all pins as output pins
    // cambiar 1 por 0 si estan invertidos los valores para prender/apagar the board
    digitalWrite(RelayBoard1[p], 1); // turn them off initially
    randomSeed(analogRead(9));
  }

}


void loop() {
  randNumber = random(70, 500); //valor anterior 20 100
  int bio = analogRead(A5);
  bio = map(bio, 0, 1023, 70, 850);
  
  
  // estado 1

  if (bio
   <= 50) {

    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard1[p], 1);
    }
    for (p = 7; p >= 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard1[p], 1);
    }
  }
  
 
 // estado 2

  else if (bio <= 100) {
    digitalWrite(RelayBoard1[0], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[0], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 1);
    delay(randNumber);
  }
  
    // estado 3

  if (bio <= 150) {
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[5], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[5], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard1[6], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[5], 1);
    digitalWrite(RelayBoard1[6], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 1);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
  }

  // estado 4


  else if (bio <= 200) {
    digitalWrite(RelayBoard1[0], 0);
    digitalWrite(RelayBoard1[0], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[1], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[3], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[4], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard1[5], 1);
    delay(randNumber);


  }
  
    // estado 5


  else if (bio <= 250) {
    digitalWrite(RelayBoard1[6], 0);
    digitalWrite(RelayBoard1[3], 0);
    delay(randNumber);

    digitalWrite(RelayBoard1[6], 1);
    digitalWrite(RelayBoard1[3], 1);
    delay(randNumber);


    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);

    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
  }

  // estado 6


  else if (bio <= 300) {
    digitalWrite(RelayBoard1[p], 0);
    digitalWrite(RelayBoard1[p], 1);

    digitalWrite(RelayBoard1[p], 0);
    digitalWrite(RelayBoard1[p], 1);
    delay(randNumber);

    digitalWrite(RelayBoard1[p], 0);
    digitalWrite(RelayBoard1[p], 1);

  }
  
    // estado 7


  else if (bio <= 350) {
    digitalWrite(RelayBoard1[0], 0);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[5], 0);

    delay(randNumber);
    digitalWrite(RelayBoard1[0], 1);
    digitalWrite(RelayBoard1[1], 1);
    digitalWrite(RelayBoard1[2], 1);
    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[5], 1);


    delay(randNumber);

  }


  // estado 8

  else if (bio <= 400) {
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p + 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
    for (p = 7; p > 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p - 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
  }
  
    // estado 9


  else if (bio <= 450) {
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p + 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
    for (p = 7; p > 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p - 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
  }
  
  
   if (bio
   <= 500) {

    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard1[p], 1);
    }
    for (p = 7; p >= 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard1[p], 1);
    }
  }
  
 
 // estado 2

  else if (bio <= 550) {
    digitalWrite(RelayBoard1[0], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[0], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 1);
    delay(randNumber);
  }
  
    // estado 3

  if (bio <= 600) {
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[5], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[5], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard1[6], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[5], 1);
    digitalWrite(RelayBoard1[6], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 1);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
  }

  // estado 4


  else if (bio <= 650) {
    digitalWrite(RelayBoard1[0], 0);
    digitalWrite(RelayBoard1[0], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[1], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[3], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[4], 1);
    delay(randNumber);
    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard1[5], 1);
    delay(randNumber);


  }
  
    // estado 5


  else if (bio <= 700) {
    digitalWrite(RelayBoard1[6], 0);
    digitalWrite(RelayBoard1[3], 0);
    delay(randNumber);

    digitalWrite(RelayBoard1[6], 1);
    digitalWrite(RelayBoard1[3], 1);
    delay(randNumber);


    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[2], 0);
    delay(randNumber);

    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[2], 1);
    delay(randNumber);
  }

  // estado 6


  else if (bio <= 300) {
    digitalWrite(RelayBoard1[p], 0);
    digitalWrite(RelayBoard1[p], 1);

    digitalWrite(RelayBoard1[p], 0);
    digitalWrite(RelayBoard1[p], 1);
    delay(randNumber);

    digitalWrite(RelayBoard1[p], 0);
    digitalWrite(RelayBoard1[p], 1);

  }
  
    // estado 7


  else if (bio <= 750) {
    digitalWrite(RelayBoard1[0], 0);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[5], 0);

    delay(randNumber);
    digitalWrite(RelayBoard1[0], 1);
    digitalWrite(RelayBoard1[1], 1);
    digitalWrite(RelayBoard1[2], 1);
    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[5], 1);


    delay(randNumber);

  }


  // estado 8

  else if (bio <= 800) {
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p + 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
    for (p = 7; p > 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p - 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
  }
  
    // estado 9


  else if (bio <= 850) {
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p + 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
    for (p = 7; p > 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p - 1], 0);
      delay(randNumber);
      digitalWrite(RelayBoard1[p], 1);
      delay(randNumber);
    }
  }
  
}





