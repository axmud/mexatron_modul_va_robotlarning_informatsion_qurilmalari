// ============================================================
//  MMRIQ — 1-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_1.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Mexatron modullarning asosiy turlari bilan tanişiş")
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
// Raqamlanmagan formula
#let eq(body) = math.equation(block: true, numbering: "(1)", body)

// ---------------- Sarlavha ----------------
#align(center)[
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI № 1]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Mexatron modullarning asosiy turlari bilan tanişiş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* zamonaviy robototexnika va avtomatlaştirilgan sanoat tizimlarida qöllaniladigan mexatron modullarning funksional tuzilişi, klassifikatsiyasi, sensorli hamda ijroçi tugunlarining özaro integratsiyasi böyiça nazariy va amaliy könikmalarni şakllantiriş.

*Öquv vazifalari:*

+ Mexatronika fani va mexatron modul tuşunçasining zamonaviy muhandislikdagi örnini örganiş.
+ Mexatronik tizimlarning JSPMI (_Japan Society for the Promotion of Machine Industry_) klassifikatsiya modelini tahlil qiliş.
+ Mexatron modulni taşkil etuvçi 5 ta asosiy funksional elementni (fizik model, sensor/aktuator, signallar, kompyuter mantiqi, dasturiy taʼminot) örganiş.
+ Axborot-ölçov (sensor), ijroçi (aktuator), boşqaruv (mikrokontroller/PLC) va mexanik harakat uzatiş modullari örtasidagi energetik hamda axborot zanjirlarini tuziş.
+ Sanoat roboti (Pick-and-Place) va avtomobil avtomatik tizimlari misolida mexatron modullarning signallar va quvvat drayverlari parametrlarini hisoblaş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Laboratoriya jihozlari:* mexatron modullar böyiça körgazmali öquv stendi, özgarmas va özgaruvçan tok elektr motorlari, pnevmatik silindrlar hamda solenoidli klapanlar.
- *Sensor va mikrokontrollerlar:* optik va magnit enkoderlar, LVDT çiziqli siljiş datçiklari, MEMS akselerometrlar, STM32 / Arduino / PLC S7-1200 boşqaruv modullari.
- *Ölçov va diagnostika vositalari:* ikki kanalli raqamli ossillograf, raqamli multimetr, quvvat manbai ($0 dots 30 "V DC"$).
- *Dasturiy muhit:* MATLAB / Simulink, LabVIEW, Proteus.

= Nazariy maʼlumotlar va konseptual tizimlar

== Mexatronika va mexatron modul tuşunçasi

*Mexatronika* --- bu mexanika, elektronika, kompyuter boşqaruvi va axborot texnologiyalarining muhandislik mahsulotlarini loyihalaş hamda işlab çiqarişdagi sinergetik integratsiyasidir. Anʼanaviy ketma-ket loyihalaş usulidan farqli ölaroq, mexatronik yondaşuv barça kiçik tizimlarni parallel va özaro uzviy boğliqlikda loyihalaşni taqozo etadi (_concurrent engineering_).

*Mexatron modul* deb, tizimning muayyan harakat yoki signalni qayta işlaş funksiyasini mustaqil ravişda bajaruvçi, aniq belgilangan kiriş va çiqiş interfeyslariga ega bölgan, konstruktiv hamda funksional jihatdan birlaştirilgan kiçik tizimga aytiladi.

== Mexatronik tizimlar va modullarning JSPMI klassifikatsiyasi

Yaponiyaning Maşinasozlikni rivojlantiriş jamiyati (JSPMI) tomonidan işlab çiqilgan va xalqaro miqyosda tan olingan klassifikatsiyaga köra, mexatronik modullar va tizimlar 4 ta asosiy sinfga ajratiladi (@tab-jspmi).

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
      table.header([*Sinf*], [*Klassifikatsiya tavsifi*], [*Sanoat va maişiy texnikadagi misollar*]),
      table.hline(stroke: 0.5pt),
      [*Class I*],
      [Asosan mexanik mahsulotlar bölib, funksionalligini oşiriş uçun elektronika kiritilgan.],
      [Sonli dastur bilan boşqariladigan (NC) stanoklar, özgaruvçan tezlikli elektr drayverlar.],
      [*Class II*],
      [Anʼanaviy mexanik tizimlar bölib, içki mexanizmlari elektron modullar va datçiklar bilan yangilangan.],
      [Zamonaviy avtomatik tikuv maşinalari, avtomatlaştirilgan konveyer va qadoqlaş liniyalari.],
      [*Class III*],
      [Mexanik tizim funksiyalarini saqlagan holda, içki kinematik zanjirlari töliq elektronika bilan almaştirilgan.],
      [Raqamli soatlar, elektron tarozilar, raqamli ölçov indikatorlari.],
      [*Class IV*],
      [Mexanik va elektron texnologiyalarning sinergetik integratsiyasi asosida noldan loyihalangan.],
      [Sanoat robotlari, avtofokusli raqamli kameralar, nusxalaş apparatlari, avtomobil ABS va dvigatelni boşqariş (Engine Management) tizimlari.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Mexatronik modullar va tizimlarning JSPMI klassifikatsiyasi],
) <tab-jspmi>

