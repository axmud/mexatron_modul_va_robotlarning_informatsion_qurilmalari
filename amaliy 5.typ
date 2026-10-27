// ============================================================
//  MMRIQ — 5-amaliy mashgʻulot — Typst versiyasi
//  (oldingi amaliy mashgʻulotlar bilan bir xil formatlash uslubi)
//  Kompilyatsiya: typst compile mmriq_amaliy_mashgulot_5.typ
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb(20, 50, 120)

#set document(title: "Informatsion tizim xatoliklari va işonçliligini hisoblaş")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 5  // amaliyot raqami
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
  #text(size: 20pt, weight: "bold", fill: headingblue)[AMALIYOT MAŞĞULOTI №5]
  #v(0.4cm)
  #text(size: 14pt, weight: "bold")[Mavzu: Informatsion tizim xatoliklari va işonçliligini hisoblaş]
  #v(0.6cm)
  #line(length: 100%, stroke: 1pt)
]
#v(0.3cm)

= Işning maqsadi

*Maşğulotning maqsadi:* mexatron modullar va robotlarda qöllaniladigan informatsion tizimlarning ölçaş xatoliklari turlari, statistik tahlil usullari, işonçlilik körsatkiçlari (töxtovsiz işlaş ehtimoli $P(t)$, buzilişlar intensivligi $lambda$, MTBF, MTTR) hamda zaxiralangan va köp kanalli informatsion tizimlarning işonçlilik modelini hisoblaş könikmalarini şakllantiriş.

*Öquv vazifalari:*

+ Informatsion-ölçov tizimlaridagi xatoliklarning kelib çiqiş manbalarini (datçik, kuçaytirgiç, filtr, ADC va algoritmik xatolar) örganiş va ularning klassifikatsiyasini tahlil qiliş.
+ Ölçaş natijalarini statistik qayta işlaş: örtaça arifmetik qiymat $macron(x)$, dispersiya $S^2$, örtaça kvadratik oğiş $sigma$ va Student $t$-taqsimoti böyiça işonç oraliqlarini (_confidence intervals_) hisoblaş.
+ Informatsion tizim va datçiklarning işonçlilik körsatkiçlarini (buzilişlar intensivligi $lambda(t)$, töxtovsiz işlaş ehtimoli $P(t)$, buzilişlar orasidagi örtaça vaqt --- MTBF, örtaça tiklaniş vaqti --- MTTR hamda tayyorlik koeffitsienti $K_t$) örganiş.
+ Ketma-ket (_series_), parallel (_parallel_) hamda zaxiralangan (_Triple Modular Redundancy_ --- TMR / $K$-out-of-$N$) informatsion tizimlarning işonçlilik strukturaviy sxemalarini (RBD --- _Reliability Block Diagram_) tuziş va ularning umumiy işonçlilik ehtimolini hisoblaş.
+ Datçiklar va robotik informatsion kanallar işonçliligini baholaş böyiça amaliy va muhandislik masalalarini yeçiş.

= Kerakli asbob-uskunalar va dasturiy taʼminot

- *Öquv-laboratoriya stendlari:* informatsion-ölçov tizimlarining xatoligi va işonçliligini tadqiq qiliş laboratoriya stendi, köp kanalli zaxiralangan datçiklar bloki (LVDT, optik enkoderlar, MEMS IMU, tenzometrlar).
- *Nazorat-ölçov va diagnostika vositalari:* raqamli ossillograf, yuqori aniqlikdagi multimetr, etalon çastota va kuçlaniş generatori, nosozliklarni simulyatsiya qiliş bloki (_Fault Injector Module_).
- *Dasturiy muhit:* MATLAB / Simulink (Statistics and Machine Learning Toolbox, Reliability funksiyalari), LabVIEW, Python (NumPy / SciPy / Statsmodels) statistik tahlil modullari.

= Nazariy maʼlumotlar va matematik modellar

== Informatsion tizimlardagi xatoliklar va ularning manbalari

Mexatronik informatsion tizimda fizik kattalikni ölçaş va qayta işlaş zanjiri böylab xatoliklar yiğilib boradi. *Xatolik* $E$ deb ölçaş natijasi $X_"ölçov"$ va ölçanayotgan kattalikning haqiqiy (haqiqatga eng yaqin) qiymati $X_"haqiqiy"$ örtasidagi farqqa aytiladi.

