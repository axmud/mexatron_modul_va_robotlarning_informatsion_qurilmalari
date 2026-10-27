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
  title: "Maʼruza №10. Mexatron modullar va robotlarning informatsion tizimlari uçun dasturiy taʼminotlar",
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
#set text(size: 12pt, lang: "uz", font: info.font)
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
  )[Mavzu: Mexatron modullar va robotlarning informatsion tizimlari uçun dasturiy taʼminotlar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Informatsion tizim dasturiy taʼminotining darajalari.
  + Real vaqt talablari va real vaqt operatsion tizimlari.
  + Datçik maʼlumotlarini oliş dasturlari.
  + Datçik maʼlumotlariga dasturiy işlov beriş: kalibrlaş, filtrlaş, birlaştiriş.
  + Robototexnika oraliq dasturiy taʼminoti: ROS 2.
  + Texnik köriş va sunʼiy intellekt kutubxonalari.
  + Modellaştiriş, simulyatsiya va sanoat dasturiy vositalari.
  + Dasturiy taʼminot sifati, işonçliligi va xavfsizligi.

  *Tayanç iboralar:* mikrodastur (firmware), örnatilgan dastur, real vaqt, keçikiş, jitter, RTOS, uziliş, DMA, drayver, raqamli filtr, eksponensial filtr, komplementar filtr, kalibrlaş, ROS 2, tugun, mavzu, xabar, xizmat, tf2, DDS, OpenCV, PCL, neyron tarmoq, simulyator, SIL, HIL, IEC 61131-3, Git, funksional xavfsizlik.
]

// =====================================================================
= Informatsion tizim dasturiy taʼminotining darajalari
// =====================================================================

Oldingi maʼruzalarda robot informatsion tizimining apparat qismi — datçiklar, ölçaş sxemalari, kameralar körib çiqildi. Lekin datçik signali boşqaruv uçun foydali axborotga aylanişi uçun uni oliş, qayta işlaş, tahlil qiliş va uzatiş kerak — bu vazifalarni *dasturiy taʼminot* bajaradi. Zamonaviy robotlarda informatsion tizim imkoniyatlari köp jihatdan aynan dasturiy taʼminot bilan belgilanadi: bir xil kamera oddiy dastur bilan faqat tasvir beradi, çuqur neyron tarmoq bilan esa obyektlarni tanib oladi.

Robot informatsion tizimining dasturiy taʼminoti bir neça darajadan iborat (1-rasm, 1-jadval).

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
        [*Amaliy dasturlar:* köriş, lokalizatsiya, rejalaştiriş],
        width: 12cm,
        fill: lightorange,
        name: <a>,
      ),
      node((0, 1), [*Oraliq dasturiy taʼminot:* ROS 2, DDS, kutubxonalar], width: 12cm, fill: lightblue, name: <b>),
      node((0, 2), [*Operatsion tizim:* Linux (PREEMPT_RT), RTOS], width: 12cm, fill: lightblue, name: <c>),
      node((0, 3), [*Örnatilgan dasturlar:* mikrokontroller, drayverlar], width: 12cm, fill: lightblue, name: <d>),
      node((0, 4), [*Mikrodastur:* datçik, kamera, drayver içida], width: 12cm, fill: white, name: <e>),
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
    [Datçik yoki kamera içida ölçaş, kalibrlaş, kompensatsiya, diagnostika],
    [Intellektual datçik, aqlli kamera, servodrayver dasturi],
    [Örnatilgan dasturlar],
    [Datçiklarni söraş, signallarni raqamlaş, birlamçi filtrlaş, tez boşqaruv konturlari],
    [STM32, ESP32 kabi mikrokontrollerlar uçun C/C++ dasturlar],
    [Operatsion tizim],
    [Vazifalarni rejalaştiriş, xotira va qurilmalarni boşqariş, vaqtni taʼminlaş],
    [FreeRTOS, Zephyr, Linux PREEMPT_RT],
    [Oraliq dasturiy taʼminot],
    [Dastur komponentlari orasida maʼlumot almaşiş, koordinatalar tizimlari, vositalar],
    [ROS 2, DDS, OPC UA],
    [Amaliy dasturlar],
    [Köriş, tanib oliş, xarita quriş, lokalizatsiya, qaror qabul qiliş],
    [OpenCV, PCL, neyron tarmoqlar, SLAM paketlari],
  ),
  caption: [Dasturiy taʼminot darajalari],
) <tab-daraja>

