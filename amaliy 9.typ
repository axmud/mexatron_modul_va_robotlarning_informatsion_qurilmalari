// ============================================================
//  MMRIQ — 9-amaliy mashgʻulot — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_9.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Intellektual datchiklar bilan tanishish")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 9  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI №9]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Intellektual datchiklar bilan tanishish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* mexatronik tizimlar va robototexnika majmualarida keng qoʻllaniladigan intellektual datchiklar (_smart sensors / intelligent transducers_) arxitekturasi, IEEE 1451 standarti va TEDS (_Transducer Electronic Data Sheet_) tushunchasi, oʻrnatilgan mikrokontrollerlar (DSP/MCU), oʻz-oʻzini kalibrlash (_self-calibration_), oʻz-oʻzini diagnostika qilish (_self-diagnosis_), raqamli sanoat protokollari (IO-Link, CANopen, HART, Modbus, IEEE 1451.4) hamda Edge AI va sensor maʼlumotlarini birlashtirish tamoyillarini oʻrganish va hisoblash masalalarini yechish koʻnikmalarini shakllantirish.

*Oʻquv vazifalari:*

+ Anʼanaviy (analog) datchiklar va intellektual (smart) datchiklar oʻrtasidagi funksional, metrologik va arxitektura farqlarini oʻrganish.
+ Smart datchiklarning 6 ta asosiy tarkibiy blokini (sezgir element, signalni konditsiyalash, ADC, mikrokontroller/DSP, TEDS xotirasi va tarmoq transiveri) tahlil qilish.
+ IEEE 1451 xalqaro standartlar oilasi, TEDS (elektron maʼlumotlar varagʻi) tuzilishi hamda “Plug-and-Play” avtomatik sozlanish mexanizmini oʻrganish.
+ Smart datchiklarning oʻz-oʻzini sinash, avtomatik harorat kompensatsiyasi, raqamli filtrlash hamda IO-Link va CANopen sanoat tarmoqlari orqali maʼlumot uzatish algoritmlarini tahlil qilish.
+ Smart datchiklarda kalibrlash koʻphadlari (_polynomial compensation_), maʼlumotlar kadrini uzatish vaqti hamda tebranish monitoringida FFT (_Fast Fourier Transform_) algoritmlari boʻyicha muhandislik hisoblashlarini bajarish.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Oʻquv-laboratoriya stendlari:* intellektual va smart datchiklar laboratoriya stendi, IO-Link Master moduli va IO-Link smart datchiklar (bosim, harorat, fotoelektr va induktiv), IEEE 1451.4 TEDS mikrosxemali tebranish datchigi (IEPE akselerometr), STM32 / ESP32 smart datchik maketi.
- *Nazorat-oʻlchov va aloqa vositalari:* USB-to-IO-Link adapteri, CAN-bus mantiqiy analizatori, raqamli ossillograf, multimetr, raqamli kalibrlash manbai.
- *Dasturiy muhit:* MATLAB / Simulink (Data Acquisition & Signal Processing Toolbox), LabVIEW (IEEE 1451.4 TEDS VI lari), IO-Link konfiguratori, Python (Edge AI / TinyML).

= Nazariy maʼlumotlar va konseptual arxitektura

== Anʼanaviy va intellektual (smart) datchiklar tushunchasi

P.P.L. Regtien va W. Bolton darsliklariga koʻra, *intellektual (smart) datchik* deb birlamchi sezgir element (_transducer_) bilan birga signalni analog va raqamli qayta ishlovchi, mantiqiy hisoblashlarni bajaruvchi mikrokontroller (MCU/DSP), kalibrlash xotirasi (TEDS) hamda sanoat tarmogʻiga ulanuvchi raqamli interfeysni bitta korpusda jamlagan yaxlit mexatronik qurilmaga aytiladi.

Anʼanaviy va smart datchiklarning asosiy farqlari @tab-smart da keltirilgan.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Xarakteristika*], [*Anʼanaviy \ analog datchik*], [*Intellektual \ (smart) datchik*]),
      table.hline(stroke: 0.5pt),
      [1], [*Chiqish signali*], [Analog ($0 dots 10 "V"$, $4 dots 20 "mA"$, mV)],
      [Raqamli kadr (IO-Link, CAN, Modbus, IEEE 1451)],
      [2], [*Signalni qayta ishlash*], [Tashqi analog zanjir yoki PLC da bajariladi],
      [Datchik ichidagi MCU/DSP da filtrlash va raqamlash],
      [3], [*Kalibrlash va dreyf*], [Qoʻlda (potensiometr bilan) kalibrlanadi],
      [Avtomatik raqamli kompensatsiya va TEDS xotirasi],
      [4], [*Diagnostika*], [Yoʻq (faqat liniya uzilishini aniqlash mumkin)],
      [Oʻz-oʻzini diagnostika va oldindan ogohlantirish],
      [5], [*Moslashuvchanlik*], [Bitta parametrni oʻlchaydi (mono-sensor)],
      [Koʻp parametrli (multi-sensor) va masofadan sozlanuvchan],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Anʼanaviy (analog) va intellektual (smart) datchiklarning qiyosiy xarakteristikasi],
) <tab-smart>