*1. Xatoliklar turlari:*

- *Absolyut xatolik ($Delta X$):* $Delta X = X_"ölçov" - X_"haqiqiy"$.
- *Nisbiy xatolik ($delta$):* $delta = (Delta X) / X_"haqiqiy" times 100%$.
- *Keltirilgan xatolik ($gamma$):* $gamma = (Delta X_"max") / X_"FS" times 100%$, bunda $X_"FS"$ --- ölçov şkalasining töliq diapazoni (_Full Scale_).

*2. Xatoliklarning paydo böliş xarakteriga köra sinflanişi:*

- *Sistematik xatoliklar ($E_"sys"$):* qayta ölçaşlarda özgarmas saqlanadigan yoki maʼlum qonuniyat böyiça özgaradigan xatolar (kalibrlaş buzilişi, harorat drifti). Tuzatişlar (_correction factor_) kiritiş orqali yöqotiladi.
- *Tasodifiy xatoliklar ($accent(E, circle)$):* oldindan aytib bölmaydigan, elektromagnit şovqinlar, tebranişlar va issiqlik fluktuatsiyalaridan kelib çiquvçi xatolar. Ehtimollar nazariyasi (Gauss normal taqsimoti) böyiça tahlil qilinadi.
- *Qöpol xatoliklar (_gross errors_):* operator eʼtiborsizligi yoki qurilmaning keskin uzilişi tufayli yuzaga keladi va statistik mezonlar ($3 sigma$ qoidasi yoki Grubbs mezoni) yordamida olib taşlanadi.

== Tasodifiy xatoliklarning statistik tahlili

Agar bir xil şaroitda $N$ marta mustaqil ölçaşlar ötkazilib, $x_1, x_2, dots, x_N$ natijalar olingan bölsa:

+ *Örtaça arifmetik qiymat ($macron(x)$):*
  #eq($ macron(x) = 1 / N sum_(i=1)^N x_i $)
+ *Örtaça kvadratik (standart) oğiş ($S_x$):*
  #eq($ S_x = sqrt(1 / (N - 1) sum_(i=1)^N (x_i - macron(x))^2) $)
+ *Örtaça qiymatning standart oğişi ($S_(macron(x))$):*
  #eq($ S_(macron(x)) = S_x / sqrt(N) $)
+ *Işonç oraliği (_confidence interval_):* işonç ehtimoli $P = 1 - alpha$ (masalan, $P = 0.95$ yoki $95%$) bölganda, ölçanayotgan kattalikning haqiqiy qiymati $X_"haqiqiy"$ quyidagi oraliqda yotadi:
  #eq($ macron(x) - t_(alpha, N-1) dot S_(macron(x)) <= X_"haqiqiy" <= macron(x) + t_(alpha, N-1) dot S_(macron(x)) $)
  bunda $t_(alpha, N-1)$ --- erkinlik darajasi $f = N - 1$ va ahamiyatlilik darajasi $alpha$ uçun Student koeffitsienti (@tab-student).

#figure(
  {
    set text(size: 10pt)
    table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: center + horizon,
      stroke: none,
      inset: (x: 6pt, y: 4pt),
      table.hline(stroke: 1pt),
      table.header(
        [*Erkinlik darajasi \ ($f = N - 1$)*],
        [*$P = 90%$ \ ($alpha = 0.10$)*],
        [*$P = 95%$ \ ($alpha = 0.05$)*],
        [*$P = 99%$ \ ($alpha = 0.01$)*],
      ),
      table.hline(stroke: 0.5pt),
      [3], [2.353], [3.182], [5.841],
      [4], [2.132], [2.776], [4.604],
      [5], [2.015], [2.571], [4.032],
      [9], [1.833], [2.262], [3.250],
      [19], [1.729], [2.093], [2.861],
      [$infinity$], [1.645], [1.960], [2.576],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Student $t$-taqsimoti koeffitsientlarining jadval qiymatlari ($t_(alpha, f)$, ikki tomonlama)],
) <tab-student>

== Informatsion tizimlar va datçiklarning işonçliligi nazariyasi

