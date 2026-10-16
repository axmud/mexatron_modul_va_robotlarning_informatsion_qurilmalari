// ============================================================
//  MMRIQ — 1-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_1.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Mexatron modullarning asosiy turlari bilan tanishish")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 1  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MASHGʻULOTI № 1]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Mexatron modullarning asosiy turlari bilan tanishish]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Ishning maqsadi

*Mashgʻulotning maqsadi:* zamonaviy robototexnika va avtomatlashtirilgan sanoat tizimlarida qoʻllaniladigan mexatron modullarning funksional tuzilishi, klassifikatsiyasi, sensorli hamda ijrochi tugunlarining oʻzaro integratsiyasi boʻyicha nazariy va amaliy koʻnikmalarni shakllantirish.

*Oʻquv vazifalari:*

+ Mexatronika fani va mexatron modul tushunchasining zamonaviy muhandislikdagi oʻrnini oʻrganish.
+ Mexatronik tizimlarning JSPMI (_Japan Society for the Promotion of Machine Industry_) klassifikatsiya modelini tahlil qilish.
+ Mexatron modulni tashkil etuvchi 5 ta asosiy funksional elementni (fizik model, sensor/aktuator, signallar, kompyuter mantiqi, dasturiy taʼminot) oʻrganish.
+ Axborot-oʻlchov (sensor), ijrochi (aktuator), boshqaruv (mikrokontroller/PLC) va mexanik harakat uzatish modullari oʻrtasidagi energetik hamda axborot zanjirlarini tuzish.
+ Sanoat roboti (Pick-and-Place) va avtomobil avtomatik tizimlari misolida mexatron modullarning signallar va quvvat drayverlari parametrlarini hisoblash.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Laboratoriya jihozlari:* mexatron modullar boʻyicha koʻrgazmali oʻquv stendi, oʻzgarmas va oʻzgaruvchan tok elektr motorlari, pnevmatik silindrlar hamda solenoidli klapanlar.
- *Sensor va mikrokontrollerlar:* optik va magnit enkoderlar, LVDT chiziqli siljish datchiklari, MEMS akselerometrlar, STM32 / Arduino / PLC S7-1200 boshqaruv modullari.
- *Oʻlchov va diagnostika vositalari:* ikki kanalli raqamli ossillograf, raqamli multimetr, quvvat manbai ($0 dots 30 "V DC"$).
- *Dasturiy muhit:* MATLAB / Simulink, LabVIEW, Proteus.

= Nazariy maʼlumotlar va konseptual tizimlar

== Mexatronika va mexatron modul tushunchasi

*Mexatronika* --- bu mexanika, elektronika, kompyuter boshqaruvi va axborot texnologiyalarining muhandislik mahsulotlarini loyihalash hamda ishlab chiqarishdagi sinergetik integratsiyasidir. Anʼanaviy ketma-ket loyihalash usulidan farqli oʻlaroq, mexatronik yondashuv barcha kichik tizimlarni parallel va oʻzaro uzviy bogʻliqlikda loyihalashni taqozo etadi (_concurrent engineering_).

*Mexatron modul* deb, tizimning muayyan harakat yoki signalni qayta ishlash funksiyasini mustaqil ravishda bajaruvchi, aniq belgilangan kirish va chiqish interfeyslariga ega boʻlgan, konstruktiv hamda funksional jihatdan birlashtirilgan kichik tizimga aytiladi.

== Mexatronik tizimlar va modullarning JSPMI klassifikatsiyasi

Yaponiyaning Mashinasozlikni rivojlantirish jamiyati (JSPMI) tomonidan ishlab chiqilgan va xalqaro miqyosda tan olingan klassifikatsiyaga koʻra, mexatronik modullar va tizimlar 4 ta asosiy sinfga ajratiladi (@tab-jspmi).

