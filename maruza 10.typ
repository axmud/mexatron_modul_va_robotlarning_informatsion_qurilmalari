// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №10. Mexatron modullar va robotlarning informatsion tizimlari
//              uchun dasturiy taʼminotlar
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №10. Mexatron modullar va robotlarning informatsion tizimlari uchun dasturiy taʼminotlar",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 10  // maʼruza raqami
#set document(keywords: (info.fan,))
#set page(header: context {
  set text(size: 9pt, fill: luma(110))
  grid(
    columns: (3fr, auto, 1fr),
    align: (left, center, right),
    info.fan, info.semestr, [Maʼruza №#raqam],
  )
  v(-0.5em)
  line(length: 100%, stroke: 0.4pt + luma(170))
})
// ===================
#set text(size: 12pt, lang: "uz")
#set par(justify: true, leading: 0.75em, first-line-indent: (amount: 1.25cm, all: true))
#set heading(numbering: "1.1.")
#show heading: set text(fill: headingblue)
#show heading.where(level: 1): it => block(above: 1.4em, below: 0.9em, text(size: 14pt, it))
#show heading.where(level: 2): it => block(above: 1.2em, below: 0.7em, text(size: 12.5pt, it))
#set list(indent: 1.25cm)
#set enum(indent: 1.25cm)

#show figure.where(kind: image): set figure(supplement: "Rasm")
#show figure.where(kind: table): set figure(supplement: "Jadval")
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.caption: set text(size: 11pt)
#show table: set par(justify: false, first-line-indent: 0pt)

#let eq(body) = math.equation(block: true, numbering: "(1)", body)
#show figure.where(kind: table): set block(breakable: true)

// booktabs uslubidagi jadval
#let btable(columns: auto, align: left, header: (), ..rows) = table(
  columns: columns,
  align: align,
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  table.hline(stroke: 1pt),
  table.header(..header.map(h => text(weight: "bold", h))),
  table.hline(stroke: 0.6pt),
  ..rows,
  table.hline(stroke: 1pt),
)

// ---------------------------------------------------------------------
// Sarlavha
// ---------------------------------------------------------------------
#align(center)[
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №10]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarning informatsion tizimlari uchun dasturiy taʼminotlar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Informatsion tizim dasturiy taʼminotining darajalari.
  + Real vaqt talablari va real vaqt operatsion tizimlari.
  + Datchik maʼlumotlarini olish dasturlari.
  + Datchik maʼlumotlariga dasturiy ishlov berish: kalibrlash, filtrlash, birlashtirish.
  + Robototexnika oraliq dasturiy taʼminoti: ROS 2.
  + Texnik koʻrish va sunʼiy intellekt kutubxonalari.
  + Modellashtirish, simulyatsiya va sanoat dasturiy vositalari.
  + Dasturiy taʼminot sifati, ishonchliligi va xavfsizligi.

  *Tayanch iboralar:* mikrodastur (firmware), oʻrnatilgan dastur, real vaqt, kechikish, jitter, RTOS, uzilish, DMA, drayver, raqamli filtr, eksponensial filtr, komplementar filtr, kalibrlash, ROS 2, tugun, mavzu, xabar, xizmat, tf2, DDS, OpenCV, PCL, neyron tarmoq, simulyator, SIL, HIL, IEC 61131-3, Git, funksional xavfsizlik.
]

// =====================================================================
= Informatsion tizim dasturiy taʼminotining darajalari
// =====================================================================

Oldingi maʼruzalarda robot informatsion tizimining apparat qismi — datchiklar, oʻlchash sxemalari, kameralar koʻrib chiqildi. Lekin datchik signali boshqaruv uchun foydali axborotga aylanishi uchun uni olish, qayta ishlash, tahlil qilish va uzatish kerak — bu vazifalarni *dasturiy taʼminot* bajaradi. Zamonaviy robotlarda informatsion tizim imkoniyatlari koʻp jihatdan aynan dasturiy taʼminot bilan belgilanadi: bir xil kamera oddiy dastur bilan faqat tasvir beradi, chuqur neyron tarmoq bilan esa obyektlarni tanib oladi.

