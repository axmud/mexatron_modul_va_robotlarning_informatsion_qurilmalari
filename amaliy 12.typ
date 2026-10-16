// ============================================================
//  MMRIQ — 10-amaliy mashgʻulot (Turli maqsadli robotlarning
//  informatsion qurilmalari) — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_10_informatsion.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Turli maqsadlarda qoʻllaniladigan mexatron modullar va robotlarning informatsion qurilmalari")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 12  // amaliyot raqami
#set document(keywords: (info.fan,))
#set page(header: context {
  set text(size: 9pt, fill: luma(110))
  grid(
    columns: (3fr, auto, 1fr),
    align: (left, center, right),
    info.fan, info.semestr, [Amaliyot №#raqam],
  )
  v(-0.5em)
  line(length: 100%, stroke: 0.4pt + luma(170))
})
// ===================
#set text(size: 12pt, lang: "uz")
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)", supplement: none)
#show link: set text(fill: blue.darken(20%))
#show heading: set text(fill: headingblue)
#show heading.where(level: 1): set block(above: 1.4em, below: 0.9em)
#show figure.where(kind: table): set figure.caption(position: top)
#show figure.where(kind: image): set figure(supplement: "Rasm")
#show figure.where(kind: table): set figure(supplement: "Jadval")

// Blok formula (raqamlangan)
#let eq(body) = math.equation(block: true, numbering: "(1)", body)

// ---------------- Sarlavha ----------------
#align(center)[
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №12]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Turli maqsadlarda qoʻllaniladigan mexatron modullar va robotlarning informatsion qurilmalari bilan tanishish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* turli sohalarda (sanoat ishlab chiqarishi, avtonom mobil transport, tibbiyot, qishloq xoʻjaligi hamda ekstremal/kosmik tadqiqotlar) qoʻllaniladigan mexatron modullar va robotik tizimlarning informatsion qurilmalari, datchiklar arxitekturasi, koʻp sensorli maʼlumotlarni yigʻish (_data acquisition_) va birlashtirish (_sensor fusion_) tamoyillari hamda ularni tanlash va hisoblash koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Turli maqsadli mexatron modullar va robotlarda informatsion qurilmalarning vazifalari, iyerarxik tuzilishi hamda klassifikatsiyasini oʻrganish.
+ Sanoat manipulyatorlari, avtonom mobil robotlar (AGV/AMR), tibbiy robotlar hamda kosmik robototexnika majmualarining informatsion-sezgi (_sensory_) tizimlarini tahlil qilish.
+ Proprioseptiv (ichki holat: enkoder, LVDT, IMU, moment sensori) va eksteroseptiv (tashqi muhit: Lidar, RGB-D kamera, taktil, ultratovush) datchiklarning fizik-texnik xarakteristikalarini oʻrganish.
+ Turli soha robotlarida sensorik maʼlumotlarni yigʻish va koʻp darajali boshqaruv blok-diagrammalarini tuzish.
+ Turli amaliy vazifalar uchun datchiklar komplektatsiyasini tanlash hamda oʻlchash aniqligi, raqamlash va tarmoq oʻtkazuvchanligi boʻyicha muhandislik masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* turli maqsadli robotlar va mexatron modullar informatsion qurilmalari laboratoriya stendi, 6-DoF sanoat manipulyatori (KUKA/ABB), avtonom mobil robot (AGV/AMR stendi), tibbiy va mikrorobototexnika sezgi stendi (taktil va pyezosensorlar).
- *Datchiklar va oʻlchov vositalari:* absolut va inkremental optik enkoderlar, LVDT chiziqli siljish datchiklari, 6 oʻqli kuch-moment sensori (FT sensor), 2D/3D Lidar, MEMS IMU 6-DoF, ultratovush datchigi, RGB-D chuqurlik kamerasi, taktil matritsali sensor.
- *Boshqaruv va DAQ modullari:* STM32F4/F7, Arduino Mega, Siemens S7-1200 PLC, National Instruments DAQ platasi, USB-to-CAN/RS-485 adapterlari.
- *Dasturiy muhit:* MATLAB / Simulink (Robotics System Toolbox), LabVIEW, ROS / ROS 2, OpenCV.

