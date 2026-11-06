# Despliegue de la API de la app de pedidos con Terraform

El equipo de desarrollo móvil necesita desplegar la API de la app de pedidos en la nube utilizando Terraform. La API debe estar disponible para que la aplicación móvil pueda realizar pedidos y consultas. Debes asegurarte de que la infraestructura esté correctamente configurada y que la API se despliegue de manera eficiente y segura.

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

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Gradle 8+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `gradle build` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el despliegue de la API.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los recursos necesarios para el despliegue de la API.
- Configurar el archivo principal de Terraform con las variables y proveedores necesarios.
- Verificar que el entorno de Terraform esté correctamente configurado y que pueda conectarse a la nube.

**Entregable:** Configuración de Terraform lista para el despliegue de la API.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda revisar la documentación de Terraform para asegurarte de que todas las configuraciones son correctas.
- Utiliza las herramientas de trabajo del candidato para depurar y probar la configuración.

</details>

### Fase 2: Despliegue de la API

**Objetivo:** Desplegar la API utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Crear los archivos de Terraform necesarios para el despliegue de la API.
- Definir los recursos de la nube que serán utilizados por la API.
- Ejecutar el comando de Terraform para desplegar la API y verificar que se haya desplegado correctamente.

**Entregable:** API desplegada utilizando Terraform y verificada.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de la API para asegurarte de que todos los recursos necesarios están incluidos en el despliegue.
- Utiliza las herramientas de trabajo del candidato para depurar y probar el despliegue.

</details>

### Fase 3: Verificación y optimización

**Objetivo:** Verificar el despliegue y optimizar la configuración de Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Verificar que la API esté funcionando correctamente y que todos los recursos estén disponibles.
- Identificar posibles mejoras en la configuración de Terraform para optimizar el despliegue.
- Aplicar las mejoras identificadas y verificar que el despliegue siga funcionando correctamente.

**Entregable:** Configuración optimizada de Terraform y API verificada.

<details>
<summary>Pistas de conocimiento</summary>

- Revisa la documentación de Terraform para identificar posibles mejoras en la configuración.
- Utiliza las herramientas de trabajo del candidato para depurar y probar las mejoras.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y para qué se utiliza en este reto?
- **paraQueSirve**: ¿Para qué sirve configurar Terraform en este reto?
- **comoSeUsa**: ¿Cómo se utiliza Terraform para desplegar la API en este reto?
- **erroresComunes**: ¿Qué errores comunes puedes encontrar al configurar y desplegar con Terraform?
- **queDecisionesImplica**: ¿Qué decisiones debes tomar al optimizar la configuración de Terraform en este reto?

## Criterios de Evaluacion

- Configuración inicial de Terraform correctamente realizada.
- Despliegue de la API utilizando Terraform y verificación de su correcto funcionamiento.
- Identificación y aplicación de mejoras en la configuración de Terraform para optimizar el despliegue.

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

- `infra` expone http (api: https://api.pedidos.example.com/prod):
  - `GET /orders`
  - `POST /orders`
  - `GET /orders/{orderId}`
  - `PATCH /orders/{orderId}/status`
- `client` expone http (api: https://api.pedidos.example.com/prod):

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
