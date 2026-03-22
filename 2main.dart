pp unificada v2 · DART
Copiar

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigator(),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// NAVEGACIÓN PRINCIPAL
// ═══════════════════════════════════════════════════════════════════
class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}
 
class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;
 
  final List<Widget> _pages = [
    PetDashboard(),
    ClinicDashboard(),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[500],
        backgroundColor: Colors.white,
        elevation: 12,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle: TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            activeIcon: Icon(Icons.pets),
            label: 'Mi Mascota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            activeIcon: Icon(Icons.local_hospital),
            label: 'Clínica',
          ),
        ],
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// ──────────────────────────────────────────────────────────────────
//  SECCIÓN 1 — PET DASHBOARD  (Ana Pérez / Linda)
// ──────────────────────────────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════════
 
class PetOwner {
  final String fullName, email, phone, city, birthDate, memberSince;
  final String petName, petBreed, petAge, petColor, petWeight, petBirthDate;
  final String vetName, nextVetAppointment;
 
  PetOwner({
    required this.fullName, required this.email, required this.phone,
    required this.city, required this.birthDate, required this.memberSince,
    required this.petName, required this.petBreed, required this.petAge,
    required this.petColor, required this.petWeight, required this.petBirthDate,
    required this.vetName, required this.nextVetAppointment,
  });
}
 
final PetOwner currentOwner = PetOwner(
  fullName: 'Ana Pérez',           email: 'ana.perez@gmail.com',
  phone: '+57 310 555 8821',       city: 'quilla, Colombia',
  birthDate: '8 de junio, 1992',   memberSince: 'Enero 2022',
  petName: 'Linda',                petBreed: 'Labrador Negra',
  petAge: '3 años',                petColor: 'Negra',
  petWeight: '25.5 kg',            petBirthDate: '12 de marzo, 2022',
  vetName: 'Dr. Jose buitrago',    nextVetAppointment: '11 de Abril, 10:00 AM',
);
 
class ActivityCardData {
  final String name, value, unit, icon;
  final Color color;
  ActivityCardData({required this.name, required this.value,
      required this.unit, required this.icon, required this.color});
}
 
final List<List<ActivityCardData>> activityPages = [
  [
    ActivityCardData(name: "Today's Walks",     value: "3",   unit: "Walks",     icon: "🦮", color: Colors.purple),
    ActivityCardData(name: "Minutes Played",    value: "45",  unit: "Min",       icon: "🎾", color: Colors.green),
    ActivityCardData(name: "Food Servings",     value: "5",   unit: "Servings",  icon: "🍖", color: Colors.orange),
  ],
  [
    ActivityCardData(name: "Training Sessions", value: "2",   unit: "Sessions",  icon: "🏋️", color: Colors.blue),
    ActivityCardData(name: "Calories Burned",   value: "320", unit: "kcal",      icon: "🔥", color: Colors.red),
    ActivityCardData(name: "Water Intake",      value: "1.2", unit: "Litros",    icon: "💧", color: Colors.teal),
  ],
  [
    ActivityCardData(name: "Sleep Time",        value: "8",   unit: "Horas",     icon: "😴", color: Colors.pink),
    ActivityCardData(name: "Baño / Aseo",       value: "1",   unit: "Sesión",    icon: "🛁", color: Colors.amber),
    ActivityCardData(name: "Obediencia",        value: "4",   unit: "Ejercicios",icon: "🎯", color: Colors.indigo),
  ],
];
 
class PetDashboard extends StatefulWidget {
  @override
  _PetDashboardState createState() => _PetDashboardState();
}
 
