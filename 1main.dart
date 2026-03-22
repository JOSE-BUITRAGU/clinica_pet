import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
 
void main() {
  runApp(ClinicApp());
}
 
class ClinicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClinicDashboard(),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// MODELOS
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
 
// ═══════════════════════════════════════════════════════════════════
// DATOS — Doctor
// ═══════════════════════════════════════════════════════════════════
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
 
// ═══════════════════════════════════════════════════════════════════
// DATOS — Pacientes
// ═══════════════════════════════════════════════════════════════════
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
 
// ═══════════════════════════════════════════════════════════════════
// DATOS — Resumen (3 páginas × 9 tarjetas = grilla 3×3 por página)
// ═══════════════════════════════════════════════════════════════════
final List<List<SummaryItem>> summaryPages = [
  // Página 1 — 3 cards
  [
    SummaryItem(label:'Citas',          value:'5',  icon:'🔔', color:Colors.blue,       stat1Label:'Pendientes',  stat1Value:'3',  stat2Label:'Completadas',  stat2Value:'2',  stat3Label:'Canceladas',   stat3Value:'0'),
    SummaryItem(label:'Hospitalizados', value:'3',  icon:'🏠', color:Colors.green,      stat1Label:'En UCI',      stat1Value:'1',  stat2Label:'Estables',     stat2Value:'2',  stat3Label:'De alta hoy',  stat3Value:'1'),
    SummaryItem(label:'Tareas',         value:'7',  icon:'📋', color:Colors.purple,     stat1Label:'Urgentes',    stat1Value:'2',  stat2Label:'Normales',     stat2Value:'5',  stat3Label:'Completadas',  stat3Value:'8'),
  ],
  // Página 2 — 3 cards
  [
    SummaryItem(label:'Laboratorio',    value:'9',  icon:'🧬', color:Colors.indigo,     stat1Label:'En proceso',  stat1Value:'4',  stat2Label:'Listos',       stat2Value:'5',  stat3Label:'Urgentes',     stat3Value:'2'),
    SummaryItem(label:'Radiografías',   value:'3',  icon:'🩻', color:Colors.deepOrange, stat1Label:'Revisadas',   stat1Value:'2',  stat2Label:'Pendientes',   stat2Value:'1',  stat3Label:'Archivadas',   stat3Value:'6'),
    SummaryItem(label:'Camas Disp.',    value:'5',  icon:'🛏️', color:Colors.pink,       stat1Label:'Ocupadas',    stat1Value:'7',  stat2Label:'Limpieza',     stat2Value:'1',  stat3Label:'Total',        stat3Value:'13'),
  ],
  // Página 3 — 3 cards
  [
    SummaryItem(label:'Perros',         value:'18', icon:'🐕', color:Colors.amber,      stat1Label:'Activos',     stat1Value:'15', stat2Label:'Alta',         stat2Value:'2',  stat3Label:'Críticos',     stat3Value:'1'),
    SummaryItem(label:'Gatos',          value:'7',  icon:'🐈', color:Colors.pink,       stat1Label:'Activos',     stat1Value:'6',  stat2Label:'Alta',         stat2Value:'1',  stat3Label:'Críticos',     stat3Value:'0'),
    SummaryItem(label:'Otros',          value:'4',  icon:'🐇', color:Colors.teal,       stat1Label:'Conejos',     stat1Value:'2',  stat2Label:'Aves',         stat2Value:'1',  stat3Label:'Reptiles',     stat3Value:'1'),
  ],
];
 
