
class UnbordingContent {
  final String lottie;
  final String title;
  final String discription;

  UnbordingContent({required this.lottie, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Bienvenido a MovieMagic',
    lottie: 'assets/animation.json',
    discription: "Aquí podrás explorar una amplia selección de películas de diferentes géneros, "
                 "desde los últimos estrenos hasta los clásicos que nunca pasan de moda. "
                 "¡Prepárate para sumergirte en historias cautivadoras y encontrar tu próxima película favorita!"
  ),
  UnbordingContent(
    title: 'Personaliza tu Experiencia',
    lottie: 'assets/colors.json', 
    discription: "Haz que MovieMagic sea verdaderamente tuya. Elige entre un tema claro, oscuro o uno "
                 "personalizado para disfrutar de una experiencia visual adaptada a ti. ¡Tu "
                 "comodidad y estilo son nuestra prioridad!"
  ),
  UnbordingContent(
    title: 'Guarda tus Favoritas',
    lottie: 'assets/logo.png', 
    discription: "Nunca más olvides tus películas preferidas. Con MovieMagic, puedes "
                 "guardar tus películas favoritas en una lista personal para acceder a ellas rápidamente. "
                 "¡Haz de cada película una experiencia memorable!"
  ),
];
