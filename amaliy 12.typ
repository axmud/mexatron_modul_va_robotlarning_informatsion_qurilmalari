// ============================================================
//  MMRIQ — 10-amaliy mashgʻulot (Turli maqsadli robotlarning
//  informatsion qurilmalari) — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_10_informatsion.typ
// ============================================================

#import "@preview/cetz:0.4.2"

#let headingblue = rgb(20, 50, 120)

#set document(title: "Turli maqsadlarda qöllaniladigan mexatron modullar va robotlarning informatsion qurilmalari")
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
#set text(size: 12pt, lang: "uz", font: info.font)
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №12]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Turli maqsadlarda qöllaniladigan mexatron modullar va robotlarning informatsion qurilmalari bilan tanişiş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* turli sohalarda (sanoat işlab çiqarişi, avtonom mobil transport, tibbiyot, qişloq xöjaligi hamda ekstremal/kosmik tadqiqotlar) qöllaniladigan mexatron modullar va robotik tizimlarning informatsion qurilmalari, datçiklar arxitekturasi, köp sensorli maʼlumotlarni yiğiş (_data acquisition_) va birlaştiriş (_sensor fusion_) tamoyillari hamda ularni tanlaş va hisoblaş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Turli maqsadli mexatron modullar va robotlarda informatsion qurilmalarning vazifalari, iyerarxik tuzilişi hamda klassifikatsiyasini örganiş.
+ Sanoat manipulyatorlari, avtonom mobil robotlar (AGV/AMR), tibbiy robotlar hamda kosmik robototexnika majmualarining informatsion-sezgi (_sensory_) tizimlarini tahlil qiliş.
+ Proprioseptiv (içki holat: enkoder, LVDT, IMU, moment sensori) va eksteroseptiv (taşqi muhit: Lidar, RGB-D kamera, taktil, ultratovuş) datçiklarning fizik-texnik xarakteristikalarini örganiş.
+ Turli soha robotlarida sensorik maʼlumotlarni yiğiş va köp darajali boşqaruv blok-diagrammalarini tuziş.
+ Turli amaliy vazifalar uçun datçiklar komplektatsiyasini tanlaş hamda ölçaş aniqligi, raqamlaş va tarmoq ötkazuvçanligi böyiça muhandislik masalalarini yeçiş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* turli maqsadli robotlar va mexatron modullar informatsion qurilmalari laboratoriya stendi, 6-DoF sanoat manipulyatori (KUKA/ABB), avtonom mobil robot (AGV/AMR stendi), tibbiy va mikrorobototexnika sezgi stendi (taktil va pyezosensorlar).
- *Datçiklar va ölçov vositalari:* absolut va inkremental optik enkoderlar, LVDT çiziqli siljiş datçiklari, 6 öqli kuç-moment sensori (FT sensor), 2D/3D Lidar, MEMS IMU 6-DoF, ultratovuş datçigi, RGB-D çuqurlik kamerasi, taktil matritsali sensor.
- *Boşqaruv va DAQ modullari:* STM32F4/F7, Arduino Mega, Siemens S7-1200 PLC, National Instruments DAQ platasi, USB-to-CAN/RS-485 adapterlari.
- *Dasturiy muhit:* MATLAB / Simulink (Robotics System Toolbox), LabVIEW, ROS / ROS 2, OpenCV.

= Nazariy maʼlumotlar va qöllaniliş sohalari böyiça klassifikatsiya

== Mexatron modul va robotlarda informatsion qurilmalarning örni

