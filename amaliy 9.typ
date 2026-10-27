// ============================================================
//  MMRIQ — 9-amaliy mashgʻulot — Typst versiyasi
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_9.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Intellektual datçiklar bilan tanişiş")
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №9]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Intellektual datçiklar bilan tanişiş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatronik tizimlar va robototexnika majmualarida keng qöllaniladigan intellektual datçiklar (_smart sensors / intelligent transducers_) arxitekturasi, IEEE 1451 standarti va TEDS (_Transducer Electronic Data Sheet_) tuşunçasi, örnatilgan mikrokontrollerlar (DSP/MCU), öz-özini kalibrlaş (_self-calibration_), öz-özini diagnostika qiliş (_self-diagnosis_), raqamli sanoat protokollari (IO-Link, CANopen, HART, Modbus, IEEE 1451.4) hamda Edge AI va sensor maʼlumotlarini birlaştiriş tamoyillarini örganiş va hisoblaş masalalarini yeçiş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Anʼanaviy (analog) datçiklar va intellektual (smart) datçiklar örtasidagi funksional, metrologik va arxitektura farqlarini örganiş.
+ Smart datçiklarning 6 ta asosiy tarkibiy blokini (sezgir element, signalni konditsiyalaş, ADC, mikrokontroller/DSP, TEDS xotirasi va tarmoq transiveri) tahlil qiliş.
+ IEEE 1451 xalqaro standartlar oilasi, TEDS (elektron maʼlumotlar varaği) tuzilişi hamda “Plug-and-Play” avtomatik sozlaniş mexanizmini örganiş.
+ Smart datçiklarning öz-özini sinaş, avtomatik harorat kompensatsiyasi, raqamli filtrlaş hamda IO-Link va CANopen sanoat tarmoqlari orqali maʼlumot uzatiş algoritmlarini tahlil qiliş.
+ Smart datçiklarda kalibrlaş koʻphadlari (_polynomial compensation_), maʼlumotlar kadrini uzatiş vaqti hamda tebraniş monitoringida FFT (_Fast Fourier Transform_) algoritmlari böyiça muhandislik hisoblaşlarini bajariş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* intellektual va smart datçiklar laboratoriya stendi, IO-Link Master moduli va IO-Link smart datçiklar (bosim, harorat, fotoelektr va induktiv), IEEE 1451.4 TEDS mikrosxemali tebraniş datçigi (IEPE akselerometr), STM32 / ESP32 smart datçik maketi.
- *Nazorat-ölçov va aloqa vositalari:* USB-to-IO-Link adapteri, CAN-bus mantiqiy analizatori, raqamli ossillograf, multimetr, raqamli kalibrlaş manbai.
- *Dasturiy muhit:* MATLAB / Simulink (Data Acquisition & Signal Processing Toolbox), LabVIEW (IEEE 1451.4 TEDS VI lari), IO-Link konfiguratori, Python (Edge AI / TinyML).

= Nazariy maʼlumotlar va konseptual arxitektura

== Anʼanaviy va intellektual (smart) datçiklar tuşunçasi

P.P.L. Regtien va W. Bolton darsliklariga köra, *intellektual (smart) datçik* deb birlamçi sezgir element (_transducer_) bilan birga signalni analog va raqamli qayta işlovçi, mantiqiy hisoblaşlarni bajaruvçi mikrokontroller (MCU/DSP), kalibrlaş xotirasi (TEDS) hamda sanoat tarmoğiga ulanuvçi raqamli interfeysni bitta korpusda jamlagan yaxlit mexatronik qurilmaga aytiladi.

