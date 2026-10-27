// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №2. Informatsiya nazariyasidan umumiy maʼlumotlar.
//             Mexatron modullar va robotlarning asosiy turlari
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №2. Informatsiya nazariyasidan umumiy maʼlumotlar. Mexatron modullar va robotlarning asosiy turlari",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 2  // amaliyot raqami
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
#let lg = math.op("lg")

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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №2]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Informatsiya nazariyasidan umumiy maʼlumotlar. \ Mexatron modullar va robotlarning asosiy turlari]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Axborot, xabar va signal tuşunçalari. Axborot uzatiş tizimi.
  + Axborot miqdori va entropiya. Ölçaş natijasida olinadigan axborot.
  + Signal va şovqin. Kanalning ötkaziş qobiliyati.
  + Signallarni diskretlaş va kvantlaş.
  + Axborotni kodlaş.
  + Mexatron modullarning asosiy turlari.
  + Robotlarning asosiy turlari va ularning informatsion qurilmalari.

  *Tayanç iboralar:* axborot, xabar, signal, aloqa kanali, şovqin, bit, entropiya, axborot miqdori, signal/şovqin nisbati, ötkaziş qobiliyati, diskretlaş, kvantlaş, Kotelnikov teoremasi, Grey kodi, harakat moduli, intellektual mexatron modul, sanoat roboti, servis roboti, mobil robot, manipulyator, erkinlik darajasi.
]

// =====================================================================
= Axborot, xabar va signal tuşunçalari
// =====================================================================

Oldingi maʼruzada robotning informatsion qurilmalari uning içki holati va taşqi muhit haqidagi axborotni olişini kördik. Bu qurilmalarni töğri loyihalaş va baholaş uçun avvalo «axborot» tuşunçasining özini aniq taʼriflaş va uni miqdoriy ölçaşni örganiş kerak. Bu masalalar bilan *informatsiya nazariyasi* şuğullanadi. Uning asoslari R.~Xartli (1928) va K.~Şennon (1948) işlarida yaratilgan, sovet olimi V.~A.~Kotelnikov esa 1933-yilda uzluksiz signallarni diskret qiymatlar orqali tiklaş teoremasini isbotlagan.

*Axborot (informatsiya)* — obyekt yoki jarayon holati haqidagi, qabul qiluvçida mavjud bölgan noaniqlikni kamaytiradigan maʼlumot. Masalan, robot böğinining burçagi ölçanmagunça u faqat maʼlum oraliqda yotişi maʼlum; ölçaşdan söng bu oraliq ölçaş xatoligi çegarasigaça torayadi. Aynan şu noaniqlikning kamayişi olingan axborot miqdorini belgilaydi.

*Xabar* — axborotni ifodalaş şakli (raqamlar, matn, tasvir, ovoz). *Signal* — xabarni uzatuvçi va saqlovçi fizik jarayon: elektr kuçlanişi, tok, yoruğlik oqimi, tovuş tölqini va hokazo. Bitta xabar turli signallar bilan uzatilişi mumkin: masalan, harorat qiymati termojuftning kuçlanişi, 4–20 mA tok signali yoki CAN şinasidagi raqamli kadr körinişida böladi.

Signallar vaqt va qiymat böyiça quyidagiça farqlanadi:
- *uzluksiz (analog) signal* — vaqtning istalgan paytida aniqlangan va istalgan qiymatni qabul qila oladi (potensiometr, tenzodatçik çiqişi);
- *diskret signal* — faqat ayrim vaqt paytlarida aniqlangan (diskretlangan) signal;
- *raqamli signal* — vaqt böyiça diskretlangan va qiymat böyiça kvantlangan, yaʼni çekli sondagi qiymatlarni qabul qiladigan signal (inkremental enkoder impulslari, ARO çiqişi).

== Axborot uzatiş tizimi

Şennon taklif etgan umumlaşgan axborot uzatiş tizimi 1-rasmda keltirilgan. *Manba* xabarni hosil qiladi, *uzatgiç (koder)* uni aloqa kanalida uzatişga qulay signalga aylantiradi, *kanalda* signalga şovqin qöşiladi, *qabul qilgiç (dekoder)* esa buzilgan signaldan xabarni tiklaydi va uni *qabul qiluvçiga* yetkazadi.

