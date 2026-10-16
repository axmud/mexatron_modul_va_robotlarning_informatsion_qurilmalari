// ============================================================
//  MMRIQ — 3-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_3.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Mexatron modullar va robotlarda qoʻllaniladigan informatsion tizimlar")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 3  // amaliyot raqami
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

// Raqamlanmagan formula
#let eq(body) = math.equation(block: true, numbering: "(1)", body)

// ---------------- Sarlavha ----------------
#align(center)[
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №3]
  #v(0.4cm)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Mexatron modullar va robotlarda qoʻllaniladigan informatsion tizimlar, ularning sinflanishi bilan tanishish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]

#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatron modullar, sanoat va avtonom robotlarda qoʻllaniladigan informatsion-oʻlchov tizimlarining funksional tuzilishi, datchiklar (sensorlar) sinflanishi, signalni konditsiyalash (shakllantirish), maʼlumotlarni yigʻish (DAQ) hamda sanoat tarmoq interfeyslari (CAN, EtherCAT, Modbus) boʻyicha chuqurlashtirilgan amaliy hamda nazariy koʻnikmalarni shakllantirish.

*Oʻquv vazifalari:*

+ Mexatronika va robototexnikada informatsion tizimlarning iyerarxik darajalarini (sensor darajasi, signalni qayta ishlash, lokal boshqaruv va intellektual daraja) oʻrganish.
+ Sensorlarning chiqish signali koʻrinishiga koʻra (binar, analog, raqamli va smart) hamda oʻlchanadigan fizik kattalikka koʻra sinflanishini tahlil qilish.
+ Signalni konditsiyalash bloklari: operatsion va instrumental kuchaytirgichlar, past va yuqori chastotali filtrlar hamda analog-raqamli oʻzgartirgichlar (ADC) ishlash prinsiplarini oʻrganish.
+ Sanoat va robototexnika axborot uzatish shinalari (CAN-bus, EtherCAT, Modbus, SPI, I2C, UART) paket kadri hamda tezlik koʻrsatkichlarini qiyosiy tahlil qilish.
+ Koʻp sensorli maʼlumotlarni birlashtirish (_Multi-sensor Data Fusion_) arxitekturasi va sensor koʻrsatkichlarini hisoblash boʻyicha muhandislik masalalarini yechish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* informatsion-oʻlchov tizimlari laboratoriya stendi, koʻp kanalli analog va raqamli datchiklar (LVDT, optik/magnit enkoderlar, MEMS akselerometr/giroskop, tenzodatchiklar, ultratovush va IQ masofa oʻlchagichlar).
- *Nazorat-oʻlchov va aloqa interfeyslari:* ikki kanalli raqamli ossillograf, raqamli multimetr, CAN-bus va EtherCAT mantiqiy analizatorlari, USB-to-CAN/RS-485 adapterlari.
- *Boshqaruv va DAQ modullari:* STM32F4/F7 mikrokontrollerli plata, Arduino Mega, Siemens S7-1200 PLC, National Instruments DAQ platasi.
- *Dasturiy muhit:* MATLAB / Simulink (Data Acquisition & Signal Processing Toolbox), LabVIEW, Proteus, ROS / ROS 2 sensor drayverlari.

= Nazariy maʼlumotlar va informatsion tizimlar klassifikatsiyasi

== Mexatronika va robototexnikada informatsion tizimning oʻrni

Zamonaviy mexatronik modul va robotik tizimlarda *informatsion tizim* --- bu fizik obyektning holati, atrof-muhit parametrlari hamda ichki tugunlarning dinamik koʻrsatkichlari haqidagi maʼlumotlarni toʻplaydigan, uzatadigan, filtrlaydigan va yuqori darajali boshqaruv algoritmlariga tayyorlab beradigan texnik hamda dasturiy vositalar majmuasidir.

P.P.L. Regtien va W. Bolton taʼrifiga koʻra, informatsion tizimlar mexatronik qurilmaning "sezgi aʼzolari" boʻlib, ular yopiq zanjirli boshqaruv tizimida (_closed-loop control_) teskari aloqani (_feedback_) taʼminlaydi. Informatsion tizimsiz robot aniq va xavfsiz harakat qila olmaydi.

== Informatsion-oʻlchov datchiklarining sinflanishi