#figure(
  {
    set text(size: 10pt)
    set par(justify: false)
    table(
      columns: (auto, 6cm, 1fr),
      align: (center + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*Sinf*], [*Klassifikatsiya tavsifi*], [*Sanoat va maishiy texnikadagi misollar*]),
      table.hline(stroke: 0.5pt),
      [*Class I*],
      [Asosan mexanik mahsulotlar boʻlib, funksionalligini oshirish uchun elektronika kiritilgan.],
      [Sonli dastur bilan boshqariladigan (NC) stanoklar, oʻzgaruvchan tezlikli elektr drayverlar.],
      [*Class II*],
      [Anʼanaviy mexanik tizimlar boʻlib, ichki mexanizmlari elektron modullar va datchiklar bilan yangilangan.],
      [Zamonaviy avtomatik tikuv mashinalari, avtomatlashtirilgan konveyer va qadoqlash liniyalari.],
      [*Class III*],
      [Mexanik tizim funksiyalarini saqlagan holda, ichki kinematik zanjirlari toʻliq elektronika bilan almashtirilgan.],
      [Raqamli soatlar, elektron tarozilar, raqamli oʻlchov indikatorlari.],
      [*Class IV*],
      [Mexanik va elektron texnologiyalarning sinergetik integratsiyasi asosida noldan loyihalangan.],
      [Sanoat robotlari, avtofokusli raqamli kameralar, nusxalash apparatlari, avtomobil ABS va dvigatelni boshqarish (Engine Management) tizimlari.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Mexatronik modullar va tizimlarning JSPMI klassifikatsiyasi],
) <tab-jspmi>

#figure(
  image("images/robotic_actuator_module.png"),
  caption: "Robot yurituvchi mexatron modulining 3D texnik illyustratsiyasi.",
)

== Mexatron modulning 5 ta asosiy funksional elementi

M. Anjanappa va R. Bishop tomonidan taklif etilgan konseptual modelga koʻra, har qanday mexatronik modul quyidagi 5 ta asosiy sohaga tayangan holda ishlaydi (@fig-5el):

+ *Fizik tizimlarni modellashtirish:* mexanik, elektr, pnevmatik va gidravlik jarayonlarning differensial tenglama hamda uzatish funksiyasi shaklidagi matematik modellari.
+ *Datchiklar va aktuatorlar:* fizik kattaliklarni elektr signaliga (sensor) hamda elektr energiyasini mexanik harakatga (aktuator) aylantiruvchi oʻzgartirgichlar.
+ *Signallar va tizimlar:* analog va raqamli signallarni kuchaytirish, filtrlash, modulyatsiya qilish (PWM) va chastotaviy tahlil.
+ *Kompyuter va mantiqiy tizimlar:* mikrokontrollerlar (MCU), signal protsessorlari (DSP), dasturlanadigan mantiqiy kontrollerlar (PLC).
+ *Dasturiy taʼminot va maʼlumotlarni yigʻish (DAQ):* real vaqt rejimida boshqarish algoritmlari (PID, Fuzzy Logic), ADC/DAC va qayta aloqa dasturiy taʼminoti.

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let labels = (
      [1. Fizik tizimlarni modellashtirish],
      [2. Datchiklar va aktuatorlar],
      [3. Signallar va tizimlar],
      [4. Kompyuter va mantiqiy tizimlar],
      [5. Dasturiy taʼminot va DAQ],
    )
    let angles = (90deg, 18deg, -54deg, -126deg, 162deg)
    let (ax, ay) = (4.2, 2.6) // elliptik joylashuv radiuslari
    let (hw, hh) = (1.6, 0.55) // blokning yarim oʻlchamlari
    let rc = 1.25 // markaziy doira radiusi
    let pos = angles.map(a => (ax * calc.cos(a), ay * calc.sin(a)))

    // Qoʻshni bloklar orasidagi shtrix bogʻlanishlar (bloklar ostida)
    for i in range(5) {
      line(pos.at(i), pos.at(calc.rem(i + 1, 5)), stroke: (
        paint: headingblue.lighten(30%),
        thickness: 1pt,
        dash: "dashed",
      ))
    }

    // Markaz ↔ blok strelkalari (blok chegarasigacha)
    for p in pos {
      let len = calc.sqrt(p.at(0) * p.at(0) + p.at(1) * p.at(1))
      let (dx, dy) = (p.at(0) / len, p.at(1) / len)
      let tx = if calc.abs(dx) > 0.001 { hw / calc.abs(dx) } else { 1e6 }
      let ty = if calc.abs(dy) > 0.001 { hh / calc.abs(dy) } else { 1e6 }
      let t = calc.min(tx, ty) + 0.05
      line(
        (dx * (rc + 0.05), dy * (rc + 0.05)),
        (p.at(0) - dx * t, p.at(1) - dy * t),
        stroke: 1.2pt + headingblue,
        mark: (start: "stealth", end: "stealth", fill: headingblue),
      )
    }

    // Bloklar
    for (i, p) in pos.enumerate() {
      rect(
        (p.at(0) - hw, p.at(1) - hh),
        (p.at(0) + hw, p.at(1) + hh),
        radius: 0.12,
        fill: blue.lighten(93%),
        stroke: 1pt + headingblue,
      )
      content(p, box(width: 2.9cm, align(center, text(size: 8.5pt, weight: "bold", labels.at(i)))))
    }

    // Markaziy blok
    circle((0, 0), radius: rc, fill: orange.lighten(80%), stroke: 2pt + orange.darken(10%))
    content((0, 0), align(center, text(size: 9pt, weight: "bold")[MEXATRON \ MODUL]))
  }),
  caption: [Mexatron modulni tashkil etuvchi 5 ta asosiy funksional element],
) <fig-5el>