#figure(
  diagram(
    spacing: (13mm, 10mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Axborot \ manbai], name: <m>),
    node((1, 0), [Uzatgiç \ (koder)], name: <k>),
    node((2, 0), [Aloqa \ kanali], name: <c>, fill: lightorange),
    node((3, 0), [Qabul qilgiç \ (dekoder)], name: <d>),
    node((4, 0), [Qabul \ qiluvçi], name: <q>),
    node((2, 1), [Şovqin \ manbai], name: <n>, fill: white),
    edge(<m>, <k>, "->", [xabar], label-sep: 6pt, label-side: left),
    edge(<k>, <c>, "->", [signal], label-sep: 6pt, label-side: left),
    edge(<c>, <d>, "->"),
    edge(<d>, <q>, "->", [xabar], label-sep: 6pt, label-side: left),
    edge(<n>, <c>, "->"),
  ),
  caption: [Axborot uzatiş tizimining umumlaşgan sxemasi (Şennon böyiça)],
) <fig-shennon>

Robotning informatsion tizimi ham aynan şu sxema asosida işlaydi. Manba — ölçanayotgan obyekt (böğin burçagi, tösiqqaça masofa), uzatgiç — datçik va uning ölçaş sxemasi, kanal — kabel, şina yoki simsiz aloqa, qabul qilgiç — analog-raqamli özgartkiç (ARO) va signalga işlov beriş algoritmlari, qabul qiluvçi — boşqaruv tizimi. Şovqin esa har bir bosqiçda — sezgir elementda, kuçaytirgiçda, kabelda va ARO da — paydo böladi. Şuning uçun *ölçaş* jarayonini ham axborot uzatiş jarayoni sifatida köriş mumkin: ölçaş vositasi obyektdan qabul qiluvçiga axborot yetkazuvçi kanaldir.

// =====================================================================
= Axborot miqdori va entropiya
// =====================================================================

== Xartli va Şennon ölçovlari

Agar tizim $N$ ta teng ehtimolli holatdan birida bölişi mumkin bölsa, uning qaysi holatda ekanini bilib olişda olinadigan axborot miqdori Xartli formulasi bilan aniqlanadi:

#eq($ I = log_2 N. $)

Axborot birligi — *bit*: ikkita teng ehtimolli holatdan birini tanlaş (masalan, tanga taşlaş natijasi) haqidagi axborot. Öyin soqqasi taşlanganda olinadigan axborot $I = log_2 6 approx 2","585$ bit. Sakkiz bit bir baytni taşkil qiladi.

Holatlar teng ehtimolli bölmasa, Şennon formulasidan foydalaniladi. Tizim $i$-holatda $p_i$ ehtimollik bilan bölsa, bitta xabardagi örtaça axborot miqdori, yaʼni *entropiya*:

#eq($ H = -sum_(i=1)^N p_i log_2 p_i. $)

Entropiya tizim holati haqidagi noaniqlik ölçovidir. U barça holatlar teng ehtimolli bölganda eng katta qiymatga ($H_max = log_2 N$) erişadi va bu holda (2) formula (1) ga aylanadi. Agar holatlardan biri aniq maʼlum bölsa ($p = 1$), $H = 0$: bunday xabar heç qanday yangi axborot bermaydi.

*Misol.* Robotning diagnostika datçigi ikki holatni körsatadi: «normal» ($p_1 = 0","9$) va «nosozlik» ($p_2 = 0","1$). Entropiya:
$ H = -0","9 log_2 0","9 - 0","1 log_2 0","1 approx 0","137 + 0","332 = 0","469 "bit". $
Bu teng ehtimolli holatdagi 1 bitdan ança kam: datçik köp hollarda kutilgan natijani beradi, şuning uçun uning har bir xabari örtaça kam axborot olib keladi. Şu bilan birga, kamdan-kam uçraydigan «nosozlik» xabarining özi katta axborot taşiydi ($-log_2 0","1 approx 3","32$ bit).

== Ölçaş natijasida olinadigan axborot

Olingan axborot miqdori xabar olişdan oldingi va keyingi entropiyalar farqiga teng:

#eq($ I = H_0 - H_1, $)

bu yerda $H_0$ — ölçaşgaça bölgan, $H_1$ — ölçaşdan keyin qolgan noaniqlik. Ölçanayotgan kattalik $D$ diapazonda istalgan qiymatni teng ehtimol bilan qabul qilsin, ölçaş xatoligi esa $plus.minus Delta$ çegarada bölsin. U holda ölçaş diapazonni $2 Delta$ kenglikdagi farqlanadigan oraliqlarga ajratadi va bitta ölçaşda olinadigan axborot miqdori:

#eq($ I = log_2 D / (2 Delta). $)

*Misol.* Siljiş datçigining diapazoni $D = 100$ mm, xatoligi $plus.minus 0","05$ mm. Farqlanadigan holatlar soni $100 slash 0","1 = 1000$, axborot miqdori $I = log_2 1000 approx 9","97$ bit. Demak, bu datçik signalini raqamga aylantiriş uçun kamida 10 razryadli ARO kerak; undan kam razryadli ARO datçik bergan axborotning bir qismini yöqotadi, ança köp razryadli ARO esa qöşimça axborot bermaydi.

(4) ifoda muhim amaliy xulosaga olib keladi: ölçaş vositasining axborot imkoniyati uning *nisbiy* aniqligi bilan belgilanadi. Xatolikni ikki marta kamaytiriş bitta ölçaşdagi axborotni atigi 1 bitga oşiradi.

// =====================================================================
= Signal va şovqin. Kanalning ötkaziş qobiliyati
// =====================================================================

Real kanalda foydali signalga har doim şovqin qöşiladi: rezistorlarning issiqlik şovqini, kuçaytirgiç şovqini, elektromagnit xalaqitlar, kvantlaş şovqini. Signal sifati *signal/şovqin nisbati* (SNR) bilan baholanadi va odatda detsibellarda ifodalanadi:

#eq($ "SNR" = 10 lg P_s / P_n = 20 lg U_s / U_n quad ["dB"], $)

bu yerda $P_s, P_n$ — signal va şovqin quvvatlari, $U_s, U_n$ — ularning örtaça kvadratik qiymatlari. Masalan, 60 dB signal kuçlanişi şovqinnikidan 1000 marta katta ekanini bildiradi.

Şennon — Xartli teoremasiga köra, ötkaziş polosasi $B$ va signal/şovqin nisbati $P_s slash P_n$ bölgan kanal orqali xatosiz uzatilişi mumkin bölgan axborotning eng katta tezligi, yaʼni kanalning *ötkaziş qobiliyati*:

#eq($ C = B log_2 (1 + P_s / P_n) quad ["bit/s"]. $)

*Misol.* Datçik kanalining polosasi $B = 1$ kHz, SNR = 60 dB ($P_s slash P_n = 10^6$). U holda $C = 1000 dot log_2 (1 + 10^6) approx 19","9$ kbit/s. Ötkaziş qobiliyatini polosani kengaytiriş yoki şovqinni kamaytiriş orqali oşiriş mumkin.

(6) formula datçik loyihalovçisi uçun ikki muhim xulosa beradi. Birinçidan, kuçli şovqin şaroitida signaldan olinadigan axborot çeklangan va uni heç qanday keyingi işlov bilan oşirib bölmaydi — şovqinni iloji boriça manbaning özida (sezgir element va birinçi kuçaytirgiçda) kamaytiriş kerak. Ikkinçidan, kerakli axborotni oliş uçun polosa va aniqlik örtasida murosaga erişiş mumkin: masalan, signalni filtrlaş yoki köp marta ölçab örtaçalaş şovqinni kamaytiradi, lekin ölçaş tezligini pasaytiradi.

// =====================================================================
= Signallarni diskretlaş va kvantlaş
// =====================================================================

Zamonaviy robotlarda axborot mikrokontroller yoki kompyuterda raqamli şaklda qayta işlanadi. Şuning uçun datçikning analog signali ARO yordamida raqamli signalga aylantiriladi. Bu ikki amalni öz içiga oladi: vaqt böyiça *diskretlaş* va qiymat böyiça *kvantlaş*.

== Diskretlaş. Kotelnikov teoremasi