Informatsion qurilmalar va sensorlar bir necha asosiy mezonlar boʻyicha sinflanadi (@tab-class).

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (auto, 3cm, 3.6cm, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Sinflash mezoni*], [*Datchik turlari*], [*Xarakterli vakillari va ishlatilish joyi*]),
      table.hline(stroke: 0.5pt),
      [1], [*Chiqish signalining shakliga koʻra*], [Binar (diskret), analog, raqamli, smart (aqlli)],
      [Limit kalitlar (binar); potensiometr, LVDT (analog); optik enkoder (raqamli); ichki mikrokontrollerli I2C/CAN sensorlar (smart).],
      [2], [*Tashqi energiya manbaiga koʻra*], [Passiv (generatorli) va aktiv (parametrik)],
      [Pyezoelektr, fotoelement (passiv --- tashqi manbasiz signal beradi); tenzometr, termistor, LVDT (aktiv --- manba talab etadi).],
      [3], [*Oʻlchanadigan fizik kattalikka koʻra*], [Kinematik, dinamik, atrof-muhit, optik / vizual],
      [Enkoder, akselerometr (kinematik); tenzodatchik, pyezodatchik (dinamik); lidar, kameralar, ultratovush (vizual).],
      [4], [*Oʻlchash usuli va kontaktga koʻra*], [Kontaktli va kontaktsiz],
      [Taktil matritsa, limit kalit (kontaktli); induktiv, sigʻimli, optik, ultratovush (kontaktsiz).],
      [5], [*Robotdagi joylashuvi va vazifasiga koʻra*], [Proprioseptiv (ichki holat) va eksteroseptiv (tashqi muhit)],
      [Boʻgʻin enkoderi, motor tok sensori, IMU (proprioseptiv); lidar, RGB-D kamera, toʻqnashuv sensori (eksteroseptiv).],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Mexatron modullar va robotlarda datchiklarning koʻp mezonli sinflanishi],
) <tab-class>

== Informatsion tizimning koʻp darajali iyerarxik arxitekturasi

Robototexnika va mexatronikada informatsion oqimlar 4 ta asosiy iyerarxik darajada qayta ishlanadi (@fig-hier):

+ *1-daraja (Transducer / Physical Sensing):* fizik kattalikni (siljish, bosim, harorat) birlamchi elektr signaliga (kuchlanish, tok, qarshilik) aylantirish.
+ *2-daraja (Signal Conditioning & DAQ):* kuchaytirish (Op-Amp), filtrlash (low-pass/high-pass), shovqinni yoʻqotish va ADC orqali raqamli kodga oʻtkazish.
+ *3-daraja (Local Embedded Processing):* mikrokontroller (STM32/DSP/PLC) darajasida PID hisoblari, enkoder impulslarini sanash, kalibrlash va filtrlar (Kalman filtri).
+ *4-daraja (High-level Supervisory & AI):* markaziy kompyuter / ROS muhitida koʻp sensorli maʼlumotlarni birlashtirish (_Sensor Fusion_), SLAM, obyektlarni tanib olish hamda trayektoriyani rejalashtirish.

== Sanoat va robototexnika tarmoq interfeyslari tavsifi

Datchiklardan olingan axborotni kontrollerga va tugunlar oʻrtasida uzatishda ishlatiladigan interfeyslar @tab-net da keltirilgan.

#figure(
  grid(
    columns: 2,
    gutter: 6mm,
    align: horizon,
    image("images/I2C.webp", width: 100%), image("images/SPI.webp", width: 100%),
  ),
  caption: [I2C (chapda) va SPI (oʻngda) shinalarida master va slave qurilmalarning ulanish sxemasi \
    #text(size: 9pt)[Manba: Wikimedia Commons]],
) <fig-i2c-spi>

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 2.6cm, auto, auto, 1fr),
      align: (center + horizon, left + horizon, center + horizon, center + horizon, left + horizon),
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Interfeys*], [*Tezlik (maks.)*], [*Maks. masofa*], [*Asosiy qoʻllanilish sohasi*]),
      table.hline(stroke: 0.5pt),
      [1],
      [*I2C / SPI*],
      [$400 "kbps" dots 10 "Mbps"$],
      [$< 0.5 "m"$],
      [Platadagi smart datchiklar, MEMS IMU, displeylar.],
      [2],
      [*UART / RS-485*],
      [$115.2 "kbps" dots 10 "Mbps"$],
      [$1200 "m"$],
      [Modbus RTU datchiklari, sanoat hisoblagichlari.],
      [3], [*CAN-bus*], [$1 "Mbps"$], [$40 "m"$], [Avtomobil va mobil robotlar, motor drayverlari.],
      [4], [*EtherCAT*], [$100 "Mbps"$], [$100 "m"$], [Sanoat robotlari boʻgʻinlarini sinxron boshqarish.],
      [5], [*Ethernet / ROS*], [$1 "Gbps"$], [$100 "m"$], [Lidar, 3D kameralar, joystiklar va yuqori daraja.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Mexatronik va robotik informatsion tarmoq interfeyslari tavsifi],
) <tab-net>