*Işonçlilik (_Reliability_)* --- informatsion tizim yoki datçikning berilgan vaqt mobaynida va belgilangan ekspluatatsiya şaroitlarida öziga yuklatilgan funksiyalarni talab qilingan körsatkiçlar doirasida bajariş qobiliyatidir.

*Asosiy işonçlilik körsatkiçlari:*

+ *Töxtovsiz işlaş ehtimoli ($P(t)$ --- Reliability Function):* tizimning $0$ dan $t$ gaça bölgan vaqt oraliğida heç qanday buzilişsiz işlaş ehtimoli:
  #eq($ P(t) = P(T > t) = 1 - F(t) $)
  bunda $F(t)$ --- buzilişlar ehtimollik taqsimot funksiyasi.
+ *Buzilişlar intensivligi ($lambda(t)$ --- Failure Rate):* vaqtning $t$ momentida tizimning buziliş tezligini ifodalaydi. Eksponensial modelda $lambda = "const"$ bölsa:
  #eq($ P(t) = e^(-lambda t) $)
+ *Buzilişlar orasidagi örtaça vaqt (MTBF --- Mean Time Between Failures):*
  #eq($ "MTBF" = integral_0^infinity P(t) dif t = integral_0^infinity e^(-lambda t) dif t = 1 / lambda $)
+ *Örtaça tiklaniş vaqti (MTTR --- Mean Time To Repair):* nosozlik yuz berganda uni bartaraf etiş va tizimni qayta işga tuşiriş uçun ketgan örtaça vaqt.
+ *Tayyorlik koeffitsienti ($K_t$ --- Availability Factor):* tizimning ixtiyoriy vaqt momentida işçi holatda böliş ehtimoli:
  #eq($ K_t = "MTBF" / ("MTBF" + "MTTR") $)

== Strukturaviy işonçlilik modellari va zaxiralaş (Redundancy)

Informatsion tizim bir neçta datçik, modul va aloqa kanallaridan iborat bölganda, uning umumiy işonçliligi uşbu modullarning ulaniş strukturasiga boğliq (@fig-rbd).

=== Ketma-ket ulaniş strukturasi (Series System)

Tizim işlaşi uçun barça $n$ ta modul bir vaqtda soz holatda bölişi şart. Agar birorta modul buzilsa, butun tizim işdan çiqadi:

#eq($ P_"sys" (t) = P_1 (t) dot P_2 (t) dots P_n (t) = product_(i=1)^n P_i (t) $)

Barça modullar bir xil $lambda$ intensivlikka ega bölsa: $P_"sys" (t) = e^(-n lambda t)$, $"MTBF"_"sys" = 1 \/ (n lambda)$.

=== Parallel ulaniş strukturasi (Parallel System / Full Redundancy)

Tizim işlaşi uçun kamida bitta modul soz bölişi yetarli. Tizim faqat barça $n$ ta modul bir vaqtda buzilgandagina işdan çiqadi:

#eq($ P_"sys" (t) = 1 - product_(i=1)^n (1 - P_i (t)) = 1 - (1 - e^(-lambda t))^n $)

=== Majoritar zaxiralaş ($K$-out-of-$N$ / TMR --- Triple Modular Redundancy)

Kritik robotik informatsion tizimlarda 3 ta bir xil datçik (TMR --- 2-out-of-3) qöllaniladi. Majoritar element (ovoz beriş --- _voting_ mantiqi) kamida 2 ta mos kelgan datçik signalini töğri deb qabul qiladi (ovoz beruvçi elementning özi ideal deb olinadi):

#eq($ P_"TMR" (t) = 3 P^2 (t) - 2 P^3 (t) = 3 e^(-2 lambda t) - 2 e^(-3 lambda t) $)

= Mavzuga oid çizmalar va sxemalar

== Informatsion tizim ölçov zanjiri böylab xatoliklarning yiğilişi (Error Propagation)

