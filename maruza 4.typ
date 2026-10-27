// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №4. Informatsion qurilmalarning turlari va xususiyatlari.
//             Birlamchi oʻzgartirgichlar. Informatsion qurilmalarning vazifalari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №4. Informatsion qurilmalarning turlari va ularning xususiyatlari. Birlamchi oʻzgartirgichlar (datchiklar, sensorlar). Informatsion qurilmalarning asosiy vazifalari",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 4  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №4]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Informatsion qurilmalarning turlari va ularning xususiyatlari. Birlamchi oʻzgartirgichlar (datchiklar, sensorlar). Informatsion qurilmalarning asosiy vazifalari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Informatsion qurilmalarning turlari.
  + Birlamchi oʻzgartirgich tushunchasi va uning tuzilishi.
  + Parametrik birlamchi oʻzgartirgichlar.
  + Generatorli birlamchi oʻzgartirgichlar.
  + Birlamchi oʻzgartirgichlarning asosiy xususiyatlari.
  + Informatsion qurilmalarning asosiy vazifalari.
  + Birlamchi oʻzgartirgichni tanlash: robot boʻgʻini misolida.

  *Tayanch iboralar:* informatsion qurilma, birlamchi oʻzgartirgich, datchik, sensor, sezgir element, oraliq oʻzgartirgich, normallashtiruvchi oʻzgartirgich, oʻzgartirish zanjiri, sezgirlik, rezistiv, sigʻim, induktiv, termoelektrik, piezoelektrik, Xoll va induksion oʻzgartirgichlar, statik va dinamik tavsif, vaqt doimiysi, normallashtirish, signalizatsiya.
]

// =====================================================================
= Informatsion qurilmalarning turlari
// =====================================================================

Oldingi maʼruzada robotning informatsion tizimi informatsion-oʻlchash kanallaridan tashkil topishi koʻrsatilgan edi. Kanalning har bir boʻgʻini alohida *informatsion qurilma* boʻlib, oʻz vazifasini bajaradi. Bajaradigan vazifasi va kanaldagi oʻrniga koʻra informatsion qurilmalar quyidagi turlarga boʻlinadi (1-jadval).

#figure(
  btable(
    columns: (1fr, 1.4fr, 1.2fr),
    header: ([Qurilma turi], [Vazifasi], [Misollar]),
    [Birlamchi oʻzgartirgich (datchik)],
    [Oʻlchanayotgan kattalikni bevosita qabul qilib, uni oʻlchash uchun qulay signalga aylantiradi],
    [Tenzorezistor, termojuft, enkoder, fotodiod],

    [Oraliq (normallashtiruvchi) oʻzgartirgich],
    [Signalni kuchaytiradi, filtrlaydi va standart koʻrinishga keltiradi],
    [Oʻlchash koʻprigi, instrumental kuchaytirgich, 4–20 mA oʻzgartirgichi],

    [Analog-raqamli oʻzgartirgich],
    [Analog signalni raqamli kodga aylantiradi],
    [Mikrokontrollerning ARO moduli, alohida ARO mikrosxemalari],

    [Axborotni uzatish qurilmasi],
    [Axborotni masofaga uzatadi],
    [CAN, EtherCAT, IO-Link interfeyslari, simsiz modullar],

    [Axborotni qayta ishlash qurilmasi],
    [Axborotni filtrlaydi, kalibrlaydi, tahlil qiladi va qaror qabul qiladi],
    [Mikrokontroller, signal protsessori, PLC, robot kontrolleri],

    [Aks ettirish va signalizatsiya qurilmasi],
    [Axborotni operatorga koʻrsatadi yoki chegaraviy holat haqida ogohlantiradi],
    [Displey, operator pulti, yorugʻlik va tovush signalizatorlari],
  ),
  caption: [Informatsion qurilmalarning turlari],
) <tab-turlar>

Bu qurilmalardan *birlamchi oʻzgartirgich* alohida oʻrin tutadi: u oʻlchanayotgan obyekt bilan bevosita aloqada boʻladi va butun kanalning imkoniyatlarini belgilaydi. Birlamchi oʻzgartirgichda yoʻqotilgan yoki buzilgan axborotni keyingi qurilmalarda tiklab boʻlmaydi (2-maʼruza). Shu sababli ushbu maʼruzaning asosiy qismi birlamchi oʻzgartirgichlarga bagʻishlangan.