Robot informatsion tizimining dasturiy taʼminoti bir necha darajadan iborat (1-rasm, 1-jadval).

#figure(
  {
    set par(justify: false)
    diagram(
      spacing: (10mm, 6mm),
      node-stroke: 1pt,
      node-corner-radius: 3pt,
      node-shape: rect,
      edge-stroke: 1pt,
      node(
        (0, 0),
        [*Amaliy dasturlar:* koʻrish, lokalizatsiya, rejalashtirish],
        width: 12cm,
        fill: lightorange,
        name: <a>,
      ),
      node((0, 1), [*Oraliq dasturiy taʼminot:* ROS 2, DDS, kutubxonalar], width: 12cm, fill: lightblue, name: <b>),
      node((0, 2), [*Operatsion tizim:* Linux (PREEMPT_RT), RTOS], width: 12cm, fill: lightblue, name: <c>),
      node((0, 3), [*Oʻrnatilgan dasturlar:* mikrokontroller, drayverlar], width: 12cm, fill: lightblue, name: <d>),
      node((0, 4), [*Mikrodastur:* datchik, kamera, drayver ichida], width: 12cm, fill: white, name: <e>),
      edge(<e>, <d>, "<->"),
      edge(<d>, <c>, "<->"),
      edge(<c>, <b>, "<->"),
      edge(<b>, <a>, "<->"),
    )
  },
  caption: [Robot informatsion tizimi dasturiy taʼminotining darajalari],
) <fig-daraja>

#figure(
  btable(
    columns: (auto, 1.3fr, 1fr),
    header: ([Daraja], [Vazifasi], [Misollar]),
    [Mikrodastur],
    [Datchik yoki kamera ichida oʻlchash, kalibrlash, kompensatsiya, diagnostika],
    [Intellektual datchik, aqlli kamera, servodrayver dasturi],
    [Oʻrnatilgan dasturlar],
    [Datchiklarni soʻrash, signallarni raqamlash, birlamchi filtrlash, tez boshqaruv konturlari],
    [STM32, ESP32 kabi mikrokontrollerlar uchun C/C++ dasturlar],
    [Operatsion tizim],
    [Vazifalarni rejalashtirish, xotira va qurilmalarni boshqarish, vaqtni taʼminlash],
    [FreeRTOS, Zephyr, Linux PREEMPT_RT],
    [Oraliq dasturiy taʼminot],
    [Dastur komponentlari orasida maʼlumot almashish, koordinatalar tizimlari, vositalar],
    [ROS 2, DDS, OPC UA],
    [Amaliy dasturlar],
    [Koʻrish, tanib olish, xarita qurish, lokalizatsiya, qaror qabul qilish],
    [OpenCV, PCL, neyron tarmoqlar, SLAM paketlari],
  ),
  caption: [Dasturiy taʼminot darajalari],
) <tab-daraja>

Quyi darajalarda dasturlar qatʼiy vaqt cheklovlari ostida, kichik resursli qurilmalarda ishlaydi va koʻpincha C yoki C++ tilida yoziladi. Yuqori darajalarda esa murakkab algoritmlar kuchli kompyuterlarda bajariladi; bu yerda C++ bilan bir qatorda Python keng qoʻllanadi.

// =====================================================================
= Real vaqt talablari va real vaqt operatsion tizimlari
// =====================================================================

== Real vaqt tushunchasi

*Real vaqt tizimi* — natijaning toʻgʻriligi nafaqat hisoblash natijasiga, balki uning qachon olinganiga ham bogʻliq boʻlgan tizim. Masalan, yuritmaning tezlik konturi enkoder qiymatini har 1 ms da olib, yangi boshqaruv signalini hisoblashi kerak; natija kechiksa, boshqaruv sifati yomonlashadi yoki tizim beqaror boʻladi. Real vaqt tizimlari ikki turga boʻlinadi:
- *qatʼiy real vaqt* — muddatni buzish yoʻl qoʻyilmaydi (yuritma konturlari, xavfsizlik funksiyalari, avariya toʻxtatish);
- *yumshoq real vaqt* — vaqti-vaqti bilan kechikish sifatni pasaytiradi, lekin halokatga olib kelmaydi (videoni koʻrsatish, xarita yangilash).