Anʼanaviy va smart datçiklarning asosiy farqlari @tab-smart da keltirilgan.

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
      table.header([*№*], [*Xarakteristika*], [*Anʼanaviy \ analog datçik*], [*Intellektual \ (smart) datçik*]),
      table.hline(stroke: 0.5pt),
      [1], [*Çiqiş signali*], [Analog ($0 dots 10 "V"$, $4 dots 20 "mA"$, mV)],
      [Raqamli kadr (IO-Link, CAN, Modbus, IEEE 1451)],
      [2], [*Signalni qayta işlaş*], [Taşqi analog zanjir yoki PLC da bajariladi],
      [Datçik içidagi MCU/DSP da filtrlaş va raqamlaş],
      [3], [*Kalibrlaş va dreyf*], [Qölda (potensiometr bilan) kalibrlanadi],
      [Avtomatik raqamli kompensatsiya va TEDS xotirasi],
      [4], [*Diagnostika*], [Yöq (faqat liniya uzilişini aniqlaş mumkin)],
      [Öz-özini diagnostika va oldindan ogohlantiriş],
      [5], [*Moslaşuvçanlik*], [Bitta parametrni ölçaydi (mono-sensor)],
      [Köp parametrli (multi-sensor) va masofadan sozlanuvçan],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Anʼanaviy (analog) va intellektual (smart) datçiklarning qiyosiy xarakteristikasi],
) <tab-smart>

== Smart datçikning funksional blok-diagrammasi

Smart datçik arxitekturasi 6 ta asosiy funksional modulni öz içiga oladi (@fig-arch):

+ *Sezgir element (sensing element / transducer):* fizik kattalikni ($P, T, a, x$) birlamçi elektr signaliga aylantiradi.
+ *Signal şakllantirgiç (analog front-end):* instrumental kuçaytirgiç (InAmp) va past çastotali anti-aliasing filtri.
+ *Analog-raqamli özgartirgiç (ADC):* yuqori ajratiş qobiliyatli ($16 dots 24$-bit) sigma-delta ($Sigma Delta$) ADC.
+ *Örnatilgan mikrokontroller (MCU / DSP yadrosi):* raqamli filtrlaş (FIR/IIR, Kalman), koʻphadli harorat kompensatsiyasi, FFT va nosozlik diagnostikasi.
+ *TEDS xotirasi (energiyaga boğliq bölmagan EEPROM):* IEEE 1451 standarti böyiça pasport maʼlumotlari, seriya raqami va kalibrlaş koeffitsientlarini saqlaydi.
+ *Tarmoq transiveri (network transceiver):* IO-Link, CANopen, RS-485 yoki sanoat Ethernet interfeysi.

== IEEE 1451 standarti va TEDS (Transducer Electronic Data Sheet)

IEEE 1451 xalqaro standarti turli işlab çiqaruvçilarning smart datçiklarini turli tarmoqlar va boşqaruvçilarga “Plug-and-Play” (ulang va işlating) tamoyilida avtomatik integratsiya qilişni taʼminlaydi.

*TEDS (elektron pasport) tarkibi quyidagi bölimlardan iborat:*