Quyi darajalarda dasturlar qatʼiy vaqt çeklovlari ostida, kiçik resursli qurilmalarda işlaydi va köpinça C yoki C++ tilida yoziladi. Yuqori darajalarda esa murakkab algoritmlar kuçli kompyuterlarda bajariladi; bu yerda C++ bilan bir qatorda Python keng qöllanadi.

// =====================================================================
= Real vaqt talablari va real vaqt operatsion tizimlari
// =====================================================================

== Real vaqt tuşunçasi

*Real vaqt tizimi* — natijaning töğriligi nafaqat hisoblaş natijasiga, balki uning qaçon olinganiga ham boğliq bölgan tizim. Masalan, yuritmaning tezlik konturi enkoder qiymatini har 1 ms da olib, yangi boşqaruv signalini hisoblaşi kerak; natija keçiksa, boşqaruv sifati yomonlaşadi yoki tizim beqaror böladi. Real vaqt tizimlari ikki turga bölinadi:
- *qatʼiy real vaqt* — muddatni buziş yöl qöyilmaydi (yuritma konturlari, xavfsizlik funksiyalari, avariya töxtatiş);
- *yumşoq real vaqt* — vaqti-vaqti bilan keçikiş sifatni pasaytiradi, lekin halokatga olib kelmaydi (videoni körsatiş, xarita yangilaş).

Real vaqt dasturining asosiy vaqt körsatkiçlari: *diskretlaş davri* (vazifa qançalik tez-tez bajariladi), *keçikiş* (hodisadan javobgaça vaqt) va *jitter* (davr yoki keçikişning tasodifiy özgarişi). Raqamli boşqaruv va filtrlaş algoritmlari diskretlaş davri özgarmas deb hisoblaydi, şuning uçun katta jitter ularning işini buzadi.

== Vazifalarni rejalaştiriş

Robot kontrollerida bir vaqtda bir neçta davriy vazifa işlaydi: enkoderlarni söraş, IMU maʼlumotini oliş, kamerani qayta işlaş va boşqalar. *Real vaqt operatsion tizimlari* (RTOS) vazifalarga ustuvorlik beradi va muhimroq vazifa kamroq muhimini darhol töxtatib, bajarilişini kafolatlaydi. Davri qisqaroq vazifaga yuqoriroq ustuvorlik beriş usulida (_Rate Monotonic Scheduling_) $n$ ta davriy vazifaning barça muddatlari bajarilişining yetarli şarti:

#eq($ U = sum_(i=1)^n C_i / T_i <= n (2^(1 slash n) - 1), $)

bu yerda $C_i$ — $i$-vazifaning eng uzoq bajariliş vaqti, $T_i$ — uning davri, $U$ — protsessor yuklamasi. *Misol.* Enkoder vazifasi ($C = 0","1$ ms, $T = 1$ ms), IMU vazifasi ($C = 0","5$ ms, $T = 5$ ms) va tasvirga işlov beriş ($C = 20$ ms, $T = 100$ ms) uçun $U = 0","1 + 0","1 + 0","2 = 0","4$. Uç vazifa uçun çegara $3 (2^(1 slash 3) - 1) approx 0","78$, demak barça muddatlar bajariladi. Agar tasvirga işlov beriş 60 ms ga çözilsa, $U = 0","8 > 0","78$ va kafolat yöqoladi — bunday holatda oğir vazifa alohida protsessorga ötkaziladi.