class _PetDashboardState extends State<PetDashboard>
    with SingleTickerProviderStateMixin {
 
  late AnimationController _controller;
  late Animation<double>  _fadeAnimation;
  late Animation<Offset>  _slideAnimation;
  final PageController _pageController = PageController();
  int _currentPage = 0;
 
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _fadeAnimation  = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }
 
  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }
 
  void _handleScroll(PointerScrollEvent event) {
    final delta = event.scrollDelta.dy != 0 ? event.scrollDelta.dy : event.scrollDelta.dx;
    if (delta > 0 && _currentPage < activityPages.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else if (delta < 0 && _currentPage > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
 
                // ── HEADER ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Hola ${currentOwner.fullName.split(' ')[0]} 👋',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('Sigamos el progreso de ${currentOwner.petName}',
                            style: TextStyle(color: Colors.grey[700])),
                      ]),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => PetOwnerProfileScreen(owner: currentOwner))),
                        child: Stack(children: [
                          Container(
                            width: 54, height: 54,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.orange, Colors.deepOrange],
                                begin: Alignment.topLeft, end: Alignment.bottomRight,
                              ),
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.4),
                                  blurRadius: 10, offset: Offset(0, 2))],
                            ),
                            child: Center(child: Text('🐶', style: TextStyle(fontSize: 26))),
                          ),
                          Positioned(bottom: 2, right: 2,
                            child: Container(width: 13, height: 13,
                              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2)))),
                        ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Actividad de ${currentOwner.petName}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
 
                // ── PAGEVIEW ACTIVIDAD ───────────────────────────────
                SizedBox(
                  height: 148,
                  child: Listener(
                    onPointerSignal: (event) {
                      if (event is PointerScrollEvent) _handleScroll(event);
                    },
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity == null) return;
                        if (details.primaryVelocity! < -300 && _currentPage < activityPages.length - 1) {
                          _pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
                        } else if (details.primaryVelocity! > 300 && _currentPage > 0) {
                          _pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
                        }
                      },
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: activityPages.length,
                        onPageChanged: (p) => setState(() => _currentPage = p),
                        itemBuilder: (context, pageIndex) {
                          final cards = activityPages[pageIndex];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: cards.asMap().entries.map((e) => Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: e.key < cards.length - 1 ? 8 : 0),
                                  child: ActivityCard(data: e.value),
                                ),
                              )).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
 
                // DOTS actividad
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(activityPages.length, (i) {
                    final isActive = _currentPage == i;
                    return GestureDetector(
                      onTap: () => _pageController.animateToPage(i,
                          duration: Duration(milliseconds: 350), curve: Curves.easeInOut),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
                        width: isActive ? 18 : 7, height: 7,
                        decoration: BoxDecoration(
                          color: isActive ? Colors.orange : Colors.grey[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Monitoreo de Salud',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
 
                // ── HEALTH LIST ──────────────────────────────────────
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      HealthCard(title: "Medicación",          main: "Dada: 7:30 AM",  extra: "✅ Completado", icon: "💊", color: Colors.green),
                      HealthCard(title: "Peso",                main: "25.5 kg",         extra: "📈 +0.5 kg",    icon: "⚖️", color: Colors.orange),
                      HealthCard(title: "Frecuencia Cardíaca", main: "120 bpm",         extra: "💓 Normal",      icon: "❤️", color: Colors.red),
                      HealthCard(title: "Consumo de Agua",     main: "1.2 L",           extra: "🌊 Bien",        icon: "💧", color: Colors.blue),
                      HealthCard(title: "Tiempo de Sueño",     main: "8 horas",         extra: "🌙 Saludable",   icon: "😴", color: Colors.purple),
                      HealthCard(title: "Temperatura",         main: "38.5 °C",         extra: "✔️ Normal",      icon: "🌡️", color: Colors.teal),
                      HealthCard(title: "Vacunas",             main: "Al día",          extra: "🛡️ Protegida",   icon: "💉", color: Colors.pink),
                      HealthCard(title: "Estado de Ánimo",     main: "Muy feliz",       extra: "🐾 Excelente",   icon: "😊", color: Colors.amber),
                      HealthCard(title: "Salud Dental",        main: "Cepillado hoy",   extra: "✨ Limpio",       icon: "🦷", color: Colors.blue),
                      HealthCard(title: "Próxima Cita Vet",    main: "15 de Abril",     extra: "📅 Agendada",    icon: "🏥", color: Colors.purple),
                    ],
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
 
// ActivityCard
class ActivityCard extends StatelessWidget {
  final ActivityCardData data;
  const ActivityCard({required this.data});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: data.color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(data.icon, style: TextStyle(fontSize: 22)),
        SizedBox(height: 4),
        Text(data.name, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600,
                color: Colors.grey[700], letterSpacing: 0.3)),
        Padding(padding: EdgeInsets.symmetric(vertical: 3),
            child: Divider(thickness: 1, color: Colors.black12, indent: 8, endIndent: 8)),
        Text(data.value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[900])),
        Text(data.unit, style: TextStyle(fontSize: 9, color: Colors.grey[600])),
      ]),
    );
  }
}
 
// HealthCard
class HealthCard extends StatelessWidget {
  final String title, main, extra, icon;
  final Color color;
 
  const HealthCard({required this.title, required this.main,
      required this.extra, required this.icon, required this.color});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => HealthDetailScreen(title: title, value: main, icon: icon, color: color))),
      child: Hero(
        tag: 'pet_$title',
        child: Card(
          margin: EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color.withOpacity(0.15),
                child: Text(icon, style: TextStyle(fontSize: 20))),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            subtitle: Text(main, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            trailing: Text(extra, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ),
      ),
    );
  }
}
 