- *Basic TEDS (asosiy bölim):* işlab çiqaruvçi identifikatori (_Manufacturer ID_), datçik modeli, versiyasi va seriya raqami (24-bit).
- *Standard Transducer TEDS:* ölçaş oraliği (min/max), ölçov birligi (SI: Pa, °C, m/s#super[2]), elektr çiqiş diapazoni.
- *Calibration TEDS:* kalibrlaş sanasi, kalibrlaş koʻphadi koeffitsientlari ($a_0, a_1, a_2, dots$) hamda haroratga kross-sezgirlik koeffitsientlari.
- *User Data TEDS:* foydalanuvçi kiritadigan joylaşuv va texnik xizmat körsatiş yozuvlari.

== Smart datçiklarda öz-özini kalibrlaş va harorat kompensatsiyasi

Anʼanaviy datçiklarda harorat özgarişi va qariş (_aging_) tufayli yuzaga keladigan nol nuqtasi dreyfi (_zero drift_) va sezgirlik dreyfi (_sensitivity drift_) smart datçiklarda raqamli koʻphadlar yordamida dasturiy tuzatiladi:

$
  Y_"töğri" = a_0 + a_1 dot V_"adc" + a_2 dot V_"adc"^2 + b_1 dot (T_"chip" - T_0) \
  + b_2 dot V_"adc" dot (T_"chip" - T_0)
$

bunda $V_"adc"$ --- ölçangan ADC kuçlanişi, $T_"chip"$ --- datçik mikrosxemasiga örnatilgan harorat sensori qiymati, $T_0$ --- kalibrlaşdagi tayanç harorat (odatda $25 degree"C"$), $a_i, b_i$ --- TEDS xotirasidagi kalibrlaş koeffitsientlari.

= Mavzuga oid çizmalar va sxemalar

== Smart datçikning (IEEE 1451) funksional blok-diagrammasi

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
        b[*Örnatilgan* \ *MCU / DSP* \ (filtrlaş, kalibrlaş, \ diagnostika, FFT)],
        width: 2.7cm,
        height: 1.6cm,
        fill: blue.lighten(80%),
      ),
      node((4, 0), b[*Tarmoq transiveri* \ (IO-Link / CAN / \ Modbus)], width: 2.56cm, height: 1.4cm),
      node(
        (3, 1),
        b[*TEDS xotirasi* \ (EEPROM, IEEE 1451 \ pasport maʼlumotlari)],
        width: 3.3cm,
        height: 1.3cm,
        fill: orange.lighten(85%),
        stroke: 0.8pt + orng,
      ),
      node((4, 1), b[*Sanoat tarmoği*], stroke: none, fill: none),

      edge((0, 0), (1, 0), "-|>", label: small[Elektr signal], label-sep: 20pt),
      edge((1, 0), (2, 0), "-|>", label: small[Analog], label-sep: 20pt),
      edge((2, 0), (3, 0), "-|>", label: small[Raqamli], label-sep: 20pt),
      edge((3, 0), (4, 0), "<|-|>", label: small[Kadr], label-sep: 20pt),
      edge((3, 0), (3, 1), "<|-|>", stroke: 1pt + orng, label: small[I2C/SPI], label-side: left, label-sep: 20pt),
      edge((4, 0), (4, 1), "<|-|>", stroke: 1pt + orng, label-sep: 20pt),
    )
  },
  caption: [Intellektual datçikning (smart sensor / IEEE 1451) töliq funksional blok-diagrammasi],
) <fig-arch>

== Anʼanaviy va smart datçiklarning ulaniş va boşqaruv iyerarxiyasi

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

      node((1, 0), title[a) Anʼanaviy analog ulaniş], stroke: none, fill: none),
      node((0, 1), b[Analog sensor], width: 2.6cm, height: 1cm),
      node((1, 1), b[Taşqi signal \ konditsioneri], width: 2.6cm, height: 1cm),
      node((2, 1), b[PLC analog moduli \ (ADC + PLC)], width: 2.8cm, height: 1cm),
      edge((0, 1), (1, 1), "-|>", label: small[$4 dots 20 "mA"$]),
      edge((1, 1), (2, 1), "-|>", label: small[$0 dots 10 "V"$]),

      node((1, 2.2), title[b) Intellektual ulaniş (IO-Link)], stroke: none, fill: none),
      node(
        (0, 3.2),
        b[Smart sensor \ (MCU + TEDS)],
        width: 2.6cm,
        height: 1cm,
        fill: orange.lighten(85%),
        stroke: 0.8pt + orng,
      ),
      node((1, 3.2), b[IO-Link Master \ moduli], width: 2.6cm, height: 1cm),
      node((2, 3.2), b[Sanoat PLC / ROS \ (PROFINET / EtherCAT)], width: 3.7cm, height: 1cm),
      edge((0, 3.2), (1, 3.2), "<|-|>", stroke: 1pt + orng, label: small[3 simli raqamli]),
      edge((1, 3.2), (2, 3.2), "<|-|>", label: small[Sanoat tarmoği]),
    )
  },
  caption: [Anʼanaviy va smart datçik ulaniş iyerarxiyasining taqqoslanişi],
) <fig-hier>

