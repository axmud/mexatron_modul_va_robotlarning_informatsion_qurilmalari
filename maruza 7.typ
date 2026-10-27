// =====================================================================
// Mexatron modul va robotlarning informatsion qurilmalari
// Maʼruza №7. Akustik, sigʻim, induktiv va Xoll datchiklari.
//             Intellektual datchiklar
// =====================================================================

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let headingblue = rgb("#1f4e79")
#let lightblue = rgb("#e8f0f8")
#let lightorange = rgb("#fbe3cf")

#set document(
  title: "Maʼruza №7. Akustik datchiklar, sigʻim datchiklari, induktiv datchiklar va Xoll datchiklari. Intellektual datchiklar",
)
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
)
// ===== HOSHIYA =====
#let info = json("fan.json")
#let raqam = 7  // maʼruza raqami
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
  #text(size: 16pt, weight: "bold", fill: headingblue)[MAʼRUZA №7]
  #v(0.3em)
  #text(
    size: 14pt,
    weight: "bold",
  )[Mavzu: Akustik datchiklar, sigʻim datchiklari, induktiv datchiklar \ va Xoll datchiklari. Intellektual datchiklar]
]

#v(0.8em)

#block[
  #set par(first-line-indent: 0pt)
  *Reja:*
  + Akustik (ultratovush) datchiklar.
  + Sigʻim datchiklari va ularning oʻlchash sxemalari.
  + Induktiv datchiklar. Induktiv yaqinlik datchiklari.
  + Xoll datchiklari va ularning robototexnikadagi qoʻllanilishi.
  + Yaqinlik va masofa datchiklarini taqqoslash.
  + Intellektual datchiklar: tuzilishi, funksiyalari va interfeyslari.

  *Tayanch iboralar:* ultratovush, piezoelektrik oʻzgartirgich, aks-sado, tovush tezligi, oʻlik zona, sigʻim datchigi, differensial kondensator, RC-generator, yaqinlik datchigi, uyurma toklar, LC-kontur, ishga tushish masofasi, tuzatish koeffitsienti, Xoll kaliti, chiziqli Xoll datchigi, kommutatsiya, tok datchigi, intellektual datchik, TEDS, IO-Link, oʻz-oʻzini diagnostika.
]

// =====================================================================
= Akustik (ultratovush) datchiklar
// =====================================================================

*Akustik datchiklar* tovush toʻlqinlari yordamida axborot oladi. Robototexnikada ularning eng keng tarqalgan turi — chastotasi 20 kHz dan yuqori boʻlgan *ultratovush* toʻlqinlaridan foydalanadigan masofa oʻlchagichlar va yaqinlik datchiklari. Bundan tashqari, mikrofonlar ovozli buyruqlarni qabul qilish va tovush manbaini aniqlashda, akustik emissiya datchiklari esa mexanizmlardagi nosozliklarni (podshipnik yeyilishi, yoriqlar) aniqlashda qoʻllanadi.

== Ishlash prinsipi

Ultratovush datchigida piezoelektrik oʻzgartirgich qisqa ultratovush impulsini (odatda 40 kHz atrofida) nurlantiradi, keyin qabul qilgich rejimiga oʻtib, obyektdan qaytgan aks-sadoni kutadi. Impuls yuborilgandan aks-sado qabul qilingunga qadar oʻtgan vaqt $t$ oʻlchanadi va masofa topiladi:

#eq($ D = (v dot t) / 2, $)

bu yerda $v$ — havoda tovush tezligi. Tovush tezligi harorat $T$ (°C) ga sezilarli bogʻliq:

#eq($ v approx 331","3 + 0","606 dot T quad ["m/s"]. $)

*Misol.* 20 °C da $v approx 343","4$ m/s. Aks-sado $t = 5","83$ ms dan keyin qaytsa, $D = 343","4 dot 0","00583 slash 2 approx 1","0$ m. Agar datchik 20 °C uchun sozlangan boʻlib, havo harorati 30 °C ($v approx 349","5$ m/s) boʻlsa, masofa taxminan 1,8 % ga kam oʻlchanadi. Shuning uchun aniq ultratovush datchiklarida harorat datchigi orqali tovush tezligi kompensatsiya qilinadi.