Real vaqt dasturining asosiy vaqt koʻrsatkichlari: *diskretlash davri* (vazifa qanchalik tez-tez bajariladi), *kechikish* (hodisadan javobgacha vaqt) va *jitter* (davr yoki kechikishning tasodifiy oʻzgarishi). Raqamli boshqaruv va filtrlash algoritmlari diskretlash davri oʻzgarmas deb hisoblaydi, shuning uchun katta jitter ularning ishini buzadi.

== Vazifalarni rejalashtirish

Robot kontrollerida bir vaqtda bir nechta davriy vazifa ishlaydi: enkoderlarni soʻrash, IMU maʼlumotini olish, kamerani qayta ishlash va boshqalar. *Real vaqt operatsion tizimlari* (RTOS) vazifalarga ustuvorlik beradi va muhimroq vazifa kamroq muhimini darhol toʻxtatib, bajarilishini kafolatlaydi. Davri qisqaroq vazifaga yuqoriroq ustuvorlik berish usulida (_Rate Monotonic Scheduling_) $n$ ta davriy vazifaning barcha muddatlari bajarilishining yetarli sharti:

#eq($ U = sum_(i=1)^n C_i / T_i <= n (2^(1 slash n) - 1), $)

bu yerda $C_i$ — $i$-vazifaning eng uzoq bajarilish vaqti, $T_i$ — uning davri, $U$ — protsessor yuklamasi. *Misol.* Enkoder vazifasi ($C = 0","1$ ms, $T = 1$ ms), IMU vazifasi ($C = 0","5$ ms, $T = 5$ ms) va tasvirga ishlov berish ($C = 20$ ms, $T = 100$ ms) uchun $U = 0","1 + 0","1 + 0","2 = 0","4$. Uch vazifa uchun chegara $3 (2^(1 slash 3) - 1) approx 0","78$, demak barcha muddatlar bajariladi. Agar tasvirga ishlov berish 60 ms ga choʻzilsa, $U = 0","8 > 0","78$ va kafolat yoʻqoladi — bunday holatda ogʻir vazifa alohida protsessorga oʻtkaziladi.

Mikrokontrollerlarda keng tarqalgan RTOS lar — FreeRTOS va Zephyr. Kuchliroq kompyuterlarda real vaqt yamogʻi (PREEMPT_RT) qoʻllangan Linux ishlatiladi. Oddiy (real vaqt boʻlmagan) operatsion tizimlarda vazifa bajarilish vaqti kafolatlanmaydi, shuning uchun tez boshqaruv konturlari odatda alohida mikrokontroller yoki drayverda bajariladi, yuqori darajadagi kompyuter esa sekinroq, lekin murakkab vazifalarni hal qiladi.

// =====================================================================
= Datchik maʼlumotlarini olish dasturlari
// =====================================================================

Datchik maʼlumotlarini olish dasturi (drayver) datchik bilan uning interfeysi orqali aloqa qiladi, maʼlumotni oʻqiydi va uni yuqori darajadagi dasturlarga qulay koʻrinishda beradi. Maʼlumot olishning uch asosiy usuli bor:
- *soʻrov (polling)* — dastur datchikni davriy ravishda oʻzi soʻraydi; sodda, lekin protsessor vaqtini behuda sarflashi mumkin;
- *uzilish (interrupt)* — datchik yoki apparat moduli yangi maʼlumot tayyor boʻlganda protsessorga signal beradi va maxsus qism-dastur (uzilishga xizmat koʻrsatish dasturi) uni darhol qayta ishlaydi; hodisalarga tez javob beradi;
- *xotiraga toʻgʻridan-toʻgʻri murojaat (DMA)* — apparat kontroller maʼlumotlarni (masalan, ARO natijalari yoki kamera kadrlarini) protsessor ishtirokisiz xotiraga koʻchiradi; katta oqimlar uchun eng samarali usul.