// ═══════════════════════════════════════════════════════════════════
// DASHBOARD PRINCIPAL
// ═══════════════════════════════════════════════════════════════════
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
    final delta = event.scrollDelta.dy != 0
        ? event.scrollDelta.dy
        : event.scrollDelta.dx;
    if (delta > 0 && _currentPage < summaryPages.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else if (delta < 0 && _currentPage > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
 
            // ── HEADER ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Hola Dr. Jose 👨‍⚕️',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Bienvenido a tu clínica veterinaria',
                        style: TextStyle(color: Colors.grey[700])),
                  ]),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => UserProfileScreen(doctor: currentDoctor))),
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
                          boxShadow: [BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 10, offset: Offset(0, 2))],
                        ),
                        child: Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 24))),
                      ),
                      Positioned(bottom: 2, right: 2,
                        child: Container(width: 13, height: 13,
                          decoration: BoxDecoration(color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2)))),
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
 
            // ── TÍTULO RESUMEN ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Resumen del Día',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
 
            // ════════════════════════════════════════════════════════
            // PAGEVIEW — 3 páginas × grilla 3×3
            // Listener  → rueda del mouse
            // GestureDetector → arrastre horizontal con mouse
            // NeverScrollableScrollPhysics → sin conflicto de gestos
            // ════════════════════════════════════════════════════════
            // 3 cards × 58px + 2 gaps × 8px = 190px de alto
            SizedBox(
              height: 190,
              child: Listener(
                onPointerSignal: (event) {
                  if (event is PointerScrollEvent) _handleWheel(event);
                },
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity == null) return;
                    if (details.primaryVelocity! < -300 &&
                        _currentPage < summaryPages.length - 1) {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeInOut);
                    } else if (details.primaryVelocity! > 300 && _currentPage > 0) {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeInOut);
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
 
            // Dots — clicables para saltar de página
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
 
            // ── TÍTULO PACIENTES ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Pacientes Recientes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
 
            // ── LISTVIEW VERTICAL ───────────────────────────────────
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
          ],
        ),
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// WIDGET — SummaryCard (estilo fila como imagen de referencia)
// [ícono círculo] [label expandido] [número grande] [›]
// ═══════════════════════════════════════════════════════════════════
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
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.30),
              blurRadius: 6, offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        child: Row(children: [
          // Ícono en círculo blanco semitransparente
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(item.icon, style: TextStyle(fontSize: 19))),
          ),
          SizedBox(width: 14),
          // Label
          Expanded(
            child: Text(item.label,
              style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white,
              ),
            ),
          ),
          // Número
          Text(item.value,
            style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          // Flecha
          Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 14),
        ]),
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// WIDGET — PatientCard
// ═══════════════════════════════════════════════════════════════════
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
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(patient.photoUrl,
                  width: 50, height: 50, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => CircleAvatar(
                      radius: 25, backgroundColor: Colors.orange,
                      child: Icon(Icons.pets, color: Colors.white))),
            ),
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
              child: Text(patient.status,
                  style: TextStyle(color: patient.statusColor,
                      fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ]),
          SizedBox(height: 8), Divider(height: 1), SizedBox(height: 8),
          Row(children: [
            Icon(Icons.calendar_today, size: 13, color: Colors.blue),
            SizedBox(width: 5),
            Text('Próxima cita: ${patient.nextAppointment}',
                style: TextStyle(fontSize: 12)),
          ]),
          SizedBox(height: 4),
          Row(children: [
            Icon(patient.conditionIcon, size: 13, color: patient.conditionColor),
            SizedBox(width: 5),
            Text(patient.condition,
                style: TextStyle(fontSize: 12, color: patient.conditionColor)),
          ]),
        ])),
      ),
    );
  }
}
 
// ═══════════════════════════════════════════════════════════════════
// PANTALLA — Perfil del Dr. Jose
// CORRECCIÓN: Avatar y nombre dentro del FlexibleSpaceBar con
// Positioned(bottom) + CollapseMode.parallax para que NO se tapen
// con el AppBar colapsado al hacer scroll.
// ═══════════════════════════════════════════════════════════════════
class UserProfileScreen extends StatelessWidget {
  final DoctorUser doctor;
  const UserProfileScreen({required this.doctor});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(slivers: [
 
        SliverAppBar(
          expandedHeight: 210,
          pinned: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.25),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 18),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Mi Perfil', style: TextStyle(color: Colors.white, fontSize: 16)),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.zero,
            background: Stack(fit: StackFit.expand, children: [
              // Gradiente de fondo
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red.shade400],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Avatar + nombre posicionados en la parte baja del banner.
              // Con parallax se deslizan suavemente sin tapar el AppBar.
              Positioned(
                bottom: 14, left: 0, right: 0,
                child: Column(children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 78, height: 78,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.orange.shade300, Colors.red.shade300],
                            begin: Alignment.topLeft, end: Alignment.bottomRight,
                          ),
                          border: Border.all(color: Colors.white, width: 3.5),
                          boxShadow: [BoxShadow(
                              color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))],
                        ),
                        child: Center(child: Text('👨‍⚕️', style: TextStyle(fontSize: 36))),
                      ),
                      Container(width: 20, height: 20,
                        decoration: BoxDecoration(color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2))),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(doctor.fullName,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(doctor.role,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.85)),
                        maxLines: 2),
                  ),
                ]),
              ),
            ]),
          ),
        ),
 
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(children: [
              Text('🏥 ${doctor.clinicName}',
                  style: TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.w600)),
              SizedBox(height: 16),
              Row(children: [
                _stat('${doctor.totalPatients}',   'Pacientes'),
                SizedBox(width: 10),
                _stat('${doctor.yearsExperience}', 'Años exp.'),
                SizedBox(width: 10),
                _stat('${doctor.rating} ⭐',       'Calificación'),
              ]),
              SizedBox(height: 16),
              _sec('Información Personal', [
                _T('👤', 'Nombre completo',    doctor.fullName),
                _T('🎂', 'Fecha de nacimiento', doctor.birthDate),
                _T('🪪', 'Cédula profesional',  doctor.licenseId),
                _T('🎓', 'Universidad',         doctor.university),
              ]),
              SizedBox(height: 12),
              _sec('Contacto', [
                _T('📧', 'Correo electrónico', doctor.email,  arrow: true),
                _T('📱', 'Teléfono',           doctor.phone,  arrow: true),
                _T('📍', 'Ciudad',             doctor.city),
              ]),
              SizedBox(height: 12),
              _sec('Horario de Trabajo', [
                _T('🕗', 'Lunes a viernes', doctor.scheduleWeekdays),
                _T('🕘', 'Sábados',         doctor.scheduleSaturday),
                _T('💤', 'Domingos',        'No disponible'),
              ]),
              SizedBox(height: 12),
              _sec('Especialidades', [
                _T('🐕', 'Principal',     doctor.specialtyMain),
                _T('🔬', 'Secundaria',    doctor.specialtySecondary),
                _T('🏆', 'Certificación', doctor.certification),
              ]),
              SizedBox(height: 20),
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
            ]),
          ),
        ),
      ]),
    );
  }
 
  Widget _stat(String v, String l) => Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text(v, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 3),
        Text(l, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ]),
    ));
 
  Widget _sec(String title, List<_T> tiles) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(),
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
              color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 10),
      ...tiles.map((t) => Padding(padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Text(t.icon, style: TextStyle(fontSize: 16)),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.label, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            SizedBox(height: 2),
            Text(t.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                color: Colors.grey[900])),
          ])),
          if (t.arrow) Icon(Icons.chevron_right, size: 18, color: Colors.grey[400]),
        ]))).toList(),
    ]));
}
 