// =====================================================================
= Birlamchi oʻzgartirgich tushunchasi va uning tuzilishi
// =====================================================================

*Birlamchi oʻzgartirgich* — oʻlchash kanalining birinchi elementi boʻlib, oʻlchanayotgan fizik kattalik unga bevosita taʼsir qiladi va u bu kattalikni oʻlchash, uzatish va qayta ishlash uchun qulay boshqa kattalikka (odatda elektr signaliga) aylantiradi.

Amaliyotda «birlamchi oʻzgartirgich», «datchik» va «sensor» atamalari koʻpincha bir xil maʼnoda ishlatiladi, lekin ular orasida nozik farq bor:
- *birlamchi oʻzgartirgich* — fizik oʻzgartirishni bajaruvchi element (masalan, tenzorezistorning oʻzi);
- *datchik* — birlamchi oʻzgartirgich, uni oʻrnatish uchun korpus va ulanish elementlari, koʻpincha oraliq oʻzgartirgich bilan birga konstruktiv tugallangan qurilma (masalan, kuch datchigi);
- *sensor* — xalqaro adabiyotda kirishi noelektrik, chiqishi elektrik boʻlgan oʻzgartirgich; zamonaviy maʼnoda koʻpincha signalga ishlov berish va raqamli interfeysga ega datchik.

== Oʻzgartirish zanjiri

Koʻp hollarda oʻlchanayotgan kattalik elektr signaliga bir bosqichda emas, balki bir nechta oraliq kattaliklar orqali aylantiriladi. Birlamchi oʻzgartirgichning kattalik bevosita taʼsir qiladigan qismi *sezgir element*, keyingi qismlari esa *oʻzgartirish elementlari* deyiladi. Masalan, robot tutqichidagi kuch datchigida kuch avval elastik elementning deformatsiyasiga, deformatsiya tenzorezistor qarshiligining oʻzgarishiga, qarshilik oʻzgarishi esa oʻlchash koʻprigida kuchlanishga aylanadi (1-rasm).

#figure(
  diagram(
    spacing: (5mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Kuch \ $F$], fill: white, name: <f>),
    node((1, 0), [Elastik \ element], name: <el>),
    node((2, 0), [Tenzo- \ rezistor], name: <tr>),
    node((3, 0), [Oʻlchash \ koʻprigi], name: <kp>),
    node((4, 0), [Kuchay- \ tirgich], name: <ku>),
    node((5, 0), [ARO], fill: lightorange, name: <aro>),
    edge(<f>, <el>, "->"),
    edge(<el>, <tr>, "->", [$epsilon$], label-side: left),
    edge(<tr>, <kp>, "->", [$Delta R$], label-side: left),
    edge(<kp>, <ku>, "->", [$U$], label-side: left),
    edge(<ku>, <aro>, "->"),
  ),
  caption: [Kuch datchigidagi oʻzgartirish zanjiri],
) <fig-zanjir>

Agar zanjirning har bir boʻgʻini chiziqli va sezgirligi $S_i$ boʻlsa, butun zanjirning sezgirligi boʻgʻinlar sezgirliklarining koʻpaytmasiga teng:

#eq($ S = S_1 dot S_2 dot dots dot S_n. $)

(1) ifodadan muhim xulosa kelib chiqadi: har bir boʻgʻinning nisbiy xatoligi umumiy natijaga qoʻshiladi, shuning uchun zanjir qancha uzun boʻlsa, natija shuncha koʻp omillarga bogʻliq boʻladi. Zamonaviy datchiklarda zanjirdagi oʻzgartirishlar sonini kamaytirishga va har bir boʻgʻinni kalibrlashga intiladilar.

Birlamchi oʻzgartirgichlar chiqish signalining tabiatiga koʻra ikki katta guruhga boʻlinadi (3-maʼruza): *parametrik* oʻzgartirgichlarda kattalik elektr zanjirining parametrini (qarshilik, sigʻim, induktivlik) oʻzgartiradi va ularni oʻlchash uchun tashqi taʼminot manbai kerak; *generatorli* oʻzgartirgichlar esa oʻlchanayotgan kattalik taʼsirida oʻzi elektr yurituvchi kuch, zaryad yoki tok hosil qiladi. Quyida har bir guruhning asosiy turlari koʻriladi.