= Mavzuga oid chizmalar va sxemalar

Quyida mexatronik informatsion tizimning koʻp darajali iyerarxik strukturasi, signalni konditsiyalash hamda koʻp sensorli maʼlumotlarni birlashtirish sxemalari keltirilgan.

== Informatsion tizimning koʻp darajali iyerarxik strukturasi

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let levels = (
      (
        [1-daraja: Sensor darajasi (Transducers / Physical Sensing)],
        [• Enkoder, LVDT, MEMS IMU, tenzodatchik, lidar, kameralar, limit kalit.],
      ),
      (
        [2-daraja: Signalni konditsiyalash va DAQ (Analog/Digital Front-End)],
        [• Operatsion kuchaytirgichlar, past chastotali filtr (LPF), 12/16-bit ADC.],
      ),
      (
        [3-daraja: Lokal boshqaruv va qayta ishlash (MCU / DSP / PLC)],
        [• Kalman filtri, PID hisoblari, enkoder sanash, PWM va protokollar.],
      ),
      (
        [4-daraja: Intellektual boshqaruv (High-Level AI / ROS)],
        [• SLAM, obyektlarni tanib olish, trayektoriyani rejalashtirish, Sensor Fusion.],
      ),
    )
    let links = ([Analog / binar signal], [Raqamli SPI / I2C / ADC], [CAN / EtherCAT / Ethernet])
    let (hw, h, step) = (6.5, 1.3, 2.0)
    let orng = orange.darken(15%)

    for (i, lv) in levels.enumerate() {
      let y = i * step
      rect((-hw, y), (hw, y + h), radius: 0.12, fill: blue.lighten(93%), stroke: 1pt + headingblue)
      content((-hw + 0.3, y + h / 2), anchor: "west", box(width: 12.4cm, align(left, text(size: 9.5pt)[
        #strong(lv.at(0)) \ #lv.at(1)
      ])))
    }
    for (i, lab) in links.enumerate() {
      let y0 = i * step + h
      let y1 = (i + 1) * step
      line((2.5, y0 + 0.05), (2.5, y1 - 0.05), stroke: 0.5pt + orng, mark: (
        start: "stealth",
        end: "stealth",
        fill: orng,
      ))
      content((2.75, (y0 + y1) / 2), anchor: "west", text(size: 8pt, weight: "bold", lab))
    }
  }),
  caption: [Mexatron modul va robotlarning koʻp darajali informatsion arxitekturasi],
) <fig-hier>

== Analog signalni konditsiyalash va ADC oʻzgartirish bloki sxemasi

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let small(body) = text(size: 7pt, body)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (7mm, 10mm),
      edge-stroke: 2pt + headingblue,

      node((0, 0), b[*Sensor* \ (masalan: LVDT / \ tenzometr)], width: 2.3cm, height: 1.3cm),
      node((1, 0), b[*Instrumental* \ *kuchaytirgich* \ ($G = 165$)], width: 2.3cm, height: 1.3cm),
      node((2, 0), b[*Past chastotali* \ *anti-aliasing* \ *filtr (LPF)*], width: 2.3cm, height: 1.3cm),
      node((3, 0), b[*12-bit ADC* \ ($V_"ref" = 3.3 "V"$)], width: 2.3cm, height: 1.3cm),
      node((4, 0), b[*Mikrokontroller* \ (STM32 / DSP)], width: 2.3cm, height: 1.3cm),

      edge((0, 0), (1, 0), "-|>", label: small[mV signal], stroke: 1pt, label-sep: 18pt),
      edge((1, 0), (2, 0), "-|>", label: small[$0 dots 3.3 "V"$], stroke: 1pt, label-sep: 18pt),
      edge((2, 0), (3, 0), "-|>", label: small[Tozalangan], stroke: 1pt, label-sep: 18pt),
      edge((3, 0), (4, 0), "-|>", label: small[Raqamli kod], stroke: 1pt, label-sep: 18pt),
    )
  },
  caption: [Analog sensor signalini kuchaytirish, filtrlash va raqamlashtirish kanali],
) <fig-cond>

