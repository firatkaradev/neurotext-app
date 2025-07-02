import 'package:hive/hive.dart';
import '../models/story.dart';

class StoryService {
  static const String _boxName = 'stories';

  static Future<Box<Story>> _getBox() async {
    return await Hive.openBox<Story>(_boxName);
  }

  // Ön yüklü hikayeleri ekle
  static Future<void> initializePreloadedStories() async {
    final box = await _getBox();

    // Eğer zaten ön yüklü hikayeler varsa tekrar ekleme
    if (box.values.any((story) => story.isPreloaded)) {
      return;
    }

    final preloadedStories = [
      Story.create(
        title: 'Altın Kaz',
        author: 'Grimm Kardeşler',
        category: 'Klasik Masallar',
        isPreloaded: true,
        content:
            '''Bir zamanlar fakir bir adam vardı. Üç oğlu olan bu adamın en küçük oğlu herkesçe aptal olarak bilinirdi ve ona "Dummling" denirdi. Bir gün büyük oğul ormana odun kesmeye gitti. Annesi ona güzel bir kek ve şarap verdi. Ormanda yaşlı, gri saçlı bir adam ona rastladı ve yiyecek istedi. Ama büyük oğul paylaşmayı reddetti. Odun keserken kazara kendini yaraladı ve eve dönmek zorunda kaldı.

Sonra ikinci oğul denedi, o da aynı şekilde yaşlı adamla karşılaştı ve paylaşmayı reddetti. O da yaralandı ve eve döndü.

En sonunda Dummling gitti. Sadece kuru ekmek ve ekşi bira vardı yanında. Yaşlı adam yiyecek istediğinde, Dummling memnuniyetle paylaştı. Yaşlı adam bunun karşılığında ona altın tüyleri olan bir kazı gösterdi ve "Bu kaz sana şans getirecek" dedi.

Dummling kaz ile bir hana geldi. Hancının üç kızı vardı ve altın tüyleri görünce çok istedi. En büyüğü bir tüy koparmaça çalıştı ama eline yapıştı ve kurtulamadı. Diğer kızlar da yardım etmeye çalıştılar ama onlar da yapıştı. Sabah Dummling kalkıp yürümeye başladığında, üç kız da arkasından sürüklendi.

Böylece devam ederken daha fazla insan bu garip alaya katıldı - bir papaz, bir kilise hizmeti, iki çiftçi... Hepsi birbirine yapışmış halde yürüyorlardı.

Sonunda krallığa vardılar. Kralın bir kızı vardı, o kadar ciddiydi ki hiç gülmemişti. Kral, kızını güldüren kişiyle evlendireceğini ilan etmişti. Prenses bu acayip alayı görünce kahkahaya boğuldu. Dummling onunla evlendi ve sonunda krallığı miras aldı.''',
      ),
      Story.create(
        title: 'Küçük Deniz Kızı',
        author: 'Hans Christian Andersen',
        category: 'Klasik Masallar',
        isPreloaded: true,
        content:
            '''Denizin derinliklerinde güzel bir saray vardı ve burada Deniz Kralı altı güzel kızıyla yaşardı. En küçüğü en güzeliydi, derisi gül yaprağı gibi pürüzsüz, gözleri en derin deniz mavisi gibiydi. Tüm deniz kızları gibi bacakları yerine balık kuyruğu vardı.

On beş yaşına geldiğinde yüzeye çıkmasına izin verildi. Yüzeye çıktığında bir gemi gördü ve genç, yakışıklı bir prensi fark etti. Birden fırtına çıktı ve gemi battı. Deniz kızı prensi kurtarıp kıyıya taşıdı, ama o uyanmadan önce denize geri döndü.

Deniz kızı artık sürekli prensi düşünüyordu ve insanların dünyasını merak ediyordu. Büyükannesi ona anlattı: "İnsanlar bizden daha kısa yaşar ama ölünce ruhları göğe çıkar. Bizler üç yüz yıl yaşarız ama öldüğümüzde deniz köpüğü oluruz."

Deniz kızı Deniz Cadısı'nın yanına gitti. Cadı ona bacak verebileceğini ama bunun bedeli olarak sesini alacağını söyledi. Ayrıca eğer prens başka biriyle evlenirse, deniz kızı ölecekti. Deniz kızı kabul etti.

İksir içtikten sonra deniz kızı kıyıda bayılarak bulundu. Prens onu sarayına götürdü. Deniz kızı çok güzel dans ediyordu ama her adımda ayakları acıyordu. Prens onu çok sevdi ama bir kardeş gibi.

Sonunda prens başka bir prensesle evlenmeye karar verdi. Deniz kızının kız kardeşleri ona bir bıçak getirdi: "Prensi öldürürsen tekrar deniz kızı olabilirsin." Ama deniz kızı bunu yapamadı. Şafak vakti deniz köpüğü olmak üzere denize atladı. Ama melek sesleri onu durdurdu ve havaya yükseldi - saf sevgisi sayesinde hava kızlarından biri olmuştu.''',
      ),
      Story.create(
        title: 'Mutlu Prens',
        author: 'Oscar Wilde',
        category: 'Klasik Masallar',
        isPreloaded: true,
        content:
            '''Şehrin yüksek bir sütunu üzerinde Mutlu Prens'in heykeli duruyordu. Altın varakla kaplı, gözleri safir, kılıcının kabzasında kırmızı yakut vardı. Herkes onu hayranlıkla izlerdi.

Bir akşam küçük bir kırlangıç heykelin ayakları arasında dinlenmek için durdu. Birden bir damla düştü - heykel ağlıyordu. Heykel kırlangıca anlattı: "Ben yaşarkenken sarayımda mutluydum çünkü keder nedir bilmiyordum. Şimdi buradan şehrin tüm sefalet ve çirkinliğini görüyorum."

Heykel, kırlangıçtan yardım istedi. "Kılıcımdaki yakutu al ve hasta çocuğu olan fakir kadına götür." Kırlangıç yakutu aldı ve kadının evine götürdü.

Ertesi gün heykel tekrar istedi: "Gözlerimdeki safirlerden birini al ve çatı katında yaşayan genç yazara götür." Kırlangıç bunu da yaptı.

Üçüncü gün heykel: "Diğer safiri de al ve kibrit satan küçük kıza ver." dedi.

Artık heykel kör olmuştu. Kırlangıç güneye gitmek yerine yanında kalmaya karar verdi. Heykel altın varakların hepsini fakir insanlara dağıtması için kırlangıca verdi.

Kış geldi ve kırlangıç soğuktan öldü. Heykelin kalbi de üzüntüden çatlayarak ikiye bölündü.

Şehir meclisi artık çirkin olan heykeli kaldırmaya karar verdi. Fırında eritirken kurşun kalp erimedi. Onu çöplüğe attılar, ölü kırlangıcın yanına.

Tanrı meleklerinden birine "Bu şehirden en değerli iki şeyi getir" dedi. Melek kurşun kalbi ve ölü kuşu getirdi. Tanrı "Doğru seçtin. Bu küçük kuş cennet bahçelerimde sonsuza dek şarkı söyleyecek ve Mutlu Prens altın şehrimde beni övecek" dedi.''',
      ),
      Story.create(
        title: 'Rip Van Winkle',
        author: 'Washington Irving',
        category: 'Klasik Hikayeler',
        isPreloaded: true,
        content:
            '''Hudson Nehri vadisinde, Hollandalı göçmenlerin kurduğu küçük bir köyde Rip Van Winkle yaşardı. İyi kalpli ama tembel bir adamdı. Komşularına her türlü yardımı yapardı ama kendi işlerini yapmaktan kaçınırdı. Karısı Dame Van Winkle sürekli ona bağırıp çağırırdı.

Bir gün karısının azarlarından kaçmak için köpeği Wolf ile birlikte Catskill Dağları'na çıktı. Akşam olurken garip giyimli, yaşlı bir adam gördü. Adam ona bir fıçı taşımakta yardım etmesini istedi. Birlikte dağın tepesindeki bir çukura indiler.

Orada eski moda giyimli, ciddi yüzlü adamlar dokuz kuka oynuyordu. Hiç konuşmuyorlardı, sadece kukaların sesi duyuluyordu. Yaşlı adam Rip'e içki ikram etti. Rip içtikçe gözleri ağırlaştı ve derin bir uykuya daldı.

Uyandığında güneş parlıyordu. Wolf yoktu, tüfeği paslanmıştı, sakalı uzamıştı. Köye indiğinde her şey değişmişti. Tanıdığı evler yıkılmış, yenileri yapılmış, insanlar farklı giyiniyordu. Adını söylediğinde yaşlılar onu hatırladı - yirmi yıl önce kaybolmuş olan Rip Van Winkle.

Karısı ölmüş, çocukları büyümüştü. Artık özgür olan Rip, köy kahvesinde hikayesini anlatarak mutlu bir yaşlılık geçirdi.''',
      ),
      Story.create(
        title: 'Kolye',
        author: 'Guy de Maupassant',
        category: 'Klasik Hikayeler',
        isPreloaded: true,
        content:
            '''Mathilde Loisel güzel ama orta sınıf bir kadındı. Lüks bir hayat yaşamadığı için sürekli mutsuzdu. Kocası Milli Eğitim Bakanlığı'nda küçük bir memurdu.

Bir gün kocası eve bir davetiye getirdi - Milli Eğitim Bakanı'nın verdiği baloya davetliydiler. Mathilde sevinmek yerine ağladı: "Giyecek elbisem yok!" Kocası elbise için biriktirdiği 400 frankı ona verdi.

Elbiseyi aldıktan sonra Mathilde yine üzgündü: "Mücevherim yok, ne kadar sefil görüneceğim!" Kocası zengin arkadaşı Madame Forestier'den borç almasını önerdi.

Madame Forestier'in mücevher kutusunu açtı ve muhteşem elmas bir kolye seçti. Baloda büyük ilgi gördü, dans etti, eğlendi - hayatının en güzel gecesiydi.

Eve döndüklerinde kolyenin gittiğini fark ettiler. Her yerde aradılar ama bulamadılar. Aynısını almak için borç para bulup 36.000 franka yeni bir kolye aldılar ve Madame Forestier'e verdiler.

On yıl boyunca bu borcu ödemek için çok çalıştılar. Mathilde hizmetçilik yaptı, kocası akşamları ek iş aldı. Mathilde'in güzelliği soldu, elleri nasırlaştı.

On yıl sonra borcu ödemişlerdi. Bir gün Mathilde, Madame Forestier'e rastladı ve her şeyi anlattı. Madame Forestier şaşkınlıkla "Ama benim kolyem taklitten yapılmıştı, en fazla 500 frank ederdi!" dedi.''',
      ),
      Story.create(
        title: 'Müneccim Kralların Hediyesi',
        author: 'O. Henry',
        category: 'Klasik Hikayeler',
        isPreloaded: true,
        content:
            '''Jim ve Della genç, çok sevgi dolu ama fakir bir çiftti. Noel yaklaşıyordu ve Della'nın elinde sadece bir dolar seksen sent vardı. Jim'e güzel bir hediye almak istiyordu.

Della'nın tek değerli eşyası dizlerine kadar uzanan muhteşem saçlarıydı. Jim'in tek değerli eşyası ise dedesinden kalma altın köstekli saatiydi.

Della saçlarını kestirip peruk yapımcısına yirmi dolara sattı. Bu parayla Jim'in saati için güzel bir platin saat kösteği aldı.

Jim eve geldiğinde Della'nın saçsızlığını görünce şaşırdı. Sonra hediyesini çıkardı - Della'nın güzel saçları için aldığı süslü saç tarakları seti.

Della da hediyesini verdi - saat kösteğini. Jim gülümseyerek "Saat kösteğini almak için saatimi sattım" dedi.

Her ikisi de birbirini mutlu etmek için en değerli eşyalarını feda etmişlerdi. Ama aslında birbirlerine verebilecekleri en büyük hediyeyi - sevgilerini - vermişlerdi.

Hikayeci der ki: Müneccim krallar bebek İsa'ya hediyeler getirmişti ve onlar bilge sayılır. Bu iki genç de, sevginin en büyük hediye olduğunu bildikleri için, hepsinden daha bilgeydiler.''',
      ),
      Story.create(
        title: 'Ay Işığı ve Çoban',
        author: 'Anonim',
        category: 'Modern Masallar',
        isPreloaded: true,
        content:
            '''Bir zamanlar yüksek dağların eteklerinde yalnız yaşayan bir çoban varmış. Sadece koyunlarıyla konuşur, geceleri yıldızlara bakarmış. En büyük hayali, Ay'a dokunmakmış.

Bir gece dolunay gökyüzünü aydınlatırken, Ay ona fısıldamış: "Cesaretin varsa, beni bul." Çoban bastonunu almış, dağa tırmanmaya başlamış. Günlerce yürümüş, sonunda zirveye ulaşmış. Ama Ay hâlâ gökyüzündeymiş.

Üzgün bir şekilde bastonunu yere vurmuş. Tam o anda, bastonun altından bir kaynak fışkırmış ve göğe yükselen bir ışık sütunu oluşmuş. Çoban hiç düşünmeden içine adım atmış ve kendini Ay'ın bahçesinde bulmuş.

Ay ona gülümsedi: "Senin kalbindeki ışıktı beni buraya çeken. Artık yıldızların çobanı sensin." O günden sonra, her gece bir yıldız daha parlardı gökyüzünde, çünkü çoban onlara tek tek isim verirdi.''',
      ),
      Story.create(
        title: 'Sessiz Kasaba',
        author: 'Anonim',
        category: 'Modern Masallar',
        isPreloaded: true,
        content:
            '''Bir zamanlar seslerin kaybolduğu bir kasaba varmış. Ne kuşlar öter, ne nehirler şırıldar, ne çocuklar gülermiş. Herkes fısıltıyla konuşur, ses çıkarmaya çekinirmiş. Efsaneye göre, sesler bir zamanlar kasabanın yakınındaki büyük çanı çaldıktan sonra uçup gitmiş.

Bir gün küçük bir kız, Lila, kütüphanede eski bir kitap bulmuş. Kitapta şöyle yazıyormuş: "Çanı bir kahkahayla çalan kişi kasabanın seslerini geri getirir." Lila bunu herkese anlatmış ama kimse inanmamış.

Ertesi sabah, Lila çanın yanına gitmiş ve en sevdiği şakayı kendine fısıldamış. Gülmeye başlamış, sonra kahkahalara boğulmuş. O sırada çan kendi kendine çalmaya başlamış.

Bir anda rüzgar esmiş, ağaçlar uğuldamış, uzaklarda köpekler havlamış. Kuşlar ötüşe, insanlar konuşmaya başlamış. Lila o gün kasabanın sesi olmuş ve çan bir daha hiç susmamış.''',
      ),
      Story.create(
        title: 'Cam Ayakkabıcı',
        author: 'Anonim',
        category: 'Modern Masallar',
        isPreloaded: true,
        content:
            '''Bir zamanlar uzak bir ülkede, camdan ayakkabılar yapan yaşlı bir usta varmış. Ne kadar güzel işler yapsa da kimse onları almazmış çünkü herkes bu ayakkabıların kolayca kırılacağından korkarmış.

Bir gün, yağmurlu bir gecede dükkâna bir kadın girmiş. Üstü başı ıslak ama gözleri parlıyormuş. "Ayaklarım için bir çift umut arıyorum" demiş.

Usta, en güzel çiftini çıkarmış. Kadın giydiğinde ayakkabılar parlamış, ama kırılmamış. O gece kadın dans ederek uzaklaşmış.

Ertesi sabah herkes onu konuşuyormuş. "Cam ayakkabılarla fırtınada yürümüş ama tek bir çatlak olmamış!" demişler. O günden sonra herkes ayakkabıcıya gelmiş.

Usta artık sadece ayakkabı değil, insanların umutlarını da yeniden camdan işliyormuş. Çünkü herkes anlamıştı ki, kırılgan olan şey bazen en dayanıklısıdır.''',
      ),
    ];

    for (final story in preloadedStories) {
      await box.add(story);
    }
  }