Ultratovush toʻlqin uzunligi:

#eq($ lambda = v / f. $)

40 kHz uchun $lambda = 343 slash 40 000 approx 8","6$ mm. Toʻlqin uzunligidan ancha kichik obyektlar yaxshi aks ettirmaydi, toʻlqin uzunligi esa datchikning koʻndalang ruxsat qobiliyatini ham cheklaydi.

== Xususiyatlari va cheklovlari

Ultratovush datchiklarining muhim xususiyatlari:
- *oʻlik zona* — nurlantirgich impulsdan keyin bir muddat tebranishda davom etadi va bu vaqtda aks-sadoni qabul qila olmaydi; shuning uchun datchik juda yaqin obyektlarni (odatda bir necha santimetrgacha) koʻrmaydi;
- *nurlanish konusi* — ultratovush keng konus (bir necha oʻn gradus) boʻylab tarqaladi; bu katta zonani qamrab olish imkonini beradi, lekin obyektning aniq yoʻnalishini aniqlashni qiyinlashtiradi;
- *aks ettirish xususiyatlari* — silliq sirt toʻlqinni koʻzgudek aks ettiradi va qiya joylashsa, aks-sado datchikka qaytmaydi; yumshoq gʻovak materiallar (mato, porolon) tovushni yutadi;
- *tezkorlik* — tovush sekin tarqalgani uchun oʻlchash sikli yorugʻlikka asoslangan datchiklarga qaraganda ancha uzun: 5 m masofa uchun bitta oʻlchash taxminan 30 ms davom etadi;
- *oʻzaro xalaqit* — bir nechta ultratovush datchigi bir vaqtda ishlasa, biri ikkinchisining signalini qabul qilib qolishi mumkin; shuning uchun ular navbatma-navbat ishga tushiriladi.

Ultratovush datchiklari optik datchiklardan farqli ravishda obyekt rangi va shaffofligiga bogʻliq emas: shisha, shaffof plastik va suyuqlik sathini ishonchli aniqlaydi, chang va tutunda ham ishlaydi. Ular arzon va sodda boʻlgani uchun mobil robotlarda yaqin toʻsiqlarni aniqlash, avtomobillarda parkovka tizimlari va sanoatda sath oʻlchash uchun keng qoʻllanadi.

// =====================================================================
= Sigʻim datchiklari va ularning oʻlchash sxemalari
// =====================================================================

== Sigʻim oʻzgartirgichlarning turlari

Yassi kondensator sigʻimi $C = epsilon_0 epsilon_r S slash d$ (4-maʼruza) uchta parametrga bogʻliq, shunga koʻra sigʻim datchiklarining uch turi mavjud:
- *tirqishi oʻzgaruvchan* — elektrodlar orasidagi masofa $d$ oʻzgaradi; sezgirlik yuqori, lekin tavsif nochiziqli ($C ~ 1 slash d$);
- *yuzasi oʻzgaruvchan* — elektrodlarning ustma-ust tushgan yuzasi $S$ oʻzgaradi; tavsif chiziqli, katta siljishlarni oʻlchash mumkin (sigʻim enkoderlari, chiziqli shkalalar);
- *dielektrigi oʻzgaruvchan* — elektrodlar orasidagi muhit $epsilon_r$ oʻzgaradi; suyuqlik va sochiluvchan materiallar sathi, namlik, metall boʻlmagan obyektlar yaqinligini aniqlash.

== Differensial sigʻim datchigi

Tirqishi oʻzgaruvchan datchikning nochiziqliligini yoʻqotish uchun *differensial* sxema qoʻllanadi: harakatlanuvchi elektrod ikkita qoʻzgʻalmas elektrod oʻrtasida joylashadi. U $x$ ga siljiganda bir kondensator tirqishi kamayadi, ikkinchisiniki ortadi:

#eq($ C_1 = (epsilon S) / (d - x), quad C_2 = (epsilon S) / (d + x), quad (C_1 - C_2) / (C_1 + C_2) = x / d. $)

