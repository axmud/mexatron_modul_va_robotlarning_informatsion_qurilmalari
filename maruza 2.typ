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
  )[INFORMATSIYA NAZARIYASIDAN UMUMIY MAʼLUMOTLAR. \ MEXATRON MODULLAR VA ROBOTLARNING ASOSIY TURLARI]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Axborot, xabar va signal tushunchalari. Axborot uzatish tizimi.
  + Axborot miqdori va entropiya. Oʻlchash natijasida olinadigan axborot.
  + Signal va shovqin. Kanalning oʻtkazish qobiliyati.
  + Signallarni diskretlash va kvantlash.
  + Axborotni kodlash.
  + Mexatron modullarning asosiy turlari.
  + Robotlarning asosiy turlari va ularning informatsion qurilmalari.

  *Tayanch iboralar:* axborot, xabar, signal, aloqa kanali, shovqin, bit, entropiya, axborot miqdori, signal/shovqin nisbati, oʻtkazish qobiliyati, diskretlash, kvantlash, Kotelnikov teoremasi, Grey kodi, harakat moduli, intellektual mexatron modul, sanoat roboti, servis roboti, mobil robot, manipulyator, erkinlik darajasi.
]

// =====================================================================
= Axborot, xabar va signal tushunchalari
// =====================================================================

Oldingi maʼruzada robotning informatsion qurilmalari uning ichki holati va tashqi muhit haqidagi axborotni olishini koʻrdik. Bu qurilmalarni toʻgʻri loyihalash va baholash uchun avvalo «axborot» tushunchasining oʻzini aniq taʼriflash va uni miqdoriy oʻlchashni oʻrganish kerak. Bu masalalar bilan *informatsiya nazariyasi* shugʻullanadi. Uning asoslari R.~Xartli (1928) va K.~Shennon (1948) ishlarida yaratilgan, sovet olimi V.~A.~Kotelnikov esa 1933-yilda uzluksiz signallarni diskret qiymatlar orqali tiklash teoremasini isbotlagan.

*Axborot (informatsiya)* — obyekt yoki jarayon holati haqidagi, qabul qiluvchida mavjud boʻlgan noaniqlikni kamaytiradigan maʼlumot. Masalan, robot boʻgʻinining burchagi oʻlchanmaguncha u faqat maʼlum oraliqda yotishi maʼlum; oʻlchashdan soʻng bu oraliq oʻlchash xatoligi chegarasigacha torayadi. Aynan shu noaniqlikning kamayishi olingan axborot miqdorini belgilaydi.

*Xabar* — axborotni ifodalash shakli (raqamlar, matn, tasvir, ovoz). *Signal* — xabarni uzatuvchi va saqlovchi fizik jarayon: elektr kuchlanishi, tok, yorugʻlik oqimi, tovush toʻlqini va hokazo. Bitta xabar turli signallar bilan uzatilishi mumkin: masalan, harorat qiymati termojuftning kuchlanishi, 4–20 mA tok signali yoki CAN shinasidagi raqamli kadr koʻrinishida boʻladi.

Signallar vaqt va qiymat boʻyicha quyidagicha farqlanadi:
- *uzluksiz (analog) signal* — vaqtning istalgan paytida aniqlangan va istalgan qiymatni qabul qila oladi (potensiometr, tenzodatchik chiqishi);
- *diskret signal* — faqat ayrim vaqt paytlarida aniqlangan (diskretlangan) signal;
- *raqamli signal* — vaqt boʻyicha diskretlangan va qiymat boʻyicha kvantlangan, yaʼni chekli sondagi qiymatlarni qabul qiladigan signal (inkremental enkoder impulslari, ARO chiqishi).

== Axborot uzatish tizimi

Shennon taklif etgan umumlashgan axborot uzatish tizimi 1-rasmda keltirilgan. *Manba* xabarni hosil qiladi, *uzatgich (koder)* uni aloqa kanalida uzatishga qulay signalga aylantiradi, *kanalda* signalga shovqin qoʻshiladi, *qabul qilgich (dekoder)* esa buzilgan signaldan xabarni tiklaydi va uni *qabul qiluvchiga* yetkazadi.