Diskretlaşda signal qiymatlari faqat $T_d$ qadam bilan, yaʼni $f_d = 1 slash T_d$ çastotada olinadi. Kotelnikov (Naykvist — Şennon) teoremasiga köra, spektri $f_max$ çastotadan yuqori taşkil etuvçilarga ega bölmagan uzluksiz signal uning diskret qiymatlari orqali töliq tiklanişi mumkin, agar diskretlaş çastotasi quyidagi şartni qanoatlantirsa:

#eq($ f_d >= 2 f_max. $)

Bu şart bajarilmasa, yuqori çastotali taşkil etuvçilar past çastotali bölib «körinadi» — bu hodisa *çastota almaşinuvi* (aliasing) deb ataladi. Masalan, 900 Hz çastotali tebraniş 1000 Hz çastotada diskretlansa, raqamli signalda u 100 Hz çastotali soxta tebraniş sifatida namoyon böladi. Buning oldini oliş uçun ARO oldidan $f_d slash 2$ dan yuqori çastotalarni söndiruvçi past çastotali filtr (antialiasing filtri) örnatiladi. Amaliyotda diskretlaş çastotasi $f_max$ dan 5–10 marta katta tanlanadi.

== Kvantlaş

Kvantlaşda signalning uzluksiz qiymatlari çekli sondagi sathlarga yaxlitlanadi. $N$ razryadli ARO $2^N$ ta sathga ega, uning kvantlaş qadami (eng kiçik razryad qiymati):

#eq($ q = U_"max" / 2^N, $)

bu yerda $U_"max"$ — ARO kiriş diapazoni. Yaxlitlaş natijasida $plus.minus q slash 2$ çegarada tasodifiy xatolik paydo böladi. U teng taqsimlangan deb hisoblansa, *kvantlaş şovqinining* örtaça kvadratik qiymati:

#eq($ sigma_q = q / sqrt(12). $)

Ideal ARO uçun töliq diapazonli sinusoidal signalda kvantlaş şovqini bilan çeklangan signal/şovqin nisbati:

#eq($ "SNR" approx 6","02 N + 1","76 quad ["dB"]. $)

*Misol.* 12 razryadli ARO, kiriş diapazoni 10 V: $q = 10 slash 4096 approx 2","44$ mV, $sigma_q approx 0","70$ mV, SNR $approx 74$ dB. Har bir qöşimça razryad SNR ni taxminan 6 dB ga oşiradi. Biroq real ARO ning samarali razryadlar soni datçik va sxema şovqinlari tufayli nominaldan kam böladi, şuning uçun datçik şovqini kvantlaş qadamidan ança katta bölsa, ARO razryadini oşiriş foyda bermaydi — bu (4) bilan olingan xulosaga mos keladi.

// =====================================================================
= Axborotni kodlaş
// =====================================================================

*Kodlaş* — xabarni maʼlum qoidaga köra belgilar (kod sözlari) ketma-ketligiga aylantiriş. Raqamli datçiklar va boşqaruv tizimlarida asosan ikkilik (binar) kodlar qöllanadi: $n$ razryadli ikkilik kod $2^n$ ta turli qiymatni ifodalaydi.

Oddiy ikkilik kodning kamçiligi şundaki, qöşni qiymatlarga ötişda bir vaqtning özida bir neçta razryad özgarişi mumkin (masalan, $0111 -> 1000$ da törttala razryad). Absolyut enkoderda kodli diskning yölakçalari heç qaçon mutlaqo bir vaqtda almaşmaydi, şuning uçun ötiş paytida mutlaqo notöğri qiymat öqilişi mumkin. Bu muammo *Grey kodi* yordamida hal qilinadi: unda qöşni qiymatlar faqat bitta razryad bilan farqlanadi. Ikkilik koddan Grey kodiga ötiş quyidagiça amalga oşiriladi:

#eq($ g_i = b_i ⊕ b_(i+1), $)

bu yerda $b_i$ — ikkilik kodning $i$-razryadi, $g_i$ — Grey kodining $i$-razryadi, $⊕$ — «istisno qiluvçi YOKI» amali (eng katta razryad özgarmaydi). Uç razryadli kodlar 1-jadvalda taqqoslangan.

