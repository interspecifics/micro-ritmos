//MICRO-PULSE

//declarar los relays
int RelayBoard1[] = {2, 3, 4, 5, 6, 7, 8, 9} ;
int RelayBoard2[] = {10, 11, 12, 13, 14, 15, 16, 17};
//declarar las mcf
long randNumber;
long randNumber2;
int count = 0;

const byte MFC1 = 5;
//declarar los valores
int bioelectricity = 0;
int value;
int timer = 30;
int p = 0;

void setup() {
  Serial.begin(9600);
  for (int p = 0; p < 8; p++) {
    pinMode(RelayBoard1[p], OUTPUT); // declare all pins as output pins
    pinMode(RelayBoard2[p], OUTPUT);
    // cambiar 1 por 0 si estan invertidos los valores para prender/apagar the board
    digitalWrite(RelayBoard1[p], 1); // turn them off initially
    digitalWrite(RelayBoard2[p], 1); // 1 is off for the relay board
    randomSeed(analogRead(9));
  }

}


void loop() {
  randNumber = random(50, 500);
  randNumber2 = random(50, 200);

  bioelectricity = analogRead(MFC1);
  value = map(bioelectricity, -500, 1023, 30, 150);

  if (randNumber <= 50) {
    
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard2[p], 0);
      digitalWrite(RelayBoard1[p], 1);
      digitalWrite(RelayBoard2[p], 1);
    }
    for (p = 7; p >= 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard2[p], 0);
      digitalWrite(RelayBoard1[p], 1);
      digitalWrite(RelayBoard2[p], 1);
    }
  }

  else if (randNumber <= 100) {
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard2[3], 0);
    delay(value);

    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard2[3], 1);
    delay(value);

    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard2[6], 0);
    delay(value);

    digitalWrite(RelayBoard1[5], 1);
    digitalWrite(RelayBoard2[6], 1);
    delay(value);

    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard2[7], 0);
    delay(value);

    digitalWrite(RelayBoard1[1], 1);
    digitalWrite(RelayBoard2[7], 1);
    delay(value);

    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard2[8], 0);
    delay(value);

    digitalWrite(RelayBoard1[2], 1);
    digitalWrite(RelayBoard2[8], 1);
    delay(value);
  }

  if (randNumber <= 150) {
    digitalWrite(RelayBoard2[4], 0);
    digitalWrite(RelayBoard2[5], 0);
    delay(value);

    digitalWrite(RelayBoard2[4], 1);
    digitalWrite(RelayBoard2[5], 1);
    delay(value);

    digitalWrite(RelayBoard2[6], 0);
    digitalWrite(RelayBoard2[7], 0);
    delay(value);

    digitalWrite(RelayBoard2[6], 1);
    digitalWrite(RelayBoard2[7], 1);
    delay(value);

    digitalWrite(RelayBoard2[1], 0);
    digitalWrite(RelayBoard2[2], 0);
    delay(value);

    digitalWrite(RelayBoard2[1], 1);
    digitalWrite(RelayBoard2[2], 1);
    delay(value);

    digitalWrite(RelayBoard2[3], 0);
    digitalWrite(RelayBoard2[2], 0);
    delay(value);

    digitalWrite(RelayBoard2[3], 1);
    digitalWrite(RelayBoard2[2], 1);
    delay(value);
  }

  else if (randNumber <= 200) {
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[1], 1);
    delay(value);

    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard1[2], 1);
    delay(value);

    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[3], 1);
    delay(value);

    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[4], 1);
    delay(value);

    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard1[5], 1);
    delay(value);

    digitalWrite(RelayBoard1[6], 0);
    digitalWrite(RelayBoard1[6], 1);
    delay(value);

    digitalWrite(RelayBoard1[7], 0);
    digitalWrite(RelayBoard2[7], 1);
    delay(value);

    digitalWrite(RelayBoard2[1], 0);
    digitalWrite(RelayBoard2[1], 1);
    delay(value);

    digitalWrite(RelayBoard2[2], 0);
    digitalWrite(RelayBoard2[2], 1);
    delay(value);

    digitalWrite(RelayBoard2[3], 0);
    digitalWrite(RelayBoard2[3], 1);
    delay(value);

    digitalWrite(RelayBoard2[4], 0);
    digitalWrite(RelayBoard2[4], 1);
    delay(value);

    digitalWrite(RelayBoard2[5], 0);
    digitalWrite(RelayBoard2[5], 1);
    delay(value);

    digitalWrite(RelayBoard2[6], 0);
    digitalWrite(RelayBoard2[6], 1);
    delay(value);

    digitalWrite(RelayBoard2[7], 0);
    digitalWrite(RelayBoard2[7], 1);
    delay(value);
  }

  else if (randNumber <= 250) {
    digitalWrite(RelayBoard1[6], 0);
    digitalWrite(RelayBoard2[6], 0);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard2[3], 0);
    delay(value/2);

    digitalWrite(RelayBoard1[6], 1);
    digitalWrite(RelayBoard2[6], 1);
    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard2[3], 1);
    delay(value/2);


    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard2[4], 0);
    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard2[2], 0);
    delay(value/2);
    
    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard2[4], 1);
    digitalWrite(RelayBoard1[2], 1);
    digitalWrite(RelayBoard2[2], 1);
    delay(value/2);
  }

 else if (randNumber <= 300) {
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard2[p], 0);
      digitalWrite(RelayBoard1[p], 1);
      digitalWrite(RelayBoard2[p], 1);

      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard2[p], 0);
      digitalWrite(RelayBoard1[p], 1);
      digitalWrite(RelayBoard2[p], 1);
      delay(300);
      
      digitalWrite(RelayBoard1[p], 0);
      digitalWrite(RelayBoard2[p], 0);
      digitalWrite(RelayBoard1[p], 1);
      digitalWrite(RelayBoard2[p], 1);
      
  }
  
  else if (randNumber <= 350) {
    digitalWrite(RelayBoard1[0], 0);
    digitalWrite(RelayBoard1[1], 0);
    digitalWrite(RelayBoard1[2], 0);
    digitalWrite(RelayBoard1[3], 0);
    digitalWrite(RelayBoard1[4], 0);
    digitalWrite(RelayBoard1[5], 0);
    digitalWrite(RelayBoard1[6], 0);
    digitalWrite(RelayBoard1[7], 0);
    digitalWrite(RelayBoard2[0], 0);
    digitalWrite(RelayBoard2[1], 0);
    digitalWrite(RelayBoard2[2], 0);
    digitalWrite(RelayBoard2[3], 0);
    digitalWrite(RelayBoard2[4], 0);
    digitalWrite(RelayBoard2[5], 0);
    digitalWrite(RelayBoard2[6], 0);
    digitalWrite(RelayBoard2[7], 0);
    delay(value);
    digitalWrite(RelayBoard1[0], 1);
    digitalWrite(RelayBoard1[1], 1);
    digitalWrite(RelayBoard1[2], 1);
    digitalWrite(RelayBoard1[3], 1);
    digitalWrite(RelayBoard1[4], 1);
    digitalWrite(RelayBoard1[5], 1);
    digitalWrite(RelayBoard1[6], 1);
    digitalWrite(RelayBoard1[7], 1);
    digitalWrite(RelayBoard2[0], 1);
    digitalWrite(RelayBoard2[1], 1);
    digitalWrite(RelayBoard2[2], 1);
    digitalWrite(RelayBoard2[3], 1);
    digitalWrite(RelayBoard2[4], 1);
    digitalWrite(RelayBoard2[5], 1);
    digitalWrite(RelayBoard2[6], 1);
    digitalWrite(RelayBoard2[7], 1);
      delay(value);
    
  }


  else if (randNumber <= 400) {
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard2[p], 0);
      delay(value);
      digitalWrite(RelayBoard2[p + 1], 0);
      delay(value);
      digitalWrite(RelayBoard2[p], 1);
      delay(value * 2);
    }
    for (p = 7; p > 0; p--) {
      digitalWrite(RelayBoard2[p], 0);
      delay(value);
      digitalWrite(RelayBoard2[p - 1], 0);
      delay(value);
      digitalWrite(RelayBoard2[p], 1);
      delay(value * 2);
    }
  }

  else if (randNumber <= 450) {
    for (p = 0; p < 8; p++) {
      digitalWrite(RelayBoard1[p], 0);
      delay(value);
      digitalWrite(RelayBoard1[p + 1], 0);
      delay(value);
      digitalWrite(RelayBoard1[p], 1);
      delay(value * 2);
    }
    for (p = 7; p > 0; p--) {
      digitalWrite(RelayBoard1[p], 0);
      delay(value);
      digitalWrite(RelayBoard1[p - 1], 0);
      delay(value);
      digitalWrite(RelayBoard1[p], 1);
      delay(value * 2);
    }
  }

  digitalWrite(RelayBoard2[7], 0);
  digitalWrite(RelayBoard2[7], 1);
  delay(value);
}