// HealthDetailScreen
class HealthDetailScreen extends StatelessWidget {
  final String title, value, icon;
  final Color color;
 
  const HealthDetailScreen({required this.title, required this.value,
      required this.icon, required this.color});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.white,
          foregroundColor: Colors.black, elevation: 0.5),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(icon, style: TextStyle(fontSize: 60)),
          SizedBox(height: 20),
          Hero(
            tag: 'pet_$title',
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 52),
              decoration: BoxDecoration(color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(value, style: TextStyle(fontSize: 40,
                  fontWeight: FontWeight.bold, color: color)),
            ),
          ),
        ]),
      ),
    );
  }
}
 
// PetOwnerProfileScreen
class PetOwnerProfileScreen extends StatelessWidget {
  final PetOwner owner;
  const PetOwnerProfileScreen({required this.owner});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200, pinned: true, backgroundColor: Colors.orange,
          title: Text('Mi Perfil', style: TextStyle(color: Colors.white, fontSize: 16)),
          titleSpacing: 0,
          leading: IconButton(
            icon: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.25),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 18)),
            onPressed: () => Navigator.pop(context)),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.zero,
            background: Stack(fit: StackFit.expand, children: [
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                    begin: Alignment.topLeft, end: Alignment.bottomRight))),
              Positioned(bottom: 16, left: 0, right: 0,
                child: Column(children: [
                  Stack(alignment: Alignment.bottomRight, children: [
                    Container(width: 80, height: 80,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: Center(child: Text('🐾', style: TextStyle(fontSize: 36)))),
                    Container(width: 22, height: 22,
                      decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2))),
                  ]),
                  SizedBox(height: 8),
                  Text(owner.fullName, style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 2),
                  Text('Dueña de ${owner.petName} 🖤',
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.85))),
                ])),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(children: [
              Text('📍 ${owner.city}', style: TextStyle(fontSize: 12,
                  color: Colors.orange, fontWeight: FontWeight.w600)),
              SizedBox(height: 16),
              Row(children: [
                _sbox('3',     'Años con Linda'), SizedBox(width: 10),
                _sbox('47',    'Visitas al vet'), SizedBox(width: 10),
                _sbox('4.8⭐', 'Calificación'),
              ]),
              SizedBox(height: 16),
              _isec('Información Personal', [
                _IT('👤', 'Nombre completo',    owner.fullName),
                _IT('🎂', 'Fecha de nacimiento', owner.birthDate),
                _IT('📍', 'Ciudad',             owner.city),
                _IT('📅', 'Miembro desde',      owner.memberSince),
              ]),
              SizedBox(height: 12),
              _isec('Contacto', [
                _IT('📧', 'Correo electrónico', owner.email,  arrow: true),
                _IT('📱', 'Teléfono',           owner.phone,  arrow: true),
              ]),
              SizedBox(height: 12),
              _petSection(owner),
              SizedBox(height: 12),
              _isec('Veterinario', [
                _IT('👨‍⚕️', 'Veterinario', owner.vetName),
                _IT('📅',   'Próxima cita', owner.nextVetAppointment, arrow: true),
              ]),
              SizedBox(height: 20),
              SizedBox(width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.logout, color: Colors.red),
                  label: Text('Cerrar Sesión', style: TextStyle(color: Colors.red, fontSize: 15)),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                )),
              SizedBox(height: 24),
            ])),
        ),
      ]),
    );
  }
 
  Widget _sbox(String v, String l) => Expanded(
    child: Container(padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(l, style: TextStyle(fontSize: 9, color: Colors.grey[600]), textAlign: TextAlign.center),
      ])));
 
  Widget _isec(String title, List<_IT> tiles) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 10),
      ...tiles.map((t) => Padding(padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Text(t.icon, style: TextStyle(fontSize: 16)), SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            SizedBox(height: 2),
            Text(t.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[900])),
          ])),
          if (t.arrow) Icon(Icons.chevron_right, size: 18, color: Colors.grey[400]),
        ]))).toList(),
    ]));
 
  Widget _petSection(PetOwner o) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('MI MASCOTA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 12),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Container(width: 64, height: 64,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[900],
                border: Border.all(color: Colors.orange, width: 2.5)),
            child: Center(child: Text('🐕‍🦺', style: TextStyle(fontSize: 30)))),
          SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('Linda', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
                child: Text('● Negra', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w500))),
            ]),
            SizedBox(height: 3),
            Text(o.petBreed, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            SizedBox(height: 6),
            Row(children: [
              _pchip('🎂', o.petAge), SizedBox(width: 6), _pchip('⚖️', o.petWeight),
            ]),
          ])),
        ]),
      ),
      SizedBox(height: 12),
      Divider(height: 1, color: Colors.grey[200]),
      SizedBox(height: 12),
      _prow('🐾', 'Nombre',             'Linda'),
      _prow('🎂', 'Fecha de nacimiento', o.petBirthDate),
      _prow('⚖️', 'Peso actual',         o.petWeight),
      _prow('🎨', 'Color de pelaje',     o.petColor),
      _prow('📏', 'Edad',                o.petAge),
    ]));
 
  Widget _pchip(String icon, String label) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
    child: Text('$icon $label', style: TextStyle(fontSize: 10, color: Colors.orange.shade800, fontWeight: FontWeight.w500)));
 
  Widget _prow(String icon, String label, String value) => Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Row(children: [
      Text(icon, style: TextStyle(fontSize: 15)), SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[900])),
      ])),
    ]));
}
 
