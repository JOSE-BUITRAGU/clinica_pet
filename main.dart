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
      home: PetDashboard(),
    );
  }
}
 
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
 
// ═══════════════════════════════════════════════════════════════════
// DASHBOARD PRINCIPAL
// ═══════════════════════════════════════════════════════════════════
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
 
  // Navega con la rueda del mouse
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
 
                // ── HEADER ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hola ${currentOwner.fullName.split(' ')[0]} 👋',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text('Sigamos el progreso de ${currentOwner.petName}',
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (_) => UserProfileScreen(owner: currentOwner))),
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
                              boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 10, offset: Offset(0, 2))],
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
 
                // ══════════════════════════════════════════════════════
                // PAGEVIEW con soporte para rueda del mouse y drag
                // Listener captura PointerScrollEvent (rueda del mouse)
                // GestureDetector captura arrastre horizontal con mouse
                // ══════════════════════════════════════════════════════
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
 
                // DOTS — también clicables para saltar de página
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
 
// ═══════════════════════════════════════════════════════════════════
// WIDGET — ActivityCard
// ═══════════════════════════════════════════════════════════════════
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
 
// ═══════════════════════════════════════════════════════════════════
// WIDGET — HealthCard con Hero animation
// ═══════════════════════════════════════════════════════════════════
class HealthCard extends StatelessWidget {
  final String title, main, extra, icon;
  final Color color;
 