== Mobil robotda koʻp sensorli maʼlumotlarni birlashtirish (Sensor Fusion) strukturasi

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let orng = orange.darken(15%)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (14mm, 4mm),

      node((0, 0), b[*Optik enkoderlar* \ (chiziqli tezlik)], width: 3cm, name: <s1>),
      node((0, 1), b[*MEMS IMU* \ (burchak tezlik va $a$)], width: 3cm, name: <s2>),
      node((0, 2), b[*2D lidar* \ (masofa va xarita)], width: 3cm, name: <s3>),
      node((0, 3), b[*RGB-D kamera* \ (vizual odometriya)], width: 3cm, name: <s4>),

      node(
        (1, 1.5),
        b[*SENSOR FUSION* \ (kengaytirilgan \ Kalman filtri --- EKF)],
        width: 3.6cm,
        height: 1.5cm,
        fill: orange.lighten(85%),
        stroke: 2pt + orng,
        name: <fus>,
      ),

      node(
        (2, 1.5),
        b[*Robotning aniq* \ *pozitsiyasi va xaritasi* \ $(X, Y, theta)$],
        width: 3.3cm,
        fill: blue.lighten(80%),
        name: <out>,
      ),

      ..(<s1>, <s2>, <s3>, <s4>).map(s => edge(s, <fus>, "-|>", stroke: 1.2pt + headingblue)),
      edge(<fus>, <out>, "-|>", stroke: 2.5pt + orng),
    )
  },
  caption: [Mobil robotda EKF (Extended Kalman Filter) asosida koʻp sensorli maʼlumotlarni birlashtirish],
) <fig-fusion>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: sanoat roboti va mobil robot informatsion tizimlarini qiyosiy tahlil qilish

6-DoF sanoat manipulyatori (KUKA/ABB) hamda avtonom mobil robot (AMR/AGV) informatsion-oʻlchov tizimlarini qiyosiy tahlil qiling va @tab-compare ni toʻldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (3.4cm, 1fr, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*Informatsion tizim parametri*], [*6-DoF sanoat manipulyatori*], [*Avtonom mobil robot (AMR)*]),
      table.hline(stroke: 0.5pt),
      [*Asosiy sensorlar majmuasi*],
      [Absolyut optik enkoderlar, moment datchiklari, limit kalitlar.],
      [2D/3D lidar, MEMS IMU, gʻildirak enkoderlari, ultratovush datchiklar.],
      [*Sensorlar tipi boʻyicha*],
      [Asosan proprioseptiv (boʻgʻin va motor holatini oʻlchash).],
      [Proprioseptiv + eksteroseptiv (tashqi muhit xaritasini tuzish).],
      [*Signalni uzatish interfeysi*],
      [Real vaqt EtherCAT, PROFINET, CANopen.],
      [CAN-bus, Wi-Fi / 5G, Ethernet, ROS topiclari.],
      [*Axborotni qayta ishlash maqsadi*],
      [Trayektoriyaga aniq rioya qilish ($0.02 "mm"$ gacha).],
      [Muhitda navigatsiya, toʻsiqlardan qochish va SLAM.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Sanoat manipulyatori va mobil robot informatsion tizimlari tahlili],
) <tab-compare>

== Topshiriq 2: sanoat datchigi signalini konditsiyalash zanjirini loyihalash

Sanoat tenzodatchigi $0 dots 20 "mV"$ diapazonda kuchlanish beradi. Mikrokontroller ADC kirishi $0 dots 3.3 "V"$ oraligʻida ishlaydi.

#set enum(numbering: "a)")
+ Instrumental kuchaytirgichning kerakli kuchaytirish koeffitsienti $G$ ni aniqlang.
+ Signal tarkibidagi $50 "Hz"$ tarmoq shovqinini yoʻqotish uchun qanday filtr (LPF/HPF) va kesish chastotasi ($f_c$) tanlanadi?
#set enum(numbering: "1.")

*Yechish va tahlil:*

- Kuchaytirish koeffitsienti:
  #eq($ G = V_"out, max" / V_"in, max" = (3.3 "V") / (0.020 "V") = 165 $)