class _IT {
  final String icon, label, value;
  final bool arrow;
  _IT(this.icon, this.label, this.value, {this.arrow = false});
}
 
// ═══════════════════════════════════════════════════════════════════
// ──────────────────────────────────────────────────────────────────
//  SECCIÓN 2 — CLINIC DASHBOARD  (Dr. Jose Martínez)
// ──────────────────────────────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════════
 
class DoctorUser {
  final String fullName, role, clinicName, birthDate, licenseId, university;
  final String email, phone, city, scheduleWeekdays, scheduleSaturday;
  final String specialtyMain, specialtySecondary, certification;
  final int totalPatients, yearsExperience;
  final double rating;
 
  DoctorUser({
    required this.fullName, required this.role, required this.clinicName,
    required this.birthDate, required this.licenseId, required this.university,
    required this.email, required this.phone, required this.city,
    required this.scheduleWeekdays, required this.scheduleSaturday,
    required this.specialtyMain, required this.specialtySecondary,
    required this.certification, required this.totalPatients,
    required this.yearsExperience, required this.rating,
  });
}
 
class Patient {
  final String name, breed, age, weight, photoUrl, status;
  final Color statusColor;
  final String condition;
  final IconData conditionIcon;
  final Color conditionColor;
  final String nextAppointment, appointmentType, temperature, heartRate, lastUpdate, ownerName;
 
  Patient({
    required this.name, required this.breed, required this.age,
    required this.weight, required this.photoUrl, required this.status,
    required this.statusColor, required this.condition,
    required this.conditionIcon, required this.conditionColor,
    required this.nextAppointment, required this.appointmentType,
    required this.temperature, required this.heartRate,
    required this.lastUpdate, required this.ownerName,
  });
}
 
class SummaryItem {
  final String label, value, icon;
  final Color color;
  final String stat1Label, stat1Value, stat2Label, stat2Value, stat3Label, stat3Value;
 
  SummaryItem({
    required this.label, required this.value, required this.icon, required this.color,
    required this.stat1Label, required this.stat1Value,
    required this.stat2Label, required this.stat2Value,
    required this.stat3Label, required this.stat3Value,
  });
}
 
final DoctorUser currentDoctor = DoctorUser(
  fullName: 'Dr. Jose Martínez Rivas',
  role: 'Médico Veterinario — Especialista en Pequeños Animales',
  clinicName: 'Clínica Veterinaria San José',
  birthDate: '15 de marzo, 1985',
  licenseId: 'MV-2847-COL',
  university: 'Univ. Nacional de Colombia',
  email: 'jose.martinez@clinica.com',
  phone: '+57 311 428 9901',
  city: 'Barranquilla, Colombia',
  scheduleWeekdays: '7:00 AM — 5:00 PM',
  scheduleSaturday: '8:00 AM — 1:00 PM',
  specialtyMain: 'Medicina interna canina',
  specialtySecondary: 'Diagnóstico por imagen',
  certification: 'WSAVA 2019 — Bangkok',
  totalPatients: 247,
  yearsExperience: 12,
  rating: 4.9,
);
 