#figure(
  {
    set text(size: 8pt)
    let b(body) = align(center, body)
    let orng = orange.darken(15%)
    let err(body) = text(size: 7pt, weight: "bold", fill: orng, align(center, body))
    diagram(
      node-stroke: 0.8pt + headingblue,
      node-fill: blue.lighten(93%),
      node-corner-radius: 3pt,
      node-inset: 5pt,
      spacing: (6mm, 8mm),
      edge-stroke: 2pt + headingblue,

      node((0, 1), b[*Datçik* \ (sensor)], width: 2.2cm, height: 1.1cm),
      node((1, 1), b[*Signalni* \ *konditsiyalaş* \ (Op-Amp / LPF)], width: 2.6cm, height: 1.5cm),
      node((2, 1), b[*12/16-bit* \ *ADC*], width: 2.2cm, height: 1.1cm),
      node((3, 1), b[*Mikrokontroller* \ *algoritmi*], width: 2.4cm, height: 1.1cm),
      node(
        (4, 1),
        b[*Çiqiş natijasi* \ $X_"ölçov" plus.minus Delta X$],
        width: 2.5cm,
        height: 1.1cm,
        fill: red.lighten(90%),
        stroke: 1pt + red,
      ),

      node((0, 0), err[Noçiziqlilik, \ gisterezis, harorat drifti], stroke: none, fill: none),
      node((1, 0), err[Şovqin (noise), \ ofset kuçlanişi], stroke: none, fill: none),
      node((2, 0), err[Kvantlaş xatosi \ (quantization)], stroke: none, fill: none),
      node((3, 0), err[Yaxlitlaş, \ approksimatsiya], stroke: none, fill: none),

      edge((0, 1), (1, 1), "-|>", stroke: 1pt),
      edge((1, 1), (2, 1), "-|>", stroke: 1pt),
      edge((2, 1), (3, 1), "-|>", stroke: 1pt),
      edge((3, 1), (4, 1), "-|>", stroke: 1pt + red),
      ..range(0, 4).map(i => edge((i, 0), (i, 1), "-|>", stroke: 1pt + orng)),
    )
  },
  caption: [Informatsion-ölçov zanjiri böylab xatoliklar yiğilişining blok-diagrammasi],
) <fig-err>

== Datçiklar va informatsion modullarning “vannasimon” (bathtub curve) buzilişlar intensivligi grafigi

#figure(
  cetz.canvas(length: 1.1cm, {
    import cetz.draw: *

    let arr = (end: "stealth", fill: black)
    let small(body) = text(size: 7.5pt, weight: "bold", body)
    let dash = (paint: blue.lighten(10%), thickness: 1pt, dash: "dashed")

    line((0, 0), (6.5, 0), stroke: 1pt, mark: arr)
    line((0, 0), (0, 4.0), stroke: 1pt, mark: arr)
    content((6.6, 0), anchor: "west", text(size: 9pt)[Vaqt ($t$, ekspluatatsiya)])
    content((0, 4.1), anchor: "south", text(size: 9pt)[Buzilişlar intensivligi ($lambda(t)$)])

    // Davr chegaralari
    line((1.8, 0), (1.8, 3.8), stroke: dash)
    line((4.2, 0), (4.2, 3.8), stroke: dash)

    // Vannasimon egri chiziq
    let bc = 2.2pt + headingblue
    bezier((0.3, 3.5), (1.8, 0.8), (0.8, 0.8), (1.5, 0.8), stroke: bc)
    line((1.8, 0.8), (4.2, 0.8), stroke: bc)
    bezier((4.2, 0.8), (5.8, 3.8), (4.8, 0.8), (5.5, 2.5), stroke: bc)

    content((0.95, 2.2), align(center, text(fill: orange.darken(15%), small[I davr: \ işga tuşiriş \ (burn-in)])))
    content((3.0, 1.3), align(center, text(
      fill: headingblue,
      small[II davr: normal ekspluatatsiya \ ($lambda = "const"$, tasodifiy buzilişlar)],
    )))
    content((5.05, 2.2), align(center, text(fill: red, small[III davr: \ yeyiliş / qariş \ (wear-out)])))
  }),
  caption: [Datçik va elektron modullarning ekspluatatsiya davridagi “vannasimon” buzilişlar intensivligi $lambda(t)$],
) <fig-bathtub>

== Ketma-ket, parallel va majoritar (TMR) zaxiralangan tizimlarning işonçlilik strukturaviy sxemalari (RBD)

