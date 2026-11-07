# Despliegue de la API de la app de pedidos

Como desarrollador senior de Flutter, tu tarea es aprovisionar la infraestructura necesaria para la aplicación móvil de pedidos usando Terraform. La API debe ser desplegada y accesible para que la aplicación móvil pueda interactuar con ella. Debes asegurarte de que la infraestructura cumpla con los requisitos de la aplicación y esté lista para su uso en un entorno de pruebas.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el proyecto.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identifica los recursos necesarios para la API de la aplicación de pedidos.
- Configura el archivo principal de Terraform con las variables y proveedores necesarios.
- Verifica que el entorno de Terraform esté correctamente configurado.

**Entregable:** Archivo de configuración de Terraform listo para su uso.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda revisar la documentación de Terraform para asegurarte de que todas las configuraciones son correctas.

</details>

### Fase 2: Aprovisionamiento de recursos con Terraform

**Objetivo:** Aprovisionar los recursos necesarios para la API de la aplicación de pedidos.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Crea los scripts de Terraform para aprovisionar los recursos necesarios.
- Ejecuta los comandos de Terraform para aplicar los cambios.
- Verifica que los recursos se hayan aprovisionado correctamente.

**Entregable:** Recursos aprovisionados y listos para su uso.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza la documentación de Terraform para asegurarte de que los scripts sean correctos.
- Revisa los logs de Terraform para identificar cualquier error durante el aprovisionamiento.

</details>

### Fase 3: Despliegue de la API

**Objetivo:** Desplegar la API de la aplicación de pedidos en el entorno de pruebas.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Configura la API para que se despliegue en el entorno de pruebas.
- Verifica que la API esté accesible y funcione correctamente.
- Documenta el proceso de despliegue para futuras referencias.

**Entregable:** API desplegada y accesible en el entorno de pruebas.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de la API para asegurarte de que esté correctamente configurada.
- Utiliza las herramientas de trabajo del candidato para depurar y probar la API.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y para qué se utiliza en este proyecto?
- **paraQueSirve**: ¿Para qué sirve aprovisionar la infraestructura con Terraform en este caso?
- **comoSeUsa**: ¿Cómo se usa Terraform para aprovisionar los recursos necesarios para la API?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar la infraestructura con Terraform?
- **queDecisionesImplica**: ¿Qué decisiones implica el despliegue de la API en el entorno de pruebas?

## Criterios de Evaluacion

- Configuración inicial de Terraform realizada correctamente.
- Recursos aprovisionados con Terraform de manera efectiva.
- API desplegada y accesible en el entorno de pruebas.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