#figure(
  image("images/robotic_actuator_module.png"),
  caption: "Robot yurituvçi mexatron modulining 3D texnik illyustratsiyasi.",
)

== Mexatron modulning 5 ta asosiy funksional elementi

M. Anjanappa va R. Bishop tomonidan taklif etilgan konseptual modelga köra, har qanday mexatronik modul quyidagi 5 ta asosiy sohaga tayangan holda işlaydi (@fig-5el):

+ *Fizik tizimlarni modellaştiriş:* mexanik, elektr, pnevmatik va gidravlik jarayonlarning differensial tenglama hamda uzatiş funksiyasi şaklidagi matematik modellari.
+ *Datçiklar va aktuatorlar:* fizik kattaliklarni elektr signaliga (sensor) hamda elektr energiyasini mexanik harakatga (aktuator) aylantiruvçi özgartirgiçlar.
+ *Signallar va tizimlar:* analog va raqamli signallarni kuçaytiriş, filtrlaş, modulyatsiya qiliş (PWM) va çastotaviy tahlil.
+ *Kompyuter va mantiqiy tizimlar:* mikrokontrollerlar (MCU), signal protsessorlari (DSP), dasturlanadigan mantiqiy kontrollerlar (PLC).
+ *Dasturiy taʼminot va maʼlumotlarni yiğiş (DAQ):* real vaqt rejimida boşqariş algoritmlari (PID, Fuzzy Logic), ADC/DAC va qayta aloqa dasturiy taʼminoti.

#figure(
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    let labels = (
      [1. Fizik tizimlarni modellaştiriş],
      [2. Datçiklar va aktuatorlar],
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
  caption: [Mexatron modulni taşkil etuvçi 5 ta asosiy funksional element],
) <fig-5el>

#figure(
  image("images/adaptive_gripper_module.png"),
  caption: "Taktil datçikli va örnatilgan mikroyuritgiçli adaptiv robot tutqiçi moduli.",
  placement: auto,
)

#figure(image("images/embedded_controller_module.png"), placement: auto, caption: "Adaptiv robotik tutqiç moduli.")

== Mexatron modullarning funksional va strukturaviy turlari

Mexatron modullar bajaradigan vazifasiga köra 4 ta asosiy guruhga bölinadi.

=== Axborot-ölçov (sensor) modullari

Mexatronik tizimda obyektning fizik holatini ölçovçi va uni raqamli körinişga keltiruvçi modullardir:

- *Siljiş va burçak datçiklari:* LVDT (_Linear Variable Differential Transformer_), optik va magnit inkremental hamda absolyut enkoderlar, potensiometrlar.
- *Tezlik va tezlaniş datçiklari:* taxogeneratorlar, MEMS akselerometrlar va giroskopik modullar.
- *Kuç, moment va bosim datçiklari:* tenzometrik köpriklar (_strain gauges_), pyezoelektrik va taktil sensorli matritsalar.
- *Signalni konditsiyalaş bloklari:* instrumental kuçaytirgiçlar, past çastotali filtrlar va ADC modullari.

=== Ijroçi (aktuator) modullari

Boşqaruv signallarini mexanik kuç, moment yoki bosimga aylantiruvçi quvvatli tugunlar:

- *Elektr yuritmalar:* özgarmas tok motorlari (DC), kollektorsiz motorlar (BLDC), qadamli motorlar (_stepper motor_), servomotorlar.
- *Pnevmatik va gidravlik aktuatorlar:* bir va ikki tomonlama harakatlanuvçi pnevmo- va gidrosilindrlar, pnevmo- va gidromotorlar, solenoidli taqsimlagiçlar.
- *Aqlli materialli aktuatorlar:* pyezoelektrik va magnitostriktiv aktuatorlar, şakl xotirasiga ega qotişmalar (_Shape Memory Alloys_ --- SMA).