= Nazariy maʼlumotlar va qoʻllanilish sohalari boʻyicha klassifikatsiya

== Mexatron modul va robotlarda informatsion qurilmalarning oʻrni

G.E. Regtien, W. Bolton va J.J. Craig darsliklariga koʻra, zamonaviy robototexnika va mexatronikada *informatsion qurilma* --- bu fizik obyekt va atrof-muhit holati haqidagi axborotni toʻplaydigan, kuchaytiradigan, filtrlaydigan, raqamlashtiradigan hamda boshqaruv algoritmlariga uzatadigan texnik va dasturiy vositalar majmuasidir. Informatsion qurilmalar robotning qoʻllanilish sohasi va bajaradigan texnologik vazifasiga koʻra keskin farqlanadi (@tab-class, @fig-taxonomy).

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3.2cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*№*], [*Robot va \ modul turi*], [*Asosiy informatsion \ qurilmalar*], [*Oʻlchanadigan parametr \ va maqsadi*]
      ),
      table.hline(stroke: 0.5pt),
      [1],
      [*Sanoat manipulyatorlari (6-DoF)*],
      [Absolut optik enkoder, LVDT, 6 oʻqli FT sensor, oxirgi holat kalitlari.],
      [Boʻgʻin burchaklari, harakat tezligi, tutqichdagi kuch/moment va chekka holatlar.],
      [2],
      [*Avtonom mobil robotlar (AGV / AMR)*],
      [2D/3D Lidar, MEMS IMU, gʻildirak enkoderi, ultratovush, RGB-D kamera.],
      [Atrof-muhit xaritasi (SLAM), toʻsiqlargacha masofa, gʻildirak sirpanishi va koordinata.],
      [3],
      [*Tibbiy va jarrohlik robotlari*],
      [Taktil matritsa, MEMS pyezodatchik, optik mikroenkoder, tolali optik datchik.],
      [Toʻqimaning qarshilik kuchi va qattiqligi, mikrosiljish va vizualizatsiya.],
      [4], [*Ekstremal va kosmik robotlar*], [Radiatsiyaga chidamli CMOS kamera, _star tracker_, optik giroskop.],
      [Kosmik apparat orientatsiyasi, radiatsiya darajasi va ekstremal haroratlar.],
      [5], [*Qishloq xoʻjaligi robotlari*], [Multispektral kamera, tuproq NPK va namlik sensori, RTK-GPS / GNSS.],
      [Oʻsimliklar holati (NDVI indeksi), tuproq tarkibi va aniq koordinata.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Turli maqsadli robot va mexatron modullarning informatsion qurilmalari klassifikatsiyasi],
) <tab-class>

== Sanoat robotlari informatsion qurilmalari

Sanoat manipulyatorlarida (KUKA, ABB, Fanuc) asosiy talab --- oʻta yuqori takrorlanuvchanlik ($"RP" < plus.minus 0.02 "mm"$) va tezkorlikdir. Ushbu robotlarda asosan *proprioseptiv (ichki holat)* datchiklari qoʻllaniladi:

- *Absolut optik enkoderlar:* motor va reduktor valining burchak holatini $16 dots 24$ bit ajratish qobiliyati bilan oʻlchaydi (elektr taʼminoti oʻchganda ham koordinata yoʻqolmaydi).
- *6 oʻqli kuch-moment sensorlari (FT sensor):* robot bilagiga oʻrnatilib, $F_x, F_y, F_z$ kuchlar va $M_x, M_y, M_z$ momentlarni oʻlchaydi. Detallarni montaj qilish va qirra tozalashda (_deburring_) moslashuvchan boshqaruvni taʼminlaydi.

== Avtonom mobil robotlar (AGV/AMR) informatsion qurilmalari

Mobil robotlarda asosiy vazifa --- noaniq va dinamik oʻzgaruvchan muhitda navigatsiya qilish va toʻsiqlardan qochishdir. Buning uchun *eksteroseptiv (tashqi muhit)* va proprioseptiv datchiklar birgalikda ishlatiladi (@fig-fusion):