== Smart datchikning funksional blok-diagrammasi

Smart datchik arxitekturasi 6 ta asosiy funksional modulni oʻz ichiga oladi (@fig-arch):

+ *Sezgir element (sensing element / transducer):* fizik kattalikni ($P, T, a, x$) birlamchi elektr signaliga aylantiradi.
+ *Signal shakllantirgich (analog front-end):* instrumental kuchaytirgich (InAmp) va past chastotali anti-aliasing filtri.
+ *Analog-raqamli oʻzgartirgich (ADC):* yuqori ajratish qobiliyatli ($16 dots 24$-bit) sigma-delta ($Sigma Delta$) ADC.
+ *Oʻrnatilgan mikrokontroller (MCU / DSP yadrosi):* raqamli filtrlash (FIR/IIR, Kalman), koʻphadli harorat kompensatsiyasi, FFT va nosozlik diagnostikasi.
+ *TEDS xotirasi (energiyaga bogʻliq boʻlmagan EEPROM):* IEEE 1451 standarti boʻyicha pasport maʼlumotlari, seriya raqami va kalibrlash koeffitsientlarini saqlaydi.
+ *Tarmoq transiveri (network transceiver):* IO-Link, CANopen, RS-485 yoki sanoat Ethernet interfeysi.

== IEEE 1451 standarti va TEDS (Transducer Electronic Data Sheet)

IEEE 1451 xalqaro standarti turli ishlab chiqaruvchilarning smart datchiklarini turli tarmoqlar va boshqaruvchilarga “Plug-and-Play” (ulang va ishlating) tamoyilida avtomatik integratsiya qilishni taʼminlaydi.

*TEDS (elektron pasport) tarkibi quyidagi boʻlimlardan iborat:*

- *Basic TEDS (asosiy boʻlim):* ishlab chiqaruvchi identifikatori (_Manufacturer ID_), datchik modeli, versiyasi va seriya raqami (24-bit).
- *Standard Transducer TEDS:* oʻlchash oraligʻi (min/max), oʻlchov birligi (SI: Pa, °C, m/s#super[2]), elektr chiqish diapazoni.
- *Calibration TEDS:* kalibrlash sanasi, kalibrlash koʻphadi koeffitsientlari ($a_0, a_1, a_2, dots$) hamda haroratga kross-sezgirlik koeffitsientlari.
- *User Data TEDS:* foydalanuvchi kiritadigan joylashuv va texnik xizmat koʻrsatish yozuvlari.

== Smart datchiklarda oʻz-oʻzini kalibrlash va harorat kompensatsiyasi

Anʼanaviy datchiklarda harorat oʻzgarishi va qarish (_aging_) tufayli yuzaga keladigan nol nuqtasi dreyfi (_zero drift_) va sezgirlik dreyfi (_sensitivity drift_) smart datchiklarda raqamli koʻphadlar yordamida dasturiy tuzatiladi:

$
  Y_"toʻgʻri" = a_0 + a_1 dot V_"adc" + a_2 dot V_"adc"^2 + b_1 dot (T_"chip" - T_0) \
  + b_2 dot V_"adc" dot (T_"chip" - T_0)
$

bunda $V_"adc"$ --- oʻlchangan ADC kuchlanishi, $T_"chip"$ --- datchik mikrosxemasiga oʻrnatilgan harorat sensori qiymati, $T_0$ --- kalibrlashdagi tayanch harorat (odatda $25 degree"C"$), $a_i, b_i$ --- TEDS xotirasidagi kalibrlash koeffitsientlari.

= Mavzuga oid chizmalar va sxemalar

== Smart datchikning (IEEE 1451) funksional blok-diagrammasi

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let small(body) = text(size: 7pt, body)
    let orng = orange.darken(15%)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (6mm, 10mm),
      edge-stroke: 1pt + headingblue,

      node((0, 0), b[*Sezgir element* \ (transducer)], width: 2.1cm, height: 1.4cm),
      node((1, 0), b[*Analog front-end* \ (InAmp / LPF)], width: 2.1cm, height: 1.4cm),
      node((2, 0), b[*16/24-bit* \ *ADC*], width: 2cm, height: 1.4cm),
      node(
        (3, 0),
        b[*Oʻrnatilgan* \ *MCU / DSP* \ (filtrlash, kalibrlash, \ diagnostika, FFT)],
        width: 2.7cm,
        height: 1.4cm,
        fill: blue.lighten(80%),
      ),
      node((4, 0), b[*Tarmoq transiveri* \ (IO-Link / CAN / \ Modbus)], width: 2.4cm, height: 1.4cm),
      node(
        (3, 1),
        b[*TEDS xotirasi* \ (EEPROM, IEEE 1451 \ pasport maʼlumotlari)],
        width: 3cm,
        height: 1.3cm,
        fill: orange.lighten(85%),
        stroke: 0.8pt + orng,
      ),
      node((4, 1), b[*Sanoat tarmogʻi*], stroke: none, fill: none),

      edge((0, 0), (1, 0), "-|>", label: small[Elektr signal], label-sep: 20pt),
      edge((1, 0), (2, 0), "-|>", label: small[Analog], label-sep: 20pt),
      edge((2, 0), (3, 0), "-|>", label: small[Raqamli], label-sep: 20pt),
      edge((3, 0), (4, 0), "<|-|>", label: small[Kadr], label-sep: 20pt),
      edge((3, 0), (3, 1), "<|-|>", stroke: 1pt + orng, label: small[I2C/SPI], label-side: left, label-sep: 20pt),
      edge((4, 0), (4, 1), "<|-|>", stroke: 1pt + orng, label-sep: 20pt),
    )
  },
  caption: [Intellektual datchikning (smart sensor / IEEE 1451) toʻliq funksional blok-diagrammasi],
) <fig-arch>