#figure(
  btable(
    columns: (auto, auto, auto),
    align: center,
    header: ([Önlik qiymat], [Ikkilik kod], [Grey kodi]),
    [0],
    [000],
    [000],
    [1],
    [001],
    [001],
    [2],
    [010],
    [011],
    [3],
    [011],
    [010],
    [4],
    [100],
    [110],
    [5],
    [101],
    [111],
    [6],
    [110],
    [101],
    [7],
    [111],
    [100],
  ),
  caption: [Uç razryadli ikkilik kod va Grey kodi],
) <tab-grey>

Aloqa kanalida yuzaga keladigan xatolarni aniqlaş uçun xabarga *ortiqça* (qöşimça) razryadlar qöşiladi. Eng oddiy usul — juftlik biti: kod sözidagi birlar soni doim juft yoki toq bölişi uçun bitta bit qöşiladi. Sanoat şinalarida (masalan, robot böğinlari kontrollerlarini boğlovçi CAN şinasida) sikl böyiça ortiqça kod (CRC) qöllanadi, u xatolarning juda katta qismini aniqlaş imkonini beradi. Şunday qilib, ortiqçalik — entropiya nuqtai nazaridan «keraksiz» axborot — uzatişning işonçliligini taʼminlaş uçun ataylab kiritiladi.

// =====================================================================
= Mexatron modullarning asosiy turlari
// =====================================================================

Avvalgi maʼruzada taʼriflanganidek, mexatron modul harakatlantiruvçi, informatsion va boşqaruv qismlarini yagona konstruksiyada birlaştiradi. Rus mexatronika maktabida (Yu.~V.~Podurayev) modullar integratsiya darajasiga köra uç turga ajratiladi (2-rasm):

- *harakat moduli* — dvigatel va mexanik uzatma (reduktor, vintli uzatma) konstruktiv jihatdan birlaştirilgan qurilma. Masalan, motor-reduktor;
- *mexatron harakat moduli* — harakat moduliga informatsion qurilmalar (enkoder, rezolver, tok va harorat datçiklari) qöşilgan qurilma. Masalan, örnatilgan enkoderli servodvigatel;
- *intellektual mexatron modul* — yuqoridagilarga boşqaruv kontrolleri, quvvat elektronikasi (drayver) va tarmoq interfeysi ham qöşilgan qurilma. U yuqori darajadagi tizimdan buyruq olib, harakatni mustaqil boşqaradi va öz holati haqida axborot uzatadi.

#figure(
  diagram(
    spacing: (6mm, 10mm),
    node-stroke: 1pt,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Dvigatel \ + uzatma], fill: white, name: <a>),
    node((1, 0), [*Harakat \ moduli*], fill: lightblue, name: <hm>),
    node((2, 0), [*Mexatron \ harakat moduli*], fill: lightblue, name: <mhm>),
    node((3, 0), [*Intellektual \ mexatron modul*], fill: lightorange, name: <imm>),
    node((2, 1), [Datçiklar: \ enkoder, rezolver, \ tok, harorat], fill: white, name: <iq>),
    node((3, 1), [Kontroller, \ drayver, \ interfeys], fill: white, name: <bt>),
    edge(<a>, <hm>, "->"),
    edge(<hm>, <mhm>, "->"),
    edge(<mhm>, <imm>, "->"),
    edge(<iq>, <mhm>, "->", [+], label-side: left),
    edge(<bt>, <imm>, "->", [+], label-side: left),
  ),
  caption: [Mexatron modullarning integratsiya darajasi böyiça turlari],
) <fig-modul>

Integratsiya darajasi oşgan sari modulning ölçamlari va kabellar soni kamayadi, işonçliligi va aniqligi ortadi, robotni yiğiş va sozlaş soddalaşadi. Zamonaviy kollaborativ robotlarning har bir böğini aynan intellektual mexatron modul bölib, uning içida dvigatel, tölqinli reduktor, ikkita enkoder (dvigatel va çiqiş valida), moment datçigi, tormoz va drayver joylaşgan.

Harakat turi böyiça mexatron modullar *aylanma* va *çiziqli* turlarga bölinadi. Ularning keng tarqalgan misollari 2-jadvalda keltirilgan.