  const HealthCard({required this.title, required this.main,
      required this.extra, required this.icon, required this.color});
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (_) => DetailScreen(title: title, value: main, icon: icon, color: color))),
      child: Hero(
        tag: title,
        child: Card(
          margin: EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                child: Text(icon, style: TextStyle(fontSize: 20))),
            title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            subtitle: Text(main, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            trailing: Text(extra,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ),
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// PANTALLA — Detalle de salud con Hero animation
// ═══════════════════════════════════════════════════════════════════
class DetailScreen extends StatelessWidget {
  final String title, value, icon;
  final Color color;
 
  const DetailScreen({required this.title, required this.value,
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
            tag: title,
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
 
// ═══════════════════════════════════════════════════════════════════
// PANTALLA — Perfil de usuario (Ana Pérez + Linda)
// CORRECCIÓN: SliverAppBar con foto de Linda sin que se tape,
// usando FlexibleSpaceBar con collapseMode.parallax y
// el nombre/avatar centrados fuera del FlexibleSpaceBar
// para que sean visibles en todo momento.
// ═══════════════════════════════════════════════════════════════════
class UserProfileScreen extends StatelessWidget {
  final PetOwner owner;
  const UserProfileScreen({required this.owner});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
 
          // ── SliverAppBar con banner limpio ──────────────────────
          // expandedHeight ajustado para dar espacio al avatar
          // sin que el título lo tape.
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.orange,
            // Al colapsar muestra "Mi Perfil" blanco
            title: Text('Mi Perfil', style: TextStyle(color: Colors.white, fontSize: 16)),
            // El título solo aparece cuando está colapsado
            titleSpacing: 0,
            leading: IconButton(
              icon: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.25),
                child: Icon(Icons.arrow_back, color: Colors.white, size: 18),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              // collapseMode.parallax evita que el contenido
              // salte bruscamente al hacer scroll
              collapseMode: CollapseMode.parallax,
              // titlePadding en cero para no mostrar título duplicado
              titlePadding: EdgeInsets.zero,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradiente naranja de fondo
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Avatar + nombre centrados en el banner
                  // Posicionados en la parte inferior del banner
                  // para que queden por encima del contenido al
                  // hacer scroll (no se tapan con el AppBar colapsado)
                  Positioned(
                    bottom: 16, left: 0, right: 0,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 80, height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                                border: Border.all(color: Colors.white, width: 3),
                              ),
                              child: Center(child: Text('🐾', style: TextStyle(fontSize: 36))),
                            ),
                            Container(
                              width: 22, height: 22,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(owner.fullName,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 2),
                        Text('Dueña de ${owner.petName} 🖤',
                            style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.85))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
 
          // ── CUERPO del perfil ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                children: [
 
                  // Ciudad
                  Text('📍 ${owner.city}',
                      style: TextStyle(fontSize: 12, color: Colors.orange,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 16),
 
                  // Stats rápidas
                  Row(children: [
                    _statBox('3',     'Años con Linda'),
                    SizedBox(width: 10),
                    _statBox('47',    'Visitas al vet'),
                    SizedBox(width: 10),
                    _statBox('4.8⭐', 'Calificación'),
                  ]),
                  SizedBox(height: 16),
 
                  // Información Personal
                  _infoSection('Información Personal', [
                    _InfoTile(icon: '👤', label: 'Nombre completo',    value: owner.fullName),
                    _InfoTile(icon: '🎂', label: 'Fecha de nacimiento', value: owner.birthDate),
                    _InfoTile(icon: '📍', label: 'Ciudad',             value: owner.city),
                    _InfoTile(icon: '📅', label: 'Miembro desde',      value: owner.memberSince),
                  ]),
                  SizedBox(height: 12),
 
                  // Contacto
                  _infoSection('Contacto', [
                    _InfoTile(icon: '📧', label: 'Correo electrónico', value: owner.email,  showArrow: true),
                    _InfoTile(icon: '📱', label: 'Teléfono',           value: owner.phone,  showArrow: true),
                  ]),
                  SizedBox(height: 12),
 
                  // Mi Mascota Linda
                  _petSection(),
                  SizedBox(height: 12),
 
                  // Veterinario
                  _infoSection('Veterinario', [
                    _InfoTile(icon: '👨‍⚕️', label: 'Veterinario de cabecera', value: owner.vetName),
                    _InfoTile(icon: '📅',   label: 'Próxima cita',            value: owner.nextVetAppointment, showArrow: true),
                  ]),
                  SizedBox(height: 20),
 
                  // Cerrar sesión
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.logout, color: Colors.red),
                      label: Text('Cerrar Sesión',
                          style: TextStyle(color: Colors.red, fontSize: 15)),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.red.withOpacity(0.4), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _petSection() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MI MASCOTA',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                  color: Colors.grey[500], letterSpacing: 0.5)),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[900],
                    border: Border.all(color: Colors.orange, width: 2.5)),
                child: Center(child: Text('🐕‍🦺', style: TextStyle(fontSize: 30))),
              ),
              SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text('Linda', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
                    child: Text('● Negra', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ]),
                SizedBox(height: 3),
                Text('Labrador Negra', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                SizedBox(height: 6),
                Row(children: [
                  _petChip('🎂', '3 años'), SizedBox(width: 6), _petChip('⚖️', '25.5 kg'),
                ]),
              ])),
            ]),
          ),
          SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey[200]),
          SizedBox(height: 12),
          _petRow('🐾', 'Nombre',              'Linda'),
          _petRow('🎂', 'Fecha de nacimiento',  '12 de marzo, 2022'),
          _petRow('⚖️', 'Peso actual',          '25.5 kg'),
          _petRow('🎨', 'Color de pelaje',      'Negra'),
          _petRow('📏', 'Edad',                 '3 años'),
        ],
      ),
    );
  }
 
  Widget _petChip(String icon, String label) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
    child: Text('$icon $label', style: TextStyle(fontSize: 10, color: Colors.orange.shade800, fontWeight: FontWeight.w500)));
 
  Widget _petRow(String icon, String label, String value) => Padding(
    padding: EdgeInsets.symmetric(vertical: 7),
    child: Row(children: [
      Text(icon, style: TextStyle(fontSize: 15)), SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[900])),
      ])),
    ]));
 
  Widget _statBox(String v, String l) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(l, style: TextStyle(fontSize: 9, color: Colors.grey[600]), textAlign: TextAlign.center),
      ])));
 
  Widget _infoSection(String title, List<_InfoTile> tiles) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 10),
      ...tiles.map((t) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Text(t.icon, style: TextStyle(fontSize: 16)), SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            SizedBox(height: 2),
            Text(t.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[900])),
          ])),
          if (t.showArrow) Icon(Icons.chevron_right, size: 18, color: Colors.grey[400]),
        ]))).toList(),
    ]));
}
 
class _InfoTile {
  final String icon, label, value;
  final bool showArrow;
  _InfoTile({required this.icon, required this.label, required this.value, this.showArrow = false});
}