== Anʼanaviy va smart datchiklarning ulanish va boshqaruv iyerarxiyasi

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let small(body) = text(size: 7pt, body)
    let title(body) = text(size: 9pt, weight: "bold", body)
    let orng = orange.darken(15%)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (10mm, 6mm),
      edge-stroke: 1pt + headingblue,

      node((1, 0), title[a) Anʼanaviy analog ulanish], stroke: none, fill: none),
      node((0, 1), b[Analog sensor], width: 2.6cm, height: 1cm),
      node((1, 1), b[Tashqi signal \ konditsioneri], width: 2.6cm, height: 1cm),
      node((2, 1), b[PLC analog moduli \ (ADC + PLC)], width: 2.6cm, height: 1cm),
      edge((0, 1), (1, 1), "-|>", label: small[$4 dots 20 "mA"$]),
      edge((1, 1), (2, 1), "-|>", label: small[$0 dots 10 "V"$]),

      node((1, 2.2), title[b) Intellektual ulanish (IO-Link)], stroke: none, fill: none),
      node(
        (0, 3.2),
        b[Smart sensor \ (MCU + TEDS)],
        width: 2.6cm,
        height: 1cm,
        fill: orange.lighten(85%),
        stroke: 0.8pt + orng,
      ),
      node((1, 3.2), b[IO-Link Master \ moduli], width: 2.6cm, height: 1cm),
      node((2, 3.2), b[Sanoat PLC / ROS \ (PROFINET / EtherCAT)], width: 3.2cm, height: 1cm),
      edge((0, 3.2), (1, 3.2), "<|-|>", stroke: 1pt + orng, label: small[3 simli raqamli]),
      edge((1, 3.2), (2, 3.2), "<|-|>", label: small[Sanoat tarmogʻi]),
    )
  },
  caption: [Anʼanaviy va smart datchik ulanish iyerarxiyasining taqqoslanishi],
) <fig-hier>