// =====================================================================
= Parametrik birlamchi oʻzgartirgichlar
// =====================================================================

== Rezistiv oʻzgartirgichlar

Rezistiv oʻzgartirgichlarda oʻlchanayotgan kattalik oʻtkazgich yoki yarimoʻtkazgichning qarshiligini oʻzgartiradi. Qarshilik $R = rho l slash S$ ifoda bilan aniqlanadi, shuning uchun uni solishtirma qarshilik $rho$, uzunlik $l$ yoki kesim yuzasi $S$ ni oʻzgartirish orqali boshqarish mumkin.

*Potensiometrik oʻzgartirgich* — sirpanuvchi kontaktli oʻzgaruvchan rezistor. Uning chiqish kuchlanishi surgichning siljishiga proporsional:

#eq($ U_"chiq" = U dot x / L, $)

bu yerda $U$ — taʼminot kuchlanishi, $x$ — surgich siljishi, $L$ — rezistiv qatlamning toʻliq uzunligi. Potensiometrlar oddiy va arzon, lekin sirpanuvchi kontakt yeyiladi va shovqin hosil qiladi. Ular oʻquv robotlari va arzon servoyuritmalarda burchak datchigi sifatida qoʻllanadi.

*Tenzorezistor* deformatsiyani qarshilik oʻzgarishiga aylantiradi: $Delta R slash R = k dot epsilon$, bu yerda $epsilon$ — nisbiy deformatsiya, $k$ — tenzosezgirlik koeffitsienti (metall tenzorezistorlar uchun $k approx 2$). Qarshilik oʻzgarishi juda kichik boʻlgani uchun tenzorezistor oʻlchash koʻprigiga ulanadi. Bitta faol tenzorezistorli (chorak) koʻprikning chiqish kuchlanishi:

#eq($ U_"chiq" approx U / 4 dot (Delta R) / R = U / 4 dot k dot epsilon. $)

*Misol.* $U = 5$ V, $k = 2$, $epsilon = 10^(-3)$ boʻlsa, $U_"chiq" approx 5 slash 4 dot 2 dot 10^(-3) = 2","5$ mV. Bunday kichik signal albatta kuchaytirilishi kerak. Tenzorezistorlar robotlarning kuch-moment datchiklari, tutqichlardagi kuch datchiklari va tarozilarning asosini tashkil etadi.

*Termorezistorlar* qarshiligi haroratga bogʻliq boʻlgan elementlar: metall termorezistorlar (Pt100) va yarimoʻtkazgichli termistorlar. Robotlarda ular dvigatellar, drayverlar va akkumulyatorlar haroratini nazorat qilishda qoʻllanadi.

== Sigʻim oʻzgartirgichlar

Sigʻim oʻzgartirgich — elektrodlaridan biri oʻlchanayotgan kattalik taʼsirida siljiydigan kondensator. Yassi kondensatorning sigʻimi:

#eq($ C = (epsilon_0 epsilon_r S) / d, $)

bu yerda $epsilon_0 = 8","854 dot 10^(-12)$ F/m — elektr doimiysi, $epsilon_r$ — muhitning nisbiy dielektrik singdiruvchanligi, $S$ — elektrodlar yuzasi, $d$ — ular orasidagi masofa. Sigʻimni $d$, $S$ yoki $epsilon_r$ ni oʻzgartirish orqali boshqarish mumkin.

*Misol.* $S = 1$ sm², $d = 0","1$ mm, havo ($epsilon_r approx 1$) uchun $C approx 8","85$ pF. Sigʻim juda kichik boʻlgani uchun sigʻim oʻzgartirgichlarga maxsus oʻlchash sxemalari kerak, lekin ular juda sezgir boʻladi. Sigʻim oʻzgartirgichlar MEMS akselerometr va giroskoplarda, kontaktsiz yaqinlik datchiklarida va robotlarning taktil qoplamalarida keng qoʻllanadi.

== Induktiv oʻzgartirgichlar