#figure(
  cetz.canvas(length: 0.9cm, {
    import cetz.draw: *

    let w = 1pt
    let arr = (end: "stealth", fill: black)
    let mblock(c, body) = {
      rect(
        (c.at(0) - 0.85, c.at(1) - 0.4),
        (c.at(0) + 0.85, c.at(1) + 0.4),
        radius: 0.08,
        fill: blue.lighten(93%),
        stroke: 0.8pt + headingblue,
      )
      content(c, align(center, text(size: 7pt, weight: "bold", body)))
    }
    let title(y, body) = content((-1.2, y), anchor: "east", text(size: 9pt, weight: "bold", body))

    // ---- a) Ketma-ket ----
    let ya = 2.9
    title(ya)[a) Ketma-ket:]
    mblock((0.6, ya))[Modul 1 \ $P_1$]
    mblock((3.0, ya))[Modul 2 \ $P_2$]
    mblock((5.4, ya))[Modul 3 \ $P_3$]
    line((-0.9, ya), (-0.25, ya), stroke: w, mark: arr)
    line((1.45, ya), (2.15, ya), stroke: w, mark: arr)
    line((3.85, ya), (4.55, ya), stroke: w, mark: arr)
    line((6.25, ya), (7.0, ya), stroke: w, mark: arr)

    // ---- b) Parallel ----
    let yb = 0
    title(yb)[b) Parallel:]
    mblock((3.0, yb + 0.8))[Sensor A \ ($P_1$)]
    mblock((3.0, yb - 0.8))[Sensor B \ ($P_2$)]
    line((-0.9, yb), (1.2, yb), stroke: w)
    line((1.2, yb - 0.8), (1.2, yb + 0.8), stroke: w)
    line((1.2, yb + 0.8), (2.15, yb + 0.8), stroke: w)
    line((1.2, yb - 0.8), (2.15, yb - 0.8), stroke: w)
    line((3.85, yb + 0.8), (4.8, yb + 0.8), stroke: w)
    line((3.85, yb - 0.8), (4.8, yb - 0.8), stroke: w)
    line((4.8, yb - 0.8), (4.8, yb + 0.8), stroke: w)
    line((4.8, yb), (7.0, yb), stroke: w, mark: arr)

    // ---- c) TMR (2/3) ----
    let yc = -3.2
    title(yc)[c) TMR (2/3):]
    for (i, dy) in (1.0, 0, -1.0).enumerate() {
      mblock((1.5, yc + dy))[Sensor #(i + 1)]
      line((-0.9, yc), (-0.2, yc), stroke: w)
      line((-0.2, yc + dy), (0.65, yc + dy), stroke: w)
    }
    line((-0.2, yc - 1.0), (-0.2, yc + 1.0), stroke: w)
    let maj = (4.2, yc)
    line((2.35, yc + 1.0), (maj.at(0), yc + 1.0), (maj.at(0), yc + 0.5), stroke: w)
    line((2.35, yc), (maj.at(0) - 0.5, yc), stroke: w)
    line((2.35, yc - 1.0), (maj.at(0), yc - 1.0), (maj.at(0), yc - 0.5), stroke: w)
    circle(maj, radius: 0.5, fill: orange.lighten(80%), stroke: 1.2pt + orange.darken(15%))
    content(maj, align(center, text(size: 7pt, weight: "bold")[2/3 \ Maj]))
    line((maj.at(0) + 0.5, yc), (7.0, yc), stroke: 2pt + orange.darken(15%), mark: (
      end: "stealth",
      fill: orange.darken(15%),
    ))
  }),
  caption: [Informatsion tizimlar işonçliligining strukturaviy körinişlari (RBD)],
) <fig-rbd>

= Amaliy topşiriqlar va tizimli tahlil

== Topşiriq 1: informatsion tizimdagi xatolik turlarini va ularni kamaytiriş usullarini tahlil qiliş

Mexatronik va robotik informatsion tizimda uçraydigan xatolik manbalarini tahlil qiling va @tab-err ni töldiring.