== Smart datchikda oʻz-oʻzini kalibrlash va harorat kompensatsiyasi algoritmi

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let small(body) = text(size: 7pt, body)
    let orng = orange.darken(15%)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 4pt,
      node-inset: 6pt,
      spacing: (10mm, 9mm),
      edge-stroke: 1pt,

      node((0, 0), b[ADC dan $V_"adc"$ va \ harorat $T_"chip"$ ni oʻqish], width: 3.2cm),
      node((1, 0), b[TEDS xotirasidan $a_i, b_i$ \ koeffitsientlarni yuklash], width: 3.2cm),
      node((2, 0), b[Koʻphad boʻyicha tuzatish: \ $Y = f(V_"adc", T_"chip")$], width: 3.4cm),
      node(
        (2, 1),
        b[Natija norma \ doirasidami?],
        shape: fletcher.shapes.diamond,
        fill: orange.lighten(85%),
        stroke: 0.8pt + orng,
        inset: 3pt,
      ),
      node((1, 1), b[Raqamli kadrni tarmoqqa \ uzatish (Status = OK)], width: 3.4cm),

      edge((0, 0), (1, 0), "-|>"),
      edge((1, 0), (2, 0), "-|>"),
      edge((2, 0), (2, 1), "-|>"),
      edge((2, 1), (1, 1), "-|>", label: small[Ha]),
      edge(
        (2, 1),
        (2, 2),
        (0, 2),
        (0, 0),
        "-|>",
        label: small[Yoʻq (xato bayrogʻi)],
        label-pos: 0.45,
        label-side: left,
      ),
    )
  },
  caption: [Smart datchikda oʻz-oʻzini kalibrlash va avto-diagnostika ish tartibi],
) <fig-flow>

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: anʼanaviy va smart datchiklarning qiyosiy tahlili

Har bir datchik turining texnik, metrologik va ekspluatatsion koʻrsatkichlarini tahlil qiling va @tab-compare ni toʻldiring.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (2.6cm, 3cm, 2.8cm, 1fr),
      align: left + horizon,
      stroke: none,
      inset: (x: 4pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Datchik turi*],
        [*Oʻlchash aniqligi \ va dreyf*],
        [*Diagnostika \ va xizmat*],
        [*Asosiy ustunligi va kamchiligi*],
      ),
      table.hline(stroke: 0.5pt),
      [*Anʼanaviy analog datchik*],
      [Oʻrtacha; harorat xatoligi katta ($> 1%$)],
      [Faqat qoʻlda, davriy oʻlchov uskunasi bilan],
      [*Ustunligi:* arzon va sodda. \ *Kamchiligi:* shovqinga taʼsirchan, kalibrlash qiyin.],
      [*Smart datchik (IO-Link / TEDS)*],
      [Yuqori; koʻphadli dasturiy kompensatsiya ($< 0.05%$)],
      [Avto-diagnostika va oldindan ogohlantirish],
      [*Ustunligi:* Plug-and-Play, shovqinga chidamli raqamli kadr. \ *Kamchiligi:* narxi yuqoriroq.],
      [*Edge AI smart datchik*],
      [Oʻta yuqori; neyron tarmoq yordamida anomaliyalarni aniqlash],
      [Bashoratli texnik xizmat (_predictive maintenance_)],
      [*Ustunligi:* sensorning oʻzida FFT va AI algoritmi ishlaydi. \ *Kamchiligi:* yuqori hisoblash quvvati talab etiladi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Anʼanaviy va smart datchiklar texnik imkoniyatlarining qiyosiy tahlili],
) <tab-compare>

== Topshiriq 2: sanoat konveyeri va mobil robot uchun smart datchik tanlash

Quyidagi ikkita texnologik modul uchun smart datchik va tarmoq interfeysini tanlang va asoslang:

+ *1-modul:* sanoat konveyeri reduktorining tebranishi va haroratini bashoratli texnik xizmat (_predictive maintenance_) maqsadida monitoring qilish.
+ *2-modul:* avtonom mobil robot (AGV) uchun koʻp kanalli smart toʻsiq sensorlari va akkumulyator holatini nazorat qilish.

*Tahlil va yechim:*

- *1-modul uchun:* _IO-Link smart tebranish va harorat sensori (3 oʻqli MEMS akselerometr + harorat + FFT yadrosi)_. Sababi: FFT sensorning oʻzida bajariladi, tebranish tezligining oʻrtacha kvadratik qiymati ($v_"rms"$) va harorat IO-Link Master orqali PLC ga uzatiladi.
- *2-modul uchun:* _CANopen smart ultratovush va sigʻimli sensorlar_. Sababi: CANopen shinasida barcha smart datchiklar bitta kabelga ulanadi va $1 "Mbit/s"$ gacha tezlikda robot kontrolleriga maʼlumot beradi.

= Hisoblash va modellashtirish masalalari

== Masala 1: TEDS kalibrlash koʻphadi boʻyicha harorat kompensatsiyasi hisobi

Smart bosim datchigining TEDS xotirasida quyidagi 2-darajali kalibrlash koʻphadi koeffitsientlari saqlangan:

$ a_0 = -0.50 "bar", quad a_1 = 2.50 "bar/V", quad a_2 = 0.05 "bar/V"^2, quad b_1 = -0.002 "bar"\/degree"C" $

ADC oʻlchagan kuchlanish $V_"adc" = 1.80 "V"$, datchikning ichki harorat sensori koʻrsatkichi $T_"chip" = 45 degree"C"$ (tayanch harorat $T_0 = 25 degree"C"$).

#set enum(numbering: "a)")
+ Harorat boʻyicha kompensatsiyalanmagan va kompensatsiyalangan bosim qiymatlarini ($P_"uncorr"$ va $P_"corr"$) barlarda hisoblang.
+ Harorat taʼsirida kelib chiqqan xatolik $Delta P_"temp"$ ni aniqlang.
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ P_"uncorr" = a_0 + a_1 dot V_"adc" + a_2 dot V_"adc"^2 $

$ P_"corr" = P_"uncorr" + b_1 dot (T_"chip" - T_0) $

*Hisoblash bosqichlari:*

- Kompensatsiyasiz bosim $P_"uncorr"$:
  $ P_"uncorr" = -0.50 + 2.50 times 1.80 + 0.05 times (1.80)^2 $
  $ P_"uncorr" = -0.50 + 4.50 + 0.05 times 3.24 = 4.00 + 0.162 = 4.162 "bar" $
- Harorat tuzatmasi ($T_"chip" = 45 degree"C"$, $T_0 = 25 degree"C"$):
  $ Delta T = 45 - 25 = 20 degree"C" $
  $ P_"corr" = 4.162 + (-0.002 times 20) = 4.162 - 0.040 = 4.122 "bar" $
- Harorat xatoligi:
  $ Delta P_"temp" = |4.122 - 4.162| = 0.040 "bar" = 40 "mbar" $

== Masala 2: IO-Link smart datchigida kadr uzatish vaqti va sikl chastotasi

IO-Link smart datchigi COM3 rejimida ($230.4 "kbit/s"$) ishlaydi. Datchik javob kadrida 2 bayt jarayon maʼlumotlari (_process data_), 1 bayt status va 2 bayt xizmat/CRC maʼlumotlari (jami 5 bayt) mavjud. Har bir bayt UART formatida 11 bit (1 start, 8 maʼlumot, 1 juftlik, 1 stop bit) bilan uzatiladi, yaʼni jami $5 times 11 = 55$ bit. Master soʻrov kadri 2 baytdan ($22$ bit) iborat.

#set enum(numbering: "a)")
+ Datchik javob kadrini uzatish vaqti $t_"kadr"$ ($mu"s"$) ni hisoblang.
+ Datchik va IO-Link Master oʻrtasidagi har bir pauza $t_"pauza" = 10 thin mu"s"$ boʻlsa, maksimal sikl chastotasi $f_"sikl"$ (Hz) nechaga teng?
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ t_"kadr" = N_"bit" / "tezlik" = (55 "bit") / (230400 "bit/s") $

$ t_"sikl" = t_"kadr, master" + t_"pauza" + t_"kadr, sensor" + t_"pauza", quad quad f_"sikl" = 1 / t_"sikl" $

*Hisoblash bosqichlari:*

- Datchik javob kadrini uzatish vaqti:
  $ t_"kadr, sensor" = 55 / 230400 approx 0.0002387 "s" = 238.7 thin mu"s" $
- Master soʻrov kadri: $t_"kadr, master" = 22 \/ 230400 approx 95.5 thin mu"s"$.
- Toʻliq soʻrov-javob sikli vaqti:
  $ t_"sikl" = 95.5 + 10 + 238.7 + 10 = 354.2 thin mu"s" = 0.0003542 "s" $
- Maksimal sikl chastotasi:
  $ f_"sikl" = 1 / (0.0003542 "s") approx 2823 "Hz" approx 2.82 "kHz" $

_Izoh:_ bu nazariy chegaraviy qiymat. IO-Link spetsifikatsiyasida COM3 uchun minimal sikl vaqti $0.4 "ms"$ qilib belgilangan, yaʼni amalda sikl chastotasi $2.5 "kHz"$ dan oshmaydi.

== Masala 3: smart tebranish datchigida FFT hisobi va xotira hajmi

Smart tebranish datchigi $f_s = 10.24 "kHz"$ diskretlash chastotasi bilan $N = 1024$ nuqtali signal namunasini toʻplaydi va ichki DSP mikrosxemasida FFT hisoblaydi.