Mikrokontrollerlarda keng tarqalgan RTOS lar — FreeRTOS va Zephyr. Kuçliroq kompyuterlarda real vaqt yamoği (PREEMPT_RT) qöllangan Linux işlatiladi. Oddiy (real vaqt bölmagan) operatsion tizimlarda vazifa bajariliş vaqti kafolatlanmaydi, şuning uçun tez boşqaruv konturlari odatda alohida mikrokontroller yoki drayverda bajariladi, yuqori darajadagi kompyuter esa sekinroq, lekin murakkab vazifalarni hal qiladi.

// =====================================================================
= Datçik maʼlumotlarini oliş dasturlari
// =====================================================================

Datçik maʼlumotlarini oliş dasturi (drayver) datçik bilan uning interfeysi orqali aloqa qiladi, maʼlumotni öqiydi va uni yuqori darajadagi dasturlarga qulay körinişda beradi. Maʼlumot olişning uç asosiy usuli bor:
- *sörov (polling)* — dastur datçikni davriy ravişda özi söraydi; sodda, lekin protsessor vaqtini behuda sarflaşi mumkin;
- *uziliş (interrupt)* — datçik yoki apparat moduli yangi maʼlumot tayyor bölganda protsessorga signal beradi va maxsus qism-dastur (uzilişga xizmat körsatiş dasturi) uni darhol qayta işlaydi; hodisalarga tez javob beradi;
- *xotiraga töğridan-töğri murojaat (DMA)* — apparat kontroller maʼlumotlarni (masalan, ARO natijalari yoki kamera kadrlarini) protsessor iştirokisiz xotiraga köçiradi; katta oqimlar uçun eng samarali usul.

Mikrokontrollerlarda köp vazifalarni maxsus apparat modullari bajaradi va dastur ularni faqat sozlaydi: masalan, taymerlarning *enkoder rejimi* A va B kvadratur signallarini apparat darajasida sanaydi (5-maʼruza), *uşlaş rejimi* impulslar orasidagi vaqtni ölçaydi (T-usul), ARO esa taymer signali böyiça qatʼiy davr bilan diskretlaydi. Bu jitterni kamaytiradi va protsessorni böşatadi.

Datçik maʼlumotlarini olişda quyidagi qoidalarga amal qilinadi:
- har bir ölçaşga *vaqt belgisi* (timestamp) qöyiladi — turli datçiklar maʼlumotlarini birlaştiriş uçun ular qaçon olingani aniq maʼlum bölişi kerak;
- maʼlumotlar *halqasimon bufer* orqali uzatiladi — tez yozuvçi va sekin öquvçi vazifalar bir-birini kutmaydi;
- datçik javobining töğriligi tekşiriladi (nazorat yiğindisi, ruxsat etilgan diapazon, javob vaqti) va nosozlik aniqlanganda xavfsiz holatga ötiladi.

// =====================================================================
= Datçik maʼlumotlariga dasturiy işlov beriş
// =====================================================================

== Kalibrlaş va birliklarga ötkaziş

ARO kodi yoki datçik çiqişi dasturda fizik birliklarga ötkaziladi. Çiziqli datçik uçun ikki nuqtali kalibrlaş qöllanadi: maʼlum ikki qiymat $x_1, x_2$ da datçik kodlari $y_1, y_2$ yozib olinadi va ötkaziş formulasi topiladi:

#eq($ x = x_1 + (x_2 - x_1) / (y_2 - y_1) dot (y - y_1). $)

*Misol.* Harorat datçigi 0 °C da $y_1 = 410$, 100 °C da $y_2 = 3686$ kod bersa, $y = 2048$ kodga $x = 100 slash 3276 dot (2048 - 410) approx 50","0$ °C mos keladi. Noçiziqli datçiklar uçun polinomlar yoki jadval va çiziqli interpolyatsiya qöllanadi (7-maʼruza).

== Raqamli filtrlaş