Shunday qilib, sigʻimlar ayirmasining yigʻindisiga nisbati siljishga *qatʼiy chiziqli* bogʻliq, bundan tashqari harorat va dielektrik singdiruvchanlik oʻzgarishining taʼsiri ham kamayadi. Masalan, $d = 1$ mm, $x = 0","1$ mm boʻlsa, nisbat aniq 0,1 ga teng. Aynan shu sxema MEMS akselerometr va giroskoplarda (6-maʼruza) qoʻllanadi.

== Oʻlchash sxemalari

Sigʻim datchiklarining sigʻimi va uning oʻzgarishi juda kichik (pikofaradlar va undan kam), shuning uchun maxsus sxemalar kerak:
- *RC- yoki LC-generatorlar* — sigʻim generator chastotasini belgilaydi, chastota esa raqamli usulda oson va aniq oʻlchanadi;
- *oʻzgaruvchan tok koʻprigi* — differensial datchiklar uchun;
- *zaryadni koʻchirish (charge transfer) va sigma-delta oʻzgartirgichlar* — zamonaviy sigʻim oʻlchash mikrosxemalari bilvosita sigʻimni raqamga aylantiradi.

Ulovchi kabellarning parazit sigʻimi datchik sigʻimi bilan solishtirarli boʻlishi mumkin, shuning uchun oʻlchash elektronikasi datchikka iloji boricha yaqin joylashtiriladi va ekranlanadi.

== Robototexnikada qoʻllanilishi

*Sigʻim yaqinlik datchiklari* metall va metall boʻlmagan obyektlarni kontaktsiz sezadi. *Sensorli (touch) panellar* va *robotlarning sigʻim «terisi»* insonning yaqinlashishi yoki tegishini sezadi: inson tanasi elektrodlar sigʻimini oʻzgartiradi. Kollaborativ robotlarda bunday qoplama robot insonga tegishidan oldin uni sekinlashtirish imkonini beradi. Sigʻim prinsipi MEMS inersial datchiklar, bosim datchiklari va taktil matritsalarning ham asosidir.

// =====================================================================
= Induktiv datchiklar. Induktiv yaqinlik datchiklari
// =====================================================================

== Induktiv datchiklarning turlari

Induktiv datchiklar magnit maydon va elektromagnit induksiya hodisalariga asoslanadi. Ularning asosiy turlari:
- *magnit qarshiligi oʻzgaruvchan datchiklar* — yakor siljiganda magnit zanjir tirqishi va gʻaltak induktivligi oʻzgaradi (4-maʼruza); nochiziqlilikni kamaytirish uchun differensial sxemada quriladi;
- *transformatorli datchiklar* — LVDT va rezolverlar (5-maʼruza);
- *uyurma tokli datchiklar* — yuqori chastotali maydon oʻtkazuvchi obyektda uyurma toklar hosil qiladi; ular gʻaltak parametrlarini oʻzgartiradi; metall obyektgacha masofa va tebranishlarni kontaktsiz, mikrometr aniqlikda oʻlchaydi;
- *induksion datchiklar* — magnit oqim oʻzgarganda EYuK hosil qiladi; tezlik va tishli gʻildirak tishlarini sanash uchun (6-maʼruza).

== Induktiv yaqinlik datchigi

*Induktiv yaqinlik datchigi* robototexnika va sanoat avtomatikasidagi eng koʻp ishlatiladigan diskret datchiklardan biri. U LC-generator, uning gʻaltagi joylashgan ochiq ferrit oʻzak, demodulyator, komparator (Shmitt triggeri) va chiqish kaliti (PNP yoki NPN) dan iborat. Generator gʻaltagi datchik oldida yuqori chastotali magnit maydon hosil qiladi. Rezonans chastotasi:

#eq($ f_0 = 1 / (2 pi sqrt(L C)). $)

Metall obyekt maydonga kirganda unda uyurma toklar hosil boʻladi va ular generator energiyasini soʻradi: tebranish amplitudasi kamayadi. Amplituda belgilangan chegaradan pastga tushganda komparator chiqish kalitini ulaydi.