#figure(
  btable(
    columns: (1fr, 1.4fr, 1.2fr),
    header: ([Modul], [Tarkibi va informatsion qurilmalari], [Qöllanilişi]),
    [Servodvigatel],
    [Sinxron dvigatel, enkoder yoki rezolver, harorat datçigi],
    [Dastgohlar va robotlar yuritmalari],
    [Motor-reduktor],
    [Dvigatel va reduktor; ixtiyoriy ravişda enkoder],
    [Konveyerlar, mobil robotlar],
    [Robot böğini moduli],
    [Dvigatel, tölqinli reduktor, ikki enkoder, moment datçigi, tormoz, drayver],
    [Kollaborativ va servis robotlari],
    [Çiziqli modul],
    [Dvigatel, şarikli vintli yoki tasmali uzatma, enkoder, çegara datçiklari],
    [Dekart robotlari, 3D printerlar, yiğiş tizimlari],
    [Çiziqli dvigatel],
    [Uzatmasiz çiziqli dvigatel, çiziqli optik yoki magnit şkala],
    [Yuqori tezlikli va aniq pozitsiyalaş],
    [Motor-ğildirak],
    [Ğildirak içidagi dvigatel, Xoll datçiklari, enkoder],
    [Mobil robotlar, elektr transport],
  ),
  caption: [Mexatron modullarning keng tarqalgan turlari],
) <tab-modullar>

// =====================================================================
= Robotlarning asosiy turlari
// =====================================================================

Robotlar juda xilma-xil bölgani uçun ularni bir neçta belgi böyiça tasniflaş qabul qilingan.

== Qöllaniş sohasi böyiça

ISO 8373 standarti robotlarni ikki asosiy guruhga ajratadi:
- *sanoat robotlari* — avtomatik boşqariladigan, qayta dasturlanadigan, köp maqsadli, uç yoki undan ortiq öq böyiça dasturlanadigan manipulyatorlar. Ular payvandlaş, böyaş, yiğiş, yuklaş-tuşiriş, qadoqlaş işlarida qöllanadi;
- *servis robotlari* — sanoat avtomatlaştirişidan taşqari sohalarda inson yoki uskunalar uçun foydali iş bajaradigan robotlar. Ular *professional* (tibbiyot, logistika, qişloq xöjaligi, inspeksiya robotlari) va *maişiy* (çangyutgiç robotlar, öyinçoq robotlar) turlarga bölinadi.

Bundan taşqari, alohida guruh sifatida ekstremal şaroitlarda işlaydigan *maxsus robotlar* (kosmik, suv osti, harbiy, avariya-qutqaruv, yadro energetikasi robotlari) ajratiladi.

== Boşqariş usuli böyiça

Oldingi maʼruzada körilgan robotlar avlodlariga mos ravişda *dasturiy*, *adaptiv* va *intellektual* robotlar farqlanadi. Inson iştiroki darajasiga köra esa robotlar:
- *masofadan boşqariladigan (teleoperatsion)* — harakatni operator real vaqtda boşqaradi (masalan, jarrohlik robotlari, suv osti apparatlari); robot operatorga kamera tasviri va kuç haqidagi axborotni qaytaradi;
- *yarim avtonom* — operator umumiy topşiriq beradi, oddiy harakatlarni robot mustaqil bajaradi;
- *avtonom* — topşiriqni inson aralaşuvisiz, öz datçiklari axboroti asosida bajaradi.

Avtonomlik darajasi qançalik yuqori bölsa, robotning informatsion tizimiga qöyiladigan talablar şunçalik ortadi.

== Harakatlaniş usuli böyiça

*Statsionar robotlar* asosi qözğalmas bölib, ular asosan manipulyatorlardir. *Mobil robotlar* esa işçi zonada harakatlanadi:
- *ğildirakli* — eng keng tarqalgan; avtomatik boşqariladigan aravaçalar (AGV), avtonom mobil robotlar (AMR), avtonom avtomobillar;
- *tirtilli* — notekis joylarda işlaş uçun (qutqaruv, harbiy robotlar);
- *yuruvçi* — ikki oyoqli (gumanoid) va tört oyoqli robotlar; murakkab relyefda yuqori ötuvçanlikka ega, lekin muvozanatni saqlaş uçun murakkab informatsion tizim talab qiladi;
- *uçuvçi* — uçuvçisiz uçiş apparatlari (dronlar);
- *suzuvçi* — suv usti va suv osti robotlari.

