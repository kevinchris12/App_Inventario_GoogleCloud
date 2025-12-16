/// Formatea una fecha de firestore a un formato de fecha definido.
/// 🔹 Formato: "16 de Enero de 2025, 6:28 PM"
String formatDate(DateTime? fecha, {bool conHora = true}) {
  if (fecha == null) return "Sin fecha";

  final meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre",
  ];

  final dia = fecha.day;
  final mes = meses[fecha.month - 1];
  final anho = fecha.year;

  int hora = fecha.hour;
  final minutos = fecha.minute.toString().padLeft(2, '0');
  final periodo = hora >= 12 ? "PM" : "AM";

  if (hora > 12) hora -= 12;
  if (hora == 0) hora = 12;

  if (!conHora) {
    return "$dia de $mes de $anho";
  } else {
    return "$dia de $mes de $anho, $hora:$minutos $periodo";
  }
}