#figure(
  image("images/adaptive_gripper_module.png"),
  caption: "Taktil datchikli va o'rnatilgan mikroyuritgichli adaptiv robot tutqichi moduli.",
  placement: auto,
)

#figure(image("images/embedded_controller_module.png"), placement: auto, caption: "Adaptiv robotik tutqich moduli.")

== Mexatron modullarning funksional va strukturaviy turlari

Mexatron modullar bajaradigan vazifasiga koʻra 4 ta asosiy guruhga boʻlinadi.

=== Axborot-oʻlchov (sensor) modullari

Mexatronik tizimda obyektning fizik holatini oʻlchovchi va uni raqamli koʻrinishga keltiruvchi modullardir:

- *Siljish va burchak datchiklari:* LVDT (_Linear Variable Differential Transformer_), optik va magnit inkremental hamda absolyut enkoderlar, potensiometrlar.
- *Tezlik va tezlanish datchiklari:* taxogeneratorlar, MEMS akselerometrlar va giroskopik modullar.
- *Kuch, moment va bosim datchiklari:* tenzometrik koʻpriklar (_strain gauges_), pyezoelektrik va taktil sensorli matritsalar.
- *Signalni konditsiyalash bloklari:* instrumental kuchaytirgichlar, past chastotali filtrlar va ADC modullari.

=== Ijrochi (aktuator) modullari

Boshqaruv signallarini mexanik kuch, moment yoki bosimga aylantiruvchi quvvatli tugunlar:

- *Elektr yuritmalar:* oʻzgarmas tok motorlari (DC), kollektorsiz motorlar (BLDC), qadamli motorlar (_stepper motor_), servomotorlar.
- *Pnevmatik va gidravlik aktuatorlar:* bir va ikki tomonlama harakatlanuvchi pnevmo- va gidrosilindrlar, pnevmo- va gidromotorlar, solenoidli taqsimlagichlar.
- *Aqlli materialli aktuatorlar:* pyezoelektrik va magnitostriktiv aktuatorlar, shakl xotirasiga ega qotishmalar (_Shape Memory Alloys_ --- SMA).

=== Boshqaruv va signalni qayta ishlash modullari

Sensordan kelgan axborotni tahlil qilib, ijrochi qurilmalarga moʻljallangan boshqaruv signallarini shakllantiruvchi intellektual modullar:

- Mikrokontrollerli modullar (STM32, ARM Cortex-M, Microchip PIC, AVR).
- Sanoat mantiqiy kontrollerlari (PLC --- _Programmable Logic Controller_).
- Quvvat drayverlari va modulyatorlar (H-Bridge, MOSFET / IGBT tranzistorli drayverlar, PWM modullari).

=== Mexanik va harakatni uzatuvchi modullar

Aktuatordagi harakat turini va parametrlarini obyektga moslab beruvchi mexanik tugunlar:

- Sharik-vintli uzatmalar (_ball-screw assemblies_).
- Tishli, tasmali va reykali reduksiya mexanizmlari.
- Robotlarning tutqich (_gripper_) va boʻgʻin mexanizmlari.

#figure(
  image("images/smart_sensor_module.png"),
  caption: "Intellektual sezgi (smart sensor) modulining strukturaviy chizmasi.",
)

== Mexatron modulning funksional va quvvat zanjiri

Mexatron modulda axborot (past quvvatli) hamda quvvat (yuqori quvvatli) domenlari oʻzaro quyidagi zanjir boʻyicha integratsiyalashadi (@fig-chain).

#figure(
  {
    set text(size: 8.5pt)
    let b(body) = align(center, strong(body))
    let info = 1pt + headingblue
    let pwr = 2.2pt + orange.darken(15%)
    let small(body) = text(size: 7pt, body)
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 6pt,
      spacing: (9mm, 12mm),

      // Modul chegarasi (orqa fonda)
      node(
        enclose: (<sens>, <adc>, <ctrl>, <dac>, <act>),
        inset: 10pt,
        layer: -1,
        stroke: (paint: headingblue.lighten(20%), thickness: 1.5pt, dash: "dashed"),
        fill: blue.lighten(96%),
      ),
      node(
        (2, -0.6),
        text(size: 8pt, fill: headingblue, strong[MEXATRON MODUL CHEGARASI (sezish + boshqaruv + ijro)]),
        stroke: none,
        fill: none,
      ),

      node((0, 0.5), b[Fizik obyekt / \ mexanik jarayon], width: 2.5cm, height: 1.1cm, name: <proc>),
      node((1, 0), b[Sensor moduli \ (datchik)], width: 2.5cm, height: 1.1cm, name: <sens>),
      node((2, 0), b[Signal shakllantirish \ va ADC], width: 2.5cm, height: 1.1cm, name: <adc>),
      node((3, 0.5), b[Boshqaruv moduli \ (MCU / PLC)], width: 2.5cm, height: 1.1cm, name: <ctrl>),
      node((2, 1), b[Quvvat drayveri \ (H-Bridge PWM)], width: 2.7cm, height: 1.1cm, name: <dac>),
      node((1, 1), b[Ijrochi modul \ (aktuator / motor)], width: 2.9cm, height: 1.1cm, name: <act>),

      edge(<proc>, (0, 0), <sens>, "-|>", stroke: info, label: small[Oʻlchash], label-pos: 0.75),
      edge(<sens>, <adc>, "-|>", stroke: info, label: small[Analog signal]),
      edge(<adc>, (3, 0), <ctrl>, "-|>", stroke: info, label: small[Raqamli kod], label-pos: 0.3),
      edge(<ctrl>, (3, 1), <dac>, "-|>", stroke: info, label: small[Boshqaruv kodi], label-pos: 0.7),
      edge(<dac>, <act>, "-|>", stroke: pwr, label: small[Quvvat]),
      edge(<act>, (0, 1), <proc>, "-|>", stroke: pwr, label: small[Mexanik kuch], label-pos: 0.3),
    )
  },
  caption: [Mexatron modulning axborot va quvvat domenlari boʻyicha funksional zanjiri],
) <fig-chain>

#figure(image("images/vision_sensor_module.png"), placement: auto, caption: "Texnik ko'rish va smart-kamera moduli.")

= Amaliy topshiriqlar va tizimli tahlil

== Topshiriq 1: Pick-and-Place sanoat roboti modullarini strukturaviy tahlil qilish

Sanoat konveyerida detallarni ushlab, boshqa oʻringa koʻchiruvchi 3 oʻqli Pick-and-Place roboti berilgan. Robot tizimi pnevmatik tutqich, qadamli motorlar, optik enkoderlar, pnevmo-solenoidlar hamda Siemens S7-1200 PLC bilan jihozlangan.

*Vazifa:* ushbu robotni tashkil etuvchi mexatron modullarni turlar boʻyicha ajrating va ularning funksional tavsifini @tab-robot ga toʻldiring.