Datçik signalidagi şovqinni kamaytiriş uçun dasturda raqamli filtrlar işlatiladi:
- *sirpanuvçi örtaça* — oxirgi $N$ ta ölçaş örtaçasi; oddiy, lekin $N$ ortgan sari keçikiş ortadi;
- *median filtr* — oxirgi ölçaşlarning medianasi; alohida keskin sakraşlarni (qöpol xatoliklarni) yaxşi yöqotadi;
- *eksponensial (birinçi tartibli past çastotali) filtr* — har bir yangi qiymat oldingi natija bilan tortib qöşiladi:

#eq($ hat(y)_k = alpha dot x_k + (1 - alpha) dot hat(y)_(k-1), quad alpha = T_s / (tau + T_s), $)

bu yerda $x_k$ — yangi ölçaş, $hat(y)_k$ — filtrlangan qiymat, $T_s$ — diskretlaş davri, $tau$ — filtrning vaqt doimiysi. *Misol.* $T_s = 1$ ms va $tau = 10$ ms uçun $alpha approx 0","091$. Filtr juda kam xotira va hisoblaş talab qiladi, şuning uçun mikrokontrollerlarda keng qöllanadi. Har qanday filtr şovqinni kamaytiriş bilan birga signalni keçiktiradi (9-maʼruzadagi dinamik xatolik), şuning uçun $tau$ boşqaruv talablariga mos tanlanadi.

== Datçiklar maʼlumotlarini birlaştiriş

Turli datçiklarning kuçli tomonlarini birlaştiriş uçun maʼlumotlarni birlaştiriş algoritmlari qöllanadi (1-maʼruza). Eng oddiy misol — IMU yordamida qiyalik burçagini aniqlovçi *komplementar filtr*. Giroskop burçak tezligini integrallaş qisqa muddatda aniq, lekin drift tufayli xato töplanadi; akselerometr esa gravitatsiya yönalişi böyiça burçakni driftsiz, lekin şovqin va tezlaniş taʼsirida beradi. Filtr ularni quyidagiça birlaştiradi:

#eq($ theta_k = gamma dot (theta_(k-1) + omega_k T_s) + (1 - gamma) dot theta_k^"aks", $)

bu yerda $omega_k$ — giroskop ölçagan burçak tezligi, $theta_k^"aks"$ — akselerometr böyiça hisoblangan burçak, $gamma$ — 1 ga yaqin koeffitsient (masalan, 0,98). Şunday qilib, natijaning yuqori çastotali qismi giroskopdan, past çastotali qismi esa akselerometrdan olinadi. Murakkabroq vazifalarda (navigatsiya, lokalizatsiya) Kalman filtri va uning noçiziqli kengaytmalari qöllanadi.

// =====================================================================
= Robototexnika oraliq dasturiy taʼminoti: ROS 2
// =====================================================================

== Asosiy tuşunçalar

Zamonaviy robotlarning dasturiy taʼminoti köplab mustaqil komponentlardan iborat: datçik drayverlari, filtrlar, lokalizatsiya, rejalaştiriş, boşqaruv. Ularni birlaştiriş uçun *oraliq dasturiy taʼminot* qöllanadi. Robototexnikada eng keng tarqalgan oçiq platforma — *ROS 2* (_Robot Operating System 2_). U operatsion tizim emas, balki dastur komponentlari orasida maʼlumot almaşişni taʼminlovçi kutubxonalar, vositalar va kelişuvlar töplamidir. ROS 2 da maʼlumot almaşiş DDS (_Data Distribution Service_) standarti asosida amalga oşiriladi. Asosiy tuşunçalar 3-jadvalda keltirilgan.