Mikrokontrollerlarda koʻp vazifalarni maxsus apparat modullari bajaradi va dastur ularni faqat sozlaydi: masalan, taymerlarning *enkoder rejimi* A va B kvadratur signallarini apparat darajasida sanaydi (5-maʼruza), *ushlash rejimi* impulslar orasidagi vaqtni oʻlchaydi (T-usul), ARO esa taymer signali boʻyicha qatʼiy davr bilan diskretlaydi. Bu jitterni kamaytiradi va protsessorni boʻshatadi.

Datchik maʼlumotlarini olishda quyidagi qoidalarga amal qilinadi:
- har bir oʻlchashga *vaqt belgisi* (timestamp) qoʻyiladi — turli datchiklar maʼlumotlarini birlashtirish uchun ular qachon olingani aniq maʼlum boʻlishi kerak;
- maʼlumotlar *halqasimon bufer* orqali uzatiladi — tez yozuvchi va sekin oʻquvchi vazifalar bir-birini kutmaydi;
- datchik javobining toʻgʻriligi tekshiriladi (nazorat yigʻindisi, ruxsat etilgan diapazon, javob vaqti) va nosozlik aniqlanganda xavfsiz holatga oʻtiladi.

// =====================================================================
= Datchik maʼlumotlariga dasturiy ishlov berish
// =====================================================================

== Kalibrlash va birliklarga oʻtkazish

ARO kodi yoki datchik chiqishi dasturda fizik birliklarga oʻtkaziladi. Chiziqli datchik uchun ikki nuqtali kalibrlash qoʻllanadi: maʼlum ikki qiymat $x_1, x_2$ da datchik kodlari $y_1, y_2$ yozib olinadi va oʻtkazish formulasi topiladi:

#eq($ x = x_1 + (x_2 - x_1) / (y_2 - y_1) dot (y - y_1). $)

*Misol.* Harorat datchigi 0 °C da $y_1 = 410$, 100 °C da $y_2 = 3686$ kod bersa, $y = 2048$ kodga $x = 100 slash 3276 dot (2048 - 410) approx 50","0$ °C mos keladi. Nochiziqli datchiklar uchun polinomlar yoki jadval va chiziqli interpolyatsiya qoʻllanadi (7-maʼruza).

== Raqamli filtrlash

Datchik signalidagi shovqinni kamaytirish uchun dasturda raqamli filtrlar ishlatiladi:
- *sirpanuvchi oʻrtacha* — oxirgi $N$ ta oʻlchash oʻrtachasi; oddiy, lekin $N$ ortgan sari kechikish ortadi;
- *median filtr* — oxirgi oʻlchashlarning medianasi; alohida keskin sakrashlarni (qoʻpol xatoliklarni) yaxshi yoʻqotadi;
- *eksponensial (birinchi tartibli past chastotali) filtr* — har bir yangi qiymat oldingi natija bilan tortib qoʻshiladi:

#eq($ hat(y)_k = alpha dot x_k + (1 - alpha) dot hat(y)_(k-1), quad alpha = T_s / (tau + T_s), $)

bu yerda $x_k$ — yangi oʻlchash, $hat(y)_k$ — filtrlangan qiymat, $T_s$ — diskretlash davri, $tau$ — filtrning vaqt doimiysi. *Misol.* $T_s = 1$ ms va $tau = 10$ ms uchun $alpha approx 0","091$. Filtr juda kam xotira va hisoblash talab qiladi, shuning uchun mikrokontrollerlarda keng qoʻllanadi. Har qanday filtr shovqinni kamaytirish bilan birga signalni kechiktiradi (9-maʼruzadagi dinamik xatolik), shuning uchun $tau$ boshqaruv talablariga mos tanlanadi.