Induktiv oʻzgartirgichlarda oʻlchanayotgan kattalik gʻaltakning induktivligini yoki ikki gʻaltak orasidagi oʻzaro induktivlikni oʻzgartiradi. Havo tirqishli magnit oʻtkazgichli gʻaltakning induktivligi taxminan:

#eq($ L approx (w^2 mu_0 S) / delta, $)

bu yerda $w$ — oʻramlar soni, $mu_0$ — magnit doimiysi, $S$ — tirqish kesimi, $delta$ — havo tirqishi uzunligi. Yakor siljishi $delta$ ni oʻzgartiradi va induktivlik oʻzgaradi.

Robototexnikada induktiv oʻzgartirgichlarning quyidagi turlari keng tarqalgan: *induktiv yaqinlik datchiklari* (metall obyektni kontaktsiz sezish), *chiziqli differensial transformator* (LVDT, aniq chiziqli siljish) va *rezolverlar* (burchak oʻlchash uchun aylanuvchi transformator). Ular kontaktsiz, mexanik yeyilmaydi va ogʻir sharoitlarga chidamli.

// =====================================================================
= Generatorli birlamchi oʻzgartirgichlar
// =====================================================================

*Termoelektrik oʻzgartirgich (termojuft)* — ikki xil metalldan yasalgan va bir uchi payvandlangan oʻtkazgichlar juftligi. Issiq va sovuq uchlar haroratlari farqi termo-EYuK hosil qiladi (Zeebek effekti):

#eq($ E = alpha (T_1 - T_2), $)

bu yerda $alpha$ — termojuft sezgirligi. K tipidagi termojuft uchun $alpha approx 41$ µV/°C, demak 100 °C farq taxminan 4,1 mV beradi. Termojuftlar keng harorat diapazonida ishlaydi va robotlashtirilgan payvandlash, quyish kabi jarayonlarda qoʻllanadi.

*Piezoelektrik oʻzgartirgich* mexanik kuch taʼsirida yuzasida elektr zaryad hosil qiluvchi kristall (kvars) yoki keramikadan iborat:

#eq($ q = d dot F, $)

bu yerda $d$ — piezomodul. Kvars uchun $d approx 2","3$ pC/N, demak 100 N kuch taxminan 230 pC zaryad hosil qiladi. Zaryad vaqt oʻtishi bilan oqib ketgani uchun piezoelektrik oʻzgartirgichlar asosan oʻzgaruvchan (dinamik) kuch, tebranish, zarba va tezlanishni oʻlchashga yaroqli, statik kuchni esa uzoq vaqt oʻlchay olmaydi. Ular ultratovush lokatorlarida ham nurlantirgich va qabul qilgich sifatida ishlatiladi.

*Xoll oʻzgartirgichi* — magnit maydonga joylashtirilgan, tok oʻtayotgan yarimoʻtkazgich plastinka. Unda tok va maydonga perpendikulyar yoʻnalishda Xoll kuchlanishi hosil boʻladi:

#eq($ U_H = (R_H dot I dot B) / h, $)

bu yerda $R_H$ — Xoll doimiysi, $I$ — plastinkadagi tok, $B$ — magnit induksiyasi, $h$ — plastinka qalinligi. Xoll oʻzgartirgichi taʼminot tokini talab qilgani uchun qatʼiy aytganda generatorli emas, lekin chiqishda bevosita kuchlanish beradi. Robotlarda Xoll datchiklari kollektorsiz dvigatellarda rotor holatini aniqlash, magnit enkoderlar, kontaktsiz chegara datchiklari va tok datchiklarida qoʻllanadi.

*Induksion oʻzgartirgich* elektromagnit induksiya qonuniga asoslanadi: gʻaltak bilan bogʻliq magnit oqimi oʻzgarganda unda EYuK hosil boʻladi:

#eq($ e = -w (d Phi) / (d t). $)

Hosil boʻlgan EYuK oqimning oʻzgarish tezligiga proporsional boʻlgani uchun induksion oʻzgartirgichlar tezlikni oʻlchashda qoʻllanadi: taxogeneratorlar, gʻildirak aylanish tezligi datchiklari (masalan, avtomobil ABS tizimida).