- Sanoat shovqinlarini yoʻqotish uchun $f_c = 10 "Hz"$ kesish chastotasiga ega 2-tartibli past chastotali filtr (_Low-Pass Filter_) qoʻllaniladi. Bunday filtr $50 "Hz"$ da taxminan $(50 \/ 10)^2 = 25$ marta ($approx -28 "dB"$) soʻndirishni beradi.

= Hisoblash va modellashtirish masalalari

== Masala 1: LVDT va optik enkoder sensorlarining ajratish qobiliyati hisobi

Mexatron modulda burchakli siljishni oʻlchash uchun $N = 4096 "ppr"$ (_pulses per revolution_) xarakteristikali inkremental optik enkoder qoʻllanilgan. Enkoder kvadratur (toʻrt baravar oshirish) rejimida ishlaydi.

#set enum(numbering: "a)")
+ Kvadratur rejimida enkoderning minimal burchak ajratish qobiliyati ($Delta theta$) necha gradus va necha radianga teng?
+ LVDT chiziqli siljish datchigi $100 "mm"$ diapazonga ega boʻlib, 12-bitli ADC ga ulangan. LVDT ning chiziqli ajratish qobiliyati ($Delta x$) necha mikrometr ($mu"m"$)?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ Delta theta = (360 degree) / (4 times N), quad quad Delta x = S_"max" / (2^n - 1) $)

*Hisoblash bosqichlari:*

- Enkoder kvadratur rejimida bir aylanishdagi impulslar soni: $N_"quad" = 4 times 4096 = 16384$ ta/ayl.
  #eq($ Delta theta = (360 degree) / 16384 approx 0.02197 degree approx 0.0003835 "rad" $)
- LVDT chiziqli ajratish qobiliyati (12-bit ADC, $n = 12$, $2^12 - 1 = 4095$):
  #eq($ Delta x = (100 "mm") / 4095 approx 0.02442 "mm" = 24.42 thin mu"m" $)

== Masala 2: ADC va operatsion kuchaytirgichli oʻlchov zanjiri hisobi

Harorat sensori $T = 0 dots 100 degree"C"$ oraligʻida $V_"sens" = 0 dots 100 "mV"$ chiziqli signal beradi. Signal $G = 30$ boʻlgan kuchaytirgich orqali oʻtib, 12-bitli ADC ($V_"ref" = 3.3 "V"$) ga beriladi.

#set enum(numbering: "a)")
+ Harorat $T = 65 degree"C"$ boʻlganda kuchaytirgich chiqishidagi kuchlanish $V_"amp"$ va ADC ning raqamli kodi $N_"dig"$ nechaga teng boʻladi?
+ Ushbu harorat oʻlchash tizimining harorat boʻyicha ajratish boʻsagʻasi ($Delta T$) qanchaga teng?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ V_"sens" = T times 1 "mV"\/degree"C", quad quad V_"amp" = V_"sens" times G $)
#eq($ N_"dig" = "round"(V_"amp" / V_"ref" times (2^12 - 1)), quad quad Delta T = T_"max" / N_"max" $)

*Hisoblash bosqichlari:*

- $T = 65 degree"C"$ da sensor kuchlanishi: $V_"sens" = 65 "mV" = 0.065 "V"$.
- Kuchaytirgich chiqishi: $V_"amp" = 0.065 "V" times 30 = 1.950 "V"$.
- ADC raqamli kodi (12-bit, $V_"ref" = 3.3 "V"$):
  #eq($ N_"dig" = "round"(1.950 / 3.3 times 4095) = "round"(2419.77) = 2420 $)
- Maksimal harorat $100 degree"C"$ da $V_"amp, max" = 0.100 times 30 = 3.0 "V"$. Maksimal kod $N_"max" = "round"(3.0 \/ 3.3 times 4095) = 3723$:
  #eq($ Delta T = (100 degree"C") / 3723 approx 0.02686 degree"C" $)

== Masala 3: CAN-bus tarmogʻida sensor maʼlumotlarini uzatish va tarmoq yuklanishi

Mobil robotdagi CAN-bus tarmogʻi $500 "kbps"$ tezlikda ishlaydi. Tarmoqqa 4 ta sensor moduli ulangan. Har bir sensor moduli har $10 "ms"$ da bittadan 8 baytli standart CAN kadrini yuboradi (kadr uzunligi kadrlararo interval bilan birga $111 "bit"$, bit-stuffing hisobga olinmagan).