Datchikning pasportida koʻrsatilgan *nominal ishga tushish masofasi* $S_n$ standart poʻlat namuna uchun belgilanadi. Boshqa metallar uyurma toklarga boshqacha javob bergani uchun haqiqiy masofa kichikroq boʻladi:

#eq($ S_r = k_m dot S_n, $)

bu yerda $k_m$ — material tuzatish koeffitsienti. Uning taxminiy qiymatlari 1-jadvalda keltirilgan (aniq qiymatlar datchik turiga bogʻliq va uning pasportida beriladi).

#figure(
  btable(
    columns: (1fr, auto),
    align: (left, center),
    header: ([Obyekt materiali], [Tuzatish koeffitsienti $k_m$ (taxminan)]),
    [Konstruksion poʻlat],
    [1,0],
    [Zanglamaydigan poʻlat],
    [0,6…0,9],
    [Latun],
    [0,35…0,5],
    [Alyuminiy],
    [0,3…0,45],
    [Mis],
    [0,25…0,4],
  ),
  caption: [Induktiv yaqinlik datchigi uchun material tuzatish koeffitsientlari],
) <tab-km>

*Misol.* $S_n = 8$ mm boʻlgan datchik alyuminiy detalni ($k_m approx 0","4$) taxminan $S_r approx 3","2$ mm masofadan sezadi. Datchikni oʻrnatishda bu albatta hisobga olinishi kerak. Induktiv yaqinlik datchiklari robot boʻgʻinlarining chekka va boshlangʻich holatlarini aniqlash, metall detallar mavjudligini tekshirish va tishli gʻildirak orqali tezlikni oʻlchashda qoʻllanadi. Ular kontaktsiz, chang, yogʻ va namlikka juda chidamli.

// =====================================================================
= Xoll datchiklari va ularning robototexnikadagi qoʻllanilishi
// =====================================================================

== Xoll datchiklarining turlari

Xoll effekti va Xoll kuchlanishi formulasi 4-maʼruzada koʻrildi. Xoll elementining kuchlanishi juda kichik (millivoltlar) boʻlgani uchun amaliyotda bitta kristallda Xoll elementi, kuchaytirgich, harorat kompensatsiyasi va chiqish bosqichi birlashtirilgan *integral Xoll datchiklari* qoʻllanadi. Chiqish signaliga koʻra ular ikki turga boʻlinadi:
- *chiziqli (analog) Xoll datchiklari* — chiqish kuchlanishi magnit induksiyasiga proporsional; masofa, burchak va tokni oʻlchash uchun;
- *Xoll kalitlari (raqamli)* — magnit induksiyasi belgilangan chegaradan oshganda chiqish holatini oʻzgartiradi. Ular gisterezisga ega: yoqilish va oʻchish induksiyalari farq qiladi. Bir qutbli kalitlar bitta qutbga, *latch* (ushlab qoluvchi) turlari esa navbatma-navbat shimoliy va janubiy qutblarga javob beradi.

== Kollektorsiz dvigatellarda rotor holatini aniqlash

Kollektorsiz oʻzgarmas tok dvigatellarida (BLDC) chulgʻamlarni toʻgʻri navbatda ulash (kommutatsiya) uchun rotor holatini bilish kerak. Buning uchun stator ichiga elektr burchak boʻyicha 120° ga siljitilgan uchta Xoll kaliti oʻrnatiladi. Rotor magniti aylanganda ular har 60° elektr burchakda bitta razryadi oʻzgaradigan uch bitli kod hosil qiladi (2-jadval).

#figure(
  btable(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: center,
    header: ([Sektor], [1], [2], [3], [4], [5], [6]),
    [Elektr burchak],
    [0…60°],
    [60…120°],
    [120…180°],
    [180…240°],
    [240…300°],
    [300…360°],
    [Kod $H_1 H_2 H_3$],
    [101],
    [100],
    [110],
    [010],
    [011],
    [001],
  ),
  caption: [Uchta Xoll datchigi kodlarining ketma-ketligi (bitta yoʻnalish uchun misol)],
) <tab-xoll>