*Fotoelektrik oʻzgartirgichlar* (fotodiodlar, fototranzistorlar) yorugʻlik oqimini tokka aylantiradi. Ular optik enkoderlar, yorugʻlik pardalari, optik yaqinlik datchiklari va kameralarning asosidir.

Koʻrib chiqilgan birlamchi oʻzgartirgichlar 2-jadvalda umumlashtirilgan.

#figure(
  btable(
    columns: (auto, 1fr, 1.3fr),
    header: ([Oʻzgartirgich], [Chiqish kattaligi], [Robotdagi qoʻllanilishi]),
    [Potensiometrik],
    [Qarshilik (kuchlanish boʻlgich)],
    [Burchak va chiziqli siljish],
    [Tenzorezistiv],
    [Qarshilik oʻzgarishi],
    [Kuch-moment datchiklari, tutqich kuchi],
    [Termorezistiv],
    [Qarshilik],
    [Dvigatel va drayver harorati],
    [Sigʻim],
    [Sigʻim],
    [MEMS akselerometrlar, yaqinlik, taktil qoplama],
    [Induktiv],
    [Induktivlik, oʻzaro induktivlik],
    [LVDT, rezolver, induktiv yaqinlik datchigi],
    [Termoelektrik],
    [Termo-EYuK],
    [Texnologik jarayon harorati],
    [Piezoelektrik],
    [Elektr zaryad],
    [Tebranish, zarba, ultratovush lokatori],
    [Xoll],
    [Kuchlanish],
    [BLDC rotor holati, magnit enkoder, tok],
    [Induksion],
    [EYuK],
    [Tezlik datchiklari, taxogenerator],
    [Fotoelektrik],
    [Tok],
    [Optik enkoder, yorugʻlik pardasi, kamera],
  ),
  caption: [Asosiy birlamchi oʻzgartirgichlar],
) <tab-oz>

// =====================================================================
= Birlamchi oʻzgartirgichlarning asosiy xususiyatlari
// =====================================================================

Birlamchi oʻzgartirgichning sifati bir qator xususiyatlar (tavsiflar) bilan baholanadi. Ularni uch guruhga ajratish mumkin.

*Statik xususiyatlar* kirish kattaligi oʻzgarmas yoki sekin oʻzgarganda chiqish va kirish orasidagi bogʻliqlikni tavsiflaydi: oʻlchash diapazoni, statik tavsif (oʻzgartirish funksiyasi) va uning chiziqliligi, sezgirlik $S = Delta y slash Delta x$, ruxsat qobiliyati, gisterezis, takrorlanuvchanlik, nol siljishi va harorat drifti.

*Dinamik xususiyatlar* kirish kattaligi tez oʻzgarganda oʻzgartirgichning xatti-harakatini tavsiflaydi. Koʻp oʻzgartirgichlar (termojuft, termorezistor, past chastotali filtrli datchiklar) birinchi tartibli differensial tenglama bilan yetarli aniqlikda tavsiflanadi:

#eq($ tau (d y) / (d t) + y = S dot x, $)

bu yerda $tau$ — vaqt doimiysi. Pogʻonali kirish taʼsirida chiqish $tau$ vaqtda barqaror qiymatning 63 % iga, taxminan $3 tau$ vaqtda esa 95 % iga yetadi. Massa va elastik elementga ega oʻzgartirgichlar (akselerometrlar, kuch datchiklari) esa ikkinchi tartibli tizim sifatida xususiy chastota va soʻnish koeffitsienti bilan tavsiflanadi; ular xususiy chastotadan ancha past chastotalarda ishlatilishi kerak.

*Ekspluatatsion xususiyatlar:* ishonchlilik va xizmat muddati, tashqi taʼsirlarga (harorat, namlik, vibratsiya, elektromagnit maydon) chidamlilik, oʻlchami va massasi, taʼminot talablari, chiqish signalining turi va interfeysi, narxi.

Statik va dinamik xususiyatlarni aniqlash va xatoliklarni hisoblash amaliy mashgʻulotlarda batafsil oʻrganiladi.

// =====================================================================
= Informatsion qurilmalarning asosiy vazifalari
// =====================================================================

Informatsion qurilmalar robot informatsion tizimida axborot bilan bogʻliq quyidagi asosiy vazifalarni (funksiyalarni) bajaradi (2-rasm).