final List<Patient> patients = [
  Patient(
    name: 'Luna', breed: 'Golden Retriever', age: '3 años', weight: '28 kg',
    photoUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=600&h=400&fit=crop',
    status: 'Urgente', statusColor: Colors.red,
    condition: 'Fiebre y vómitos', conditionIcon: Icons.sick, conditionColor: Colors.red,
    nextAppointment: 'Hoy, 3:00 PM', appointmentType: 'Consulta urgente',
    temperature: '39.8 °C', heartRate: '110 bpm',
    lastUpdate: 'Hace 20 min', ownerName: 'María López',
  ),
  Patient(
    name: 'Max', breed: 'Labrador', age: '2 años', weight: '32 kg',
    photoUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=600&h=400&fit=crop',
    status: 'Estable', statusColor: Colors.green,
    condition: 'Vacunación anual', conditionIcon: Icons.vaccines, conditionColor: Colors.blue,
    nextAppointment: 'Hoy, 5:00 PM', appointmentType: 'Vacunación',
    temperature: '38.2 °C', heartRate: '95 bpm',
    lastUpdate: 'Hace 1 hora', ownerName: 'Carlos Pérez',
  ),
  Patient(
    name: 'Coco', breed: 'Beagle', age: '4 años', weight: '12 kg',
    photoUrl: 'https://images.unsplash.com/photo-1558788353-f76d92427f16?w=600&h=400&fit=crop',
    status: 'En observación', statusColor: Colors.orange,
    condition: 'Pérdida de apetito', conditionIcon: Icons.warning, conditionColor: Colors.orange,
    nextAppointment: 'Mañana, 10:00 AM', appointmentType: 'Seguimiento',
    temperature: '38.5 °C', heartRate: '88 bpm',
    lastUpdate: 'Hace 2 horas', ownerName: 'Ana Gómez',
  ),
  Patient(
    name: 'Rocky', breed: 'Bulldog Francés', age: '5 años', weight: '14 kg',
    photoUrl: 'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?w=600&h=400&fit=crop',
    status: 'Estable', statusColor: Colors.green,
    condition: 'Control de peso', conditionIcon: Icons.monitor_weight, conditionColor: Colors.purple,
    nextAppointment: 'Mañana, 2:00 PM', appointmentType: 'Control rutina',
    temperature: '38.0 °C', heartRate: '92 bpm',
    lastUpdate: 'Hace 3 horas', ownerName: 'Pedro Ruiz',
  ),
  Patient(
    name: 'Bella', breed: 'Poodle', age: '1 año', weight: '6 kg',
    photoUrl: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?w=600&h=400&fit=crop',
    status: 'Estable', statusColor: Colors.green,
    condition: 'Seguimiento medicación', conditionIcon: Icons.medication, conditionColor: Colors.teal,
    nextAppointment: 'Jue, 11:00 AM', appointmentType: 'Control medicación',
    temperature: '38.3 °C', heartRate: '100 bpm',
    lastUpdate: 'Hace 4 horas', ownerName: 'Laura Torres',
  ),
  Patient(
    name: 'Thor', breed: 'Pastor Alemán', age: '6 años', weight: '35 kg',
    photoUrl: 'https://images.unsplash.com/photo-1561037404-61cd46aa615b?w=600&h=400&fit=crop',
    status: 'Post-cirugía', statusColor: Colors.red,
    condition: 'Revisión post-cirugía', conditionIcon: Icons.healing, conditionColor: Colors.red,
    nextAppointment: 'Vie, 9:00 AM', appointmentType: 'Revisión cirugía',
    temperature: '38.7 °C', heartRate: '105 bpm',
    lastUpdate: 'Hace 5 horas', ownerName: 'Jorge Díaz',
  ),
];
 
// 3 páginas × 3 cards = una card por fila, 3 filas por página
final List<List<SummaryItem>> summaryPages = [
  [
    SummaryItem(label:'Citas',          value:'5',  icon:'🔔', color:Colors.blue,       stat1Label:'Pendientes',  stat1Value:'3',  stat2Label:'Completadas',  stat2Value:'2',  stat3Label:'Canceladas',   stat3Value:'0'),
    SummaryItem(label:'Hospitalizados', value:'3',  icon:'🏠', color:Colors.green,      stat1Label:'En UCI',      stat1Value:'1',  stat2Label:'Estables',     stat2Value:'2',  stat3Label:'De alta hoy',  stat3Value:'1'),
    SummaryItem(label:'Tareas',         value:'7',  icon:'📋', color:Colors.purple,     stat1Label:'Urgentes',    stat1Value:'2',  stat2Label:'Normales',     stat2Value:'5',  stat3Label:'Completadas',  stat3Value:'8'),
  ],
  [
    SummaryItem(label:'Laboratorio',    value:'9',  icon:'🧬', color:Colors.indigo,     stat1Label:'En proceso',  stat1Value:'4',  stat2Label:'Listos',       stat2Value:'5',  stat3Label:'Urgentes',     stat3Value:'2'),
    SummaryItem(label:'Radiografías',   value:'3',  icon:'🩻', color:Colors.deepOrange, stat1Label:'Revisadas',   stat1Value:'2',  stat2Label:'Pendientes',   stat2Value:'1',  stat3Label:'Archivadas',   stat3Value:'6'),
    SummaryItem(label:'Camas Disp.',    value:'5',  icon:'🛏️', color:Colors.pink,       stat1Label:'Ocupadas',    stat1Value:'7',  stat2Label:'Limpieza',     stat2Value:'1',  stat3Label:'Total',        stat3Value:'13'),
  ],
  [
    SummaryItem(label:'Perros',         value:'18', icon:'🐕', color:Colors.amber,      stat1Label:'Activos',     stat1Value:'15', stat2Label:'Alta',         stat2Value:'2',  stat3Label:'Críticos',     stat3Value:'1'),
    SummaryItem(label:'Gatos',          value:'7',  icon:'🐈', color:Colors.pink,       stat1Label:'Activos',     stat1Value:'6',  stat2Label:'Alta',         stat2Value:'1',  stat3Label:'Críticos',     stat3Value:'0'),
    SummaryItem(label:'Otros',          value:'4',  icon:'🐇', color:Colors.teal,       stat1Label:'Conejos',     stat1Value:'2',  stat2Label:'Aves',         stat2Value:'1',  stat3Label:'Reptiles',     stat3Value:'1'),
  ],
];
 