#figure(
  diagram(
    spacing: (13mm, 10mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Axborot \ manbai], name: <m>),
    node((1, 0), [Uzatgich \ (koder)], name: <k>),
    node((2, 0), [Aloqa \ kanali], name: <c>, fill: lightorange),
    node((3, 0), [Qabul qilgich \ (dekoder)], name: <d>),
    node((4, 0), [Qabul \ qiluvchi], name: <q>),
    node((2, 1), [Shovqin \ manbai], name: <n>, fill: white),
    edge(<m>, <k>, "->", [xabar], label-sep: 6pt, label-side: left),
    edge(<k>, <c>, "->", [signal], label-sep: 6pt, label-side: left),
    edge(<c>, <d>, "->"),
    edge(<d>, <q>, "->", [xabar], label-sep: 6pt, label-side: left),
    edge(<n>, <c>, "->"),
  ),
  caption: [Axborot uzatish tizimining umumlashgan sxemasi (Shennon boʻyicha)],
) <fig-shennon>

Robotning informatsion tizimi ham aynan shu sxema asosida ishlaydi. Manba — oʻlchanayotgan obyekt (boʻgʻin burchagi, toʻsiqqacha masofa), uzatgich — datchik va uning oʻlchash sxemasi, kanal — kabel, shina yoki simsiz aloqa, qabul qilgich — analog-raqamli oʻzgartkich (ARO) va signalga ishlov berish algoritmlari, qabul qiluvchi — boshqaruv tizimi. Shovqin esa har bir bosqichda — sezgir elementda, kuchaytirgichda, kabelda va ARO da — paydo boʻladi. Shuning uchun *oʻlchash* jarayonini ham axborot uzatish jarayoni sifatida koʻrish mumkin: oʻlchash vositasi obyektdan qabul qiluvchiga axborot yetkazuvchi kanaldir.

// =====================================================================
= Axborot miqdori va entropiya
// =====================================================================

== Xartli va Shennon oʻlchovlari

Agar tizim $N$ ta teng ehtimolli holatdan birida boʻlishi mumkin boʻlsa, uning qaysi holatda ekanini bilib olishda olinadigan axborot miqdori Xartli formulasi bilan aniqlanadi:

#eq($ I = log_2 N. $)

Axborot birligi — *bit*: ikkita teng ehtimolli holatdan birini tanlash (masalan, tanga tashlash natijasi) haqidagi axborot. Oʻyin soqqasi tashlanganda olinadigan axborot $I = log_2 6 approx 2","585$ bit. Sakkiz bit bir baytni tashkil qiladi.

Holatlar teng ehtimolli boʻlmasa, Shennon formulasidan foydalaniladi. Tizim $i$-holatda $p_i$ ehtimollik bilan boʻlsa, bitta xabardagi oʻrtacha axborot miqdori, yaʼni *entropiya*:

#eq($ H = -sum_(i=1)^N p_i log_2 p_i. $)

Entropiya tizim holati haqidagi noaniqlik oʻlchovidir. U barcha holatlar teng ehtimolli boʻlganda eng katta qiymatga ($H_max = log_2 N$) erishadi va bu holda (2) formula (1) ga aylanadi. Agar holatlardan biri aniq maʼlum boʻlsa ($p = 1$), $H = 0$: bunday xabar hech qanday yangi axborot bermaydi.

*Misol.* Robotning diagnostika datchigi ikki holatni koʻrsatadi: «normal» ($p_1 = 0","9$) va «nosozlik» ($p_2 = 0","1$). Entropiya:
$ H = -0","9 log_2 0","9 - 0","1 log_2 0","1 approx 0","137 + 0","332 = 0","469 "bit". $
Bu teng ehtimolli holatdagi 1 bitdan ancha kam: datchik koʻp hollarda kutilgan natijani beradi, shuning uchun uning har bir xabari oʻrtacha kam axborot olib keladi. Shu bilan birga, kamdan-kam uchraydigan «nosozlik» xabarining oʻzi katta axborot tashiydi ($-log_2 0","1 approx 3","32$ bit).

== Oʻlchash natijasida olinadigan axborot

Olingan axborot miqdori xabar olishdan oldingi va keyingi entropiyalar farqiga teng:

#eq($ I = H_0 - H_1, $)

bu yerda $H_0$ — oʻlchashgacha boʻlgan, $H_1$ — oʻlchashdan keyin qolgan noaniqlik. Oʻlchanayotgan kattalik $D$ diapazonda istalgan qiymatni teng ehtimol bilan qabul qilsin, oʻlchash xatoligi esa $plus.minus Delta$ chegarada boʻlsin. U holda oʻlchash diapazonni $2 Delta$ kenglikdagi farqlanadigan oraliqlarga ajratadi va bitta oʻlchashda olinadigan axborot miqdori:

#eq($ I = log_2 D / (2 Delta). $)

*Misol.* Siljish datchigining diapazoni $D = 100$ mm, xatoligi $plus.minus 0","05$ mm. Farqlanadigan holatlar soni $100 slash 0","1 = 1000$, axborot miqdori $I = log_2 1000 approx 9","97$ bit. Demak, bu datchik signalini raqamga aylantirish uchun kamida 10 razryadli ARO kerak; undan kam razryadli ARO datchik bergan axborotning bir qismini yoʻqotadi, ancha koʻp razryadli ARO esa qoʻshimcha axborot bermaydi.

(4) ifoda muhim amaliy xulosaga olib keladi: oʻlchash vositasining axborot imkoniyati uning *nisbiy* aniqligi bilan belgilanadi. Xatolikni ikki marta kamaytirish bitta oʻlchashdagi axborotni atigi 1 bitga oshiradi.

// =====================================================================
= Signal va shovqin. Kanalning oʻtkazish qobiliyati
// =====================================================================

Real kanalda foydali signalga har doim shovqin qoʻshiladi: rezistorlarning issiqlik shovqini, kuchaytirgich shovqini, elektromagnit xalaqitlar, kvantlash shovqini. Signal sifati *signal/shovqin nisbati* (SNR) bilan baholanadi va odatda detsibellarda ifodalanadi:

#eq($ "SNR" = 10 lg P_s / P_n = 20 lg U_s / U_n quad ["dB"], $)

bu yerda $P_s, P_n$ — signal va shovqin quvvatlari, $U_s, U_n$ — ularning oʻrtacha kvadratik qiymatlari. Masalan, 60 dB signal kuchlanishi shovqinnikidan 1000 marta katta ekanini bildiradi.

Shennon — Xartli teoremasiga koʻra, oʻtkazish polosasi $B$ va signal/shovqin nisbati $P_s slash P_n$ boʻlgan kanal orqali xatosiz uzatilishi mumkin boʻlgan axborotning eng katta tezligi, yaʼni kanalning *oʻtkazish qobiliyati*:

#eq($ C = B log_2 (1 + P_s / P_n) quad ["bit/s"]. $)

*Misol.* Datchik kanalining polosasi $B = 1$ kHz, SNR = 60 dB ($P_s slash P_n = 10^6$). U holda $C = 1000 dot log_2 (1 + 10^6) approx 19","9$ kbit/s. Oʻtkazish qobiliyatini polosani kengaytirish yoki shovqinni kamaytirish orqali oshirish mumkin.

(6) formula datchik loyihalovchisi uchun ikki muhim xulosa beradi. Birinchidan, kuchli shovqin sharoitida signaldan olinadigan axborot cheklangan va uni hech qanday keyingi ishlov bilan oshirib boʻlmaydi — shovqinni iloji boricha manbaning oʻzida (sezgir element va birinchi kuchaytirgichda) kamaytirish kerak. Ikkinchidan, kerakli axborotni olish uchun polosa va aniqlik oʻrtasida murosaga erishish mumkin: masalan, signalni filtrlash yoki koʻp marta oʻlchab oʻrtachalash shovqinni kamaytiradi, lekin oʻlchash tezligini pasaytiradi.

// =====================================================================
= Signallarni diskretlash va kvantlash
// =====================================================================

Zamonaviy robotlarda axborot mikrokontroller yoki kompyuterda raqamli shaklda qayta ishlanadi. Shuning uchun datchikning analog signali ARO yordamida raqamli signalga aylantiriladi. Bu ikki amalni oʻz ichiga oladi: vaqt boʻyicha *diskretlash* va qiymat boʻyicha *kvantlash*.

== Diskretlash. Kotelnikov teoremasi

Diskretlashda signal qiymatlari faqat $T_d$ qadam bilan, yaʼni $f_d = 1 slash T_d$ chastotada olinadi. Kotelnikov (Naykvist — Shennon) teoremasiga koʻra, spektri $f_max$ chastotadan yuqori tashkil etuvchilarga ega boʻlmagan uzluksiz signal uning diskret qiymatlari orqali toʻliq tiklanishi mumkin, agar diskretlash chastotasi quyidagi shartni qanoatlantirsa [1]:

#eq($ f_d >= 2 f_max. $)

Bu shart bajarilmasa, yuqori chastotali tashkil etuvchilar past chastotali boʻlib «koʻrinadi» — bu hodisa *chastota almashinuvi* (aliasing) deb ataladi. Masalan, 900 Hz chastotali tebranish 1000 Hz chastotada diskretlansa, raqamli signalda u 100 Hz chastotali soxta tebranish sifatida namoyon boʻladi. Buning oldini olish uchun ARO oldidan $f_d slash 2$ dan yuqori chastotalarni soʻndiruvchi past chastotali filtr (antialiasing filtri) oʻrnatiladi. Amaliyotda diskretlash chastotasi $f_max$ dan 5–10 marta katta tanlanadi.

== Kvantlash

Kvantlashda signalning uzluksiz qiymatlari chekli sondagi sathlarga yaxlitlanadi. $N$ razryadli ARO $2^N$ ta sathga ega, uning kvantlash qadami (eng kichik razryad qiymati):

#eq($ q = U_"max" / 2^N, $)

bu yerda $U_"max"$ — ARO kirish diapazoni. Yaxlitlash natijasida $plus.minus q slash 2$ chegarada tasodifiy xatolik paydo boʻladi. U teng taqsimlangan deb hisoblansa, *kvantlash shovqinining* oʻrtacha kvadratik qiymati:

#eq($ sigma_q = q / sqrt(12). $)

Ideal ARO uchun toʻliq diapazonli sinusoidal signalda kvantlash shovqini bilan cheklangan signal/shovqin nisbati:

#eq($ "SNR" approx 6","02 N + 1","76 quad ["dB"]. $)

*Misol.* 12 razryadli ARO, kirish diapazoni 10 V: $q = 10 slash 4096 approx 2","44$ mV, $sigma_q approx 0","70$ mV, SNR $approx 74$ dB. Har bir qoʻshimcha razryad SNR ni taxminan 6 dB ga oshiradi. Biroq real ARO ning samarali razryadlar soni datchik va sxema shovqinlari tufayli nominaldan kam boʻladi, shuning uchun datchik shovqini kvantlash qadamidan ancha katta boʻlsa, ARO razryadini oshirish foyda bermaydi — bu (4) bilan olingan xulosaga mos keladi.

// =====================================================================
= Axborotni kodlash
// =====================================================================

*Kodlash* — xabarni maʼlum qoidaga koʻra belgilar (kod soʻzlari) ketma-ketligiga aylantirish. Raqamli datchiklar va boshqaruv tizimlarida asosan ikkilik (binar) kodlar qoʻllanadi: $n$ razryadli ikkilik kod $2^n$ ta turli qiymatni ifodalaydi.

Oddiy ikkilik kodning kamchiligi shundaki, qoʻshni qiymatlarga oʻtishda bir vaqtning oʻzida bir nechta razryad oʻzgarishi mumkin (masalan, $0111 -> 1000$ da toʻrttala razryad). Absolyut enkoderda kodli diskning yoʻlakchalari hech qachon mutlaqo bir vaqtda almashmaydi, shuning uchun oʻtish paytida mutlaqo notoʻgʻri qiymat oʻqilishi mumkin. Bu muammo *Grey kodi* yordamida hal qilinadi: unda qoʻshni qiymatlar faqat bitta razryad bilan farqlanadi [1]. Ikkilik koddan Grey kodiga oʻtish quyidagicha amalga oshiriladi:

#eq($ g_i = b_i ⊕ b_(i+1), $)

bu yerda $b_i$ — ikkilik kodning $i$-razryadi, $g_i$ — Grey kodining $i$-razryadi, $⊕$ — «istisno qiluvchi YOKI» amali (eng katta razryad oʻzgarmaydi). Uch razryadli kodlar 1-jadvalda taqqoslangan.

#figure(
  btable(
    columns: (auto, auto, auto),
    align: center,
    header: ([Oʻnlik qiymat], [Ikkilik kod], [Grey kodi]),
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
  caption: [Uch razryadli ikkilik kod va Grey kodi],
) <tab-grey>

