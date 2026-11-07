# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Despliegue de la API de la app de pedidos**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el backend de una app movil |
| Nivel | senior-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart / Flutter 3.27 |
| Patron arquitectonico | clean architecture con mvvm |
| Tiempo estimado | 8 horas |

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://api-dev.pedidos.example.com):
  - `GET /health`
  - `GET/POST /api/orders`
  - `GET/POST /api/products`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter 3.27.0
- provider 6.1.2
- http 1.2.2
- get_it 8.0.3
- equatable 2.0.7
- flutter_test sdk
- mockito 5.4.4
- build_runner 2.4.13

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración inicial de Terraform**: Archivo de configuración de Terraform listo para su uso.
- **Fase 2 — Aprovisionamiento de recursos con Terraform**: Recursos aprovisionados y listos para su uso.
- **Fase 3 — Despliegue de la API**: API desplegada y accesible en el entorno de pruebas.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/api/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/api/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/api/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/api/security.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/database/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/database/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- [ ] `infra/modules/cache/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Lo que falta y tenes que completar

### 1. Archivos que la arquitectura declara (8 de 40)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `infra/main.tf`
- [ ] `infra/outputs.tf`
- [ ] `client/lib/presentation/screens/home_screen.dart`
- [ ] `client/lib/presentation/screens/orders_screen.dart`
- [ ] `client/lib/presentation/screens/products_screen.dart`
- [ ] `client/lib/presentation/widgets/product_card.dart`
- [ ] `client/lib/di/injection.dart`
- [ ] `client/test/data/repositories/order_repository_test.dart`

### 2. Referencias colgando (5)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `client/lib/data/models/order_model.dart` — `OrderItem.toJson`
      Se invoca `toJson` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/lib/data/models/order_model.dart` — `OrderItem.toEntity`
      Se invoca `toEntity` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/test/presentation/viewmodels/orders_viewmodel_test.dart` — `OrdersViewModel.addListener`
      Se invoca `addListener` sobre `OrdersViewModel`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/test/presentation/viewmodels/orders_viewmodel_test.dart` — `OrdersViewModel.removeListener`
      Se invoca `removeListener` sobre `OrdersViewModel`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `client/test/presentation/viewmodels/orders_viewmodel_test.dart` — `OrdersViewModel.clearOrders`
      Se invoca `clearOrders` sobre `OrdersViewModel`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (35)

- `infra/variables.tf`
- `infra/providers.tf`
- `infra/modules/api/variables.tf`
- `infra/modules/database/variables.tf`
- `infra/README.md`
- `infra/versions.tf`
- `infra/.terraform-version`
- `infra/.gitignore`
- `infra/modules/api/main.tf`
- `infra/modules/api/outputs.tf`
- `infra/modules/api/security.tf`
- `infra/modules/database/main.tf`
- `infra/modules/cache/main.tf`
- `infra/environments/dev/terraform.tfvars`
- `infra/scripts/deploy.sh`
- `infra/scripts/verify.sh`
- `client/pubspec.yaml`
- `client/lib/main.dart`
- `client/lib/core/config/api_config.dart`
- `client/lib/core/constants/app_constants.dart`
- `client/lib/domain/entities/order.dart`
- `client/lib/domain/entities/product.dart`
- `client/lib/domain/repositories/order_repository.dart`
- `client/lib/domain/repositories/product_repository.dart`
- `client/lib/data/models/order_model.dart`
- `client/lib/data/models/product_model.dart`
- `client/lib/data/datasources/remote/order_remote_datasource.dart`
- `client/lib/data/datasources/remote/product_remote_datasource.dart`
- `client/lib/data/repositories/order_repository_impl.dart`
- `client/lib/data/repositories/product_repository_impl.dart`
- `client/android/app/src/main/AndroidManifest.xml`
- `client/lib/presentation/viewmodels/orders_viewmodel.dart`
- `client/lib/presentation/viewmodels/products_viewmodel.dart`
- `client/lib/presentation/widgets/order_card.dart`
- `client/test/presentation/viewmodels/orders_viewmodel_test.dart`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `infra`
- `infra/modules`
- `infra/environments`
- `infra/scripts`
- `client`
- `client/lib/domain`
- `client/lib/data`
- `client/lib/presentation`
- `client/lib/core`

## Verificacion

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **clean architecture con mvvm**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261106194239047), Aprovisiona con Terraform los recursos que consume la aplicacion movil
- Mision: Desplegar la API de la app de pedidos

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