Mobil platformaga manipulyator örnatilgan robotlar *mobil manipulyatorlar* deb ataladi.

== Manipulyatorlarning kinematik tuzilişi

Manipulyatorning harakatçanligi *erkinlik darajalari soni* bilan tavsiflanadi. Fazodagi qattiq jismning holati va yönalişini töliq belgilaş uçun oltita erkinlik darajasi kerak (uçta siljiş va uçta buriliş). Fazoviy mexanizmning erkinlik darajalari soni Somov — Malişev formulasi bilan aniqlanadi:

#eq($ W = 6n - 5p_5 - 4p_4 - 3p_3 - 2p_2 - p_1, $)

bu yerda $n$ — harakatlanuvçi zvenolar soni, $p_k$ — $k$-sinf kinematik juftlar soni ($k$ — juftning harakatga qöyadigan çeklovlar soni). Robotlarda asosan beşinçi sinf juftlar — aylanma (R) va ilgarilanma (P) böğinlar qöllanadi. Masalan, oltita aylanma böğinli ketma-ket manipulyator uçun $n = 6$, $p_5 = 6$ va $W = 36 - 30 = 6$.

Ketma-ket manipulyatorlarning aksariyatida dastlabki uçta böğin işçi organning *pozitsiyasini*, oxirgi böğinlar (bilak) esa uning *yönalişini* belgilaydi. Şu sababli manipulyatorlar dastlabki uçta böğinning turi böyiça tasniflanadi (3-jadval).

#figure(
  btable(
    columns: (auto, auto, 0.75fr, 1.8fr),
    header: ([Turi], [Böğinlar], [Işçi zona], [Xususiyatlari va qöllanilişi]),
    [Dekart (portal)],
    [PPP],
    [Töğri burçakli \ parallelepiped],
    [Bikr, juda katta ölçamli bölişi mumkin, teskari kinematika masalasi oddiy; jihozlar robot «içida» joylaşadi. Portal tizimlari, yuklaş, 3D çop etiş],
    [Silindrik],
    [RPP],
    [Silindr],
    [Vertikal siljiş va radial çiqiş; yuklaş-tuşiriş işlari],
    [Sferik],
    [RRP],
    [Sfera qismi],
    [Burçakli manipulyatorga öxşaş, tirsak örnida teleskopik böğin],
    [SCARA],
    [RRP (+R)],
    [Silindr qismi],
    [Dastlabki böğinlar yuk oğirligini kötarmaydi, juda tez; tekislikdagi yiğiş işlari],
    [Burçakli \ (antropomorf)],
    [RRR],
    [Sfera qismi],
    [Işçi zonaga kam xalaqit beradi, tor joylarga kira oladi; eng universal sanoat roboti],
    [Parallel (delta)],
    [Yopiq zanjir],
    [Kiçik, gumbazsimon],
    [Yuqori bikrlik va juda katta tezlik; oziq-ovqat va farmatsevtikada saralaş],
  ),
  caption: [Manipulyatorlarning kinematik tuziliş böyiça turlari],
) <tab-kinematika>

Işçi zona şakli, erkinlik darajalari soni va böğinlar turi informatsion qurilmalarni tanlaşga bevosita taʼsir qiladi: aylanma böğinlarda burçak datçiklari (enkoder, rezolver), ilgarilanma böğinlarda çiziqli siljiş datçiklari (çiziqli şkala, magnitostriktsion datçik) qöllanadi. Bundan taşqari, aylanma böğinli manipulyatorda burçak xatoligi işçi organda zveno uzunligiga proporsional ravişda kattalaşadi, şuning uçun bunday robotlarga aniqroq burçak datçiklari kerak böladi.

== Robot turlari va ularning informatsion qurilmalari

Turli robotlar öz vazifasiga köra turli informatsion qurilmalar majmuasi bilan jihozlanadi (4-jadval). Jadvaldan körinadiki, barça robotlarda içki holat datçiklari (enkoderlar, inersial datçiklar) mavjud, taşqi muhit datçiklarining tarkibi esa robotning qançalik özgaruvçan muhitda işlaşiga boğliq.