G.E. Regtien, W. Bolton va J.J. Craig darsliklariga köra, zamonaviy robototexnika va mexatronikada *informatsion qurilma* --- bu fizik obyekt va atrof-muhit holati haqidagi axborotni töplaydigan, kuçaytiradigan, filtrlaydigan, raqamlaştiradigan hamda boşqaruv algoritmlariga uzatadigan texnik va dasturiy vositalar majmuasidir. Informatsion qurilmalar robotning qöllaniliş sohasi va bajaradigan texnologik vazifasiga köra keskin farqlanadi (@tab-class, @fig-taxonomy).

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
        [*№*], [*Robot va \ modul turi*], [*Asosiy informatsion \ qurilmalar*], [*Ölçanadigan parametr \ va maqsadi*]
      ),
      table.hline(stroke: 0.5pt),
      [1],
      [*Sanoat manipulyatorlari (6-DoF)*],
      [Absolut optik enkoder, LVDT, 6 öqli FT sensor, oxirgi holat kalitlari.],
      [Böğin burçaklari, harakat tezligi, tutqiçdagi kuç/moment va çekka holatlar.],
      [2],
      [*Avtonom mobil robotlar (AGV / AMR)*],
      [2D/3D Lidar, MEMS IMU, ğildirak enkoderi, ultratovuş, RGB-D kamera.],
      [Atrof-muhit xaritasi (SLAM), tösiqlargaça masofa, ğildirak sirpanişi va koordinata.],
      [3],
      [*Tibbiy va jarrohlik robotlari*],
      [Taktil matritsa, MEMS pyezodatçik, optik mikroenkoder, tolali optik datçik.],
      [Töqimaning qarşilik kuçi va qattiqligi, mikrosiljiş va vizualizatsiya.],
      [4], [*Ekstremal va kosmik robotlar*], [Radiatsiyaga çidamli CMOS kamera, _star tracker_, optik giroskop.],
      [Kosmik apparat orientatsiyasi, radiatsiya darajasi va ekstremal haroratlar.],
      [5], [*Qişloq xöjaligi robotlari*], [Multispektral kamera, tuproq NPK va namlik sensori, RTK-GPS / GNSS.],
      [Ösimliklar holati (NDVI indeksi), tuproq tarkibi va aniq koordinata.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Turli maqsadli robot va mexatron modullarning informatsion qurilmalari klassifikatsiyasi],
) <tab-class>

== Sanoat robotlari informatsion qurilmalari

Sanoat manipulyatorlarida (KUKA, ABB, Fanuc) asosiy talab --- öta yuqori takrorlanuvçanlik ($"RP" < plus.minus 0.02 "mm"$) va tezkorlikdir. Uşbu robotlarda asosan *proprioseptiv (içki holat)* datçiklari qöllaniladi:

- *Absolut optik enkoderlar:* motor va reduktor valining burçak holatini $16 dots 24$ bit ajratiş qobiliyati bilan ölçaydi (elektr taʼminoti öçganda ham koordinata yöqolmaydi).
- *6 öqli kuç-moment sensorlari (FT sensor):* robot bilagiga örnatilib, $F_x, F_y, F_z$ kuçlar va $M_x, M_y, M_z$ momentlarni ölçaydi. Detallarni montaj qiliş va qirra tozalaşda (_deburring_) moslaşuvçan boşqaruvni taʼminlaydi.

== Avtonom mobil robotlar (AGV/AMR) informatsion qurilmalari

Mobil robotlarda asosiy vazifa --- noaniq va dinamik özgaruvçan muhitda navigatsiya qiliş va tösiqlardan qoçişdir. Buning uçun *eksteroseptiv (taşqi muhit)* va proprioseptiv datçiklar birgalikda işlatiladi (@fig-fusion):

- *2D/3D Lidar (_Light Detection and Ranging_):* lazer nuri yordamida $360 degree$ atrof-muhit masofalar xaritasini hosil qiladi (_3D point cloud_).
- *MEMS IMU (_Inertial Measurement Unit_):* 3 öqli akselerometr va 3 öqli giroskop birikmasi bölib, robotning burçak tezligi va çiziqli tezlanişini ölçaydi.
- *Multi-sensor data fusion (Kalman filtri):* ğildirak enkoderi, IMU va Lidar maʼlumotlarini birlaştirib, robotning aniq holatini $(X, Y, theta)$ hisoblaydi.

== Tibbiyot va mikromexatronik modullar informatsion qurilmalari

Tibbiy robotlarda (masalan, da Vinci jarrohlik roboti va mikromanipulyatorlar) asosiy talab --- öta yuqori sezgirlik, miniatyuralik va biomoslaşuvçanlikdir:

- *Taktil matritsali sensorlar (_tactile arrays_):* inson terisi kabi bosim va uşlaş kuçini matritsa koordinatalarida ölçaydi.
- *Tolali optik datçiklar (FBG --- _Fiber Bragg Grating_):* elektromagnit xalaqitlarga (MRT muhitida) töliq çidamli bölib, mikroskopik egiliş va kuçni ölçaydi.

= Mavzuga oid çizmalar va sxemalar

== Turli maqsadli robotlar informatsion qurilmalarining iyerarxik klassifikatsiyasi

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let arr = (end: "stealth", fill: blue-c)

    rect((-6.9, 1.95), (6.9, 2.88), fill: blue.lighten(85%), stroke: 1pt + blue-c, radius: 0.12)
    content((0, 2.4), text(
      size: 9pt,
      weight: "bold",
    )[Turli maqsadli mexatron modullar va robotlarning informatsion qurilmalari])

    let leaves = (
      (-4.4, [*Sanoat robotlari:*], ([Absolut enkoder], [LVDT datçigi], [6-DoF FT sensor], [Oxirgi holat kalitlari])),
      (0, [*Mobil robotlar (AMR):*], ([2D/3D Lidar], [MEMS IMU 6-DoF], [Ğildirak enkoderi], [RGB-D kamera])),
      (4.4, [*Tibbiyot va kosmos:*], ([Taktil matritsa], [Tolali optik FBG], [Star tracker], [Radiatsiya sensori])),
    )
    for (x, title, items) in leaves {
      rect((x - 2, -1.4), (x + 1.9, 0.7), fill: blue.lighten(93%), stroke: 1pt + blue-c, radius: 0.1)
      content((x - 1.7, 0.5), anchor: "north-west", box(width: 3.1cm, align(left, text(size: 7.5pt)[
        #title \
        #items.map(i => [• #i]).join(linebreak())
      ])))
      line((x, 1.95), (x, 0.7), stroke: 1pt + blue-c, mark: arr)
    }
  }),
  caption: [Turli maqsadli robot va mexatron modullar informatsion qurilmalarining taksonomiyasi],
) <fig-taxonomy>

== Robotlarda sensorik maʼlumotlarni yiğiş va boşqaruv blok-diagrammasi

