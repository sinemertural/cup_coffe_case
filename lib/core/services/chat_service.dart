import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatService {
  Future<String> sendMessage(String message) async {
    try {
      print('🔄 API çağrısı başlatılıyor...');
      print('📝 Gönderilen mesaj: $message');

      await Future.delayed(Duration(milliseconds: 800));
      
      final userMessage = message.toLowerCase();

      if (userMessage.contains('merhaba') || userMessage.contains('selam')) {
        return 'Merhaba! Kahve dükkanımıza hoş geldiniz. Size nasıl yardımcı olabilirim? Hangi konuda bilgi almak istiyorsunuz?';
      }
      
      if (userMessage.contains('fiyat') || userMessage.contains('ne kadar')) {
        return 'Kahvelerimizin fiyatları şöyle:\n• Espresso: 15 TL\n• Latte: 25 TL\n• Cappuccino: 22 TL\n• Americano: 18 TL\n• Mocha: 28 TL\n\nHangi kahveyi denemek istersiniz?';
      }
      
      if (userMessage.contains('saat') || userMessage.contains('açık')) {
        return 'Dükkanımızın çalışma saatleri:\n\n🕐 Hafta içi: 08:00 - 22:00\n🕐 Hafta sonu: 09:00 - 23:00\n🕐 Pazartesi: 09:00 - 21:00\n\nÖzel günlerde saatler değişebilir.';
      }
      
      if (userMessage.contains('sipariş') || userMessage.contains('nasıl sipariş')) {
        return 'Sipariş vermek çok kolay:\n\n1️⃣ Ana sayfadan istediğiniz ürünü seçin\n2️⃣ Sepete ekleyin\n3️⃣ Adresinizi girin\n4️⃣ Ödeme yapın\n\nSiparişiniz 30-45 dakika içinde elinizde!';
      }
      
      if (userMessage.contains('teslimat') || userMessage.contains('ne kadar sürer')) {
        return 'Teslimat sürelerimiz:\n\n🚚 Şehir içi: 30-45 dakika\n🚚 Şehir dışı: 45-60 dakika\n🚚 Yoğun saatlerde: +15 dakika\n\nMinimum sipariş tutarı: 50 TL';
      }
      
      if (userMessage.contains('menü') || userMessage.contains('ne var')) {
        return 'Menümüzde şunlar var:\n\n☕ Sıcak İçecekler:\n• Espresso, Latte, Cappuccino\n• Americano, Mocha, Macchiato\n\n🍰 Tatlılar:\n• Cheesecake, Tiramisu\n• Brownie, Muffin\n\n🥪 Yiyecekler:\n• Sandviç, Tost\n• Salata, Çorba';
      }
      
      if (userMessage.contains('teşekkür') || userMessage.contains('sağol')) {
        return 'Rica ederim! Başka bir sorunuz varsa yardımcı olmaktan mutluluk duyarım. İyi günler! 😊';
      }
      
      if (userMessage.contains('kupon') || userMessage.contains('indirim')) {
        return 'Kuponlarımız:\n\n🎫 İlk sipariş: %20 indirim\n🎫 100 TL üzeri: %10 indirim\n🎫 Öğrenci: %15 indirim\n🎫 Doğum günü: %25 indirim\n\nKupon kodlarını profil sayfanızdan görebilirsiniz!';
      }
      
      if (userMessage.contains('iletişim') || userMessage.contains('telefon')) {
        return 'İletişim bilgilerimiz:\n\n📞 Telefon: 0212 555 0123\n📧 E-posta: info@kahvedukkani.com\n📍 Adres: İstiklal Caddesi No:123\n🌐 Web: www.kahvedukkani.com\n\n7/24 hizmetinizdeyiz!';
      }
      
      // Genel yanıt
      return 'Anlıyorum! Size daha iyi yardımcı olabilmem için şunları sorabilirsiniz:\n\n• Fiyatlar hakkında\n• Çalışma saatleri\n• Sipariş verme\n• Teslimat süreleri\n• Menü\n• Kuponlar\n• İletişim bilgileri\n\nHangi konuda bilgi almak istiyorsunuz?';
      

    } catch (e) {
      print('❌ Exception hatası: $e');
      return 'Bir hata oluştu. Lütfen internet bağlantınızı kontrol edin.';
    }
  }
}