- *2D/3D Lidar (_Light Detection and Ranging_):* lazer nuri yordamida $360 degree$ atrof-muhit masofalar xaritasini hosil qiladi (_3D point cloud_).
- *MEMS IMU (_Inertial Measurement Unit_):* 3 oʻqli akselerometr va 3 oʻqli giroskop birikmasi boʻlib, robotning burchak tezligi va chiziqli tezlanishini oʻlchaydi.
- *Multi-sensor data fusion (Kalman filtri):* gʻildirak enkoderi, IMU va Lidar maʼlumotlarini birlashtirib, robotning aniq holatini $(X, Y, theta)$ hisoblaydi.

== Tibbiyot va mikromexatronik modullar informatsion qurilmalari

Tibbiy robotlarda (masalan, da Vinci jarrohlik roboti va mikromanipulyatorlar) asosiy talab --- oʻta yuqori sezgirlik, miniatyuralik va biomoslashuvchanlikdir:

- *Taktil matritsali sensorlar (_tactile arrays_):* inson terisi kabi bosim va ushlash kuchini matritsa koordinatalarida oʻlchaydi.
- *Tolali optik datchiklar (FBG --- _Fiber Bragg Grating_):* elektromagnit xalaqitlarga (MRT muhitida) toʻliq chidamli boʻlib, mikroskopik egilish va kuchni oʻlchaydi.

= Mavzuga oid chizmalar va sxemalar

== Turli maqsadli robotlar informatsion qurilmalarining iyerarxik klassifikatsiyasi

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let arr = (end: "stealth", fill: blue-c)

    rect((-6.3, 1.95), (6.3, 2.85), fill: blue.lighten(85%), stroke: 1pt + blue-c, radius: 0.12)
    content((0, 2.4), text(
      size: 9pt,
      weight: "bold",
    )[Turli maqsadli mexatron modullar va robotlarning informatsion qurilmalari])

    let leaves = (
      (-4.4, [*Sanoat robotlari:*], ([Absolut enkoder], [LVDT datchigi], [6-DoF FT sensor], [Oxirgi holat kalitlari])),
      (0, [*Mobil robotlar (AMR):*], ([2D/3D Lidar], [MEMS IMU 6-DoF], [Gʻildirak enkoderi], [RGB-D kamera])),
      (4.4, [*Tibbiyot va kosmos:*], ([Taktil matritsa], [Tolali optik FBG], [Star tracker], [Radiatsiya sensori])),
    )
    for (x, title, items) in leaves {
      rect((x - 1.9, -1.3), (x + 1.9, 0.7), fill: blue.lighten(93%), stroke: 1pt + blue-c, radius: 0.1)
      content((x - 1.7, 0.5), anchor: "north-west", box(width: 3.1cm, align(left, text(size: 7.5pt)[
        #title \
        #items.map(i => [• #i]).join(linebreak())
      ])))
      line((x, 1.95), (x, 0.7), stroke: 1pt + blue-c, mark: arr)
    }
  }),
  caption: [Turli maqsadli robot va mexatron modullar informatsion qurilmalarining taksonomiyasi],
) <fig-taxonomy>

== Robotlarda sensorik maʼlumotlarni yigʻish va boshqaruv blok-diagrammasi

