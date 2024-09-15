import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), 
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    // Contoh validasi dengan username dan password hard-coded
    if (_usernameController.text == 'admin' && _passwordController.text == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), 
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], 
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login', 
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _login,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final double buttonWidth = 150;
  final double buttonHeight = 120;
  final double fontSize = 14;

  final List<MenuItemData> menuItems = [
    MenuItemData('User Profile', ProfilPenggunaPage(), Icons.person),
    MenuItemData('Registration', PendaftaranPage(), Icons.app_registration),
    MenuItemData('Medicine Alarm', AlarmObatPage(), Icons.alarm),
    MenuItemData('Input Bundle Medicine', InputBundleObatPage(), Icons.medical_services),
    MenuItemData('Drug Level Calculation', PerhitunganKadarObatPage(), Icons.calculate),
    MenuItemData('Food Recommendations', RekomendasiMakananPage(), Icons.restaurant_menu),
    MenuItemData('Medication History', RiwayatObatPage(), Icons.history),
    MenuItemData('Logout', null, Icons.logout), 
  ];

  void _handleMenuItem(BuildContext context, MenuItemData menuItem) {
    if (menuItem.title == 'Logout') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else if (menuItem.page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => menuItem.page!),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              TimeOfDay.now().format(context),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Medication Management App',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[500],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: buttonWidth / buttonHeight,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return _buildMenuButton(context, menuItems[index]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, MenuItemData menuItem) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
        ),
        onPressed: () => _handleMenuItem(context, menuItem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(menuItem.icon, size: 40),
            SizedBox(height: 8),
            Text(
              menuItem.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItemData {
  final String title;
  final Widget? page;
  final IconData icon;

  MenuItemData(this.title, this.page, this.icon);
}

class ProfilPenggunaPage extends StatefulWidget {
  @override
  _ProfilPenggunaPageState createState() => _ProfilPenggunaPageState();
}

class _ProfilPenggunaPageState extends State<ProfilPenggunaPage> {
  final TextEditingController _namaObatController = TextEditingController();
  final TextEditingController _dosisController = TextEditingController();
  final TextEditingController _frekuensiController = TextEditingController();
  final List<Map<String, String>> _riwayatMedis = [];

  @override
  void dispose() {
    _namaObatController.dispose();
    _dosisController.dispose();
    _frekuensiController.dispose();
    super.dispose();
  }

  void _tambahRiwayatMedis() {
    setState(() {
      _riwayatMedis.add({
        'namaObat': _namaObatController.text,
        'dosis': _dosisController.text,
        'frekuensi': _frekuensiController.text,
      });
      _namaObatController.clear();
      _dosisController.clear();
      _frekuensiController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Name: John Doe', style: TextStyle(fontSize: 18)),
                      Text('Age: 30 years', style: TextStyle(fontSize: 18)),
                      Text('Gender: Male', style: TextStyle(fontSize: 18)),
                      Text('Address: Jl. Example No. 123', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Medical Input', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Column( // Changed to Column to center
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _namaObatController,
                            decoration: InputDecoration(labelText: 'Medicine Name'),
                          ),
                          SizedBox(height: 8), // Added space between TextFields
                          TextField(
                            controller: _dosisController,
                            decoration: InputDecoration(labelText: 'Dosage'),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: _frekuensiController,
                            decoration: InputDecoration(labelText: 'Usage Frequency'),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            child: Text('Add Medical History'),
                            onPressed: _tambahRiwayatMedis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Medical History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _riwayatMedis.length,
                        itemBuilder: (context, index) {
                          final riwayat = _riwayatMedis[index];
                          return ListTile(
                            title: Text(riwayat['namaObat'] ?? ''),
                            subtitle: Text('Dosage: ${riwayat['dosis']}, Frequency: ${riwayat['frekuensi']}'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PendaftaranPage extends StatefulWidget {
  @override
  _PendaftaranPageState createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _umurController.dispose();
    _jenisKelaminController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _umurController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jenisKelaminController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Register'),
              onPressed: () {
                // Registration logic will be added here
                print('Name: ${_namaController.text}');
                print('Age: ${_umurController.text}');
                print('Gender: ${_jenisKelaminController.text}');
                print('Address: ${_alamatController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InputMedisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medical Input')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Medicine Name')),
            TextField(decoration: InputDecoration(labelText: 'Dosage')),
            TextField(decoration: InputDecoration(labelText: 'Usage Frequency')),
            TextField(decoration: InputDecoration(labelText: 'Start Date')),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                // Medical data saving logic will be added here
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlarmObatPage extends StatefulWidget {
  @override
  _AlarmObatPageState createState() => _AlarmObatPageState();
}

class _AlarmObatPageState extends State<AlarmObatPage> {
  List<AlarmObat> alarms = [];
  TextEditingController _namaObatController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _namaObatController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _addAlarm() {
    if (_namaObatController.text.isNotEmpty) {
      setState(() {
        alarms.add(AlarmObat(
          namaObat: _namaObatController.text,
          waktu: _selectedTime,
        ));
        _namaObatController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _namaObatController,
              decoration: InputDecoration(labelText: 'Medicine Name'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Time: ${_selectedTime.format(context)}'),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addAlarm,
              child: Text('Add Alarm'),
            ),
            SizedBox(height: 24),
            Text(
              'Alarm List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  final alarm = alarms[index];
                  return ListTile(
                    title: Text(alarm.namaObat),
                    subtitle: Text('Time: ${alarm.waktu.format(context)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          alarms.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlarmObat {
  final String namaObat;
  final TimeOfDay waktu;

  AlarmObat({required this.namaObat, required this.waktu});
}

class InputBundleObatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Bundle Medicine')),
      body: Center(child: Text('Input Bundle Medicine Page')),
    );
  }
}

class PerhitunganKadarObatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drug Level Calculation')),
      body: Center(child: Text('Drug Level Calculation Page')),
    );
  }
}

class RekomendasiMakananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Recommendations')),
      body: Center(child: Text('Food Recommendations Page')),
    );
  }
}

class RiwayatObatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medication History')),
      body: Center(child: Text('Medication History Page')),
    );
  }
}