Har bir kodga chulgʻamlarning maʼlum ulanish kombinatsiyasi mos keladi. 000 va 111 kodlari normal ishlashda hech qachon uchramaydi, shuning uchun ular paydo boʻlsa, drayver Xoll datchiklari yoki ularning ulanishi nosozligini aniqlaydi — bu oddiy, lekin samarali diagnostika usuli. Sektorlarning faza chulgʻamlariga aniq mosligi dvigatel konstruksiyasiga bogʻliq va drayver hujjatlarida beriladi.

== Tok va burchak datchiklari

*Xoll tok datchigida* oʻlchanayotgan tok oʻtkazgichi tirqishli ferromagnit oʻzak ichidan oʻtadi, Xoll elementi esa tirqishga joylashtiriladi. Tirqishdagi magnit induksiyasi tokka proporsional:

#eq($ B approx (mu_0 dot I) / delta, $)

bu yerda $delta$ — tirqish uzunligi (oʻzakning magnit qarshiligi tirqishnikidan ancha kichik deb olingan). *Misol.* $delta = 2$ mm, $I = 50$ A boʻlsa, $B approx 4 pi dot 10^(-7) dot 50 slash 0","002 approx 31$ mT. Bunday datchik tok zanjiriga galvanik ulanmasdan oʻzgarmas va oʻzgaruvchan tokni oʻlchaydi. Robot drayverlarida dvigatel toki (demak, moment) shu tarzda nazorat qilinadi.

*Xoll burchak datchiklari (magnit enkoderlar)* valga oʻrnatilgan diametral magnit maydonining ikki perpendikulyar komponentini oʻlchaydi; burchak sin/cos signallar nisbatidan topiladi. Ular ixcham, kontaktsiz va ifloslanishga chidamli. Shuningdek, Xoll datchiklari kontaktsiz chegara kalitlari, joystiklar va pnevmosilindr porshenining holatini aniqlashda (porshendagi magnit orqali) keng qoʻllanadi.

Xoll datchiklariga yaqin vazifalarni *magnitorezistiv* datchiklar ham bajaradi: ularda magnit maydon taʼsirida qarshilik oʻzgaradi. Ular sezgirroq va magnit enkoderlar hamda elektron kompaslarda (magnitometrlarda) qoʻllanadi.

// =====================================================================
= Yaqinlik va masofa datchiklarini taqqoslash
// =====================================================================

Koʻrib chiqilgan datchiklar va optik datchiklar (6-maʼruza) robotlarda obyekt yaqinligi va masofasini aniqlashda bir-birini toʻldiradi. Ularning asosiy xususiyatlari 3-jadvalda taqqoslangan.

#figure(
  btable(
    columns: (auto, 1fr, 1fr, 1fr),
    header: ([Datchik], [Sezadigan obyektlar], [Afzalligi], [Cheklovi]),
    [Induktiv],
    [Faqat metallar],
    [Juda chidamli, ifloslanishga sezgir emas],
    [Kichik masofa, material taʼsir qiladi],
    [Sigʻim],
    [Deyarli barcha materiallar, suyuqliklar],
    [Metall boʻlmagan obyektlar, devor orqali sath],
    [Namlik va ifloslanishga sezgir],
    [Xoll],
    [Magnitlar],
    [Kontaktsiz holat va tok, ixcham],
    [Obyektda magnit boʻlishi kerak],
    [Ultratovush],
    [Tovushni aks ettiruvchi obyektlar],
    [Rang va shaffoflikka bogʻliq emas, arzon],
    [Sekin, keng konus, oʻlik zona],
    [Optik],
    [Yorugʻlikni aks ettiruvchi yoki toʻsuvchi obyektlar],
    [Katta masofa, tezkor, aniq],
    [Shaffof va qora obyektlar, chang],
  ),
  caption: [Yaqinlik va masofa datchiklarini taqqoslash],
) <tab-taqqos>

// =====================================================================
= Intellektual datchiklar: tuzilishi, funksiyalari va interfeyslari
// =====================================================================

== Tuzilishi