#figure(
  btable(
    columns: (auto, 1.5fr),
    header: ([Tuşunça], [Mazmuni]),
    [Tugun (node)],
    [Bitta vazifani bajaruvçi mustaqil dastur komponenti (masalan, LiDAR drayveri yoki filtr)],
    [Mavzu (topic)],
    [Nomlangan maʼlumot kanali; tugunlar unga xabar eʼlon qiladi (publish) yoki obuna böladi (subscribe)],
    [Xabar (message)],
    [Belgilangan tuzilişdagi maʼlumot: `sensor_msgs/Imu`, `LaserScan`, `Image`, `JointState` va boşqalar],
    [Xizmat (service)],
    [Sörov-javob körinişidagi aloqa (masalan, datçikni kalibrlaş buyruği)],
    [Harakat (action)],
    [Uzoq davom etadigan, oraliq natija beradigan topşiriq (masalan, nuqtaga boriş)],
    [tf2],
    [Robot qismlari va datçiklarning koordinatalar tizimlari orasidagi özgarişlarni boşqariş],
    [QoS sozlamalari],
    [Işonçlilik, xabarlar navbati çuqurligi va boşqa uzatiş xossalari],
    [Vositalar],
    [RViz (vizualizatsiya), rosbag (maʼlumotlarni yoziş va qayta ijro etiş), launch (işga tuşiriş)],
  ),
  caption: [ROS 2 ning asosiy tuşunçalari],
) <tab-ros>

Mobil robot informatsion tizimining ROS 2 dagi tipik tuzilişi 2-rasmda körsatilgan: har bir datçik drayveri öz mavzusiga maʼlumot eʼlon qiladi, filtr va lokalizatsiya tugunlari ularga obuna bölib, natijani boşqa mavzularga uzatadi.

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
    node((3, 1), [Rejalaştiriş \ va boşqaruv], name: <ctl>),
    edge(<imu>, <odo>, "->", [`/imu`], label-size: 8pt),
    edge(<enc>, <odo>, "->", [`/joint_states`], label-size: 8pt, label-side: right, label-pos: 0.5),
    edge(<odo>, <loc>, "->", [`/odom`], label-size: 8pt),
    edge(<lid>, <loc>, "->", [`/scan`], label-size: 8pt, label-side: right),
    edge(<loc>, <ctl>, "->", [`/pose`], label-size: 8pt),
  ),
  caption: [Mobil robot informatsion tizimining ROS 2 dagi tuzilişi (tugunlar va mavzular)],
) <fig-ros>

Bunday tuzilişning afzalligi — modullik: masalan, LiDAR boşqa modelga almaştirilsa, faqat uning drayveri özgaradi, qolgan tugunlar öşa `/scan` mavzusidan maʼlumot olişda davom etadi. Yozib olingan maʼlumotlar (rosbag) yordamida algoritmlarni robotsiz, laboratoriyada qayta-qayta sinaş mumkin.

== Dastur namunasi

Quyida Python tilidagi ROS 2 tuguniga misol keltirilgan: u IMU ning xom maʼlumotlariga obuna böladi, vertikal tezlanişni eksponensial filtr (3) bilan silliqlaydi va natijani yangi mavzuga eʼlon qiladi.

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

Dastur ROS 2 ning asosiy ğoyasini körsatadi: tugun faqat öz vazifasini bajaradi va boşqa tugunlar bilan mavzular orqali boğlanadi; datçik qaysi interfeys bilan ulangani va uning drayveri qanday işlaşi bu tugun uçun ahamiyatsiz.

// =====================================================================
= Texnik köriş va sunʼiy intellekt kutubxonalari
// =====================================================================

Texnik köriş tizimlari (8-maʼruza) uçun tasvir va nuqtalar bulutiga işlov beruvçi tayyor kutubxonalar keng qöllanadi (4-jadval).