class ClinicDashboard extends StatefulWidget {
  @override
  _ClinicDashboardState createState() => _ClinicDashboardState();
}
 
class _ClinicDashboardState extends State<ClinicDashboard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
 
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
 
  void _handleWheel(PointerScrollEvent event) {
    final delta = event.scrollDelta.dy != 0 ? event.scrollDelta.dy : event.scrollDelta.dx;
    if (delta > 0 && _currentPage < summaryPages.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else if (delta < 0 && _currentPage > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
 
          // ── HEADER ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Hola Dr. Jose 👨‍⚕️',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Bienvenido a tu clínica veterinaria',
                    style: TextStyle(color: Colors.grey[700])),
              ]),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => DoctorProfileScreen(doctor: currentDoctor))),
                child: Stack(children: [
                  Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.red.shade400],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.4),
                          blurRadius: 10, offset: Offset(0, 2))],
                    ),
                    child: Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 24))),
                  ),
                  Positioned(bottom: 2, right: 2,
                    child: Container(width: 13, height: 13,
                      decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2)))),
                ]),
              ),
            ]),
          ),
          SizedBox(height: 18),
 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Resumen del Día',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
 
          // ── PAGEVIEW RESUMEN — 3 cards por página en filas ────────
          SizedBox(
            height: 190,
            child: Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) _handleWheel(event);
              },
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity == null) return;
                  if (details.primaryVelocity! < -300 && _currentPage < summaryPages.length - 1) {
                    _pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
                  } else if (details.primaryVelocity! > 300 && _currentPage > 0) {
                    _pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
                  }
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: summaryPages.length,
                  onPageChanged: (p) => setState(() => _currentPage = p),
                  itemBuilder: (context, pageIndex) {
                    final items = summaryPages[pageIndex];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: List.generate(items.length, (i) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: i < items.length - 1 ? 8 : 0),
                            child: SummaryCard(
                              item: items[i],
                              onTap: () => Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => SummaryDetailScreen(item: items[i]))),
                            ),
                          ),
                        )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
 
          // DOTS resumen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(summaryPages.length, (i) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(i,
                    duration: Duration(milliseconds: 350), curve: Curves.easeInOut),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                  width: _currentPage == i ? 10 : 7, height: 7,
                  decoration: BoxDecoration(
                    color: _currentPage == i ? Colors.grey[700] : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Pacientes Recientes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
 
          // ── LISTVIEW PACIENTES ───────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: patients.length,
              itemBuilder: (context, i) => PatientCard(
                patient: patients[i],
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => PatientDetailScreen(patient: patients[i]))),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
 
// SummaryCard — fila horizontal: [ícono] [label] [valor] [›]
class SummaryCard extends StatelessWidget {
  final SummaryItem item;
  final VoidCallback? onTap;
  const SummaryCard({required this.item, this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [item.color.withOpacity(0.82), item.color],
            begin: Alignment.centerLeft, end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: item.color.withOpacity(0.30),
              blurRadius: 6, offset: Offset(0, 3))],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        child: Row(children: [
          Container(width: 40, height: 40,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), shape: BoxShape.circle),
            child: Center(child: Text(item.icon, style: TextStyle(fontSize: 19)))),
          SizedBox(width: 14),
          Expanded(child: Text(item.label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white))),
          Text(item.value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
        ]),
      ),
    );
  }
}
 