*Intellektual (smart) datchik* — birlamchi oʻzgartirgich, signalga ishlov berish sxemasi, analog-raqamli oʻzgartirgich, mikroprotsessor, xotira va raqamli aloqa interfeysi bitta qurilmada birlashtirilgan datchik (1-rasm). U faqat oʻlchab qolmay, natijani qayta ishlaydi, oʻzining holatini nazorat qiladi va boshqaruv tizimi bilan raqamli tarmoq orqali muloqot qiladi.

#figure(
  diagram(
    spacing: (6mm, 9mm),
    node-stroke: 1pt,
    node-fill: lightblue,
    node-corner-radius: 3pt,
    node-shape: rect,
    edge-stroke: 1pt,
    node((0, 0), [Sezgir \ element], name: <se>),
    node((1, 0), [Analog \ qism], name: <aq>),
    node((2, 0), [ARO], name: <aro>),
    node((3, 0), [Mikro- \ protsessor], fill: lightorange, name: <mp>),
    node((4, 0), [Raqamli \ interfeys], name: <if>),
    node((1, 1), [Harorat \ datchigi], fill: white, name: <td>),
    node((3, 1), [Xotira: kalibrlash, \ TEDS, jurnal], fill: white, name: <xt>),
    node((4.6, 1), [Boshqaruv \ tizimi], fill: white, name: <bt>),
    edge(<se>, <aq>, "->"),
    edge(<aq>, <aro>, "->"),
    edge(<aro>, <mp>, "->"),
    edge(<mp>, <if>, "<->"),
    edge(<td>, <aro>, "->"),
    edge(<xt>, <mp>, "<->"),
    edge(<if>, <bt>, "<->"),
  ),
  caption: [Intellektual datchikning tuzilishi],
) <fig-smart>

== Funksiyalari

Intellektual datchik quyidagi funksiyalarni bajaradi:
- *raqamli kalibrlash va chiziqlashtirish* — xotiradagi kalibrlash koeffitsientlari yordamida nochiziqli tavsifni tuzatish;
- *harorat kompensatsiyasi* — ichki harorat datchigi orqali nol siljishi va sezgirlikning haroratga bogʻliqligini tuzatish;
- *raqamli filtrlash va oʻrtachalash* — shovqinni kamaytirish;
- *oʻlchov birliklariga oʻtkazish* — natijani bevosita fizik birliklarda (°C, bar, mm) berish;
- *chegaraviy qiymatlarni nazorat qilish* — chegaradan chiqilganda signal berish;
- *oʻz-oʻzini diagnostika qilish* — sezgir element uzilishi yoki qisqa tutashuvi, taʼminot buzilishi, ifloslanish, ish resursi tugashini aniqlash;
- *identifikatsiya* — ishlab chiqaruvchi, model, seriya raqami va kalibrlash maʼlumotlarini xotirada saqlash (masalan, IEEE 1451 standartidagi TEDS — _Transducer Electronic Data Sheet_ — elektron pasport);
- *parametrlash* — oʻlchash diapazoni, filtr, chegaralar kabi sozlamalarni masofadan oʻzgartirish.

Raqamli kalibrlashda chiqish signali $y$ va ichki harorat $T$ boʻyicha oʻlchanayotgan kattalikning bahosi koʻpincha ikki oʻzgaruvchili polinom bilan hisoblanadi:

#eq($ hat(x) = sum_(i=0)^n sum_(j=0)^m a_(i j) dot y^i dot T^j, $)

bu yerda $a_(i j)$ — har bir datchik uchun ishlab chiqarishda alohida aniqlanib, uning xotirasiga yozilgan kalibrlash koeffitsientlari. Shu tufayli arzon, lekin nochiziqli va haroratga sezgir sezgir element bilan ham yuqori aniqlikka erishiladi.

== Interfeyslar