Aloqa kanalida yuzaga keladigan xatolarni aniqlash uchun xabarga *ortiqcha* (qoʻshimcha) razryadlar qoʻshiladi. Eng oddiy usul — juftlik biti: kod soʻzidagi birlar soni doim juft yoki toq boʻlishi uchun bitta bit qoʻshiladi. Sanoat shinalarida (masalan, robot boʻgʻinlari kontrollerlarini bogʻlovchi CAN shinasida) sikl boʻyicha ortiqcha kod (CRC) qoʻllanadi, u xatolarning juda katta qismini aniqlash imkonini beradi. Shunday qilib, ortiqchalik — entropiya nuqtai nazaridan «keraksiz» axborot — uzatishning ishonchliligini taʼminlash uchun ataylab kiritiladi.

// =====================================================================
= Mexatron modullarning asosiy turlari
// =====================================================================

Avvalgi maʼruzada taʼriflanganidek, mexatron modul harakatlantiruvchi, informatsion va boshqaruv qismlarini yagona konstruksiyada birlashtiradi. Rus mexatronika maktabida (Yu.~V.~Podurayev) modullar integratsiya darajasiga koʻra uch turga ajratiladi [8] (2-rasm):

- *harakat moduli* — dvigatel va mexanik uzatma (reduktor, vintli uzatma) konstruktiv jihatdan birlashtirilgan qurilma. Masalan, motor-reduktor;
- *mexatron harakat moduli* — harakat moduliga informatsion qurilmalar (enkoder, rezolver, tok va harorat datchiklari) qoʻshilgan qurilma. Masalan, oʻrnatilgan enkoderli servodvigatel;
- *intellektual mexatron modul* — yuqoridagilarga boshqaruv kontrolleri, quvvat elektronikasi (drayver) va tarmoq interfeysi ham qoʻshilgan qurilma. U yuqori darajadagi tizimdan buyruq olib, harakatni mustaqil boshqaradi va oʻz holati haqida axborot uzatadi.

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
    node((2, 1), [Datchiklar: \ enkoder, rezolver, \ tok, harorat], fill: white, name: <iq>),
    node((3, 1), [Kontroller, \ drayver, \ interfeys], fill: white, name: <bt>),
    edge(<a>, <hm>, "->"),
    edge(<hm>, <mhm>, "->"),
    edge(<mhm>, <imm>, "->"),
    edge(<iq>, <mhm>, "->", [+], label-side: left),
    edge(<bt>, <imm>, "->", [+], label-side: left),
  ),
  caption: [Mexatron modullarning integratsiya darajasi boʻyicha turlari],
) <fig-modul>

Integratsiya darajasi oshgan sari modulning oʻlchamlari va kabellar soni kamayadi, ishonchliligi va aniqligi ortadi, robotni yigʻish va sozlash soddalashadi. Zamonaviy kollaborativ robotlarning har bir boʻgʻini aynan intellektual mexatron modul boʻlib, uning ichida dvigatel, toʻlqinli reduktor, ikkita enkoder (dvigatel va chiqish valida), moment datchigi, tormoz va drayver joylashgan.

Harakat turi boʻyicha mexatron modullar *aylanma* va *chiziqli* turlarga boʻlinadi. Ularning keng tarqalgan misollari 2-jadvalda keltirilgan.

#figure(
  btable(
    columns: (1fr, 1.4fr, 1.2fr),
    header: ([Modul], [Tarkibi va informatsion qurilmalari], [Qoʻllanilishi]),
    [Servodvigatel],
    [Sinxron dvigatel, enkoder yoki rezolver, harorat datchigi],
    [Dastgohlar va robotlar yuritmalari],
    [Motor-reduktor],
    [Dvigatel va reduktor; ixtiyoriy ravishda enkoder],
    [Konveyerlar, mobil robotlar],
    [Robot boʻgʻini moduli],
    [Dvigatel, toʻlqinli reduktor, ikki enkoder, moment datchigi, tormoz, drayver],
    [Kollaborativ va servis robotlari],
    [Chiziqli modul],
    [Dvigatel, sharikli vintli yoki tasmali uzatma, enkoder, chegara datchiklari],
    [Dekart robotlari, 3D printerlar, yigʻish tizimlari],
    [Chiziqli dvigatel],
    [Uzatmasiz chiziqli dvigatel, chiziqli optik yoki magnit shkala],
    [Yuqori tezlikli va aniq pozitsiyalash],
    [Motor-gʻildirak],
    [Gʻildirak ichidagi dvigatel, Xoll datchiklari, enkoder],
    [Mobil robotlar, elektr transport],
  ),
  caption: [Mexatron modullarning keng tarqalgan turlari],
) <tab-modullar>