#figure(
  {
    set text(size: 9.5pt)
    set par(justify: false)
    table(
      columns: (auto, 3.2cm, 1fr, 1fr),
      align: (center + horizon, left + horizon, left + horizon, left + horizon),
      stroke: none,
      inset: (x: 5pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*№*], [*Xatolik manbai*], [*Xatolik şakli / körinişi*], [*Kompensatsiya / yöqotiş usuli*]),
      table.hline(stroke: 0.5pt),
      [1], [Datçik harorat drifti], [Sistematik (nol siljişi va sezgirlik özgarişi)],
      [Dasturiy harorat kompensatsiyasi, termostatlaş.],
      [2], [Elektromagnit şovqinlar], [Tasodifiy (tebranma fluktuatsiyalar)],
      [Ekranlangan kabel, median va Kalman filtrlari.],
      [3], [ADC kvantlaş xatosi], [Çekli ajratiş qobiliyati ($plus.minus 0.5 "LSB"$)],
      [ADC bitlar sonini oşiriş ($12 -> 16$-bit), oversampling.],
      [4], [Operator xatosi / tarmoq uzilişi], [Qöpol xatolik (keskin sakraşlar)],
      [Grubbs va $3 sigma$ qoidasi böyiça maʼlumotni filtrlaş.],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Informatsion tizim xatoliklari tahlili va kompensatsiya usullari],
) <tab-err>

== Topşiriq 2: kritik robotik tizimlar uçun zaxiralaş darajasini tanlaş

Avtonom uçuvçisiz dron (UAV) va sanoat roboti uçun sensorlar zaxiralanadi.

- *UAV navigatsiya tizimi:* MEMS IMU datçigining buzilişlar intensivligi $lambda = 10^(-4) "1/soat"$.
- *Variant A (zaxirasiz):* 1 ta IMU.
- *Variant B (TMR --- 2/3):* 3 ta IMU va majoritar mantiqiy blok.

$t = 500 "soat"$ parvoz vaqtida har bir variantning işonçlilik ehtimoli $P(t)$ ni taqqoslang.

*Yeçim:* $lambda t = 10^(-4) times 500 = 0.05$.

#eq($ P_A = e^(-0.05) approx 0.9512 quad (95.12%) $)
#eq($ P_B = 3 e^(-0.10) - 2 e^(-0.15) = 3 times 0.9048 - 2 times 0.8607 approx 0.9931 quad (99.31%) $)

TMR zaxiralaş nosozlik ehtimolini $4.88%$ dan $0.69%$ gaça, yaʼni taxminan 7 baravar kamaytiradi.

= Hisoblaş va modellaştiriş masalalari

== Masala 1: ölçov natijalarini statistik tahlil qiliş va Student böyiça oraliq baholaş

Optik enkoder yordamida robot böğinining buriliş burçagi bir xil şaroitda $N = 6$ marta ölçandi va quyidagi natijalar olindi (gradusda):

#eq($ x_i = {45.12 degree, 45.18 degree, 45.10 degree, 45.15 degree, 45.14 degree, 45.11 degree} $)

#set enum(numbering: "a)")
+ Örtaça arifmetik qiymat $macron(x)$, dispersiya $S_x^2$ va örtaça kvadratik oğiş $S_x$ ni hisoblang.
+ Örtaça qiymatning standart oğişi $S_(macron(x))$ ni aniqlang.
+ Işonç ehtimoli $P = 0.95$ ($95%$) bölganda Student koeffitsientini @tab-student dan olib, buriliş burçagining haqiqiy qiymati uçun işonç oraliğini toping.
#set enum(numbering: "1.")

*Hisoblaş bosqiçlari:*

- Örtaça arifmetik qiymat $macron(x)$:
  #eq($ macron(x) = (45.12 + 45.18 + 45.10 + 45.15 + 45.14 + 45.11) / 6 = 270.80 / 6 approx 45.1333 degree $)
- Oğişlar kvadratlari yiğindisi $sum (x_i - macron(x))^2$:
  #eq($ (45.12 - 45.1333)^2 = (-0.0133)^2 = 0.000177, \ quad (45.18 - 45.1333)^2 = (0.0467)^2 = 0.002181 $)
  #eq($ (45.10 - 45.1333)^2 = (-0.0333)^2 = 0.001109, \ quad (45.15 - 45.1333)^2 = (0.0167)^2 = 0.000279 $)
  #eq($ (45.14 - 45.1333)^2 = (0.0067)^2 = 0.000045, \ quad (45.11 - 45.1333)^2 = (-0.0233)^2 = 0.000543 $)
  #eq($ sum (x_i - macron(x))^2 = 0.004334 $)