== Smart datçikda öz-özini kalibrlaş va harorat kompensatsiyasi algoritmi

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

      node((0, 0), b[ADC dan $V_"adc"$ va \ harorat $T_"chip"$ ni öqiş], width: 3.2cm),
      node((1, 0), b[TEDS xotirasidan $a_i, b_i$ koeffitsientlarni yuklaş], width: 3.3cm),
      node((2, 0), b[Koʻphad böyiça tuzatiş: \ $Y = f(V_"adc", T_"chip")$], width: 3.4cm),
      node(
        (2, 1),
        b[Natija norma \ doirasidami?],
        shape: fletcher.shapes.diamond,
        fill: orange.lighten(85%),
        stroke: 0.8pt + orng,
        inset: 3pt,
      ),
      node((1, 1), b[Raqamli kadrni tarmoqqa uzatiş (Status = OK)], width: 3.6cm),

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
        label: small[Yöq (xato bayroği)],
        label-pos: 0.45,
        label-side: left,
      ),
    )
  },
  caption: [Smart datçikda öz-özini kalibrlaş va avto-diagnostika iş tartibi],
) <fig-flow>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: anʼanaviy va smart datçiklarning qiyosiy tahlili

Har bir datçik turining texnik, metrologik va ekspluatatsion körsatkiçlarini tahlil qiling va @tab-compare ni töldiring.

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
        [*Datçik turi*], [*Ölçaş aniqligi \ va dreyf*], [*Diagnostika \ va xizmat*], [*Asosiy ustunligi va kamçiligi*]
      ),
      table.hline(stroke: 0.5pt),
      [*Anʼanaviy analog datçik*],
      [Örtaça; harorat xatoligi katta ($> 1%$)],
      [Faqat qölda, davriy ölçov uskunasi bilan],
      [*Ustunligi:* arzon va sodda. \ *Kamçiligi:* şovqinga taʼsirçan, kalibrlaş qiyin.],
      [*Smart datçik (IO-Link / TEDS)*],
      [Yuqori; koʻphadli dasturiy kompensatsiya ($< 0.05%$)],
      [Avto-diagnostika va oldindan ogohlantiriş],
      [*Ustunligi:* Plug-and-Play, şovqinga çidamli raqamli kadr. \ *Kamçiligi:* narxi yuqoriroq.],
      [*Edge AI smart datçik*],
      [Öta yuqori; neyron tarmoq yordamida anomaliyalarni aniqlaş],
      [Başoratli texnik xizmat (_predictive maintenance_)],
      [*Ustunligi:* sensorning özida FFT va AI algoritmi işlaydi. \ *Kamçiligi:* yuqori hisoblaş quvvati talab etiladi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Anʼanaviy va smart datçiklar texnik imkoniyatlarining qiyosiy tahlili],
) <tab-compare>

== Topşiriq 2: sanoat konveyeri va mobil robot uçun smart datçik tanlaş

Quyidagi ikkita texnologik modul uçun smart datçik va tarmoq interfeysini tanlang va asoslang:

+ *1-modul:* sanoat konveyeri reduktorining tebranişi va haroratini başoratli texnik xizmat (_predictive maintenance_) maqsadida monitoring qiliş.
+ *2-modul:* avtonom mobil robot (AGV) uçun köp kanalli smart tösiq sensorlari va akkumulyator holatini nazorat qiliş.

*Tahlil va yeçim:*

- *1-modul uçun:* _IO-Link smart tebraniş va harorat sensori (3 öqli MEMS akselerometr + harorat + FFT yadrosi)_. Sababi: FFT sensorning özida bajariladi, tebraniş tezligining örtaça kvadratik qiymati ($v_"rms"$) va harorat IO-Link Master orqali PLC ga uzatiladi.
- *2-modul uçun:* _CANopen smart ultratovuş va siğimli sensorlar_. Sababi: CANopen şinasida barça smart datçiklar bitta kabelga ulanadi va $1 "Mbit/s"$ gaça tezlikda robot kontrolleriga maʼlumot beradi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: TEDS kalibrlaş koʻphadi böyiça harorat kompensatsiyasi hisobi

Smart bosim datçigining TEDS xotirasida quyidagi 2-darajali kalibrlaş koʻphadi koeffitsientlari saqlangan:

$ a_0 = -0.50 "bar", quad a_1 = 2.50 "bar/V", quad a_2 = 0.05 "bar/V"^2, quad b_1 = -0.002 "bar"\/degree"C" $

ADC ölçagan kuçlaniş $V_"adc" = 1.80 "V"$, datçikning içki harorat sensori körsatkiçi $T_"chip" = 45 degree"C"$ (tayanç harorat $T_0 = 25 degree"C"$).