#figure(
  cetz.canvas(length: 0.72cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let blocks = (
      [Sensorlar \ majmuasi \ (enkoder, Lidar, \ IMU, kamera)],
      [Signalni \ tayyorlaş \ (op-amp, FNÇ, \ 16/24 bit ADC)],
      [Sensor fusion \ va filtrlaş \ (Kalman / EKF)],
      [Lokal \ MCU / PLC \ (PID, \ traektoriya)],
      [Ijroçi \ mexanizm \ (motor / \ drayver)],
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
  caption: [Sensorik maʼlumotlarni yiğiş, qayta işlaş va teskari aloqali boşqaruv zanjiri],
) <fig-chain>

== Avtonom mobil robotda multi-sensor data fusion (EKF) arxitekturasi

#figure(
  cetz.canvas(length: 0.85cm, {
    import cetz.draw: *

    let blue-c = headingblue
    let orng = orange.darken(15%)
    let sensors = (
      [Ğildirak enkoderlari \ (odometriya)],
      [MEMS IMU 6-DoF \ ($omega$ va $a$)],
      [2D/3D Lidar \ (masofa xaritasi)],
      [RTK-GPS / GNSS \ (taşqi koordinata)],
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

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: turli soha robotlari informatsion qurilmalarining qiyosiy tahlili

Har bir robot turining informatsion-sezgi apparati, metrologik talablari va aloqa interfeyslarini tahlil qiling va @tab-compare ni töldiring.

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
        [*Asosiy ustunligi \ va kamçiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Sanoat manipulyatori*], [Takrorlanuvçanlik $"RP" < 0.02 "mm"$, öta yuqori tezkorlik.],
      [EtherCAT, PROFINET, real vaqtli CANopen.],
      [*Ustunligi:* yuqori aniqlik, xavfsiz. \ *Kamçiligi:* faqat barqaror muhitda işlaydi.],
      [*Avtonom mobil robot (AMR)*], [Holat xatoligi $< 1 "cm"$, tösiq masofasi $0.1 dots 30 "m"$.],
      [ROS 2 topiclari, CAN-bus, Wi-Fi 6 / 5G.],
      [*Ustunligi:* dinamik muhitga moslaşuvçan. \ *Kamçiligi:* sensor dreyfi va murakkab algoritmlar.],
      [*Tibbiy jarrohlik roboti*], [Mikrometr darajasidagi aniqlik, kuç sezgirligi $< 0.01 "N"$.],
      [Tolali optika, yuqori tezlikli SPI / analog.],
      [*Ustunligi:* inson töqimalari uçun xavfsiz. \ *Kamçiligi:* yuqori narx, sterillaş şarti.],
      [*Kosmik va ekstremal robot*], [Radiatsiyaga çidamlilik ($> 100 "krad"$), $-150 dots +150 degree"C"$.],
      [SpaceWire, MIL-STD-1553, CAN.],
      [*Ustunligi:* ekstremal çidamlilik. \ *Kamçiligi:* oğir, resurs talabi yuqori.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Turli soha robotlari informatsion qurilmalarining qiyosiy tahlili],
) <tab-compare>

== Topşiriq 2: sanoat va mobil robot uçun informatsion qurilmalar majmuasini tanlaş

Quyidagi ikkita texnologik topşiriq uçun informatsion qurilmalar komplektatsiyasini tanlang va asoslang:

+ *1-topşiriq:* sanoat liniyasida dvigatel blokiga valni $0.01 "mm"$ aniqlik bilan presslab örnatiş (_assembly_).
+ *2-topşiriq:* omborxonada sutkasiga 24 soat avtonom harakatlanuvçi AGV mobil roboti navigatsiyasi.

*Tahlil va yeçim:*

- *1-topşiriq uçun:* _20 bitli absolut optik enkoderlar (har bir böğinda)_, _6 öqli FT sensor (robot bilagida)_ va _lazerli siljiş datçigi (laser displacement sensor)_. Sababi: presslaş kuçi $F_z$ va momentni uzluksiz nazorat qilib, detal va robotning şikastlanişining oldini oladi.
- *2-topşiriq uçun:* _2D xavfsizlik Lidari (SICK / Hokuyo)_, _MEMS IMU 6-DoF_, _ğildirak enkoderlari_ va _ultratovuşli ToF sensorlar_. Sababi: SLAM navigatsiyani va inson yaqinlaşganda avtomatik töxtaş xavfsizlik zonasini taʼminlaydi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: optik enkoder va moment sensori signalini raqamlaş hisobi

Sanoat manipulyatori böğinidagi burçakni ölçaş uçun $N_"enc" = 18$ bitli absolut optik enkoder qöllanilgan. Bilakdagi moment datçigi $M = 0 dots 100 "N" dot "m"$ diapazonda $V_"sens" = 0 dots 20 "mV"$ analog kuçlaniş beradi. Signal kuçaytiriş koeffitsienti $G = 150$ bölgan kuçaytirgiç orqali 16 bitli ADC ($V_"ref" = 3.3 "V"$) ga uzatiladi.

#set enum(numbering: "a)")
+ Optik enkoderning minimal burçak ajratiş qobiliyati $Delta theta$ ni gradus va burçak sekundlarida hisoblang.
+ Moment $M = 40 "N" dot "m"$ bölganda kuçaytirgiç çiqişidagi kuçlaniş $V_"amp"$ va ADC ning raqamli kodi $N_"dig"$ ni aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ N_"pos" = 2^18 = 262144, quad quad Delta theta = (360 degree) / 2^18 $

$
  V_"amp" = V_"sens" dot G = (M / M_"max" times V_"sens,max") dot G, quad quad N_"dig" = op("round")(V_"amp" / V_"ref" times (2^16 - 1))
$

*Hisoblaş bosqiçlari:*

- Enkoderning ajratiş qobiliyati:
  $ Delta theta = (360 degree) / 262144 approx 0.0013733 degree = 0.0013733 times 3600'' approx 4.944'' $
- Moment $M = 40 "N" dot "m"$ dagi sensor kuçlanişi:
  $ V_"sens" = 40 / 100 times 20 "mV" = 8 "mV" = 0.008 "V" $
- Kuçaytirgiç çiqişi $V_"amp"$ (töliq şkala: $20 "mV" times 150 = 3.0 "V" < V_"ref"$):
  $ V_"amp" = 0.008 "V" times 150 = 1.200 "V" $
- ADC raqamli kodi (16 bit, $2^16 - 1 = 65535$):
  $ N_"dig" = op("round")(1.200 / 3.3 times 65535) = op("round")(23830.9) = 23831 $

== Masala 2: mobil robot Lidar va IMU sensorlari maʼlumot oqimi va tarmoq yuklanişi

Avtonom mobil robotdagi 2D Lidar sekundiga 20 marta ($20 "Hz"$) $360 degree$ skanerlaydi. Har bir skan 720 ta nuqtadan iborat bölib, har bir nuqta 4 bayt (masofa va burçak) maʼlumot beradi. CAN-bus tarmoğida işlaydigan IMU datçigi har $5 "ms"$ da ($200 "Hz"$) bittadan 111 bitli standart CAN kadr uzatadi.

#set enum(numbering: "a)")
+ Lidarning 1 sekundda hosil qiladigan maʼlumotlar oqimi $B_"Lidar"$ (kB/s) ni hisoblang.
+ CAN-bus tarmoği tezligi $500 "kbit/s"$ bölganda, faqat IMU datçigining tarmoqqa beradigan yuklaniş koeffitsienti (%) ni aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar* ($1 "kB" = 10^3$ bayt):

$
  B_"Lidar" = f_"scan" times N_"points" times 4 "bayt", quad quad B_"IMU" = f_"IMU" times 111 "bit", \ "Yuklaniş" = B_"IMU" / v_"CAN" times 100%
$

*Hisoblaş bosqiçlari:*

- Lidar maʼlumotlar oqimi:
  $ B_"Lidar" = 20 "Hz" times 720 times 4 "bayt" = 57600 "bayt/s" = 57.6 "kB/s" $
- IMU bitlar oqimi ($f_"IMU" = 200 "Hz"$):
  $ B_"IMU" = 200 times 111 "bit" = 22200 "bit/s" = 22.2 "kbit/s" $
- CAN-bus yuklanişi ($500 "kbit/s"$ da):
  $ "Yuklaniş" = 22200 / 500000 times 100% = 4.44% $

== Masala 3: tibbiy mikromexatronik modulda taktil sensor va ADC hisobi

Tibbiy mikromanipulyatorda taktil datçik bosim kuçi $F = 0 dots 2.0 "N"$ oraliğida $R_"tactile" = 10 "k"Omega dots 1.0 "k"Omega$ çiziqsiz qarşilik özgarişini beradi. Datçik teskari aloqa rezistori $R_f = 5.0 "k"Omega$ bölgan inverslovçi kuçaytirgiç zanjiriga kiriş rezistori sifatida ulangan. $F = 1.0 "N"$ bölganda datçik qarşiligi $R_"tactile" = 2.5 "k"Omega$ ga teng. Tayanç kuçlanişi $|V_"in"| = 2.5 "V"$.

#set enum(numbering: "a)")
+ Inverslovçi kuçaytirgiç çiqiş kuçlanişi $V_"out" = -V_"in" dot R_f \/ R_"tactile"$ ni hisoblang.
+ ADC 12 bitli ($V_"ref" = 3.3 "V"$) bölsa, $R_f$ ni butun diapazon uçun tanlang va $F = 1.0 "N"$ dagi çiqiş kodi $N_"dig"$ ni aniqlang.
#set enum(numbering: "1.")

*Hisoblaş bosqiçlari:*

- Kuçaytirgiç çiqiş kuçlanişi amplitudasi ($R_f = 5.0 "k"Omega$):
  $ |V_"out"| = 2.5 "V" times (5.0 "k"Omega) / (2.5 "k"Omega) = 2.5 times 2.0 = 5.0 "V" $
  Bu qiymat ADC diapazonidan ($3.3 "V"$) katta, şuning uçun $R_f$ kamaytirilişi kerak. Çiqiş kuçlanişi eng katta kuçda ($F = 2.0 "N"$, $R_"tactile" = R_"min" = 1.0 "k"Omega$) ham $V_"ref"$ dan oşmasligi lozim:
  $
    R_f <= V_"ref" / (|V_"in"|) dot R_"min" = 3.3 / 2.5 times 1.0 "k"Omega = 1.32 "k"Omega quad => quad R_f = 1.2 "k"Omega "(E12 qatori)"
  $
  Çiqiş musbat bölişi uçun tayanç kuçlanişi $V_"in" = -2.5 "V"$ olinadi (yoki çiqişga $-1$ kuçaytirişli ikkinçi inverslovçi kaskad qöyiladi).
- $F = 1.0 "N"$ dagi çiqiş kuçlanişi:
  $ V_"out" = 2.5 "V" times (1.2 "k"Omega) / (2.5 "k"Omega) = 1.20 "V" quad (F = 2.0 "N" "da": 3.0 "V" < 3.3 "V") $
- ADC kodi (12 bit, $2^12 - 1 = 4095$):
  $ N_"dig" = op("round")(1.20 / 3.3 times 4095) = op("round")(1489.1) = 1489 $

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: turli soha robotlarining informatsion qurilmalarini közdan keçiriş.* Laboratoriya stendidagi sanoat roboti (enkoder, FT sensor) va mobil robot (Lidar, IMU, ultratovuş) sensorik modullarini örganing.
+ *2-bosqiç: sanoat manipulyatori FT sensori signallarini ossillografda kuzatiş.* FT sensorga turli yönalişlarda $F_x, F_y, F_z$ kuçlarini berib, kuçaytirgiç çiqişidagi va ADC kirişidagi kuçlaniş signallarini ossillografda qayd eting.
+ *3-bosqiç: avtonom mobil robot Lidar va IMU maʼlumotlarini ROS 2 da vizualizatsiya qiliş.* ROS 2 `rviz2` muhitida 2D Lidar nuqtalar bulutini va IMU burçak tezliklarini real vaqt rejimida kuzating.
+ *4-bosqiç: multi-sensor data fusion algoritmini sinaş.* MATLAB/Simulink da ğildirak enkoderi va IMU maʼlumotlarini kengaytirilgan Kalman filtri (EKF) orqali birlaştirib, robot traektoriyasini hisoblang.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Olingan natijalarni tahlil qilib, amaliy hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Turli maqsadli robotlarda (sanoat, mobil, tibbiy, kosmik) informatsion qurilmalarga qöyiladigan asosiy metrologik va texnik talablarni sanab bering.
+ Proprioseptiv va eksteroseptiv datçiklarning taʼrifi hamda ularning robototexnikadagi misollarini ayting.
+ Sanoat manipulyatorlarida 6 öqli kuç-moment sensori (FT sensor) qanday vazifani bajaradi?
+ Avtonom mobil robotlarda (AGV/AMR) SLAM navigatsiyasida Lidar va IMU datçiklarining tutgan örni nimadan iborat?
+ Multi-sensor data fusion (kengaytirilgan Kalman filtri --- EKF) nima uçun qöllaniladi va u sensor xatoliklarini qanday kamaytiradi?
+ Tibbiyot va jarrohlik robotlarida taktil matritsali sensorlar va tolali optik (FBG) datçiklarning afzalliklari nimalardan iborat?
+ Kosmik va ekstremal muhit robotlarining informatsion qurilmalariga qöyiladigan radiatsiya va harorat çidamliligi talablarini tuşuntiring.
+ Optik absolut va inkremental enkoderlarning sanoat robotlari böğinlarida qöllaniliş farqini ayting.
+ Qişloq xöjaligi robotlarida multispektral kameralar va RTK-GPS navigatsiya tizimlarining işlaş prinsipi qanday?
+ CAN-bus va EtherCAT sanoat tarmoqlarining robotik informatsion tizimlarda qöllaniliş sabablari nimada?
+ Lidar va ultratovuş datçiklarining tösiqlarni aniqlaşdagi fizik farqlari hamda afzallik va kamçiliklarini tuşuntiring.
+ Smart sensorlar va Edge AI texnologiyalarining turli soha robotlari informatsion qurilmalaridagi kelajakdagi imkoniyatlarini izohlang.