// PatientCard
class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;
  const PatientCard({required this.patient, required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: 11),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(padding: EdgeInsets.all(13), child: Column(children: [
          Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(25),
              child: Image.network(patient.photoUrl, width: 50, height: 50, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => CircleAvatar(radius: 25,
                    backgroundColor: Colors.orange, child: Icon(Icons.pets, color: Colors.white)))),
            SizedBox(width: 11),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(patient.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(patient.breed, style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              Text('Actualizado ${patient.lastUpdate}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 10)),
            ])),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: patient.statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(patient.status, style: TextStyle(color: patient.statusColor,
                  fontSize: 10, fontWeight: FontWeight.bold))),
          ]),
          SizedBox(height: 8), Divider(height: 1), SizedBox(height: 8),
          Row(children: [
            Icon(Icons.calendar_today, size: 13, color: Colors.blue), SizedBox(width: 5),
            Text('Próxima cita: ${patient.nextAppointment}', style: TextStyle(fontSize: 12)),
          ]),
          SizedBox(height: 4),
          Row(children: [
            Icon(patient.conditionIcon, size: 13, color: patient.conditionColor), SizedBox(width: 5),
            Text(patient.condition, style: TextStyle(fontSize: 12, color: patient.conditionColor)),
          ]),
        ])),
      ),
    );
  }
}
 
// DoctorProfileScreen
class DoctorProfileScreen extends StatelessWidget {
  final DoctorUser doctor;
  const DoctorProfileScreen({required this.doctor});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 210, pinned: true, backgroundColor: Colors.orange,
          leading: IconButton(
            icon: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.25),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 18)),
            onPressed: () => Navigator.pop(context)),
          title: Text('Mi Perfil', style: TextStyle(color: Colors.white, fontSize: 16)),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.zero,
            background: Stack(fit: StackFit.expand, children: [
              Container(decoration: BoxDecoration(gradient: LinearGradient(
                  colors: [Colors.orange, Colors.red.shade400],
                  begin: Alignment.topLeft, end: Alignment.bottomRight))),
              Positioned(bottom: 14, left: 0, right: 0,
                child: Column(children: [
                  Stack(alignment: Alignment.bottomRight, children: [
                    Container(width: 78, height: 78,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Colors.orange.shade300, Colors.red.shade300],
                            begin: Alignment.topLeft, end: Alignment.bottomRight),
                        border: Border.all(color: Colors.white, width: 3.5),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))]),
                      child: Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 36)))),
                    Container(width: 20, height: 20,
                      decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2))),
                  ]),
                  SizedBox(height: 8),
                  Text(doctor.fullName, style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 2),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(doctor.role, textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.85)),
                        maxLines: 2)),
                ])),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(children: [
              Text('🏥 ${doctor.clinicName}', style: TextStyle(fontSize: 12,
                  color: Colors.orange, fontWeight: FontWeight.w600)),
              SizedBox(height: 16),
              Row(children: [
                _ds('${doctor.totalPatients}',   'Pacientes'), SizedBox(width: 10),
                _ds('${doctor.yearsExperience}', 'Años exp.'), SizedBox(width: 10),
                _ds('${doctor.rating} ⭐',       'Calificación'),
              ]),
              SizedBox(height: 16),
              _dc('Información Personal', [
                _DT('👤', 'Nombre completo',    doctor.fullName),
                _DT('🎂', 'Fecha de nacimiento', doctor.birthDate),
                _DT('🪪', 'Cédula profesional',  doctor.licenseId),
                _DT('🎓', 'Universidad',         doctor.university),
              ]),
              SizedBox(height: 12),
              _dc('Contacto', [
                _DT('📧', 'Correo electrónico', doctor.email,  arrow: true),
                _DT('📱', 'Teléfono',           doctor.phone,  arrow: true),
                _DT('📍', 'Ciudad',             doctor.city),
              ]),
              SizedBox(height: 12),
              _dc('Horario de Trabajo', [
                _DT('🕗', 'Lunes a viernes', doctor.scheduleWeekdays),
                _DT('🕘', 'Sábados',         doctor.scheduleSaturday),
                _DT('💤', 'Domingos',        'No disponible'),
              ]),
              SizedBox(height: 12),
              _dc('Especialidades', [
                _DT('🐕', 'Principal',     doctor.specialtyMain),
                _DT('🔬', 'Secundaria',    doctor.specialtySecondary),
                _DT('🏆', 'Certificación', doctor.certification),
              ]),
              SizedBox(height: 20),
              SizedBox(width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.logout, color: Colors.red),
                  label: Text('Cerrar Sesión', style: TextStyle(color: Colors.red, fontSize: 15)),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                )),
              SizedBox(height: 24),
            ])),
        ),
      ]),
    );
  }
 
  Widget _ds(String v, String l) => Expanded(
    child: Container(padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text(v, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(l, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ])));
 
  Widget _dc(String title, List<_DT> tiles) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 10),
      ...tiles.map((t) => Padding(padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Text(t.icon, style: TextStyle(fontSize: 16)), SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            SizedBox(height: 2),
            Text(t.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[900])),
          ])),
          if (t.arrow) Icon(Icons.chevron_right, size: 18, color: Colors.grey[400]),
        ]))).toList(),
    ]));
}
 
