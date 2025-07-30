import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup_coffe_case/data/entity/coupon.dart';

class AdminCouponPage extends StatefulWidget {
  const AdminCouponPage({Key? key}) : super(key: key);

  @override
  State<AdminCouponPage> createState() => _AdminCouponPageState();
}

class _AdminCouponPageState extends State<AdminCouponPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _discountController = TextEditingController();
  final _minimumAmountController = TextEditingController();
  DateTime _expiryDate = DateTime.now().add(Duration(days: 30));
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kupon Oluştur'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Kupon Kodu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kupon kodu gerekli';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _discountController,
                decoration: InputDecoration(
                  labelText: 'İndirim Miktarı (TL)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'İndirim miktarı gerekli';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Geçerli bir sayı girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _minimumAmountController,
                decoration: InputDecoration(
                  labelText: 'Minimum Tutar (TL)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Minimum tutar gerekli';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Geçerli bir sayı girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Bitiş Tarihi'),
                subtitle: Text('${_expiryDate.day}/${_expiryDate.month}/${_expiryDate.year}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _expiryDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _expiryDate = date;
                    });
                  }
                },
              ),
              SwitchListTile(
                title: Text('Aktif'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _createCoupon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Kupon Oluştur'),
              ),
              SizedBox(height: 24),
              Text(
                'Mevcut Kuponlar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('coupons').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Hata: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    
                    final coupons = snapshot.data?.docs ?? [];
                    
                    return ListView.builder(
                      itemCount: coupons.length,
                      itemBuilder: (context, index) {
                        final coupon = coupons[index].data() as Map<String, dynamic>;
                        final couponId = coupons[index].id;
                        
                        return Card(
                          child: ListTile(
                            title: Text('${coupon['code']} - ${coupon['discount']} TL'),
                            subtitle: Text('Min: ${coupon['minimumAmount']} TL'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteCoupon(couponId),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createCoupon() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('coupons').add({
          'code': _codeController.text.toUpperCase(),
          'discount': int.parse(_discountController.text),
          'minimumAmount': double.parse(_minimumAmountController.text),
          'isActive': _isActive,
          'expiryDate': Timestamp.fromDate(_expiryDate),
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kupon başarıyla oluşturuldu!')),
        );
        
        _formKey.currentState!.reset();
        _codeController.clear();
        _discountController.clear();
        _minimumAmountController.clear();
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }

  void _deleteCoupon(String couponId) async {
    try {
      await FirebaseFirestore.instance.collection('coupons').doc(couponId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kupon silindi!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }
} 