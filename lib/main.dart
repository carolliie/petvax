import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/cadastro_tutor_screen.dart';
import 'screens/cadastro_pet_screen.dart';
import 'screens/carteirinha_screen.dart';
import 'screens/vacina_detalhe_screen.dart';
import 'screens/enviar_carteirinha_screen.dart';
import 'screens/petbot_screen.dart';
import 'screens/consultas_list_screen.dart';
import 'screens/consulta_detalhe_screen.dart';
import 'screens/agendar_screen.dart';
import 'screens/receitas_screen.dart';
import 'screens/restricoes_screen.dart';
import 'screens/perfil_tutor_screen.dart';
import 'screens/calendario_vacinas_screen.dart';
import 'screens/noticia_detalhe_screen.dart';
import 'screens/agendar_vacina_screen.dart';
import 'screens/receita_detalhe_screen.dart';
import 'screens/configuracoes_screen.dart';
import 'screens/dados_pessoais_screen.dart';
import 'screens/noticias_screen.dart';
import 'screens/procedimentos_screen.dart';

void main() {
  runApp(const PetVaxApp());
}

class PetVaxApp extends StatelessWidget {
  const PetVaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetVax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deep),
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.mulishTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/':                      (context) => const OnboardingScreen(),
        '/login':                 (context) => const LoginScreen(),
        '/cadastro-tutor':        (context) => const CadastroTutorScreen(),
        '/home':                  (context) => const HomeScreen(),
        '/cadastro-pet':          (context) => const CadastroPetScreen(),
        '/carteirinha':           (context) => const CarteirinhaScreen(),
        '/vacina-detalhe':        (context) => const VacinaDetalheScreen(),
        '/enviar-carteirinha':    (context) => const EnviarCarteirinhaScreen(),
        '/petbot':                (context) => const PetBotScreen(),
        '/consultas':             (context) => const ConsultasListScreen(),
        '/consulta-detalhe':      (context) => const ConsultaDetalheScreen(),
        '/agendar':               (context) => const AgendarScreen(),
        '/receitas':              (context) => const ReceitasScreen(),
        '/restricoes':            (context) => const RestricoesScreen(),
        '/perfil':                (context) => const PerfilTutorScreen(),
        '/calendario-vacinas':    (context) => const CalendarioVacinasScreen(),
        '/noticias':              (context) => const NoticiasScreen(),
        '/noticia-detalhe':       (context) => const NoticiaDetalheScreen(),
        '/agendar-vacina':        (context) => const AgendarVacinaScreen(),
        '/receita-detalhe':       (context) => const ReceitaDetalheScreen(),
        '/configuracoes':         (context) => const ConfiguracoesScreen(),
        '/dados-pessoais':       (context) => const DadosPessoaisScreen(),
        '/procedimentos':        (context) => const ProcedimentosScreen(),
      },
    );
  }
}
