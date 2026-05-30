# PetVax

Aplicativo Flutter de saúde animal para tutores de pets. Registra vacinas, consultas veterinárias, receitas médicas, restrições/alergias, procedimentos e notícias de saúde — tudo organizado por pet.

O design foi criado no Claude Design (claude.ai/design) e exportado como protótipo HTML/React, depois implementado como app Flutter nativo.

---

## Contexto do produto

**Usuários:** tutores de pets (lado atual implementado) e veterinários (lado futuro).

**Problema:** donos de pets não têm onde centralizar o histórico de saúde dos animais — carteirinha de vacinas se perde, receitas vencem sem lembretes, consultas ficam espalhadas em agendas e mensagens.

**Solução:** app que age como prontuário digital do pet, com lembretes proativos via PetBot (assistente).

---

## Design

**Paleta:**
- Roxo profundo `#543075` — cor principal (botões, nav, títulos)
- Lilás `#C8A0E1` — fundo do onboarding
- Rosa claro `#FEE9F9` — fundo das telas internas
- Verde `#4FA980` / Âmbar `#CF953C` / Vermelho `#C95D6E` — status

**Tipografia:**
- **Fraunces** (serifa) — títulos, wordmark, dados em destaque
- **Mulish** (sans-serif) — corpo de texto, labels, metadados

**Logotipo:** cruz médica arredondada com pata central (`CrossPaw`).

---

## Arquitetura Flutter

```
lib/
├── main.dart                      # Entry point, MaterialApp, rotas nomeadas
│
├── core/
│   ├── app_colors.dart            # Tokens de cor (AppColors.deep, .lilac, .bg…)
│   └── app_text_styles.dart       # Estilos tipográficos (AppTextStyles.h1, .sans…)
│
├── widgets/                       # Kit de UI reutilizável
│   ├── paw_icon.dart              # Pata SVG parametrizável por cor/tamanho
│   ├── syringe_icon.dart          # Seringa SVG
│   ├── stetho_icon.dart           # Estetoscópio SVG
│   ├── cross_paw.dart             # Logo cruz+pata
│   ├── pet_duo.dart               # Ilustração cão+gato (onboarding)
│   ├── pv_status_bar.dart         # Barra de status simulada (9:41, sinal, bateria)
│   ├── pv_bottom_nav.dart         # Nav inferior com FAB central (pata)
│   ├── pv_push_header.dart        # Header com botão voltar para telas "pushed"
│   ├── pv_tag.dart                # Tags de status (PvTag) e pílulas (PvPill)
│   ├── pv_chip.dart               # Chip de seleção toggle
│   ├── pv_avatar.dart             # Avatar circular
│   ├── pv_card.dart               # Card com sombra roxa suave
│   └── hatch_box.dart             # Box com padrão hachura (placeholder de imagem)
│
└── screens/                       # 13 telas do lado Tutor
    ├── onboarding_screen.dart
    ├── home_screen.dart
    ├── cadastro_pet_screen.dart
    ├── carteirinha_screen.dart
    ├── calendario_vacinas_screen.dart
    ├── consultas_list_screen.dart
    ├── consulta_detalhe_screen.dart
    ├── agendar_screen.dart
    ├── receitas_screen.dart
    ├── restricoes_screen.dart
    ├── procedimentos_screen.dart
    ├── noticias_screen.dart
    └── perfil_tutor_screen.dart
```

---

## Telas implementadas (Tutor)

| Rota | Tela | Descrição |
|------|------|-----------|
| `/` | Onboarding | Splash lilás com ilustração cão+gato, botão de entrada |
| `/home` | Home | Hub principal: menu Cadastro/Carteirinha, próxima consulta, acesso rápido a serviços, notícias, PetBot |
| `/cadastro-pet` | Cadastro do pet | Formulário com foto, espécie, raça, sexo, nascimento, peso, microchip |
| `/carteirinha` | Carteirinha de vacinação | Seletor de pet, booklet com histórico e status de cada vacina |
| `/calendario-vacinas` | Calendário de Vacinas | Vacinas organizadas por mês, filtros por status (Todas/Próximas/Atrasadas), countdown em dias, resumo estatístico |
| `/consultas` | Lista de Consultas | Tabs Próximas/Anteriores/Canceladas, busca, seções por mês, atalho para agendar |
| `/consulta-detalhe` | Detalhe da Consulta | Info do vet (CRMV), data/horário/local/paciente, motivo, anexos (receita + relatório) |
| `/agendar` | Agendar Consulta | Seletor de pet, seletor de vet, calendário mensal interativo (grid 7×5), slots de horário com ocupados marcados |
| `/receitas` | Receitas Médicas | Tabs Vigentes/Vencidas, cards expansíveis com posologia, dias restantes, download/compartilhar |
| `/restricoes` | Restrições e Alergias | Filtro por pet e severidade (Grave/Moderada/Leve), cards expansíveis com médico responsável e data |
| `/procedimentos` | Procedimentos | Filtros por tipo (Cirurgias/Tratamentos/Terapias/Exames) e pet, badges de status, observações clínicas |
| `/noticias` | Notícias | Filtros por categoria (Vacinação/Saúde/Prevenção/Alertas), card destaque, artigos com tag |
| `/perfil` | Perfil do Tutor | Dados pessoais, lista de pets, configurações de conta |

---

## Dependências

```yaml
dependencies:
  flutter_svg: ^2.0.9      # Renderização dos ícones SVG customizados (pata, seringa, estetoscópio)
  google_fonts: ^6.2.1     # Fraunces (serif) + Mulish (sans)
  device_preview: ^1.3.1   # Preview em múltiplos dispositivos
```

---

## Como rodar

```bash
flutter pub get
flutter run
```

O app inicia no Onboarding (`/`). O botão de seta leva para a Home. A nav inferior conecta Home → Carteirinha → Perfil; as demais telas são acessadas pela Home ou por contexto.

---

## Navegação

```
Onboarding → [seta] → Home
Home
 ├── Cadastro do pet
 ├── Carteirinha de vacinação
 │    └── Calendário de vacinas
 ├── Consultas [Ver todas] → Lista de consultas
 │    ├── Detalhe da consulta
 │    └── [+] Agendar consulta
 ├── Serviços (acesso rápido)
 │    ├── Calendário de vacinas
 │    ├── Receitas médicas
 │    ├── Procedimentos
 │    ├── Restrições e alergias
 │    └── Notícias
 └── Notícias [Ver todas]

Bottom nav (tutor)
 ├── 💉  → Carteirinha de vacinação
 ├── 🐾  → Home  (FAB central)
 └── 👤  → Perfil do tutor
```

---

## Próximos passos sugeridos

- **Lado veterinário:** agenda de consultas, detalhe do paciente/animal, emissão de receita, cadastro com CRMV
- **Backend:** autenticação, sincronização de dados, notificações push (lembretes de vacina via PetBot)
- **Estado:** introduzir Riverpod ou Bloc para gerenciar pet selecionado e dados do usuário
- **Testes:** widget tests para os componentes do kit UI