#figure(
  {
    set text(size: 10pt)
    set par(justify: false)
    table(
      columns: (auto, 3.4cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Modul turi*], [*Tarkibiy komponentlari*], [*Bajaradigan funksiyasi*]),
      table.hline(stroke: 0.5pt),
      [1], [Axborot-oʻlchov (sensor) moduli],
      [Inkremental optik enkoderlar, pnevmo-bosim datchigi, limit kalitlari],
      [Armning joriy koordinatalari va tutqichdagi detal bosimini oʻlchaydi.],
      [2], [Ijrochi (aktuator) moduli],
      [Qadamli motorlar, pnevmosilindr, solenoidli klapan],
      [X, Y, Z oʻqlari boʻyicha siljishni taʼminlaydi hamda detalni qisib ushlaydi.],
      [3], [Boshqaruv moduli],
      [Siemens S7-1200 PLC, H-koʻprik drayverlari, PWM modullari],
      [Datchik signallarini tahlil qilib, motor va klapanlarga boshqaruv rejimini beradi.],
      [4], [Mexanik va harakat uzatish moduli],
      [Sharik-vintli uzatma, pnevmo-tutqich richagi va yoʻnaltiruvchi relslar],
      [Motorning aylanish harakatini aniq chiziqli siljishga aylantirib beradi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Pick-and-Place roboti mexatron modullari tahlili],
) <tab-robot>

== Topshiriq 2: H-koʻprik (H-Bridge) drayver mexatron modulining prinsipial sxemasi

Oʻzgarmas tok motori (DC motor) yoʻnalishini va tezligini boshqaruvchi H-koʻprik quvvat moduli sxemasi @fig-hbridge da keltirilgan.

#figure(
  cetz.canvas(length: 0.95cm, {
    import cetz.draw: *

    let w = 1pt
    let sw(p, name) = {
      rect((p.at(0) - 0.4, p.at(1) - 0.3), (p.at(0) + 0.4, p.at(1) + 0.3), fill: gray.lighten(85%), stroke: w)
      content(p, text(size: 9pt, weight: "bold", name))
    }
    let pwm(from, to, lab, anchor) = {
      line(from, to, stroke: 2pt + orange.darken(15%), mark: (end: "stealth", fill: orange.darken(15%)))
      content(from, anchor: anchor, padding: 0.1, text(size: 9pt, raw(lab)))
    }

    // Manba (+V_DC) va yuqori shina
    line((0, 3.3), (0, 3.9), stroke: w)
    content((0, 4.0), anchor: "south", text(size: 10pt, weight: "bold")[$+V_"DC"$ (24 V)])
    line((-2.2, 3.3), (2.2, 3.3), stroke: w)

    // Pastki shina va yer (GND)
    line((-2.2, -0.6), (2.2, -0.6), stroke: w)
    line((0, -0.6), (0, -0.9), stroke: w)
    line((-0.5, -0.9), (0.5, -0.9), stroke: w)
    line((-0.3, -1.0), (0.3, -1.0), stroke: w)
    line((-0.1, -1.1), (0.1, -1.1), stroke: w)
    content((0, -1.2), anchor: "north", text(size: 10pt, weight: "bold")[GND (0 V)])

    // Vertikal ulanishlar
    for x in (-2.2, 2.2) {
      line((x, 3.3), (x, 2.7), stroke: w)
      line((x, 2.1), (x, 0.9), stroke: w)
      line((x, 0.3), (x, -0.6), stroke: w)
    }

    // Kalitlar (MOSFET)
    sw((-2.2, 2.4), [Q1])
    sw((2.2, 2.4), [Q2])
    sw((-2.2, 0.6), [Q3])
    sw((2.2, 0.6), [Q4])

    // Motor
    line((-2.2, 1.5), (-0.7, 1.5), stroke: w)
    line((2.2, 1.5), (0.7, 1.5), stroke: w)
    circle((0, 1.5), radius: 0.7, fill: white, stroke: w)
    content((0, 1.5), text(size: 16pt, weight: "bold")[M])

    // Boshqaruv signallari
    pwm((-3.4, 2.4), (-2.65, 2.4), "MCU_PWM1", "east")
    pwm((3.4, 2.4), (2.65, 2.4), "MCU_PWM2", "west")
    pwm((-3.4, 0.6), (-2.65, 0.6), "MCU_PWM3", "east")
    pwm((3.4, 0.6), (2.65, 0.6), "MCU_PWM4", "west")
  }),
  caption: [DC motor tezligi va yoʻnalishini boshqaruvchi H-koʻprikli quvvat drayver moduli],
) <fig-hbridge>