#figure(
  diagram(
    spacing: (8mm, 8mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Qabul qilish \ va oʻzgartirish], name: <a>),
    node((1, 0), [Normal- \ lashtirish], name: <b>),
    node((2, 0), [Raqamga \ aylantirish], name: <c>),
    node((3, 0), [Uzatish], name: <d>),
    node((3, 1), [Qayta \ ishlash], name: <e>),
    node((1.5, 1), [Saqlash, \ aks ettirish], fill: lightorange, name: <f>),
    node((3, 2), [Nazorat, signalizatsiya, \ diagnostika], fill: lightorange, name: <g>),
    edge(<a>, <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<c>, <d>, "->"),
    edge(<d>, <e>, "->"),
    edge(<e>, <f>, "->"),
    edge(<e>, <g>, "->"),
  ),
  caption: [Informatsion qurilmalarning asosiy vazifalari],
) <fig-vazifa>

+ *Axborotni qabul qilish va oʻzgartirish* — fizik kattalikni elektr signaliga aylantirish. Bu vazifani birlamchi oʻzgartirgich bajaradi.
+ *Normallashtirish* — signalni kuchaytirish, filtrlash, chiziqlashtirish va standart diapazonga (masalan, 0–10 V yoki 4–20 mA) keltirish. Standart signal turli datchiklarni bir xil kirish qurilmalariga ulash imkonini beradi.
+ *Raqamga aylantirish* — signalni diskretlash va kvantlash (2-maʼruza).
+ *Uzatish* — axborotni datchikdan boshqaruv tizimiga xalaqitlardan himoyalangan holda yetkazish. Tok signali (4–20 mA) va raqamli shinalar uzun masofada kuchlanish signaliga nisbatan xalaqitga chidamliroq.
+ *Qayta ishlash* — raqamli filtrlash, kalibrlash tavsifi boʻyicha tuzatish, harorat kompensatsiyasi, bir nechta datchik maʼlumotlarini birlashtirish, belgilarni ajratish.
+ *Saqlash va aks ettirish* — oʻlchash natijalarini xotirada saqlash (jurnal, diagnostika uchun) va operatorga displey yoki pultda koʻrsatish.
+ *Nazorat, signalizatsiya va diagnostika* — oʻlchangan qiymatni chegaraviy qiymatlar bilan solishtirish, chegaradan chiqilganda ogohlantirish yoki himoyani ishga tushirish (masalan, dvigatel qizib ketganda toʻxtatish), datchikning oʻzi sozligini tekshirish.

Anʼanaviy tizimlarda bu vazifalar alohida qurilmalarda bajarilgan. Intellektual datchiklarda esa ularning koʻpchiligi — oʻzgartirish, normallashtirish, raqamga aylantirish, qayta ishlash, oʻz-oʻzini diagnostika qilish va raqamli uzatish — bitta qurilmada birlashtiriladi.

// =====================================================================
= Birlamchi oʻzgartirgichni tanlash: robot boʻgʻini misolida
// =====================================================================

Bir xil kattalikni turli birlamchi oʻzgartirgichlar bilan oʻlchash mumkin. Toʻgʻri tanlov robot vazifasi, ish sharoiti, talab qilinadigan aniqlik va narxga bogʻliq. Misol tariqasida robot boʻgʻini burchagini oʻlchash uchun keng qoʻllanadigan toʻrt xil oʻzgartirgichni taqqoslaymiz (3-jadval).

#figure(
  btable(
    columns: (auto, 1fr, 1fr, 1fr),
    header: ([Koʻrsatkich], [Potensiometr], [Rezolver], [Optik enkoder]),
    [Fizik prinsip],
    [Rezistiv],
    [Induktiv],
    [Fotoelektrik],
    [Kontakt],
    [Sirpanuvchi kontakt],
    [Kontaktsiz],
    [Kontaktsiz],
    [Chiqish signali],
    [Analog kuchlanish],
    [Analog sin/cos],
    [Raqamli impuls yoki kod],
    [Ruxsat qobiliyati],
    [Past–oʻrtacha],
    [Yuqori (oʻzgartirgichga bogʻliq)],
    [Juda yuqori],
    [Ogʻir sharoitga chidamlilik],
    [Past (yeyilish)],
    [Juda yuqori],
    [Oʻrtacha (chang, namlik)],
    [Narxi],
    [Past],
    [Yuqori],
    [Oʻrtacha–yuqori],
    [Odatiy qoʻllanilishi],
    [Oʻquv robotlari, oddiy servolar],
    [Ogʻir sharoitdagi yuritmalar],
    [Sanoat va kollaborativ robotlar],
  ),
  caption: [Robot boʻgʻini burchak datchiklarini taqqoslash],
) <tab-tanlash>