#figure(
  cetz.canvas(length: 0.72cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let blocks = (
      [Sensorlar \ majmuasi \ (enkoder, Lidar, \ IMU, kamera)],
      [Signalni \ tayyorlash \ (op-amp, FNCh, \ 16/24 bit ADC)],
      [Sensor fusion \ va filtrlash \ (Kalman / EKF)],
      [Lokal \ MCU / PLC \ (PID, \ traektoriya)],
      [Ijrochi \ mexanizm \ (motor / \ drayver)],
    )
    let labels = ([Fizik \ signal], [Raqamli \ kod], [Holat \ baho], [PWM / \ CAN])
    for (i, b) in blocks.enumerate() {
      let x = i * 3.6
      rect((x - 1.3, -0.85), (x + 1.3, 0.85), fill: blue.lighten(93%), stroke: 1pt + blue-c, radius: 0.12)
      content((x, 0), align(center, text(size: 6.5pt, weight: "bold", b)))
      if i > 0 {
        line((x - 2.3, 0), (x - 1.3, 0), stroke: 1pt + blue-c, mark: (end: "stealth", fill: blue-c))
        content((x - 1.8, 0.1), anchor: "south", align(center, text(size: 5.5pt, labels.at(i - 1))))
      }
    }
    line(
      (14.4, -0.85),
      (14.4, -1.7),
      (0, -1.7),
      (0, -0.85),
      stroke: (paint: orng, thickness: 1pt, dash: "dashed"),
      mark: (end: "stealth", fill: orng),
    )
    content((7.2, -1.8), anchor: "north", text(size: 7pt, weight: "bold")[Teskari aloqa halqasi (_feedback loop_)])
  }),
  caption: [Sensorik maʼlumotlarni yigʻish, qayta ishlash va teskari aloqali boshqaruv zanjiri],
) <fig-chain>

== Avtonom mobil robotda multi-sensor data fusion (EKF) arxitekturasi

#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let sensors = (
      [Gʻildirak enkoderlari \ (odometriya)],
      [MEMS IMU 6-DoF \ ($omega$ va $a$)],
      [2D/3D Lidar \ (masofa xaritasi)],
      [RTK-GPS / GNSS \ (tashqi koordinata)],
    )
    for (i, s) in sensors.enumerate() {
      let y = 2.4 - i * 1.6
      rect((-6.0, y - 0.55), (-3.0, y + 0.55), fill: blue.lighten(93%), stroke: 1pt + blue-c, radius: 0.1)
      content((-4.5, y), align(center, text(size: 7pt, weight: "bold", s)))
      line((-3.0, y), (-1.3, y * 0.3), stroke: 1pt + blue-c, mark: (end: "stealth", fill: blue-c))
    }
    rect((-1.3, -0.8), (2.3, 0.8), fill: orange.lighten(85%), stroke: 1pt + orng, radius: 0.12)
    content((0.5, 0), align(center, text(
      size: 7.5pt,
      weight: "bold",
    )[MULTI-SENSOR \ DATA FUSION \ (kengaytirilgan \ Kalman filtri --- EKF)]))
    line((2.3, 0), (3.6, 0), stroke: 1pt + orng, mark: (end: "stealth", fill: orng))
    rect((3.6, -0.75), (6.8, 0.75), fill: blue.lighten(80%), stroke: 1pt + blue-c, radius: 0.1)
    content((5.2, 0), align(center, text(
      size: 7pt,
      weight: "bold",
    )[Robotning aniq \ holati va xaritasi \ $(X, Y, theta)$]))
  }),
  caption: [Avtonom mobil robotda multi-sensor data fusion (EKF) arxitekturasi],
) <fig-fusion>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: turli soha robotlari informatsion qurilmalarining qiyosiy tahlili

Har bir robot turining informatsion-sezgi apparati, metrologik talablari va aloqa interfeyslarini tahlil qiling va @tab-compare ni toʻldiring.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (2.6cm, 1fr, 1fr, 1.3fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Robot \ sohasi*],
        [*Metrologik talab \ va aniqlik*],
        [*Signal va tarmoq \ interfeysi*],
        [*Asosiy ustunligi \ va kamchiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Sanoat manipulyatori*], [Takrorlanuvchanlik $"RP" < 0.02 "mm"$, oʻta yuqori tezkorlik.],
      [EtherCAT, PROFINET, real vaqtli CANopen.],
      [*Ustunligi:* yuqori aniqlik, xavfsiz. \ *Kamchiligi:* faqat barqaror muhitda ishlaydi.],
      [*Avtonom mobil robot (AMR)*], [Holat xatoligi $< 1 "cm"$, toʻsiq masofasi $0.1 dots 30 "m"$.],
      [ROS 2 topiclari, CAN-bus, Wi-Fi 6 / 5G.],
      [*Ustunligi:* dinamik muhitga moslashuvchan. \ *Kamchiligi:* sensor dreyfi va murakkab algoritmlar.],
      [*Tibbiy jarrohlik roboti*], [Mikrometr darajasidagi aniqlik, kuch sezgirligi $< 0.01 "N"$.],
      [Tolali optika, yuqori tezlikli SPI / analog.],
      [*Ustunligi:* inson toʻqimalari uchun xavfsiz. \ *Kamchiligi:* yuqori narx, sterillash sharti.],
      [*Kosmik va ekstremal robot*], [Radiatsiyaga chidamlilik ($> 100 "krad"$), $-150 dots +150 degree"C"$.],
      [SpaceWire, MIL-STD-1553, CAN.],
      [*Ustunligi:* ekstremal chidamlilik. \ *Kamchiligi:* ogʻir, resurs talabi yuqori.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Turli soha robotlari informatsion qurilmalarining qiyosiy tahlili],
) <tab-compare>