= Hisoblash va modellashtirish masalalari

== Masala 1: ADC (analog-raqamli oʻzgartirgich) moduli koʻrsatkichlari hisobi

Mexatron modul tarkibidagi analog-raqamli oʻzgartirgich (ADC) $V_"ref" = 5.0 "V"$ tayanch kuchlanishiga ega. Bosim sensori $0 dots 5 "V"$ diapazonda analog signal beradi.

#set enum(numbering: "a)")
+ 10-bitli va 12-bitli ADC uchun eng kichik sezgirlik boʻsagʻasi ($Delta V$, _step voltage_) qanchaga teng?
+ Agar sensor oʻlchagan kuchlanish $V_"in" = 3.65 "V"$ boʻlsa, 12-bitli ADC chiqishidagi raqamli kod ($N_"dig"$) va nisbiy xatolik qanday boʻladi?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ Delta V = V_"ref" / (2^n - 1), quad quad N_"dig" = "round"(V_"in" / (Delta V)) $)

*Hisoblash bosqichlari:*

- 10-bitli ADC uchun ($n = 10$):
  #eq($ Delta V_10 = (5.0 "V") / (2^10 - 1) = 5.0 / 1023 approx 4.8876 "mV" $)
- 12-bitli ADC uchun ($n = 12$):
  #eq($ Delta V_12 = (5.0 "V") / (2^12 - 1) = 5.0 / 4095 approx 1.2210 "mV" $)
- $V_"in" = 3.65 "V"$ boʻlganda 12-bitli raqamli kod:
  #eq($ N_"dig" = "round"(3.65 / 0.0012210) = 2989 quad ("ikkilik sanoq sistemasida: " 101110101101_2) $)
- Kvantlangan kuchlanish va nisbiy xatolik:
  #eq(
    $
      V_q = N_"dig" dot Delta V_12 = 2989 dot 5.0 / 4095 = 3.64957 "V", quad
      delta = (|V_"in" - V_q|) / V_"in" dot 100% \ = 0.427 "mV" / 3650 "mV" dot 100% approx 0.012%
    $,
  )
- ADC kvantlashdagi maksimal xatolik:
  #eq($ E_"max" = (Delta V_12) / 2 = 0.6105 "mV" $)

== Masala 2: PWM drayver moduli va motor kuchlanishi hisobi

Ijrochi drayver moduli $V_"DC" = 24 "V"$ quvvat manbaiga ulangan. Mikrokontroller H-koʻprikka $f = 25 "kHz"$ chastotali PWM signal bermoqda. Toʻldirish koeffitsienti (_duty cycle_) $D = 72%$ boʻlsa:

#set enum(numbering: "a)")
+ PWM signalining bir davri $T$ va impuls yoqilgan vaqti $t_"on"$ qanday boʻladi?
+ Motor terminalidagi oʻrtacha kuchlanish $V_"avg"$ nechaga teng?
#set enum(numbering: "1.")

*Yechish va formulalar:*

#eq($ T = 1 / f, quad t_"on" = D dot T, quad V_"avg" = D dot V_"DC" $)

*Hisoblash bosqichlari:*

- PWM davri:
  #eq($ T = 1 / (25000 "Hz") = 0.00004 "s" = 40 thin mu"s" $)
- Impuls yoqilgan vaqti ($t_"on"$):
  #eq($ t_"on" = 0.72 times 40 thin mu"s" = 28.8 thin mu"s" $)
- Motordagi oʻrtacha kuchlanish ($V_"avg"$):
  #eq($ V_"avg" = 0.72 times 24 "V" = 17.28 "V" $)

== Masala 3: Inkremental optik enkoder moduli bilan tezlikni oʻlchash

Inkremental optik enkoder moduli $N = 2048 "ppr"$ (_pulses per revolution_) ajratish qobiliyatiga ega. Agar enkoder $t = 0.05 "s"$ vaqt oraligʻida $P = 8192$ ta impuls shakllantirsa, motor valining aylanish tezligi $n$ (ayl/min) va burchak tezligi $omega$ (rad/s) ni toping.