== Datchiklar maʼlumotlarini birlashtirish

Turli datchiklarning kuchli tomonlarini birlashtirish uchun maʼlumotlarni birlashtirish algoritmlari qoʻllanadi (1-maʼruza). Eng oddiy misol — IMU yordamida qiyalik burchagini aniqlovchi *komplementar filtr*. Giroskop burchak tezligini integrallash qisqa muddatda aniq, lekin drift tufayli xato toʻplanadi; akselerometr esa gravitatsiya yoʻnalishi boʻyicha burchakni driftsiz, lekin shovqin va tezlanish taʼsirida beradi. Filtr ularni quyidagicha birlashtiradi:

#eq($ theta_k = gamma dot (theta_(k-1) + omega_k T_s) + (1 - gamma) dot theta_k^"aks", $)

bu yerda $omega_k$ — giroskop oʻlchagan burchak tezligi, $theta_k^"aks"$ — akselerometr boʻyicha hisoblangan burchak, $gamma$ — 1 ga yaqin koeffitsient (masalan, 0,98). Shunday qilib, natijaning yuqori chastotali qismi giroskopdan, past chastotali qismi esa akselerometrdan olinadi. Murakkabroq vazifalarda (navigatsiya, lokalizatsiya) Kalman filtri va uning nochiziqli kengaytmalari qoʻllanadi.

// =====================================================================
= Robototexnika oraliq dasturiy taʼminoti: ROS 2
// =====================================================================

== Asosiy tushunchalar

Zamonaviy robotlarning dasturiy taʼminoti koʻplab mustaqil komponentlardan iborat: datchik drayverlari, filtrlar, lokalizatsiya, rejalashtirish, boshqaruv. Ularni birlashtirish uchun *oraliq dasturiy taʼminot* qoʻllanadi. Robototexnikada eng keng tarqalgan ochiq platforma — *ROS 2* (_Robot Operating System 2_). U operatsion tizim emas, balki dastur komponentlari orasida maʼlumot almashishni taʼminlovchi kutubxonalar, vositalar va kelishuvlar toʻplamidir. ROS 2 da maʼlumot almashish DDS (_Data Distribution Service_) standarti asosida amalga oshiriladi. Asosiy tushunchalar 3-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1.5fr),
    header: ([Tushuncha], [Mazmuni]),
    [Tugun (node)],
    [Bitta vazifani bajaruvchi mustaqil dastur komponenti (masalan, LiDAR drayveri yoki filtr)],
    [Mavzu (topic)],
    [Nomlangan maʼlumot kanali; tugunlar unga xabar eʼlon qiladi (publish) yoki obuna boʻladi (subscribe)],
    [Xabar (message)],
    [Belgilangan tuzilishdagi maʼlumot: `sensor_msgs/Imu`, `LaserScan`, `Image`, `JointState` va boshqalar],
    [Xizmat (service)],
    [Soʻrov-javob koʻrinishidagi aloqa (masalan, datchikni kalibrlash buyrugʻi)],
    [Harakat (action)],
    [Uzoq davom etadigan, oraliq natija beradigan topshiriq (masalan, nuqtaga borish)],
    [tf2],
    [Robot qismlari va datchiklarning koordinatalar tizimlari orasidagi oʻzgarishlarni boshqarish],
    [QoS sozlamalari],
    [Ishonchlilik, xabarlar navbati chuqurligi va boshqa uzatish xossalari],
    [Vositalar],
    [RViz (vizualizatsiya), rosbag (maʼlumotlarni yozish va qayta ijro etish), launch (ishga tushirish)],
  ),
  caption: [ROS 2 ning asosiy tushunchalari],
) <tab-ros>

Mobil robot informatsion tizimining ROS 2 dagi tipik tuzilishi 2-rasmda koʻrsatilgan: har bir datchik drayveri oʻz mavzusiga maʼlumot eʼlon qiladi, filtr va lokalizatsiya tugunlari ularga obuna boʻlib, natijani boshqa mavzularga uzatadi.