=== Boşqaruv va signalni qayta işlaş modullari

Sensordan kelgan axborotni tahlil qilib, ijroçi qurilmalarga möljallangan boşqaruv signallarini şakllantiruvçi intellektual modullar:

- Mikrokontrollerli modullar (STM32, ARM Cortex-M, Microchip PIC, AVR).
- Sanoat mantiqiy kontrollerlari (PLC --- _Programmable Logic Controller_).
- Quvvat drayverlari va modulyatorlar (H-Bridge, MOSFET / IGBT tranzistorli drayverlar, PWM modullari).

=== Mexanik va harakatni uzatuvçi modullar

Aktuatordagi harakat turini va parametrlarini obyektga moslab beruvçi mexanik tugunlar:

- Şarik-vintli uzatmalar (_ball-screw assemblies_).
- Tişli, tasmali va reykali reduksiya mexanizmlari.
- Robotlarning tutqiç (_gripper_) va böğin mexanizmlari.

#figure(
  image("images/smart_sensor_module.png"),
  caption: "Intellektual sezgi (smart sensor) modulining strukturaviy çizmasi.",
)

== Mexatron modulning funksional va quvvat zanjiri

Mexatron modulda axborot (past quvvatli) hamda quvvat (yuqori quvvatli) domenlari özaro quyidagi zanjir böyiça integratsiyalaşadi (@fig-chain).

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
        enclose: ((1, -0.6), (3, -0.8)),
        text(size: 8pt, fill: headingblue, strong[MEXATRON MODUL ÇEGARASI\ (seziş + boşqaruv + ijro)]),
        stroke: none,
        fill: none,
      ),

      node((0, 0.5), b[Fizik obyekt / \ mexanik jarayon], width: 2.5cm, height: 1.1cm, name: <proc>),
      node((1, 0), b[Sensor moduli \ (datçik)], width: 2.5cm, height: 1.1cm, name: <sens>),
      node((2, 0), b[Signal şakllantiriş \ va ADC], width: 2.5cm, height: 1.1cm, name: <adc>),
      node((3, 0.5), b[Boşqaruv moduli \ (MCU / PLC)], width: 3cm, height: 1.1cm, name: <ctrl>),
      node((2, 1), b[Quvvat drayveri \ (H-Bridge PWM)], width: 3cm, height: 1.1cm, name: <dac>),
      node((1, 1), b[Ijroçi modul \ (aktuator / motor)], width: 3.5cm, height: 1.1cm, name: <act>),

      edge(<proc>, (0, 0), <sens>, "-|>", stroke: info, label: small[Ölçaş], label-pos: 0.75),
      edge(<sens>, <adc>, "-|>", stroke: info, label: small[Analog signal]),
      edge(<adc>, (3, 0), <ctrl>, "-|>", stroke: info, label: small[Raqamli kod], label-pos: 0.3),
      edge(<ctrl>, (3, 1), <dac>, "-|>", stroke: info, label: small[Boşqaruv kodi], label-pos: 0.7),
      edge(<dac>, <act>, "-|>", stroke: pwr, label: small[Quvvat]),
      edge(<act>, (0, 1), <proc>, "-|>", stroke: pwr, label: small[Mexanik kuç], label-pos: 0.3),
    )
  },
  caption: [Mexatron modulning axborot va quvvat domenlari böyiça funksional zanjiri],
) <fig-chain>

#figure(image("images/vision_sensor_module.png"), placement: auto, caption: "Texnik köriş va smart-kamera moduli.")

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: Pick-and-Place sanoat roboti modullarini strukturaviy tahlil qiliş

Sanoat konveyerida detallarni uşlab, boşqa öringa köçiruvçi 3 öqli Pick-and-Place roboti berilgan. Robot tizimi pnevmatik tutqiç, qadamli motorlar, optik enkoderlar, pnevmo-solenoidlar hamda Siemens S7-1200 PLC bilan jihozlangan.