// =====================================================================
= Robotlarning asosiy turlari
// =====================================================================

Robotlar juda xilma-xil boʻlgani uchun ularni bir nechta belgi boʻyicha tasniflash qabul qilingan.

== Qoʻllanish sohasi boʻyicha

ISO 8373 standarti robotlarni ikki asosiy guruhga ajratadi:
- *sanoat robotlari* — avtomatik boshqariladigan, qayta dasturlanadigan, koʻp maqsadli, uch yoki undan ortiq oʻq boʻyicha dasturlanadigan manipulyatorlar. Ular payvandlash, boʻyash, yigʻish, yuklash-tushirish, qadoqlash ishlarida qoʻllanadi;
- *servis robotlari* — sanoat avtomatlashtirishidan tashqari sohalarda inson yoki uskunalar uchun foydali ish bajaradigan robotlar. Ular *professional* (tibbiyot, logistika, qishloq xoʻjaligi, inspeksiya robotlari) va *maishiy* (changyutgich robotlar, oʻyinchoq robotlar) turlarga boʻlinadi.

Bundan tashqari, alohida guruh sifatida ekstremal sharoitlarda ishlaydigan *maxsus robotlar* (kosmik, suv osti, harbiy, avariya-qutqaruv, yadro energetikasi robotlari) ajratiladi.

== Boshqarish usuli boʻyicha

Oldingi maʼruzada koʻrilgan robotlar avlodlariga mos ravishda *dasturiy*, *adaptiv* va *intellektual* robotlar farqlanadi. Inson ishtiroki darajasiga koʻra esa robotlar:
- *masofadan boshqariladigan (teleoperatsion)* — harakatni operator real vaqtda boshqaradi (masalan, jarrohlik robotlari, suv osti apparatlari); robot operatorga kamera tasviri va kuch haqidagi axborotni qaytaradi;
- *yarim avtonom* — operator umumiy topshiriq beradi, oddiy harakatlarni robot mustaqil bajaradi;
- *avtonom* — topshiriqni inson aralashuvisiz, oʻz datchiklari axboroti asosida bajaradi.

Avtonomlik darajasi qanchalik yuqori boʻlsa, robotning informatsion tizimiga qoʻyiladigan talablar shunchalik ortadi.

== Harakatlanish usuli boʻyicha

*Statsionar robotlar* asosi qoʻzgʻalmas boʻlib, ular asosan manipulyatorlardir. *Mobil robotlar* esa ishchi zonada harakatlanadi:
- *gʻildirakli* — eng keng tarqalgan; avtomatik boshqariladigan aravachalar (AGV), avtonom mobil robotlar (AMR), avtonom avtomobillar;
- *tirtilli* — notekis joylarda ishlash uchun (qutqaruv, harbiy robotlar);
- *yuruvchi* — ikki oyoqli (gumanoid) va toʻrt oyoqli robotlar; murakkab relyefda yuqori oʻtuvchanlikka ega, lekin muvozanatni saqlash uchun murakkab informatsion tizim talab qiladi;
- *uchuvchi* — uchuvchisiz uchish apparatlari (dronlar);
- *suzuvchi* — suv usti va suv osti robotlari.

Mobil platformaga manipulyator oʻrnatilgan robotlar *mobil manipulyatorlar* deb ataladi.

== Manipulyatorlarning kinematik tuzilishi

Manipulyatorning harakatchanligi *erkinlik darajalari soni* bilan tavsiflanadi. Fazodagi qattiq jismning holati va yoʻnalishini toʻliq belgilash uchun oltita erkinlik darajasi kerak (uchta siljish va uchta burilish). Fazoviy mexanizmning erkinlik darajalari soni Somov — Malishev formulasi bilan aniqlanadi:

#eq($ W = 6n - 5p_5 - 4p_4 - 3p_3 - 2p_2 - p_1, $)

bu yerda $n$ — harakatlanuvchi zvenolar soni, $p_k$ — $k$-sinf kinematik juftlar soni ($k$ — juftning harakatga qoʻyadigan cheklovlar soni). Robotlarda asosan beshinchi sinf juftlar — aylanma (R) va ilgarilanma (P) boʻgʻinlar qoʻllanadi. Masalan, oltita aylanma boʻgʻinli ketma-ket manipulyator uchun $n = 6$, $p_5 = 6$ va $W = 36 - 30 = 6$.