#figure(
  diagram(
    spacing: (16mm, 7mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [IMU \ drayveri], name: <imu>),
    node((0, 1), [Enkoder \ drayveri], name: <enc>),
    node((0, 2), [LiDAR \ drayveri], name: <lid>),
    node((1, 0), [Filtr va \ odometriya], name: <odo>),
    node((2, 1), [Lokalizatsiya \ va xarita], fill: lightorange, name: <loc>),
    node((3, 1), [Rejalashtirish \ va boshqaruv], name: <ctl>),
    edge(<imu>, <odo>, "->", [`/imu`], label-size: 8pt),
    edge(<enc>, <odo>, "->", [`/joint_states`], label-size: 8pt, label-side: right, label-pos: 0.5),
    edge(<odo>, <loc>, "->", [`/odom`], label-size: 8pt),
    edge(<lid>, <loc>, "->", [`/scan`], label-size: 8pt, label-side: right),
    edge(<loc>, <ctl>, "->", [`/pose`], label-size: 8pt),
  ),
  caption: [Mobil robot informatsion tizimining ROS 2 dagi tuzilishi (tugunlar va mavzular)],
) <fig-ros>

Bunday tuzilishning afzalligi — modullik: masalan, LiDAR boshqa modelga almashtirilsa, faqat uning drayveri oʻzgaradi, qolgan tugunlar oʻsha `/scan` mavzusidan maʼlumot olishda davom etadi. Yozib olingan maʼlumotlar (rosbag) yordamida algoritmlarni robotsiz, laboratoriyada qayta-qayta sinash mumkin.

== Dastur namunasi

Quyida Python tilidagi ROS 2 tuguniga misol keltirilgan: u IMU ning xom maʼlumotlariga obuna boʻladi, vertikal tezlanishni eksponensial filtr (3) bilan silliqlaydi va natijani yangi mavzuga eʼlon qiladi.

```python
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Imu


class ImuFilter(Node):
    def __init__(self):
        super().__init__("imu_filter")
        self.sub = self.create_subscription(
            Imu, "/imu/data_raw", self.callback, 10)
        self.pub = self.create_publisher(Imu, "/imu/data_filtered", 10)
        self.alpha = 0.1   # eksponensial filtr koeffitsienti
        self.az = 0.0      # filtrlangan vertikal tezlanish

    def callback(self, msg):
        a = self.alpha
        self.az = a * msg.linear_acceleration.z + (1 - a) * self.az
        msg.linear_acceleration.z = self.az
        self.pub.publish(msg)


def main():
    rclpy.init()
    rclpy.spin(ImuFilter())


if __name__ == "__main__":
    main()
```

Dastur ROS 2 ning asosiy gʻoyasini koʻrsatadi: tugun faqat oʻz vazifasini bajaradi va boshqa tugunlar bilan mavzular orqali bogʻlanadi; datchik qaysi interfeys bilan ulangani va uning drayveri qanday ishlashi bu tugun uchun ahamiyatsiz.

// =====================================================================
= Texnik koʻrish va sunʼiy intellekt kutubxonalari
// =====================================================================

Texnik koʻrish tizimlari (8-maʼruza) uchun tasvir va nuqtalar bulutiga ishlov beruvchi tayyor kutubxonalar keng qoʻllanadi (4-jadval).