*Yechish va formulalar:*

#eq($ n = (P dot 60) / (N dot t) quad "(ayl/min)", quad quad omega = (2 pi dot n) / 60 quad "(rad/s)" $)

*Hisoblash bosqichlari:*

#eq($ n = (8192 times 60) / (2048 times 0.05) = 491520 / 102.4 = 4800 "ayl/min" $)

#eq($ omega = (2 pi times 4800) / 60 = 160 pi approx 502.65 "rad/s" $)

= Ishni bajarish tartibi va metodik tavsiyalar

Amaliy mashgʻulotni bajarishda talabalar quyidagi bosqichlarni ketma-ket amalga oshirishlari shart:

+ *1-bosqich: oʻquv stendini va xavfsizlik qoidalarini oʻrganish.* Stenddagi kuchlanish manbalari, drayver modullari, datchiklar va motorlarning ulanish sxemasi bilan tanishib chiqing.
+ *2-bosqich: sensor modulini ulab, signalni oʻlchash.* LVDT va optik enkoder modullarini mikrokontrollerning ADC va taymer kirishlariga ulang. Datchik milini surib, analog signalning $0 dots 5 "V"$ oraligʻida oʻzgarishini multimetrda tekshiring.
+ *3-bosqich: PWM va H-koʻprik drayver modulini sozlash.* Mikrokontrollerning PWM chiqishini H-koʻprik kirishiga ulang. Ossillograf zondlarini motor terminallariga ulagan holda PWM toʻldirish koeffitsientini $20%, 50%, 80%$ ga oʻzgartirib, impuls shaklini va $t_"on"$ vaqtini oʻlchang.
+ *4-bosqich: qayta aloqali tezlikni boshqarishni tajribada sinash.* Mikrokontrollerga yuklangan PID boshqaruv dasturi orqali val tezligini belgilangan qiymatda ($3000 "ayl/min"$) ushlab turish jarayonini ossillografda kuzating.
+ *5-bosqich: tajriba natijalarini qayta ishlash.* Tajribada olingan $V_"avg"$, $N_"dig"$ va $n$ (ayl/min) qiymatlarini 5-boʻlimdagi formulalar boʻyicha hisoblangan nazariy qiymatlar bilan solishtiring, nisbiy xatolikni hisoblang.

= Nazorat va muhokama savollari

+ Mexatronika fani va mexatron modul tushunchasining anʼanaviy elektromexanikadan tub farqini tushuntiring.
+ JSPMI boʻyicha Class IV mexatronik mahsulotlarning asosiy xususiyatlari va afzalliklari nimalardan iborat?
+ Mexatron modulni tashkil etuvchi 5 ta asosiy funksional elementni sanang va ularning oʻzaro taʼsirini izohlang.
+ Axborot-oʻlchov (sensor) modullari mexatronik tizimda qanday vazifalarni bajaradi?
+ LVDT datchigi va optik enkoder moduli oʻrtasidagi fizik-texnik va signal farqlari nimada?
+ Aktuator modullari tarkibidagi quvvat drayverlarining (H-Bridge) roli nimadan iborat?
+ H-koʻprik drayverlarida “shoot-through” (qisqa tutashuv) hodisasi nima va uning apparat/dasturiy yoʻl bilan qanday oldi olinadi?
+ PWM (impuls kenglik modulyatsiyasi) signalining toʻldirish koeffitsienti ($D$) motor tezligiga qanday taʼsir koʻrsatadi?
+ ADC modulining ajratish qobiliyati ($n$-bit) va namunalash chastotasi (_sampling rate_) mexatron modul aniqligiga qanday taʼsir qiladi?
+ Yopiq zanjirli (_closed-loop_) mexatronik modullarda qayta aloqa (_feedback_) zanjiri qanday tashkil etiladi?
+ Sanoat roboti tutqich modullarida pnevmatik va elektr aktuatorlarning qanday afzallik hamda kamchiliklari bor?
+ Avtomobildagi ABS (_Anti-lock Braking System_) tizimi qanday mexatron modullardan tashkil topgan?