*Vazifa:* uşbu robotni taşkil etuvçi mexatron modullarni turlar böyiça ajrating va ularning funksional tavsifini @tab-robot ga töldiring.

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
      [1], [Axborot-ölçov (sensor) moduli],
      [Inkremental optik enkoderlar, pnevmo-bosim datçigi, limit kalitlari],
      [Armning joriy koordinatalari va tutqiçdagi detal bosimini ölçaydi.],
      [2], [Ijroçi (aktuator) moduli],
      [Qadamli motorlar, pnevmosilindr, solenoidli klapan],
      [X, Y, Z öqlari böyiça siljişni taʼminlaydi hamda detalni qisib uşlaydi.],
      [3], [Boşqaruv moduli],
      [Siemens S7-1200 PLC, H-köprik drayverlari, PWM modullari],
      [Datçik signallarini tahlil qilib, motor va klapanlarga boşqaruv rejimini beradi.],
      [4], [Mexanik va harakat uzatiş moduli],
      [Şarik-vintli uzatma, pnevmo-tutqiç riçagi va yönaltiruvçi relslar],
      [Motorning aylaniş harakatini aniq çiziqli siljişga aylantirib beradi.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Pick-and-Place roboti mexatron modullari tahlili],
) <tab-robot>

== Topşiriq 2: H-köprik (H-Bridge) drayver mexatron modulining prinsipial sxemasi

Özgarmas tok motori (DC motor) yönalişini va tezligini boşqaruvçi H-köprik quvvat moduli sxemasi @fig-hbridge da keltirilgan.

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
  caption: [DC motor tezligi va yönalişini boşqaruvçi H-köprikli quvvat drayver moduli],
) <fig-hbridge>

= Hisoblaş va modellaştiriş masalalari

== Masala 1: ADC (analog-raqamli özgartirgiç) moduli körsatkiçlari hisobi

Mexatron modul tarkibidagi analog-raqamli özgartirgiç (ADC) $V_"ref" = 5.0 "V"$ tayanç kuçlanişiga ega. Bosim sensori $0 dots 5 "V"$ diapazonda analog signal beradi.

#set enum(numbering: "a)")
+ 10-bitli va 12-bitli ADC uçun eng kiçik sezgirlik bösağasi ($Delta V$, _step voltage_) qançaga teng?
+ Agar sensor ölçagan kuçlaniş $V_"in" = 3.65 "V"$ bölsa, 12-bitli ADC çiqişidagi raqamli kod ($N_"dig"$) va nisbiy xatolik qanday böladi?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ Delta V = V_"ref" / (2^n - 1), quad quad N_"dig" = "round"(V_"in" / (Delta V)) $)

*Hisoblaş bosqiçlari:*

- 10-bitli ADC uçun ($n = 10$):
  #eq($ Delta V_10 = (5.0 "V") / (2^10 - 1) = 5.0 / 1023 approx 4.8876 "mV" $)
- 12-bitli ADC uçun ($n = 12$):
  #eq($ Delta V_12 = (5.0 "V") / (2^12 - 1) = 5.0 / 4095 approx 1.2210 "mV" $)
- $V_"in" = 3.65 "V"$ bölganda 12-bitli raqamli kod:
  #eq($ N_"dig" = "round"(3.65 / 0.0012210) = 2989 quad \ ("ikkilik sanoq sistemasida: " 101110101101_2) $)
- Kvantlangan kuçlaniş va nisbiy xatolik:
  #eq(
    $
      V_q = N_"dig" dot Delta V_12 = 2989 dot 5.0 / 4095 = 3.64957 "V", quad
      delta = (|V_"in" - V_q|) / V_"in" dot 100% \ = 0.427 "mV" / 3650 "mV" dot 100% approx 0.012%
    $,
  )
- ADC kvantlaşdagi maksimal xatolik:
  #eq($ E_"max" = (Delta V_12) / 2 = 0.6105 "mV" $)

== Masala 2: PWM drayver moduli va motor kuçlanişi hisobi

Ijroçi drayver moduli $V_"DC" = 24 "V"$ quvvat manbaiga ulangan. Mikrokontroller H-köprikka $f = 25 "kHz"$ çastotali PWM signal bermoqda. Töldiriş koeffitsienti (_duty cycle_) $D = 72%$ bölsa:

#set enum(numbering: "a)")
+ PWM signalining bir davri $T$ va impuls yoqilgan vaqti $t_"on"$ qanday böladi?
+ Motor terminalidagi örtaça kuçlaniş $V_"avg"$ neçaga teng?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ T = 1 / f, quad t_"on" = D dot T, quad V_"avg" = D dot V_"DC" $)

*Hisoblaş bosqiçlari:*

- PWM davri:
  #eq($ T = 1 / (25000 "Hz") = 0.00004 "s" = 40 thin mu"s" $)
- Impuls yoqilgan vaqti ($t_"on"$):
  #eq($ t_"on" = 0.72 times 40 thin mu"s" = 28.8 thin mu"s" $)