== Topshiriq 2: sanoat va mobil robot uchun informatsion qurilmalar majmuasini tanlash

Quyidagi ikkita texnologik topshiriq uchun informatsion qurilmalar komplektatsiyasini tanlang va asoslang:

+ *1-topshiriq:* sanoat liniyasida dvigatel blokiga valni $0.01 "mm"$ aniqlik bilan presslab oʻrnatish (_assembly_).
+ *2-topshiriq:* omborxonada sutkasiga 24 soat avtonom harakatlanuvchi AGV mobil roboti navigatsiyasi.

*Tahlil va yechim:*

- *1-topshiriq uchun:* _20 bitli absolut optik enkoderlar (har bir boʻgʻinda)_, _6 oʻqli FT sensor (robot bilagida)_ va _lazerli siljish datchigi (laser displacement sensor)_. Sababi: presslash kuchi $F_z$ va momentni uzluksiz nazorat qilib, detal va robotning shikastlanishining oldini oladi.
- *2-topshiriq uchun:* _2D xavfsizlik Lidari (SICK / Hokuyo)_, _MEMS IMU 6-DoF_, _gʻildirak enkoderlari_ va _ultratovushli ToF sensorlar_. Sababi: SLAM navigatsiyani va inson yaqinlashganda avtomatik toʻxtash xavfsizlik zonasini taʼminlaydi.

= Hisoblash va modellashtirish masalalari

== Masala 1: optik enkoder va moment sensori signalini raqamlash hisobi

Sanoat manipulyatori boʻgʻinidagi burchakni oʻlchash uchun $N_"enc" = 18$ bitli absolut optik enkoder qoʻllanilgan. Bilakdagi moment datchigi $M = 0 dots 100 "N" dot "m"$ diapazonda $V_"sens" = 0 dots 20 "mV"$ analog kuchlanish beradi. Signal kuchaytirish koeffitsienti $G = 150$ boʻlgan kuchaytirgich orqali 16 bitli ADC ($V_"ref" = 3.3 "V"$) ga uzatiladi.

#set enum(numbering: "a)")
+ Optik enkoderning minimal burchak ajratish qobiliyati $Delta theta$ ni gradus va burchak sekundlarida hisoblang.
+ Moment $M = 40 "N" dot "m"$ boʻlganda kuchaytirgich chiqishidagi kuchlanish $V_"amp"$ va ADC ning raqamli kodi $N_"dig"$ ni aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ N_"pos" = 2^18 = 262144, quad quad Delta theta = (360 degree) / 2^18 $

$
  V_"amp" = V_"sens" dot G = (M / M_"max" times V_"sens,max") dot G, quad quad N_"dig" = op("round")(V_"amp" / V_"ref" times (2^16 - 1))
$

*Hisoblash bosqichlari:*

- Enkoderning ajratish qobiliyati:
  $ Delta theta = (360 degree) / 262144 approx 0.0013733 degree = 0.0013733 times 3600'' approx 4.944'' $
- Moment $M = 40 "N" dot "m"$ dagi sensor kuchlanishi:
  $ V_"sens" = 40 / 100 times 20 "mV" = 8 "mV" = 0.008 "V" $
- Kuchaytirgich chiqishi $V_"amp"$ (toʻliq shkala: $20 "mV" times 150 = 3.0 "V" < V_"ref"$):
  $ V_"amp" = 0.008 "V" times 150 = 1.200 "V" $