#figure(
  btable(
    columns: (auto, 1fr, 1fr),
    header: ([Robot turi], [Içki holat datçiklari], [Taşqi muhit datçiklari]),
    [Sanoat manipulyatori],
    [Böğin enkoderlari, çegara datçiklari, dvigatel toki],
    [Kuç-moment datçigi, kamera, xavfsizlik tösiqlari va yoruğlik pardalari],
    [Kollaborativ robot],
    [Ikki tomonlama enkoderlar, böğin moment datçiklari],
    [Yaqinlik datçiklari, kamera, taktil qoplama],
    [AGV / AMR],
    [Ğildirak enkoderlari (odometriya), IMU],
    [Lazer skaneri (LiDAR), ultratovuş datçiklari, kamera],
    [Dron],
    [IMU (akselerometr, giroskop), magnitometr, barometr],
    [GNSS, kamera, masofa ölçagiç],
    [Avtonom avtomobil],
    [Ğildirak tezligi datçiklari, IMU, rul burçagi datçigi],
    [Kameralar, radarlar, LiDAR, ultratovuş datçiklari, GNSS],
    [Yuruvçi robot],
    [Böğin enkoderlari, IMU, oyoq kuç datçiklari],
    [Çuqurlik kameralari, LiDAR],
  ),
  caption: [Robot turlari va ularning odatiy informatsion qurilmalari],
) <tab-robot-datchik>

// =====================================================================
= Xulosa
// =====================================================================

Informatsiya nazariyasi robotning informatsion qurilmalarini miqdoriy baholaş uçun umumiy til beradi. Datçik — axborot kanali, uning aniqligi va şovqini esa bitta ölçaşda qança axborot oliş mumkinligini belgilaydi. Diskretlaş çastotasi Kotelnikov teoremasi asosida, ARO razryadi esa datçikning nisbiy aniqligi va şovqiniga mos tanlanişi kerak. Grey kodi va ortiqça kodlar axborotni işonçli öqiş va uzatişni taʼminlaydi.

Mexatron modullar integratsiya darajasi böyiça harakat moduli, mexatron harakat moduli va intellektual mexatron modulga ajratiladi; informatsion qurilmalarning modul içiga kiritilişi uning aniqligi va işonçliligini oşiradi. Robotlar qöllaniş sohasi, boşqariş usuli, harakatlaniş usuli va kinematik tuzilişi böyiça tasniflanadi. Har bir turdagi robot öziga xos informatsion qurilmalar majmuasini talab qiladi va robot qançalik avtonom bölsa, bu majmua şunçalik murakkab böladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Axborot, xabar va signal tuşunçalarini taʼriflang.
  + Şennon böyiça axborot uzatiş tizimi qanday elementlardan iborat? Uni robotning ölçaş kanaliga qanday qöllaş mumkin?
  + Xartli va Şennon formulalari örtasidagi farq nimada? Entropiya qaçon eng katta qiymatga erişadi?
  + Diapazoni 0…360°, xatoligi $plus.minus 0","1°$ bölgan burçak datçigi bitta ölçaşda qança axborot beradi? Uning uçun neça razryadli ARO kerak?
  + Signal/şovqin nisbati va kanalning ötkaziş qobiliyati qanday boğlangan?
  + Kotelnikov teoremasini tuşuntiring. Çastota almaşinuvi nima va uning oldi qanday olinadi?
  + ARO razryadi, kvantlaş qadami va kvantlaş şovqini örtasidagi boğliqlikni yozing.
  + Absolyut enkoderlarda nima uçun Grey kodi qöllanadi?
  + Harakat moduli, mexatron harakat moduli va intellektual mexatron modul qanday farqlanadi?
  + ISO 8373 böyiça sanoat va servis robotlariga taʼrif bering.
  + Manipulyatorlarning kinematik tuziliş böyiça turlarini sanab bering va ularning işçi zonalarini taqqoslang.
  + Avtonom mobil robot va sanoat manipulyatorining informatsion qurilmalari nima uçun farq qiladi?
]