- Dispersiya va tanlanma standart oğişi $S_x$:
  #eq($ S_x^2 = 0.004334 / (6 - 1) = 0.004334 / 5 = 0.0008668 ==> S_x = sqrt(0.0008668) approx 0.02944 degree $)
- Örtaça qiymatning standart oğişi $S_(macron(x))$:
  #eq($ S_(macron(x)) = S_x / sqrt(6) = 0.02944 / 2.4495 approx 0.01202 degree $)
- Student koeffitsienti $P = 0.95$ va $f = N - 1 = 5$ uçun jadval böyiça: $t_(0.05, 5) = 2.571$.
- Işonç çegarasi: $Delta = t dot S_(macron(x)) = 2.571 times 0.01202 degree approx 0.0309 degree$.
- Yakuniy işonç oraliği ($95%$ ehtimollik bilan):
  #eq(
    $
      X_"haqiqiy" = 45.1333 degree plus.minus 0.0309 degree quad "yoki" quad 45.1024 degree <= X_"haqiqiy" <= 45.1642 degree
    $,
  )

== Masala 2: datçikning töxtovsiz işlaş ehtimoli $P(t)$ va MTBF hisobi

Sanoat roboti böğinidagi tok sensori drayverining buzilişlar intensivligi özgarmas bölib, $lambda = 2.5 times 10^(-5) "1/soat"$ ga teng.

#set enum(numbering: "a)")
+ Sensorning buzilişlar orasidagi örtaça vaqti (MTBF) neça soat va neça yilni taşkil etadi ($1 "yil" approx 8760 "soat"$)?
+ Sensorning $t = 1000$, $5000$ va $10000$ soat ekspluatatsiya vaqtidagi töxtovsiz işlaş ehtimolliklari $P(t)$ ni hisoblang.
+ Agar sensorni tiklaş uçun örtaça $"MTTR" = 5 "soat"$ ketsa, tayyorlik koeffitsienti $K_t$ qançaga teng?
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ "MTBF" = 1 / lambda, quad quad P(t) = e^(-lambda t), quad quad K_t = "MTBF" / ("MTBF" + "MTTR") $)

*Hisoblaş bosqiçlari:*

- MTBF hisobi:
  #eq($ "MTBF" = 1 / (2.5 times 10^(-5)) = 40000 "soat" approx 40000 / 8760 approx 4.566 "yil" $)
- $P(t)$ ehtimolliklar hisobi:
  #eq($ P(1000) = e^(-(2.5 times 10^(-5)) times 1000) = e^(-0.025) approx 0.9753 quad (97.53%) $)
  #eq($ P(5000) = e^(-(2.5 times 10^(-5)) times 5000) = e^(-0.125) approx 0.8825 quad (88.25%) $)
  #eq($ P(10000) = e^(-(2.5 times 10^(-5)) times 10000) = e^(-0.250) approx 0.7788 quad (77.88%) $)
- Tayyorlik koeffitsienti $K_t$:
  #eq($ K_t = 40000 / (40000 + 5) = 40000 / 40005 approx 0.999875 quad (99.9875%) $)

== Masala 3: zaxiralangan robotik informatsion tizimning işonçlilik hisobi

Mobil robot navigatsiya tizimida 3 ta bir xil lidar sensori TMR (2/3) majoritar zaxiralaş sxemasi böyiça ulangan. Har bir lidar datçigining $t = 2000 "soat"$ vaqtdagi töxtovsiz işlaş ehtimoli $P_1 = P_2 = P_3 = P = 0.90$ ($90%$).

#set enum(numbering: "a)")
+ Bitta lidar (zaxirasiz) işlatilgandagi işonçlilik ehtimoli $P_"single"$ ni aniqlang.
+ TMR (2/3) zaxiralangan informatsion tizimning umumiy işonçlilik ehtimoli $P_"TMR"$ ni hisoblang va zaxiralaş samarasini baholang.
#set enum(numbering: "1.")

*Yeçiş va formulalar:*

#eq($ P_"TMR" (t) = 3 P^2 (t) - 2 P^3 (t) $)