Bulardan tashqari, *magnit enkoderlar* (Xoll yoki magnitorezistiv prinsip asosida) ham keng tarqalgan: ular optik enkoderlarga qaraganda ixchamroq, chang va namlikka chidamliroq, lekin odatda ruxsat qobiliyati pastroq. Tanlovda quyidagi tartibga amal qilish tavsiya etiladi:
+ oʻlchanadigan kattalik, diapazon va talab qilinadigan aniqlikni aniqlash;
+ dinamik talablarni (tezlik, oʻtkazish polosasi) aniqlash;
+ ish sharoitini (harorat, chang, namlik, vibratsiya, elektromagnit maydon) baholash;
+ oʻrnatish joyi, oʻlcham, massa va taʼminot cheklovlarini hisobga olish;
+ boshqaruv tizimi interfeysiga mos chiqish signalini tanlash;
+ narx va ishonchlilikni solishtirib, yakuniy qaror qabul qilish.

// =====================================================================
= Xulosa
// =====================================================================

Informatsion qurilmalar oʻlchash kanalidagi oʻrniga koʻra birlamchi oʻzgartirgichlar, oraliq oʻzgartirgichlar, analog-raqamli oʻzgartirgichlar, uzatish, qayta ishlash va aks ettirish qurilmalariga boʻlinadi. Ular orasida birlamchi oʻzgartirgich eng muhim boʻgʻin hisoblanadi, chunki u butun kanalning imkoniyatlarini belgilaydi.

Birlamchi oʻzgartirgichlar parametrik (rezistiv, sigʻim, induktiv) va generatorli (termoelektrik, piezoelektrik, induksion, fotoelektrik) turlarga boʻlinadi; har bir tur oʻzining fizik qonuniyati, afzalliklari va cheklovlariga ega. Ularning sifati statik, dinamik va ekspluatatsion xususiyatlar bilan baholanadi. Informatsion qurilmalar axborotni qabul qilish, normallashtirish, raqamga aylantirish, uzatish, qayta ishlash, saqlash va aks ettirish hamda nazorat va diagnostika vazifalarini bajaradi. Muayyan robot uchun oʻzgartirgich vazifa, sharoit, aniqlik va narx talablarini birgalikda hisobga olib tanlanadi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Informatsion qurilmalar oʻlchash kanalidagi oʻrniga koʻra qanday turlarga boʻlinadi?
  + Birlamchi oʻzgartirgich, datchik va sensor tushunchalari qanday farqlanadi?
  + Oʻzgartirish zanjiri nima? Kuch datchigi misolida tushuntiring.
  + Zanjirning umumiy sezgirligi qanday aniqlanadi?
  + Parametrik va generatorli birlamchi oʻzgartirgichlar qanday farqlanadi?
  + Tenzorezistor nima uchun oʻlchash koʻprigiga ulanadi?
  + $U = 10$ V, $k = 2$, $epsilon = 5 dot 10^(-4)$ boʻlganda chorak koʻprikning chiqish kuchlanishini toping.
  + Sigʻim oʻzgartirgichning sigʻimi qanday kattaliklarga bogʻliq? Robotlarda qayerda qoʻllanadi?
  + Nima uchun piezoelektrik oʻzgartirgich statik kuchni oʻlchashga yaroqsiz?
  + Xoll oʻzgartirgichi robotlarda qanday maqsadlarda qoʻllanadi?
  + Birinchi tartibli oʻzgartirgichning vaqt doimiysi nimani anglatadi?
  + Informatsion qurilmalarning asosiy vazifalarini sanab bering va har biriga robotdan misol keltiring.
  + Robot boʻgʻini uchun potensiometr, rezolver va optik enkoderni taqqoslang.
]