#figure(
  btable(
    columns: (auto, 1.5fr),
    header: ([Vosita], [Vazifasi]),
    [OpenCV],
    [Tasvirga ishlov berishning klassik algoritmlari: filtrlash, segmentatsiya, konturlar, xarakterli nuqtalar, kamerani kalibrlash, stereo koʻrish],
    [PCL, Open3D],
    [3D nuqtalar bulutiga ishlov berish: filtrlash, tekisliklarni ajratish, bulutlarni moslashtirish (registratsiya)],
    [PyTorch, TensorFlow],
    [Neyron tarmoqlarni oʻqitish: obyektlarni aniqlash, segmentatsiya, tasniflash],
    [ONNX Runtime, TensorRT],
    [Oʻqitilgan tarmoqlarni robot kompyuterida tez bajarish (inferens)],
    [Kamera SDK lari, GenICam],
    [Kameralarni sozlash va kadrlarni olishning ishlab chiqaruvchi va standart interfeyslari],
    [Tijorat koʻrish paketlari],
    [Sanoat sifat nazorati va robotni yoʻnaltirish uchun tayyor, sertifikatlangan vositalar],
  ),
  caption: [Texnik koʻrish dasturiy vositalari],
) <tab-kor>

Neyron tarmoqlarga asoslangan usullar obyektlarni tanib olishda klassik algoritmlardan ancha ustun, lekin katta hajmdagi belgilangan oʻqitish maʼlumotlarini va kuchli hisoblash resurslarini (grafik protsessorlar yoki maxsus tezlatkichlar) talab qiladi. Amaliyotda ikkala yondashuv birga ishlatiladi: masalan, neyron tarmoq obyektni topadi, klassik geometrik algoritm esa uning aniq holatini hisoblaydi.

// =====================================================================
= Modellashtirish, simulyatsiya va sanoat dasturiy vositalari
// =====================================================================

== Modellashtirish va simulyatsiya

Informatsion tizim va uning algoritmlari real robotda sinashdan oldin modellashtiriladi:
- *MATLAB / Simulink* — datchik va filtr modellarini qurish, signalga ishlov berish va boshqaruv algoritmlarini ishlab chiqish, ulardan mikrokontroller uchun kod generatsiya qilish;
- *LabVIEW* — oʻlchash va maʼlumot yigʻish tizimlarini grafik dasturlash;
- *robot simulyatorlari* (Gazebo, Webots, CoppeliaSim, NVIDIA Isaac Sim) — robot, uning datchiklari (kamera, LiDAR, IMU) va muhitning virtual modeli; avtonom transport uchun maxsus simulyatorlar (masalan, CARLA) ham mavjud.

Ishlab chiqish jarayonida bosqichma-bosqich sinov qoʻllanadi: *SIL* (_Software-in-the-Loop_) bosqichida dastur simulyatsiyalangan robot va datchiklar bilan kompyuterda sinaladi; *HIL* (_Hardware-in-the-Loop_) bosqichida haqiqiy kontroller yoki drayver real vaqtda ishlaydigan virtual obyekt bilan ulanib sinaladi. Bu xavfli va qimmat sinovlarni real robotga oʻtishdan oldin bajarish imkonini beradi.

== Sanoat dasturiy vositalari

Sanoat robototexnik majmualarida datchiklar va robot bilan ishlash uchun quyidagi vositalar qoʻllanadi:
- *PLC dasturlash muhitlari* — IEC 61131-3 standartidagi tillar: zinapoyasimon diagrammalar (LD), funksional bloklar (FBD), strukturalangan matn (ST), ketma-ket funksional diagrammalar (SFC);
- *robot ishlab chiqaruvchilarining dasturlash tillari va muhitlari* — robot harakatini datchik signallari (masalan, kuch-moment datchigi yoki kamera) bilan bogʻlash uchun;
- *datchiklarni sozlash vositalari* — IO-Link datchiklari parametrlarini oʻrnatish, intellektual datchiklar diagnostikasini koʻrish;
- *SCADA va OPC UA* — uskunalar holatini yuqori darajada kuzatish va maʼlumotlarni korxona tizimlariga uzatish.

// =====================================================================
= Dasturiy taʼminot sifati, ishonchliligi va xavfsizligi
// =====================================================================