#set enum(numbering: "a)")
+ FFT spektrining chastota boʻyicha ajratish qobiliyati $Delta f$ (Hz) ni hisoblang.
+ Spektrdagi maksimal (Nyquist) chastota $f_"Nyquist"$ nechaga teng?
+ Har bir namuna 16-bitli (2 bayt) ADC kodi boʻlsa, $N = 1024$ nuqtali bufer uchun RAM xotira hajmi qancha boʻladi?
#set enum(numbering: "1.")

*Yechish va formulalar:*

$ Delta f = f_s / N, quad quad f_"Nyquist" = f_s / 2, quad quad "RAM" = N times 2 "bayt" $

*Hisoblash bosqichlari:*

- Chastota boʻyicha ajratish qobiliyati:
  $ Delta f = (10240 "Hz") / 1024 = 10.0 "Hz" $
- Nyquist chastotasi:
  $ f_"Nyquist" = 10240 / 2 = 5120 "Hz" = 5.12 "kHz" $
- RAM xotira hajmi:
  $ "RAM" = 1024 times 2 "bayt" = 2048 "bayt" = 2 "KiB" $

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: smart datchiklar va IO-Link Master modulini ulash.* IO-Link smart bosim/harorat datchigini M12 kabeli orqali IO-Link Master moduliga ulang va USB orqali kompyuterdagi sozlash dasturini oching.
+ *2-bosqich: IEEE 1451.4 TEDS pasport maʼlumotlarini oʻqish.* LabVIEW yoki TEDS konfiguratori yordamida tebranish datchigining EEPROM xotirasidagi Manufacturer ID, Serial Number va kalibrlash koeffitsientlarini oʻqing.
+ *3-bosqich: oʻz-oʻzini diagnostika va kalibrlashni sinash.* Smart datchikka sunʼiy ravishda yuqori harorat yoki ortiqcha bosim berib, datchik qaytaradigan status baytidagi diagnostika bayroqchalarini (_warning / error_) dasturda kuzating.
+ *4-bosqich: IO-Link kadrlarini mantiqiy analizatorda tahlil qilish.* COM3 ($230.4 "kbit/s"$) rejimida oʻtayotgan jarayon maʼlumotlari (_process data_) kadrlarini ushlab oling va maʼlumot baytlarini fizik kattalikka (bar, °C) qayta hisoblang.
+ *5-bosqich: hisobot tayyorlash va xulosalar chiqarish.* Olingan natijalarni nazariy hisoblar bilan taqqoslab, amaliy hisobotni rasmiylashtiring.

= Nazorat va muhokama savollari

+ Intellektual (smart) datchikning anʼanaviy analog datchikdan asosiy arxitektura va funksional farqlari nimalardan iborat?
+ Smart datchikning 6 ta asosiy tarkibiy blokini sanang va ularning vazifalarini tushuntiring.
+ IEEE 1451 xalqaro standartining maqsadi nima va TEDS (_Transducer Electronic Data Sheet_) xotirasi tarkibiga nimalar kiradi?
+ TEDS datchiklarga qanday qilib “Plug-and-Play” (ulang va ishlating) imkoniyatini beradi?
+ Smart datchiklarda oʻz-oʻzini kalibrlash va avtomatik harorat kompensatsiyasi qanday dasturiy algoritmlar bilan bajariladi?
+ IO-Link va CANopen sanoat raqamli interfeyslarining smart datchiklarda qoʻllanilish afzalliklari nimada?
+ Smart datchiklarda oʻz-oʻzini diagnostika (_self-diagnosis_) va bashoratli texnik xizmat (_predictive maintenance_) mexanizmi qanday ishlaydi?
+ Yuqori ajratish qobiliyatli $Sigma Delta$ ADC va oʻrnatilgan DSP ning smart tebranish datchiklaridagi (FFT hisobi) roli nimadan iborat?
+ Edge AI (sensorda sunʼiy intellekt) va TinyML modellari intellektual datchiklarga qanday yangi imkoniyatlar beradi?
+ IO-Link protokolida COM1, COM2 va COM3 uzatish tezliklari hamda sikl vaqtlari qanday belgilanadi?
+ Smart datchiklarda shovqinlarni kamaytirishda raqamli FIR va Kalman filtrlarining ahamiyati nima?
+ Avtonom mobil robotlarda (AGV) va sanoat IoT (IIoT) konsepsiyasida smart datchiklarning tutgan oʻrnini izohlang.