class _DT {
  final String icon, label, value;
  final bool arrow;
  _DT(this.icon, this.label, this.value, {this.arrow = false});
}
 
// PatientDetailScreen
class PatientDetailScreen extends StatelessWidget {
  final Patient patient;
  const PatientDetailScreen({required this.patient});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 260, pinned: true, backgroundColor: Colors.white,
          leading: IconButton(
            icon: CircleAvatar(backgroundColor: Colors.white.withOpacity(0.88),
                child: Icon(Icons.arrow_back, color: Colors.black, size: 18)),
            onPressed: () => Navigator.pop(context)),
          flexibleSpace: FlexibleSpaceBar(background: Stack(fit: StackFit.expand, children: [
            Image.network(patient.photoUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.orange,
                    child: Icon(Icons.pets, size: 80, color: Colors.white))),
            DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.25), Colors.transparent, Colors.black.withOpacity(0.55)]))),
            Positioned(bottom: 16, left: 16, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(patient.name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(patient.breed, style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.85))),
            ])),
            Positioned(top: 16, right: 16,
              child: Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: patient.statusColor, borderRadius: BorderRadius.circular(20)),
                child: Text(patient.status, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)))),
          ])),
        ),
        SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, runSpacing: 8, children: [
                _chip(Icons.cake, patient.age), _chip(Icons.monitor_weight, patient.weight),
                _chip(Icons.person, patient.ownerName), _chip(Icons.access_time, patient.lastUpdate),
              ]),
              SizedBox(height: 14),
              Container(padding: EdgeInsets.all(14),
                decoration: BoxDecoration(color: patient.conditionColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Icon(patient.conditionIcon, color: patient.conditionColor, size: 26), SizedBox(width: 12),
                  Text(patient.condition, style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold, color: patient.conditionColor)),
                ])),
              SizedBox(height: 14),
              _sec('Información Médica', [
                _R('Temperatura', patient.temperature), _R('Frecuencia cardíaca', patient.heartRate),
                _R('Peso', patient.weight), _R('Edad', patient.age),
              ]),
              SizedBox(height: 12),
              _sec('Próxima Cita', [
                _R('Fecha y hora', patient.nextAppointment), _R('Doctor', 'Dr. Jose'),
                _R('Tipo', patient.appointmentType), _R('Dueño', patient.ownerName),
              ]),
              SizedBox(height: 20),
            ])),
        ),
      ]),
    );
  }
 
  Widget _chip(IconData icon, String label) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 14, color: Colors.grey[600]), SizedBox(width: 5),
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
    ]));
 
  Widget _sec(String title, List<_R> rows) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 10),
      ...rows.map((r) => Padding(padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(r.label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(r.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[900])),
        ]))).toList(),
    ]));
}
 
class _R {
  final String label, value;
  _R(this.label, this.value);
}
 
// SummaryDetailScreen
class SummaryDetailScreen extends StatelessWidget {
  final SummaryItem item;
  const SummaryDetailScreen({required this.item});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.label), backgroundColor: Colors.white,
          foregroundColor: Colors.black, elevation: 0.5),
      backgroundColor: Colors.grey[100],
      body: Center(child: Padding(padding: EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(item.icon, style: TextStyle(fontSize: 72)),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [item.color.withOpacity(0.80), item.color],
                  begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: item.color.withOpacity(0.35),
                  blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: Column(children: [
              Text(item.value, style: TextStyle(fontSize: 80,
                  fontWeight: FontWeight.bold, color: Colors.white)),
              Text(item.label, style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.85))),
            ]),
          ),
          SizedBox(height: 16),
          Row(children: [
            _sc(item.stat1Label, item.stat1Value, item.color), SizedBox(width: 10),
            _sc(item.stat2Label, item.stat2Value, item.color), SizedBox(width: 10),
            _sc(item.stat3Label, item.stat3Value, item.color),
          ]),
        ]))),
    );
  }
 
  Widget _sc(String l, String v, Color c) => Expanded(
    child: Container(padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [c.withOpacity(0.70), c],
            begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: c.withOpacity(0.3), blurRadius: 6, offset: Offset(0, 3))]),
      child: Column(children: [
        Text(l, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.85)),
            textAlign: TextAlign.center),
        SizedBox(height: 4),
        Text(v, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      ])));
}