- ADC raqamli kodi (16 bit, $2^16 - 1 = 65535$):
  $ N_"dig" = op("round")(1.200 / 3.3 times 65535) = op("round")(23830.9) = 23831 $

== Masala 2: mobil robot Lidar va IMU sensorlari maʼlumot oqimi va tarmoq yuklanishi

Avtonom mobil robotdagi 2D Lidar sekundiga 20 marta ($20 "Hz"$) $360 degree$ skanerlaydi. Har bir skan 720 ta nuqtadan iborat boʻlib, har bir nuqta 4 bayt (masofa va burchak) maʼlumot beradi. CAN-bus tarmogʻida ishlaydigan IMU datchigi har $5 "ms"$ da ($200 "Hz"$) bittadan 111 bitli standart CAN kadr uzatadi.

#set enum(numbering: "a)")
+ Lidarning 1 sekundda hosil qiladigan maʼlumotlar oqimi $B_"Lidar"$ (kB/s) ni hisoblang.
+ CAN-bus tarmogʻi tezligi $500 "kbit/s"$ boʻlganda, faqat IMU datchigining tarmoqqa beradigan yuklanish koeffitsienti (%) ni aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar* ($1 "kB" = 10^3$ bayt):

$
  B_"Lidar" = f_"scan" times N_"points" times 4 "bayt", quad quad B_"IMU" = f_"IMU" times 111 "bit", \ "Yuklanish" = B_"IMU" / v_"CAN" times 100%
$

*Hisoblash bosqichlari:*

- Lidar maʼlumotlar oqimi:
  $ B_"Lidar" = 20 "Hz" times 720 times 4 "bayt" = 57600 "bayt/s" = 57.6 "kB/s" $
- IMU bitlar oqimi ($f_"IMU" = 200 "Hz"$):
  $ B_"IMU" = 200 times 111 "bit" = 22200 "bit/s" = 22.2 "kbit/s" $
- CAN-bus yuklanishi ($500 "kbit/s"$ da):
  $ "Yuklanish" = 22200 / 500000 times 100% = 4.44% $

== Masala 3: tibbiy mikromexatronik modulda taktil sensor va ADC hisobi

Tibbiy mikromanipulyatorda taktil datchik bosim kuchi $F = 0 dots 2.0 "N"$ oraligʻida $R_"tactile" = 10 "k"Omega dots 1.0 "k"Omega$ chiziqsiz qarshilik oʻzgarishini beradi. Datchik teskari aloqa rezistori $R_f = 5.0 "k"Omega$ boʻlgan inverslovchi kuchaytirgich zanjiriga kirish rezistori sifatida ulangan. $F = 1.0 "N"$ boʻlganda datchik qarshiligi $R_"tactile" = 2.5 "k"Omega$ ga teng. Tayanch kuchlanishi $|V_"in"| = 2.5 "V"$.

#set enum(numbering: "a)")
+ Inverslovchi kuchaytirgich chiqish kuchlanishi $V_"out" = -V_"in" dot R_f \/ R_"tactile"$ ni hisoblang.
+ ADC 12 bitli ($V_"ref" = 3.3 "V"$) boʻlsa, $R_f$ ni butun diapazon uchun tanlang va $F = 1.0 "N"$ dagi chiqish kodi $N_"dig"$ ni aniqlang.
#set enum(numbering: "1.")

*Hisoblash bosqichlari:*

- Kuchaytirgich chiqish kuchlanishi amplitudasi ($R_f = 5.0 "k"Omega$):
  $ |V_"out"| = 2.5 "V" times (5.0 "k"Omega) / (2.5 "k"Omega) = 2.5 times 2.0 = 5.0 "V" $
  Bu qiymat ADC diapazonidan ($3.3 "V"$) katta, shuning uchun $R_f$ kamaytirilishi kerak. Chiqish kuchlanishi eng katta kuchda ($F = 2.0 "N"$, $R_"tactile" = R_"min" = 1.0 "k"Omega$) ham $V_"ref"$ dan oshmasligi lozim:
  $
    R_f <= V_"ref" / (|V_"in"|) dot R_"min" = 3.3 / 2.5 times 1.0 "k"Omega = 1.32 "k"Omega quad => quad R_f = 1.2 "k"Omega "(E12 qatori)"
  $
  Chiqish musbat boʻlishi uchun tayanch kuchlanishi $V_"in" = -2.5 "V"$ olinadi (yoki chiqishga $-1$ kuchaytirishli ikkinchi inverslovchi kaskad qoʻyiladi).
