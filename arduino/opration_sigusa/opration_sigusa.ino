// Bluetooth
#include <BluetoothSerial.h>

// #include <WiFi.h>
// #include <HTTPClient.h>
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
#include <M5Stack.h>


// クラス定義
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver(0x40);

// サーボモータクラス
// ピン設定等コンストラクタにて設定
class Servo_pca9685 {
  private:

    int pin,
        now_angle;

    // PCA9685でサーボモータを動かすときに使用する定数
    const int servo_min = 500,
              servo_max = 2400,
              servo_deg_max = 180,
              servo_deg_min = 0;

  public:
    // コンストラクタ
    Servo_pca9685(int output_pin, int default_angle = 90) {
      
      pin = output_pin;
      now_angle = default_angle;
    }

    void angle(int angle) {
      // サーボモータを利用するために出力周波数を設定 
      pwm.setPWMFreq(20);

      angle = map(
        angle,
        servo_deg_min,
        servo_deg_max,
        servo_min,
        servo_max);

      pwm.writeMicroseconds(pin, angle);
      // 現在の角度に設定
      now_angle = angle;
    }
};

// DCモータの制御クラス
class DCmotor {
  private:
    const int max_speed = 1600,min_speed = 0;
    
    int pin_black,pin_white,
    default_speed_right = max_speed,
    default_speed_left = max_speed;

  public:
    DCmotor(int output_pin_black, int output_pin_white){
      pin_black = output_pin_black;
      pin_white = output_pin_white;
    }
// モータの片方の端子に電流を流して回転方向を制御する
    void power_right(int speed){
      pwm.setPWMFreq(1600);
      default_speed_right = speed;
      pwm.setPWM(pin_black,min_speed,speed);
      pwm.setPWM(pin_white,min_speed,min_speed);
    }

    void power_left(int speed){
      pwm.setPWMFreq(1600);
      default_speed_left = speed;
      pwm.setPWM(pin_black,min_speed,min_speed);
      pwm.setPWM(pin_white,min_speed,speed);
    }

    void power_stop(){
      pwm.setPWMFreq(1600);
      pwm.setPWM(pin_black,min_speed,min_speed);
      pwm.setPWM(pin_white,min_speed,min_speed);
    }
};

//pca9685接続ピン列挙型
// w：白ケーブル b：黒ケーブル（試作を参照;水色のやつ）
enum pca9685_no {
  sv1,         //首
  sv2,         //右フリッパー
  sv3,         //左フリッパー
  dc_right_b,  //右DCモータ
  dc_right_w,  //右DCモータ
  dc_left_b,   //左dcモータ
  dc_left_w    //左dcモータ
};

//サーボモータの中心の値sv1から
int sv_angleVal[3] = { 90, 70, 170 };

// サーボモータとDCモータのインスタンスを生成

Servo_pca9685 servo1 = Servo_pca9685(sv1,sv_angleVal[0]);
Servo_pca9685 servo2 = Servo_pca9685(sv1,sv_angleVal[1]);
Servo_pca9685 servo3 = Servo_pca9685(sv1,sv_angleVal[2]);

DCmotor dc_right = DCmotor(dc_right_b, dc_right_w);
DCmotor dc_left = DCmotor(dc_left_b, dc_left_w);

// pin
const char *pin = "1234";

String device_name = "SIGUSA";
BluetoothSerial SerialBT;

void setup() {
  // put your setup code here, to run once:
  pwm.begin();
  M5.begin();
  M5.Lcd.begin();
  Serial.begin(115200);
  SerialBT.begin(device_name);
  Serial.println("\nNow you can pair it with bluetooth!");
  M5.Lcd.println("start m5 stack");
  #ifdef USE_PIN
    SerialBT.setPin(pin);
    Serial.println("use pin");
    M5.Lcd.println("use pin");
  #endif

}

void loop() {
  static int state = 0;
  int read_data;
  M5.update();

  if (state == 0){
    delay(20);
    // esp to phone
    if (Serial.available()) {
        SerialBT.write(Serial.read());
    }
    // phone to esp
    if (SerialBT.available()) {
        read_data = SerialBT.read();
        Serial.write(read_data);
        M5.Lcd.write(read_data);
    }
  }else if(state == 2){

  }else if(state == 3){

  }else if(state == 4){

  }else if(state == 5){

  }
  
  // put your main code here, to run repeatedly:
}