Ketma-ket manipulyatorlarning aksariyatida dastlabki uchta boʻgʻin ishchi organning *pozitsiyasini*, oxirgi boʻgʻinlar (bilak) esa uning *yoʻnalishini* belgilaydi. Shu sababli manipulyatorlar dastlabki uchta boʻgʻinning turi boʻyicha tasniflanadi [4] (3-jadval).

#figure(
  btable(
    columns: (auto, auto, 0.75fr, 1.8fr),
    header: ([Turi], [Boʻgʻinlar], [Ishchi zona], [Xususiyatlari va qoʻllanilishi]),
    [Dekart (portal)],
    [PPP],
    [Toʻgʻri burchakli \ parallelepiped],
    [Bikr, juda katta oʻlchamli boʻlishi mumkin, teskari kinematika masalasi oddiy; jihozlar robot «ichida» joylashadi. Portal tizimlari, yuklash, 3D chop etish],
    [Silindrik],
    [RPP],
    [Silindr],
    [Vertikal siljish va radial chiqish; yuklash-tushirish ishlari],
    [Sferik],
    [RRP],
    [Sfera qismi],
    [Burchakli manipulyatorga oʻxshash, tirsak oʻrnida teleskopik boʻgʻin],
    [SCARA],
    [RRP (+R)],
    [Silindr qismi],
    [Dastlabki boʻgʻinlar yuk ogʻirligini koʻtarmaydi, juda tez; tekislikdagi yigʻish ishlari],
    [Burchakli \ (antropomorf)],
    [RRR],
    [Sfera qismi],
    [Ishchi zonaga kam xalaqit beradi, tor joylarga kira oladi; eng universal sanoat roboti],
    [Parallel (delta)],
    [Yopiq zanjir],
    [Kichik, gumbazsimon],
    [Yuqori bikrlik va juda katta tezlik; oziq-ovqat va farmatsevtikada saralash],
  ),
  caption: [Manipulyatorlarning kinematik tuzilish boʻyicha turlari],
) <tab-kinematika>

Ishchi zona shakli, erkinlik darajalari soni va boʻgʻinlar turi informatsion qurilmalarni tanlashga bevosita taʼsir qiladi: aylanma boʻgʻinlarda burchak datchiklari (enkoder, rezolver), ilgarilanma boʻgʻinlarda chiziqli siljish datchiklari (chiziqli shkala, magnitostriktsion datchik) qoʻllanadi. Bundan tashqari, aylanma boʻgʻinli manipulyatorda burchak xatoligi ishchi organda zveno uzunligiga proporsional ravishda kattalashadi, shuning uchun bunday robotlarga aniqroq burchak datchiklari kerak boʻladi.

== Robot turlari va ularning informatsion qurilmalari

Turli robotlar oʻz vazifasiga koʻra turli informatsion qurilmalar majmuasi bilan jihozlanadi (4-jadval). Jadvaldan koʻrinadiki, barcha robotlarda ichki holat datchiklari (enkoderlar, inersial datchiklar) mavjud, tashqi muhit datchiklarining tarkibi esa robotning qanchalik oʻzgaruvchan muhitda ishlashiga bogʻliq.

#figure(
  btable(
    columns: (auto, 1fr, 1fr),
    header: ([Robot turi], [Ichki holat datchiklari], [Tashqi muhit datchiklari]),
    [Sanoat manipulyatori],
    [Boʻgʻin enkoderlari, chegara datchiklari, dvigatel toki],
    [Kuch-moment datchigi, kamera, xavfsizlik toʻsiqlari va yorugʻlik pardalari],
    [Kollaborativ robot],
    [Ikki tomonlama enkoderlar, boʻgʻin moment datchiklari],
    [Yaqinlik datchiklari, kamera, taktil qoplama],
    [AGV / AMR],
    [Gʻildirak enkoderlari (odometriya), IMU],
    [Lazer skaneri (LiDAR), ultratovush datchiklari, kamera],
    [Dron],
    [IMU (akselerometr, giroskop), magnitometr, barometr],
    [GNSS, kamera, masofa oʻlchagich],
    [Avtonom avtomobil],
    [Gʻildirak tezligi datchiklari, IMU, rul burchagi datchigi],
    [Kameralar, radarlar, LiDAR, ultratovush datchiklari, GNSS],
    [Yuruvchi robot],
    [Boʻgʻin enkoderlari, IMU, oyoq kuch datchiklari],
    [Chuqurlik kameralari, LiDAR],
  ),
  caption: [Robot turlari va ularning odatiy informatsion qurilmalari],
) <tab-robot-datchik>