- $F = 1.0 "N"$ dagi chiqish kuchlanishi:
  $ V_"out" = 2.5 "V" times (1.2 "k"Omega) / (2.5 "k"Omega) = 1.20 "V" quad (F = 2.0 "N" "da": 3.0 "V" < 3.3 "V") $
- ADC kodi (12 bit, $2^12 - 1 = 4095$):
  $ N_"dig" = op("round")(1.20 / 3.3 times 4095) = op("round")(1489.1) = 1489 $

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: turli soha robotlarining informatsion qurilmalarini koʻzdan kechirish.* Laboratoriya stendidagi sanoat roboti (enkoder, FT sensor) va mobil robot (Lidar, IMU, ultratovush) sensorik modullarini oʻrganing.
+ *2-bosqich: sanoat manipulyatori FT sensori signallarini ossillografda kuzatish.* FT sensorga turli yoʻnalishlarda $F_x, F_y, F_z$ kuchlarini berib, kuchaytirgich chiqishidagi va ADC kirishidagi kuchlanish signallarini ossillografda qayd eting.
+ *3-bosqich: avtonom mobil robot Lidar va IMU maʼlumotlarini ROS 2 da vizualizatsiya qilish.* ROS 2 `rviz2` muhitida 2D Lidar nuqtalar bulutini va IMU burchak tezliklarini real vaqt rejimida kuzating.
+ *4-bosqich: multi-sensor data fusion algoritmini sinash.* MATLAB/Simulink da gʻildirak enkoderi va IMU maʼlumotlarini kengaytirilgan Kalman filtri (EKF) orqali birlashtirib, robot traektoriyasini hisoblang.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Olingan natijalarni tahlil qilib, amaliy hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Turli maqsadli robotlarda (sanoat, mobil, tibbiy, kosmik) informatsion qurilmalarga qoʻyiladigan asosiy metrologik va texnik talablarni sanab bering.
+ Proprioseptiv va eksteroseptiv datchiklarning taʼrifi hamda ularning robototexnikadagi misollarini ayting.
+ Sanoat manipulyatorlarida 6 oʻqli kuch-moment sensori (FT sensor) qanday vazifani bajaradi?
+ Avtonom mobil robotlarda (AGV/AMR) SLAM navigatsiyasida Lidar va IMU datchiklarining tutgan oʻrni nimadan iborat?
+ Multi-sensor data fusion (kengaytirilgan Kalman filtri --- EKF) nima uchun qoʻllaniladi va u sensor xatoliklarini qanday kamaytiradi?
+ Tibbiyot va jarrohlik robotlarida taktil matritsali sensorlar va tolali optik (FBG) datchiklarning afzalliklari nimalardan iborat?
+ Kosmik va ekstremal muhit robotlarining informatsion qurilmalariga qoʻyiladigan radiatsiya va harorat chidamliligi talablarini tushuntiring.
+ Optik absolut va inkremental enkoderlarning sanoat robotlari boʻgʻinlarida qoʻllanilish farqini ayting.
+ Qishloq xoʻjaligi robotlarida multispektral kameralar va RTK-GPS navigatsiya tizimlarining ishlash prinsipi qanday?
+ CAN-bus va EtherCAT sanoat tarmoqlarining robotik informatsion tizimlarda qoʻllanilish sabablari nimada?
+ Lidar va ultratovush datchiklarining toʻsiqlarni aniqlashdagi fizik farqlari hamda afzallik va kamchiliklarini tushuntiring.
+ Smart sensorlar va Edge AI texnologiyalarining turli soha robotlari informatsion qurilmalaridagi kelajakdagi imkoniyatlarini izohlang.