- Motordagi örtaça kuçlaniş ($V_"avg"$):
  #eq($ V_"avg" = 0.72 times 24 "V" = 17.28 "V" $)

== Masala 3: Inkremental optik enkoder moduli bilan tezlikni ölçaş

Inkremental optik enkoder moduli $N = 2048 "ppr"$ (_pulses per revolution_) ajratiş qobiliyatiga ega. Agar enkoder $t = 0.05 "s"$ vaqt oraliğida $P = 8192$ ta impuls şakllantirsa, motor valining aylaniş tezligi $n$ (ayl/min) va burçak tezligi $omega$ (rad/s) ni toping.

*Yeçiş va formulalar:*

#eq($ n = (P dot 60) / (N dot t) quad "(ayl/min)", quad quad omega = (2 pi dot n) / 60 quad "(rad/s)" $)

*Hisoblaş bosqiçlari:*

#eq($ n = (8192 times 60) / (2048 times 0.05) = 491520 / 102.4 = 4800 "ayl/min" $)

#eq($ omega = (2 pi times 4800) / 60 = 160 pi approx 502.65 "rad/s" $)

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: öquv stendini va xavfsizlik qoidalarini örganiş.* Stenddagi kuçlaniş manbalari, drayver modullari, datçiklar va motorlarning ulaniş sxemasi bilan tanişib çiqing.
+ *2-bosqiç: sensor modulini ulab, signalni ölçaş.* LVDT va optik enkoder modullarini mikrokontrollerning ADC va taymer kirişlariga ulang. Datçik milini surib, analog signalning $0 dots 5 "V"$ oraliğida özgarişini multimetrda tekşiring.
+ *3-bosqiç: PWM va H-köprik drayver modulini sozlaş.* Mikrokontrollerning PWM çiqişini H-köprik kirişiga ulang. Ossillograf zondlarini motor terminallariga ulagan holda PWM töldiriş koeffitsientini $20%, 50%, 80%$ ga özgartirib, impuls şaklini va $t_"on"$ vaqtini ölçang.
+ *4-bosqiç: qayta aloqali tezlikni boşqarişni tajribada sinaş.* Mikrokontrollerga yuklangan PID boşqaruv dasturi orqali val tezligini belgilangan qiymatda ($3000 "ayl/min"$) uşlab turiş jarayonini ossillografda kuzating.
+ *5-bosqiç: tajriba natijalarini qayta işlaş.* Tajribada olingan $V_"avg"$, $N_"dig"$ va $n$ (ayl/min) qiymatlarini 5-bölimdagi formulalar böyiça hisoblangan nazariy qiymatlar bilan soliştiring, nisbiy xatolikni hisoblang.

= Nazorat va muhokama savollari

+ Mexatronika fani va mexatron modul tuşunçasining anʼanaviy elektromexanikadan tub farqini tuşuntiring.
+ JSPMI böyiça Class IV mexatronik mahsulotlarning asosiy xususiyatlari va afzalliklari nimalardan iborat?
+ Mexatron modulni taşkil etuvçi 5 ta asosiy funksional elementni sanang va ularning özaro taʼsirini izohlang.
+ Axborot-ölçov (sensor) modullari mexatronik tizimda qanday vazifalarni bajaradi?
+ LVDT datçigi va optik enkoder moduli örtasidagi fizik-texnik va signal farqlari nimada?
+ Aktuator modullari tarkibidagi quvvat drayverlarining (H-Bridge) roli nimadan iborat?
+ H-köprik drayverlarida “shoot-through” (qisqa tutaşuv) hodisasi nima va uning apparat/dasturiy yöl bilan qanday oldi olinadi?
+ PWM (impuls kenglik modulyatsiyasi) signalining töldiriş koeffitsienti ($D$) motor tezligiga qanday taʼsir körsatadi?
+ ADC modulining ajratiş qobiliyati ($n$-bit) va namunalaş çastotasi (_sampling rate_) mexatron modul aniqligiga qanday taʼsir qiladi?
+ Yopiq zanjirli (_closed-loop_) mexatronik modullarda qayta aloqa (_feedback_) zanjiri qanday taşkil etiladi?
+ Sanoat roboti tutqiç modullarida pnevmatik va elektr aktuatorlarning qanday afzallik hamda kamçiliklari bor?
+ Avtomobildagi ABS (_Anti-lock Braking System_) tizimi qanday mexatron modullardan taşkil topgan?