#set enum(numbering: "a)")
+ Harorat böyiça kompensatsiyalanmagan va kompensatsiyalangan bosim qiymatlarini ($P_"uncorr"$ va $P_"corr"$) barlarda hisoblang.
+ Harorat taʼsirida kelib çiqqan xatolik $Delta P_"temp"$ ni aniqlang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ P_"uncorr" = a_0 + a_1 dot V_"adc" + a_2 dot V_"adc"^2 $

$ P_"corr" = P_"uncorr" + b_1 dot (T_"chip" - T_0) $

*Hisoblaş bosqiçlari:*

- Kompensatsiyasiz bosim $P_"uncorr"$:
  $ P_"uncorr" = -0.50 + 2.50 times 1.80 + 0.05 times (1.80)^2 $
  $ P_"uncorr" = -0.50 + 4.50 + 0.05 times 3.24 = 4.00 + 0.162 = 4.162 "bar" $
- Harorat tuzatmasi ($T_"chip" = 45 degree"C"$, $T_0 = 25 degree"C"$):
  $ Delta T = 45 - 25 = 20 degree"C" $
  $ P_"corr" = 4.162 + (-0.002 times 20) = 4.162 - 0.040 = 4.122 "bar" $
- Harorat xatoligi:
  $ Delta P_"temp" = |4.122 - 4.162| = 0.040 "bar" = 40 "mbar" $

== Masala 2: IO-Link smart datçigida kadr uzatiş vaqti va sikl çastotasi

IO-Link smart datçigi COM3 rejimida ($230.4 "kbit/s"$) işlaydi. Datçik javob kadrida 2 bayt jarayon maʼlumotlari (_process data_), 1 bayt status va 2 bayt xizmat/CRC maʼlumotlari (jami 5 bayt) mavjud. Har bir bayt UART formatida 11 bit (1 start, 8 maʼlumot, 1 juftlik, 1 stop bit) bilan uzatiladi, yaʼni jami $5 times 11 = 55$ bit. Master sörov kadri 2 baytdan ($22$ bit) iborat.

#set enum(numbering: "a)")
+ Datçik javob kadrini uzatiş vaqti $t_"kadr"$ ($mu"s"$) ni hisoblang.
+ Datçik va IO-Link Master örtasidagi har bir pauza $t_"pauza" = 10 thin mu"s"$ bölsa, maksimal sikl çastotasi $f_"sikl"$ (Hz) neçaga teng?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ t_"kadr" = N_"bit" / "tezlik" = (55 "bit") / (230400 "bit/s") $

$ t_"sikl" = t_"kadr, master" + t_"pauza" + t_"kadr, sensor" + t_"pauza", quad quad f_"sikl" = 1 / t_"sikl" $

*Hisoblaş bosqiçlari:*

- Datçik javob kadrini uzatiş vaqti:
  $ t_"kadr, sensor" = 55 / 230400 approx 0.0002387 "s" = 238.7 thin mu"s" $
- Master sörov kadri: $t_"kadr, master" = 22 \/ 230400 approx 95.5 thin mu"s"$.
- Töliq sörov-javob sikli vaqti:
  $ t_"sikl" = 95.5 + 10 + 238.7 + 10 = 354.2 thin mu"s" = 0.0003542 "s" $
- Maksimal sikl çastotasi:
  $ f_"sikl" = 1 / (0.0003542 "s") approx 2823 "Hz" approx 2.82 "kHz" $

_Izoh:_ bu nazariy çegaraviy qiymat. IO-Link spetsifikatsiyasida COM3 uçun minimal sikl vaqti $0.4 "ms"$ qilib belgilangan, yaʼni amalda sikl çastotasi $2.5 "kHz"$ dan oşmaydi.

== Masala 3: smart tebraniş datçigida FFT hisobi va xotira hajmi

Smart tebraniş datçigi $f_s = 10.24 "kHz"$ diskretlaş çastotasi bilan $N = 1024$ nuqtali signal namunasini töplaydi va içki DSP mikrosxemasida FFT hisoblaydi.