#figure(
  btable(
    columns: (auto, 1.5fr),
    header: ([Vosita], [Vazifasi]),
    [OpenCV],
    [Tasvirga işlov berişning klassik algoritmlari: filtrlaş, segmentatsiya, konturlar, xarakterli nuqtalar, kamerani kalibrlaş, stereo köriş],
    [PCL, Open3D],
    [3D nuqtalar bulutiga işlov beriş: filtrlaş, tekisliklarni ajratiş, bulutlarni moslaştiriş (registratsiya)],
    [PyTorch, TensorFlow],
    [Neyron tarmoqlarni öqitiş: obyektlarni aniqlaş, segmentatsiya, tasniflaş],
    [ONNX Runtime, TensorRT],
    [Öqitilgan tarmoqlarni robot kompyuterida tez bajariş (inferens)],
    [Kamera SDK lari, GenICam],
    [Kameralarni sozlaş va kadrlarni olişning işlab çiqaruvçi va standart interfeyslari],
    [Tijorat köriş paketlari],
    [Sanoat sifat nazorati va robotni yönaltiriş uçun tayyor, sertifikatlangan vositalar],
  ),
  caption: [Texnik köriş dasturiy vositalari],
) <tab-kor>

Neyron tarmoqlarga asoslangan usullar obyektlarni tanib olişda klassik algoritmlardan ança ustun, lekin katta hajmdagi belgilangan öqitiş maʼlumotlarini va kuçli hisoblaş resurslarini (grafik protsessorlar yoki maxsus tezlatkiçlar) talab qiladi. Amaliyotda ikkala yondaşuv birga işlatiladi: masalan, neyron tarmoq obyektni topadi, klassik geometrik algoritm esa uning aniq holatini hisoblaydi.

// =====================================================================
= Modellaştiriş, simulyatsiya va sanoat dasturiy vositalari
// =====================================================================

== Modellaştiriş va simulyatsiya

Informatsion tizim va uning algoritmlari real robotda sinaşdan oldin modellaştiriladi:
- *MATLAB / Simulink* — datçik va filtr modellarini quriş, signalga işlov beriş va boşqaruv algoritmlarini işlab çiqiş, ulardan mikrokontroller uçun kod generatsiya qiliş;
- *LabVIEW* — ölçaş va maʼlumot yiğiş tizimlarini grafik dasturlaş;
- *robot simulyatorlari* (Gazebo, Webots, CoppeliaSim, NVIDIA Isaac Sim) — robot, uning datçiklari (kamera, LiDAR, IMU) va muhitning virtual modeli; avtonom transport uçun maxsus simulyatorlar (masalan, CARLA) ham mavjud.

Işlab çiqiş jarayonida bosqiçma-bosqiç sinov qöllanadi: *SIL* (_Software-in-the-Loop_) bosqiçida dastur simulyatsiyalangan robot va datçiklar bilan kompyuterda sinaladi; *HIL* (_Hardware-in-the-Loop_) bosqiçida haqiqiy kontroller yoki drayver real vaqtda işlaydigan virtual obyekt bilan ulanib sinaladi. Bu xavfli va qimmat sinovlarni real robotga ötişdan oldin bajariş imkonini beradi.

== Sanoat dasturiy vositalari

Sanoat robototexnik majmualarida datçiklar va robot bilan işlaş uçun quyidagi vositalar qöllanadi:
- *PLC dasturlaş muhitlari* — IEC 61131-3 standartidagi tillar: zinapoyasimon diagrammalar (LD), funksional bloklar (FBD), strukturalangan matn (ST), ketma-ket funksional diagrammalar (SFC);
- *robot işlab çiqaruvçilarining dasturlaş tillari va muhitlari* — robot harakatini datçik signallari (masalan, kuç-moment datçigi yoki kamera) bilan boğlaş uçun;
- *datçiklarni sozlaş vositalari* — IO-Link datçiklari parametrlarini örnatiş, intellektual datçiklar diagnostikasini köriş;
- *SCADA va OPC UA* — uskunalar holatini yuqori darajada kuzatiş va maʼlumotlarni korxona tizimlariga uzatiş.

// =====================================================================
= Dasturiy taʼminot sifati, işonçliligi va xavfsizligi
// =====================================================================