Informatsion tizim dasturidagi xato datchik nosozligi kabi xavfli boʻlishi mumkin: notoʻgʻri kalibrlash koeffitsienti yoki kechikkan maʼlumot robotning notoʻgʻri harakatiga olib keladi. Shuning uchun dasturiy taʼminotni ishlab chiqishda quyidagi tamoyillarga amal qilinadi:
- *versiyalarni boshqarish* (Git) — har bir oʻzgarish saqlanadi va kerak boʻlsa oldingi holatga qaytish mumkin;
- *testlash* — alohida funksiyalar (modul testlari), komponentlar birgalikda (integratsion testlar) va yozib olingan real maʼlumotlar bilan sinash;
- *diagnostika va jurnal yuritish* — datchiklar holati, xatolar va muhim hodisalarni qayd etish, nosozlik sabablarini keyinchalik tahlil qilish;
- *nosozlikka chidamlilik* — datchik maʼlumoti kelmasa yoki ruxsat etilgan chegaradan chiqsa, tizimni xavfsiz holatga oʻtkazish;
- *funksional xavfsizlik* — xavfsizlik funksiyalari dasturlari IEC 61508, ISO 13849, avtomobillar uchun ISO 26262 talablariga muvofiq ishlab chiqiladi;
- *kiberxavfsizlik* — tarmoqqa ulangan robot va datchiklarni ruxsatsiz kirishdan himoyalash, dasturiy yangilanishlarni tekshirish.

// =====================================================================
= Xulosa
// =====================================================================

Robot informatsion tizimining dasturiy taʼminoti mikrodastur, oʻrnatilgan dasturlar, operatsion tizim, oraliq dasturiy taʼminot va amaliy dasturlardan iborat koʻp darajali tuzilmadir. Quyi darajalarda qatʼiy real vaqt talablari ustun boʻladi: vazifalar RTOS yordamida rejalashtiriladi, datchik maʼlumotlari uzilishlar, DMA va apparat modullari orqali olinadi, har bir oʻlchashga vaqt belgisi qoʻyiladi.

Dasturda datchik maʼlumotlari kalibrlanadi, raqamli filtrlar bilan shovqindan tozalanadi va komplementar yoki Kalman filtrlari yordamida birlashtiriladi. ROS 2 dastur komponentlarini tugunlar va mavzular orqali bogʻlab, modulli va qayta foydalaniladigan tizim qurish imkonini beradi. Texnik koʻrish uchun OpenCV, PCL va neyron tarmoq kutubxonalari, algoritmlarni ishlab chiqish va sinash uchun MATLAB/Simulink va robot simulyatorlari qoʻllanadi. Dasturiy taʼminot sifati versiyalarni boshqarish, testlash, diagnostika va xavfsizlik standartlariga rioya qilish orqali taʼminlanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Robot informatsion tizimi dasturiy taʼminoti qanday darajalardan iborat?
  + Qatʼiy va yumshoq real vaqt tizimlari qanday farqlanadi? Robotdan misollar keltiring.
  + Kechikish va jitter nima? Ular boshqaruv sifatiga qanday taʼsir qiladi?
  + Uchta vazifa uchun $C_1 = 0","2$ ms, $T_1 = 1$ ms; $C_2 = 1$ ms, $T_2 = 5$ ms; $C_3 = 30$ ms, $T_3 = 100$ ms boʻlsa, ular RMS chegarasini qanoatlantiradimi?
  + Soʻrov, uzilish va DMA usullari qanday farqlanadi?
  + Nima uchun datchik maʼlumotlariga vaqt belgisi qoʻyish kerak?
  + Ikki nuqtali kalibrlash qanday bajariladi?
  + Eksponensial filtrda $T_s = 2$ ms va $tau = 20$ ms boʻlsa, $alpha$ qanchaga teng?
  + Komplementar filtr giroskop va akselerometr maʼlumotlarini qanday birlashtiradi?
  + ROS 2 dagi tugun, mavzu, xabar va xizmat tushunchalarini tushuntiring.
  + ROS 2 ning modulli tuzilishi qanday afzalliklar beradi?
  + SIL va HIL sinovlari qanday farqlanadi?
  + Informatsion tizim dasturiy taʼminotining ishonchliligi qanday taʼminlanadi?
]