Intellektual datchiklar boshqaruv tizimiga raqamli interfeyslar orqali ulanadi:
- *I²C va SPI* — plata ichidagi qisqa masofali aloqa; MEMS akselerometrlar, giroskoplar, magnitometrlar, harorat va bosim datchiklari;
- *IO-Link* (IEC 61131-9) — datchik va boshqaruv tizimi orasidagi «nuqta-nuqta» raqamli aloqa; oddiy ekranlanmagan uch simli kabel orqali (20 m gacha) oʻlchash natijasi, parametrlar va diagnostika uzatiladi;
- *CAN, EtherCAT, PROFINET* kabi sanoat tarmoqlari — robot boʻgʻinlari, enkoderlar va kuch-moment datchiklarini real vaqtda ulash;
- *SSI, BiSS, EnDat* — enkoderlar uchun maxsus ketma-ket interfeyslar (5-maʼruza).

== Afzalliklari

Anʼanaviy analog datchiklarga nisbatan intellektual datchiklar quyidagi afzalliklarga ega: yuqori aniqlik (raqamli kalibrlash va kompensatsiya tufayli), uzatishda xalaqitga chidamlilik, kabellar sonining kamayishi (bir nechta datchik bitta tarmoqqa ulanadi), oʻrnatish va almashtirishning soddaligi (parametrlar avtomatik yuklanadi), nosozliklarni oldindan aniqlash va bashorat qilish imkoniyati. Bu Sanoat 4.0 konsepsiyasidagi uskunalarni uzluksiz kuzatish va bashoratli texnik xizmat koʻrsatishning asosidir. Kamchiliklari — narxning yuqoriligi va qoʻshimcha kechikish (raqamli ishlov va uzatish vaqti), bu tez boshqaruv konturlarida hisobga olinishi kerak.

// =====================================================================
= Xulosa
// =====================================================================

Ultratovush datchiklari aks-sado vaqti boʻyicha masofani oʻlchaydi; ular obyekt rangi va shaffofligiga bogʻliq emas, lekin tovush tezligining haroratga bogʻliqligi, oʻlik zona va sekinlik ularning cheklovlaridir. Sigʻim datchiklari tirqish, yuza yoki dielektrik oʻzgarishiga asoslanadi; differensial sxema ularning tavsifini chiziqli qiladi. Induktiv yaqinlik datchiklari uyurma toklar hisobiga metall obyektlarni sezadi, ularning ishga tushish masofasi obyekt materialiga bogʻliq. Xoll datchiklari kollektorsiz dvigatellarda rotor holatini aniqlash, tokni galvanik ajratilgan holda oʻlchash va kontaktsiz burchak datchiklarida keng qoʻllanadi.

Intellektual datchiklar oʻlchash, raqamli kalibrlash, kompensatsiya, filtrlash, diagnostika va raqamli aloqani bitta qurilmada birlashtiradi. Ular zamonaviy robotlarning informatsion tizimini soddaroq, aniqroq va ishonchliroq qiladi.

// =====================================================================
= Nazorat savollari
// =====================================================================

#block[
  #set par(first-line-indent: 0pt)
  + Ultratovush datchigi qanday prinsipda masofani oʻlchaydi?
  + Nima uchun ultratovush datchigida harorat kompensatsiyasi kerak? 0 °C da $t = 10$ ms aks-sado qanday masofaga mos keladi?
  + Ultratovush datchigining oʻlik zonasi va nurlanish konusi nimani anglatadi?
  + Sigʻim datchiklarining qanday turlari bor? Ularning tavsiflari qanday farqlanadi?
  + Differensial sigʻim datchigi nima uchun chiziqli tavsifga ega?
  + Sigʻim datchiklarida parazit sigʻimning taʼsiri qanday kamaytiriladi?
  + Induktiv yaqinlik datchigi qanday ishlaydi?
  + $S_n = 10$ mm boʻlgan induktiv datchik mis detalni ($k_m = 0","3$) qanday masofadan sezadi?
  + Chiziqli Xoll datchigi va Xoll kaliti qanday farqlanadi?
  + BLDC dvigatelda uchta Xoll datchigi qanday vazifani bajaradi? 000 kodi nimani bildiradi?
  + Xoll tok datchigining afzalligi nimada?
  + Intellektual datchik qanday qismlardan iborat va qanday funksiyalarni bajaradi?
  + IO-Link interfeysining afzalliklari nimada?
]