#set enum(numbering: "a)")
+ FFT spektrining çastota böyiça ajratiş qobiliyati $Delta f$ (Hz) ni hisoblang.
+ Spektrdagi maksimal (Nyquist) çastota $f_"Nyquist"$ neçaga teng?
+ Har bir namuna 16-bitli (2 bayt) ADC kodi bölsa, $N = 1024$ nuqtali bufer uçun RAM xotira hajmi qança böladi?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

$ Delta f = f_s / N, quad quad f_"Nyquist" = f_s / 2, quad quad "RAM" = N times 2 "bayt" $

*Hisoblaş bosqiçlari:*

- Çastota böyiça ajratiş qobiliyati:
  $ Delta f = (10240 "Hz") / 1024 = 10.0 "Hz" $
- Nyquist çastotasi:
  $ f_"Nyquist" = 10240 / 2 = 5120 "Hz" = 5.12 "kHz" $
- RAM xotira hajmi:
  $ "RAM" = 1024 times 2 "bayt" = 2048 "bayt" = 2 "KiB" $

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: smart datçiklar va IO-Link Master modulini ulaş.* IO-Link smart bosim/harorat datçigini M12 kabeli orqali IO-Link Master moduliga ulang va USB orqali kompyuterdagi sozlaş dasturini oçing.
+ *2-bosqiç: IEEE 1451.4 TEDS pasport maʼlumotlarini öqiş.* LabVIEW yoki TEDS konfiguratori yordamida tebraniş datçigining EEPROM xotirasidagi Manufacturer ID, Serial Number va kalibrlaş koeffitsientlarini öqing.
+ *3-bosqiç: öz-özini diagnostika va kalibrlaşni sinaş.* Smart datçikka sunʼiy ravişda yuqori harorat yoki ortiqça bosim berib, datçik qaytaradigan status baytidagi diagnostika bayroqçalarini (_warning / error_) dasturda kuzating.
+ *4-bosqiç: IO-Link kadrlarini mantiqiy analizatorda tahlil qiliş.* COM3 ($230.4 "kbit/s"$) rejimida ötayotgan jarayon maʼlumotlari (_process data_) kadrlarini uşlab oling va maʼlumot baytlarini fizik kattalikka (bar, °C) qayta hisoblang.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Olingan natijalarni nazariy hisoblar bilan taqqoslab, amaliy hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Intellektual (smart) datçikning anʼanaviy analog datçikdan asosiy arxitektura va funksional farqlari nimalardan iborat?
+ Smart datçikning 6 ta asosiy tarkibiy blokini sanang va ularning vazifalarini tuşuntiring.
+ IEEE 1451 xalqaro standartining maqsadi nima va TEDS (_Transducer Electronic Data Sheet_) xotirasi tarkibiga nimalar kiradi?
+ TEDS datçiklarga qanday qilib “Plug-and-Play” (ulang va işlating) imkoniyatini beradi?
+ Smart datçiklarda öz-özini kalibrlaş va avtomatik harorat kompensatsiyasi qanday dasturiy algoritmlar bilan bajariladi?
+ IO-Link va CANopen sanoat raqamli interfeyslarining smart datçiklarda qöllaniliş afzalliklari nimada?
+ Smart datçiklarda öz-özini diagnostika (_self-diagnosis_) va başoratli texnik xizmat (_predictive maintenance_) mexanizmi qanday işlaydi?
+ Yuqori ajratiş qobiliyatli $Sigma Delta$ ADC va örnatilgan DSP ning smart tebraniş datçiklaridagi (FFT hisobi) roli nimadan iborat?
+ Edge AI (sensorda sunʼiy intellekt) va TinyML modellari intellektual datçiklarga qanday yangi imkoniyatlar beradi?
+ IO-Link protokolida COM1, COM2 va COM3 uzatiş tezliklari hamda sikl vaqtlari qanday belgilanadi?
+ Smart datçiklarda şovqinlarni kamaytirişda raqamli FIR va Kalman filtrlarining ahamiyati nima?
+ Avtonom mobil robotlarda (AGV) va sanoat IoT (IIoT) konsepsiyasida smart datçiklarning tutgan örnini izohlang.