Informatsion tizim dasturidagi xato datçik nosozligi kabi xavfli bölişi mumkin: notöğri kalibrlaş koeffitsienti yoki keçikkan maʼlumot robotning notöğri harakatiga olib keladi. Şuning uçun dasturiy taʼminotni işlab çiqişda quyidagi tamoyillarga amal qilinadi:
- *versiyalarni boşqariş* (Git) — har bir özgariş saqlanadi va kerak bölsa oldingi holatga qaytiş mumkin;
- *testlaş* — alohida funksiyalar (modul testlari), komponentlar birgalikda (integratsion testlar) va yozib olingan real maʼlumotlar bilan sinaş;
- *diagnostika va jurnal yuritiş* — datçiklar holati, xatolar va muhim hodisalarni qayd etiş, nosozlik sabablarini keyinçalik tahlil qiliş;
- *nosozlikka çidamlilik* — datçik maʼlumoti kelmasa yoki ruxsat etilgan çegaradan çiqsa, tizimni xavfsiz holatga ötkaziş;
- *funksional xavfsizlik* — xavfsizlik funksiyalari dasturlari IEC 61508, ISO 13849, avtomobillar uçun ISO 26262 talablariga muvofiq işlab çiqiladi;
- *kiberxavfsizlik* — tarmoqqa ulangan robot va datçiklarni ruxsatsiz kirişdan himoyalaş, dasturiy yangilanişlarni tekşiriş.

// =====================================================================
= Xulosa
// =====================================================================

Robot informatsion tizimining dasturiy taʼminoti mikrodastur, örnatilgan dasturlar, operatsion tizim, oraliq dasturiy taʼminot va amaliy dasturlardan iborat köp darajali tuzilmadir. Quyi darajalarda qatʼiy real vaqt talablari ustun böladi: vazifalar RTOS yordamida rejalaştiriladi, datçik maʼlumotlari uzilişlar, DMA va apparat modullari orqali olinadi, har bir ölçaşga vaqt belgisi qöyiladi.

Dasturda datçik maʼlumotlari kalibrlanadi, raqamli filtrlar bilan şovqindan tozalanadi va komplementar yoki Kalman filtrlari yordamida birlaştiriladi. ROS 2 dastur komponentlarini tugunlar va mavzular orqali boğlab, modulli va qayta foydalaniladigan tizim quriş imkonini beradi. Texnik köriş uçun OpenCV, PCL va neyron tarmoq kutubxonalari, algoritmlarni işlab çiqiş va sinaş uçun MATLAB/Simulink va robot simulyatorlari qöllanadi. Dasturiy taʼminot sifati versiyalarni boşqariş, testlaş, diagnostika va xavfsizlik standartlariga rioya qiliş orqali taʼminlanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Robot informatsion tizimi dasturiy taʼminoti qanday darajalardan iborat?
  + Qatʼiy va yumşoq real vaqt tizimlari qanday farqlanadi? Robotdan misollar keltiring.
  + Keçikiş va jitter nima? Ular boşqaruv sifatiga qanday taʼsir qiladi?
  + Uçta vazifa uçun $C_1 = 0","2$ ms, $T_1 = 1$ ms; $C_2 = 1$ ms, $T_2 = 5$ ms; $C_3 = 30$ ms, $T_3 = 100$ ms bölsa, ular RMS çegarasini qanoatlantiradimi?
  + Sörov, uziliş va DMA usullari qanday farqlanadi?
  + Nima uçun datçik maʼlumotlariga vaqt belgisi qöyiş kerak?
  + Ikki nuqtali kalibrlaş qanday bajariladi?
  + Eksponensial filtrda $T_s = 2$ ms va $tau = 20$ ms bölsa, $alpha$ qançaga teng?
  + Komplementar filtr giroskop va akselerometr maʼlumotlarini qanday birlaştiradi?
  + ROS 2 dagi tugun, mavzu, xabar va xizmat tuşunçalarini tuşuntiring.
  + ROS 2 ning modulli tuzilişi qanday afzalliklar beradi?
  + SIL va HIL sinovlari qanday farqlanadi?
  + Informatsion tizim dasturiy taʼminotining işonçliligi qanday taʼminlanadi?
]