#set enum(numbering: "a)")
+ 4 ta sensorning 1 sekundda tarmoqqa uzatadigan umumiy bitlar sonini hisoblang.
+ CAN-bus tarmogʻining yuklanish koeffitsientini (_Bus Load_) aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ "Kadrlar soni (1 s)" = (1000 "ms") / (10 "ms") times 4 = 100 times 4 = 400 "kadr/s" $)
#eq($ "Jami bitlar (1 s)" = 400 times 111 "bit" = 44400 "bit/s" $)
#eq($ "Bus Load" (%) = "Jami bitlar (1 s)" / "CAN tezligi (bit/s)" times 100% $)

*Hisoblash bosqichlari:*

- Sekundiga uzatiladigan bitlar: $44400 "bit/s"$.
- Tarmoq yuklanishi:
  #eq($ "Bus Load" = 44400 / 500000 times 100% = 0.0888 times 100% = 8.88% $)
- Tahlil: $8.88%$ yuklanish CAN-bus uchun xavfsiz hisoblanadi (amaliy tavsiya: $< 60%$). Bit-stuffing ning eng yomon holatida kadr uzunligi $approx 135 "bit"$ gacha oshadi va yuklanish $approx 10.8%$ ni tashkil etadi --- bu ham xavfsiz chegarada.

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: informatsion-oʻlchov stendini vizual va elektr jihatdan oʻrganish.* Stenddagi sensorlar (LVDT, optik enkoder, MEMS IMU, tenzodatchik) va ularning signalni konditsiyalash bloklarini koʻzdan kechiring.
+ *2-bosqich: sensor signalini ossillografda oʻrganish.* LVDT va enkoder chiqish terminallarini ossillografga ulang. Datchikni harakatlantirib, analog signal amplitudasining oʻzgarishini va kvadratur impulslarni kuzating.
+ *3-bosqich: ADC va mikrokontroller interfeysini sozlash.* STM32 mikrokontrollerida ADC va taymer (_Encoder Interface Mode_) modullarini dasturlang. Datchik koʻrsatkichini USART/UART orqali kompyuterga uzating.
+ *4-bosqich: CAN-bus tarmogʻida datchik paketlarini tahlil qilish.* CAN-bus mantiqiy analizatori yordamida sensor paketlarining kadr ID sini, DLC (_Data Length Code_) hamda maʼlumot baytlarini ($8$ bayt) ushlang va tahlil qiling.
+ *5-bosqich: hisoblash natijalarini qayta ishlash va hisobot tayyorlash.* Nazariy va amaliy olingan maʼlumotlarni solishtiring.

= Nazorat va muhokama savollari

+ Mexatronika va robototexnikada informatsion tizimlarning asosiy funksional vazifalarini sanab bering.
+ Datchiklarning analog, binar, raqamli va smart (aqlli) turlari bir-biridan qanday farq qiladi?
+ Proprioseptiv va eksteroseptiv sensorlar tushunchasini misollar bilan tushuntiring.
+ Optik inkremental enkoderlarda kvadratur (A va B signallari orasida $90 degree$ faza farqi) rejimining afzalligi nimada?
+ LVDT (_Linear Variable Differential Transformer_) datchigining ishlash fizik prinsipi va afzalliklarini ayting.
+ Operatsion va instrumental kuchaytirgichlarning datchik signalini konditsiyalashdagi roli nimada?
+ Signalni raqamlashtirishda Nyquist–Shannon teoremasi va anti-aliasing filtrining ahamiyatini tushuntiring.
+ MEMS texnologiyasi boʻyicha tayyorlangan akselerometr va giroskop datchiklarining ishlash prinsipi qanday?
+ CAN-bus tarmogʻining sanoat va robototexnika tizimlarida keng qoʻllanilishiga sabab boʻlgan texnik xususiyatlari nimalardan iborat?
+ EtherCAT protokoli va anʼanaviy Ethernet oʻrtasidagi real vaqt rejimida ishlash farqini tushuntiring.
+ Koʻp sensorli maʼlumotlarni birlashtirishda (_Sensor Fusion_) Kalman filtri va EKF qanday vazifani bajaradi?
+ Avtonom mobil robotlarda SLAM (_Simultaneous Localization and Mapping_) jarayonida qaysi sensorlar majmuasi ishlatiladi?