  static Future<List<Story>> getAllStories() async {
    final box = await _getBox();
    return box.values.toList();
  }

  static Future<List<Story>> getStoriesByCategory(String category) async {
    final box = await _getBox();
    return box.values.where((story) => story.category == category).toList();
  }

  static Future<List<String>> getAllCategories() async {
    final stories = await getAllStories();
    final categories = stories.map((story) => story.category).toSet().toList();
    categories.sort();
    return categories;
  }

  static Future<Story?> getStoryById(String id) async {
    final box = await _getBox();
    try {
      return box.values.firstWhere((story) => story.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> deleteStory(String id) async {
    final box = await _getBox();
    try {
      final storyToDelete = box.values.firstWhere((story) => story.id == id);
      await storyToDelete.delete();
    } catch (e) {
      throw Exception('Story not found');
    }
  }

  static Future<int> getTotalWordCount() async {
    final stories = await getAllStories();
    return stories.fold<int>(0, (sum, story) => sum + story.wordCount);
  }

  static Future<Map<String, dynamic>> getStatistics() async {
    final stories = await getAllStories();
    return {
      'totalStories': stories.length,
      'totalWordCount':
          stories.fold<int>(0, (sum, story) => sum + story.wordCount),
      'totalReadingTime': stories.fold<int>(
          0, (sum, story) => sum + story.estimatedReadingTimeMinutes),
      'categoriesCount': stories.map((story) => story.category).toSet().length,
      'preloadedStories': stories.where((story) => story.isPreloaded).length,
    };
  }
}