// =====================================================================
= Xulosa
// =====================================================================

Informatsiya nazariyasi robotning informatsion qurilmalarini miqdoriy baholash uchun umumiy til beradi. Datchik — axborot kanali, uning aniqligi va shovqini esa bitta oʻlchashda qancha axborot olish mumkinligini belgilaydi. Diskretlash chastotasi Kotelnikov teoremasi asosida, ARO razryadi esa datchikning nisbiy aniqligi va shovqiniga mos tanlanishi kerak. Grey kodi va ortiqcha kodlar axborotni ishonchli oʻqish va uzatishni taʼminlaydi.

Mexatron modullar integratsiya darajasi boʻyicha harakat moduli, mexatron harakat moduli va intellektual mexatron modulga ajratiladi; informatsion qurilmalarning modul ichiga kiritilishi uning aniqligi va ishonchliligini oshiradi. Robotlar qoʻllanish sohasi, boshqarish usuli, harakatlanish usuli va kinematik tuzilishi boʻyicha tasniflanadi. Har bir turdagi robot oʻziga xos informatsion qurilmalar majmuasini talab qiladi va robot qanchalik avtonom boʻlsa, bu majmua shunchalik murakkab boʻladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Axborot, xabar va signal tushunchalarini taʼriflang.
  + Shennon boʻyicha axborot uzatish tizimi qanday elementlardan iborat? Uni robotning oʻlchash kanaliga qanday qoʻllash mumkin?
  + Xartli va Shennon formulalari oʻrtasidagi farq nimada? Entropiya qachon eng katta qiymatga erishadi?
  + Diapazoni 0…360°, xatoligi $plus.minus 0","1°$ boʻlgan burchak datchigi bitta oʻlchashda qancha axborot beradi? Uning uchun necha razryadli ARO kerak?
  + Signal/shovqin nisbati va kanalning oʻtkazish qobiliyati qanday bogʻlangan?
  + Kotelnikov teoremasini tushuntiring. Chastota almashinuvi nima va uning oldi qanday olinadi?
  + ARO razryadi, kvantlash qadami va kvantlash shovqini oʻrtasidagi bogʻliqlikni yozing.
  + Absolyut enkoderlarda nima uchun Grey kodi qoʻllanadi?
  + Harakat moduli, mexatron harakat moduli va intellektual mexatron modul qanday farqlanadi?
  + ISO 8373 boʻyicha sanoat va servis robotlariga taʼrif bering.
  + Manipulyatorlarning kinematik tuzilish boʻyicha turlarini sanab bering va ularning ishchi zonalarini taqqoslang.
  + Avtonom mobil robot va sanoat manipulyatorining informatsion qurilmalari nima uchun farq qiladi?
]

// =====================================================================
#heading(numbering: none)[Adabiyotlar]
// =====================================================================

#set par(first-line-indent: 0pt, justify: false)
#set enum(numbering: "[1]")

+ Bolton W. Mechatronics: Electronic Control Systems in Mechanical and Electrical Engineering. 6th ed. — Harlow: Pearson Education, 2015.
+ Regtien P., Dertien E. Sensors for Mechatronics. 2nd ed. — Amsterdam: Elsevier, 2018.
+ Bishop R. H. (ed.). The Mechatronics Handbook. 2nd ed. — Boca Raton: CRC Press, 2008.
+ Craig J. J. Introduction to Robotics: Mechanics and Control. 3rd ed. — Upper Saddle River: Pearson Prentice Hall, 2005.
+ Воротников С. А. Информационные устройства робототехнических систем. — М.: Изд-во МГТУ им. Н. Э. Баумана, 2005. — 384 с.
+ Интеллектуальные роботы / под общ. ред. Е. И. Юревича. — М.: Машиностроение, 2007. — 360 с.
+ Интеллектуальные сенсорные системы / под ред. Дж. К. М. Мейджера. — М.: Техносфера, 2011. — 464 с.
+ Подураев Ю. В. Мехатроника: основы, методы, применение. — М.: Машиностроение, 2006. — 256 с.