class _T {
  final String icon, label, value;
  final bool arrow;
  _T(this.icon, this.label, this.value, {this.arrow = false});
}
 
// ═══════════════════════════════════════════════════════════════════
// PANTALLA — Detalle del Paciente
// ═══════════════════════════════════════════════════════════════════
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
                colors: [Colors.black.withOpacity(0.25), Colors.transparent,
                  Colors.black.withOpacity(0.55)]))),
            Positioned(bottom: 16, left: 16, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(patient.name, style: TextStyle(fontSize: 26,
                  fontWeight: FontWeight.bold, color: Colors.white)),
              Text(patient.breed, style: TextStyle(fontSize: 13,
                  color: Colors.white.withOpacity(0.85))),
            ])),
            Positioned(top: 16, right: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: patient.statusColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(patient.status, style: TextStyle(color: Colors.white,
                    fontSize: 11, fontWeight: FontWeight.bold)))),
          ])),
        ),
        SliverToBoxAdapter(
          child: Padding(padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(spacing: 8, runSpacing: 8, children: [
                _chip(Icons.cake, patient.age),
                _chip(Icons.monitor_weight, patient.weight),
                _chip(Icons.person, patient.ownerName),
                _chip(Icons.access_time, patient.lastUpdate),
              ]),
              SizedBox(height: 14),
              Container(padding: EdgeInsets.all(14),
                decoration: BoxDecoration(color: patient.conditionColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Icon(patient.conditionIcon, color: patient.conditionColor, size: 26),
                  SizedBox(width: 12),
                  Text(patient.condition, style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold, color: patient.conditionColor)),
                ])),
              SizedBox(height: 14),
              _infoSec('Información Médica', [
                _IR('Temperatura', patient.temperature),
                _IR('Frecuencia cardíaca', patient.heartRate),
                _IR('Peso', patient.weight),
                _IR('Edad', patient.age),
              ]),
              SizedBox(height: 12),
              _infoSec('Próxima Cita', [
                _IR('Fecha y hora', patient.nextAppointment),
                _IR('Doctor', 'Dr. Jose'),
                _IR('Tipo', patient.appointmentType),
                _IR('Dueño', patient.ownerName),
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
 
  Widget _infoSec(String title, List<_IR> rows) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    padding: EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
          color: Colors.grey[500], letterSpacing: 0.5)),
      SizedBox(height: 10),
      ...rows.map((r) => Padding(padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(r.label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(r.value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
              color: Colors.grey[900])),
        ]))).toList(),
    ]));
}
 
class _IR {
  final String label, value;
  _IR(this.label, this.value);
}
 
// ═══════════════════════════════════════════════════════════════════
// PANTALLA — Detalle de Tarjeta de Resumen
// ═══════════════════════════════════════════════════════════════════
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
              gradient: LinearGradient(
                colors: [item.color.withOpacity(0.75), item.color],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              Text(item.value, style: TextStyle(fontSize: 80,
                  fontWeight: FontWeight.bold, color: Colors.white)),
              Text(item.label, style: TextStyle(fontSize: 18,
                  color: Colors.white.withOpacity(0.85))),
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
        gradient: LinearGradient(colors: [c.withOpacity(0.7), c],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Text(l, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.85)),
            textAlign: TextAlign.center),
        SizedBox(height: 4),
        Text(v, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
      ])));
}