*Hisoblaş bosqiçlari:*

- Yakka sensor işonçliligi: $P_"single" = 0.90$ ($90.0%$).
- TMR (2/3) zaxiralangan tizim işonçliligi:
  #eq(
    $
      P_"TMR" = 3 times (0.90)^2 - 2 times (0.90)^3 = 3 times 0.81 - \ 2 times 0.729 = 2.43 - 1.458 = 0.972 quad (97.2%)
    $,
  )
- Xulosa: TMR (2/3) zaxiralaş qöllanilişi natijasida informatsion tizimning töxtovsiz işlaş ehtimoli $90.0%$ dan $97.2%$ ga kötarildi va nosozlik ehtimoli $10%$ dan $2.8%$ ga (yaʼni $3.57$ baravar) kamaydi.

= Işni bajariş tartibi va metodik tavsiyalar

Amaliy maşğulotni bajarişda talabalar quyidagi bosqiçlarni ketma-ket amalga oşirişlari şart:

+ *1-bosqiç: ölçov natijalarini töplaş va statistik tozalaş.* Laboratoriya stendidagi datçik körsatkiçlarini $N = 6 dots 10$ marta yozib oling. Qöpol xatoliklarni Grubbs yoki $3 sigma$ qoidasi böyiça maʼlumotlar töplamidan çiqarib taşlang.
+ *2-bosqiç: statistik körsatkiçlarni hisoblaş.* Olingan tanlanma böyiça $macron(x)$, $S_x$, $S_(macron(x))$ qiymatlarini hisoblang va $95%$ işonç darajasida Student işonç oraliğini aniqlang.
+ *3-bosqiç: datçiklar va modullarning işonçlilik körsatkiçlarini modellaştiriş.* MATLAB / Python muhitida eksponensial taqsimot böyiça $P(t) = e^(-lambda t)$ grafigini turli $lambda$ qiymatlari uçun çizing.
+ *4-bosqiç: zaxiralangan tizimlar işonçliligini simulyatsiya qiliş.* Ketma-ket, parallel va TMR (2/3) ulaniş strukturalari böyiça $P_"sys" (t)$ grafiklarini taqqoslang.
+ *5-bosqiç: hisobot tayyorlaş va xulosalar çiqariş.* Olingan natijalarni tahlil qilib, amaliy hisobotni rasmiylaştiring.

= Nazorat va muhokama savollari

+ Informatsion tizimlardagi absolyut, nisbiy va keltirilgan xatoliklarning taʼrifini va farqini tuşuntiring.
+ Sistematik va tasodifiy xatoliklarning kelib çiqiş sabablari hamda ularni kamaytiriş usullarini ayting.
+ Student $t$-taqsimoti nima va u kiçik hajmdagi ($N < 30$) tanlanmalarda işonç oraliğini topişda qanday qöllaniladi?
+ Datçik va informatsion modullarning töxtovsiz işlaş ehtimoli $P(t)$ va buzilişlar intensivligi $lambda$ örtasidagi boğliqlikni izohlang.
+ “Vannasimon” (_bathtub curve_) buzilişlar intensivligi grafigining 3 ta davri qanday xarakterlanadi?
+ MTBF (_Mean Time Between Failures_) va MTTR (_Mean Time To Repair_) körsatkiçlari nimani anglatadi?
+ Tayyorlik koeffitsienti $K_t$ qanday hisoblanadi va unga MTTR parametrining taʼsiri qanday?
+ Ketma-ket ulangan informatsion tizimlarning umumiy işonçliligi nima uçun alohida modullar işonçliligidan har doim kiçik böladi?
+ Parallel zaxiralangan va majoritar (TMR --- 2/3) zaxiralangan tizimlarning afzallik hamda kamçiliklarini tuşuntiring.
+ Nima uçun kritik robototexnik tizimlarda (kosmik robotlar, avtonom transport, tibbiyot robotlari) TMR zaxiralaş qöllaniladi?
+ ADC kvantlaş xatosi (_quantization error_) raqamli informatsion kanallarda qanday nazorat qilinadi?
+ Kalman filtri va median filtri tasodifiy ölçov xatoliklarini kamaytirişda qanday vazifani bajaradi?
