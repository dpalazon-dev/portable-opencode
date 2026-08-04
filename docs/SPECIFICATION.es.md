# Portable OpenCode + OpenRouter

**Documento:** Especificación conceptual y funcional  
**Estado:** Draft v0.2  
**Nombre provisional:** `portable-opencode`

## 1. Definición

`portable-opencode` es un sistema versionado, portable, reproducible y configurable para desplegar un entorno de **agentic coding** construido conjuntamente sobre **OpenCode y OpenRouter**.

No es únicamente una distribución de OpenCode. OpenCode actúa como runtime y superficie de interacción; OpenRouter funciona como plano de control de modelos, proveedores, privacidad, costes y routing. RTK, Graphify, la observabilidad local y una capa mínima de automatización completan el sistema.

El objetivo es permitir que una persona o un equipo pueda:

1. preparar un ordenador para trabajar con OpenCode de forma segura y consistente;
2. inicializar un proyecto nuevo con infraestructura agentic reproducible;
3. definir junto al agente el contexto, la arquitectura y las convenciones;
4. mantener un grafo útil del código durante todo el ciclo de desarrollo;
5. conservar decisiones, estado operativo y continuidad entre sesiones;
6. sustituir modelos, proveedores o preferencias sin reconstruir el entorno.

> Una configuración portable del sistema OpenCode + OpenRouter para crear proyectos preparados desde el primer momento para desarrollo agentic.

## 2. Propuesta de valor

El sistema combina:

- configuración global coherente;
- configuración específica por proyecto;
- roles de agentes bien delimitados;
- permisos codificados, no solo descritos en prompts;
- documentación estructurada del proyecto;
- selección desacoplada de modelos y proveedores;
- mantenimiento continuo del grafo de código;
- procedimientos explícitos de exploración, planificación, revisión y verificación;
- aislamiento estricto de credenciales y estado privado.

Será **opinionated by default, configurable by design**: ofrecerá una ruta recomendada, pero sus decisiones podrán sustituirse mediante perfiles, fragmentos de configuración o preferencias locales.

## 3. Principios de diseño

### 3.1. Aprovechar OpenCode antes de extenderlo

Se utilizarán primero sus capacidades nativas: configuración jerárquica, agentes, subagentes, comandos, skills, permisos, plugins, custom tools, LSP, formatters, watcher, compactación y sesiones.

### 3.2. Convención fuerte, sustitución sencilla

Cada decisión importante tendrá un valor predeterminado, una justificación, un mecanismo de sustitución y un criterio de validación.

### 3.3. Separación de responsabilidades

La instalación del entorno, la configuración de OpenCode y OpenRouter, la preparación del proyecto, la observabilidad y los secretos locales son ámbitos distintos.

### 3.4. Seguridad codificada

Las restricciones críticas deben reflejarse en permisos, hooks, herramientas y límites explícitos, no depender únicamente del prompt.

### 3.5. Estado observable

El usuario debe poder conocer si el entorno y el proyecto están correctamente configurados, si el grafo está actualizado, qué decisiones quedan pendientes, qué verificaciones han pasado y qué modelo, proveedor y coste se han utilizado.

### 3.6. Automatizar lo seguro y preguntar lo ambiguo

Las operaciones deterministas y reversibles pueden automatizarse. Las decisiones semánticas, arquitectónicas o destructivas deben pedir intervención del usuario.

### 3.7. Optimización inicial para proyectos nuevos

La primera versión se centrará en repositorios nuevos o vacíos. La adopción en proyectos existentes será un flujo posterior.

## 4. Componentes principales

### 4.1. OpenCode: runtime y superficie de interacción

Responsabilidades:

- gestionar sesiones;
- fusionar configuración global y local;
- ejecutar agentes, comandos, skills y tools;
- aplicar permisos;
- integrar LSP y formatters;
- gestionar compactación;
- proporcionar TUI, escritorio o integración IDE.

### 4.2. OpenRouter: plano de control de modelos

OpenCode conocerá roles semánticos estables, por ejemplo:

```text
main
build
explore
review
verify
```

La política de OpenRouter decidirá qué modelo, proveedor, fallback y perfil de privacidad corresponde a cada rol.

La integración contemplará:

- presets o aliases semánticos;
- fallbacks;
- compatibilidad con tool calling;
- continuidad por sesión;
- política de privacidad;
- límites de gasto;
- información de uso y coste;
- verificación de la configuración remota esperada.

Los detalles exactos de API, headers, routers y presets se verificarán contra la documentación vigente antes de implementarse.

### 4.3. Observabilidad local

La observabilidad será un plano central del sistema, no una función secundaria.

```text
OpenCode
    ↓
proxy o sidecar local de observabilidad
    ↓
OpenRouter

proxy local
    ↓ OTLP / OpenInference
backend y UI local
```

El proxy expondrá un endpoint compatible con OpenCode, reenviará las peticiones a OpenRouter y registrará la telemetría. Debe conservar streaming, tool calling, structured outputs, headers, errores y campos específicos de OpenRouter.

**Backend de referencia para el MVP:** Arize Phoenix local, sujeto a un spike técnico. Langfuse podrá ofrecerse como perfil alternativo para equipos.

Telemetría de inferencia:

- modelo solicitado y resuelto;
- proveedor seleccionado;
- tokens de entrada, salida, reasoning y caché;
- coste real;
- latencia y time-to-first-token;
- errores, reintentos y fallbacks;
- `session_id`;
- metadata de routing.

Telemetría operativa de OpenCode:

- proyecto, sesión, agente y comando;
- tool calls y duración;
- errores de sesión;
- compactaciones;
- verificaciones;
- eventos relevantes de Graphify.

Privacidad predeterminada:

- almacenamiento local;
- UI enlazada a `127.0.0.1`;
- prompts y respuestas completos desactivados por defecto;
- metadata, usage y errores activados;
- redacción de secretos antes de persistir;
- retención configurable.

Comandos previstos:

```text
portable-opencode observe start
portable-opencode observe stop
portable-opencode observe status
portable-opencode observe open
portable-opencode observe doctor
```

### 4.4. RTK

RTK reducirá el ruido de las salidas operativas y el consumo de contexto. No sustituye la observabilidad ni la verificación.

### 4.5. Graphify

Graphify será la memoria estructural del código. Se instalará desde el inicio, tendrá un `.graphifyignore` generado y refinado y mantendrá estado explícito sobre actualización, calidad y decisiones pendientes.

### 4.6. Documentación y OKF

La documentación de contexto adoptará un subconjunto compatible con **Open Knowledge Format (OKF)** para expresar procedencia, estado, verificación, fuentes y ciclo de vida.

OKF no sustituye Graphify:

```text
OKF      → conocimiento curado, procedencia y ciclo de vida
Graphify → estructura y relaciones del código
LSP      → semántica precisa del lenguaje
```

## 5. Arquitectura por capas

### Capa 1: entorno del ordenador

Instala y configura:

- OpenCode;
- OpenRouter;
- proxy y backend local de observabilidad;
- RTK;
- Graphify;
- configuración global;
- agentes, comandos, plugins, skills y tools globales;
- permisos seguros;
- diagnóstico final.

Esta capa no conoce el stack ni la arquitectura de un proyecto concreto.

### Capa 2: scaffold portable del proyecto

`portable-opencode init-project <ruta>`:

1. valida que la ruta esté vacía o recién creada;
2. inicializa Git;
3. crea la estructura documental;
4. copia la configuración local de OpenCode;
5. genera `.graphifyignore` provisional;
6. crea `graphify-out/` y el estado local;
7. instala hooks y tools locales;
8. deja el proyecto preparado para `/init-project`.

### Capa 3: configuración interactiva dentro de OpenCode

`/init-project`:

1. define propósito, usuarios, alcance y restricciones;
2. completa la documentación;
3. selecciona o detecta el stack;
4. genera la estructura técnica mínima;
5. configura LSP, formatter y verificaciones;
6. finaliza `.gitignore` y `.graphifyignore`;
7. genera y audita el primer grafo;
8. ejecuta `/init` nativo de OpenCode;
9. revisa `AGENTS.md`;
10. verifica la aplicación;
11. marca el proyecto como `ready`.

### Capa 4: secretos y estado privado

Nunca se versionan:

- API keys;
- tokens;
- credenciales SSH;
- `.env` reales;
- autenticación local;
- trazas privadas;
- bases de datos de observabilidad;
- caches y logs sensibles.

## 6. Estructura inicial de un proyecto

```text
my-project/
├── .git/
├── AGENTS.md
├── opencode.jsonc
├── .gitignore
├── .graphifyignore
├── .opencode/
│   ├── agents/
│   ├── commands/
│   ├── plugins/
│   ├── skills/
│   └── tools/
├── docs/context/
│   ├── index.md
│   ├── log.md
│   ├── PROJECT.md
│   ├── ARCHITECTURE.md
│   ├── CONVENTIONS.md
│   ├── OPERATIONS.md
│   ├── DECISIONS.md
│   └── ROADMAP.md
├── graphify-out/
└── .portable-opencode/
    └── state.json
```

## 7. Modelo de agentes

### `build`

Agente principal. Puede editar y ejecutar comandos seguros, pero no leer secretos, hacer push ni realizar operaciones destructivas.

### `plan`

Analiza y crea planes sin modificar el proyecto.

### `explore`

Subagente de comprensión estructural. Prioridad de consulta:

1. documentación del proyecto;
2. Graphify;
3. LSP;
4. búsqueda textual;
5. lectura directa.

### `architect`

Evalúa alternativas, trade-offs y decisiones arquitectónicas. No implementa por defecto.

### `review`

Revisa diff, contratos, diagnósticos, tests e impacto estructural. No modifica.

### `verify`

Ejecuta lint, typecheck, tests, build y smoke tests. No edita salvo permiso explícito.

### `docs`

Mantiene documentación del proyecto sin modificar código fuente.

## 8. Commands, skills, plugins y tools

Distinción canónica:

```text
AGENTS.md   → principios permanentes y breves
Skill       → procedimiento cargado bajo demanda
Command     → flujo iniciado explícitamente por el usuario
Agent       → rol con modelo, tools y permisos
Plugin      → automatización ligada a eventos
Custom tool → operación estructurada ejecutable
```

Comandos iniciales:

```text
/init-project
/project-status
/context-review
/explore
/plan
/implement
/debug
/review
/verify
/graph-status
/graph-update
/graph-audit
/graph-review
/decision
/cost
/handoff
```

Plugins mínimos:

- `portable-security`;
- `portable-graphify`;
- `portable-compaction`;
- `portable-session`;
- `portable-observability`.

Custom tools previstas:

- `project_status`;
- `project_context`;
- `graph_status`;
- `graph_update`;
- `graph_audit`;
- `graph_decision`;
- `verification_profile`;
- `observability_status`.

## 9. Permisos y seguridad

Filosofía:

```text
Lectura segura        → allow
Edición dentro repo   → allow para build
Diagnóstico           → allow
Comandos conocidos    → allow
Operaciones externas  → ask
Operaciones peligrosas → deny
```

Se denegará por defecto la lectura de `.env`, claves privadas y certificados. `git push`, `git reset --hard`, `git clean`, `rm -rf` y operaciones destructivas equivalentes estarán denegadas o requerirán aprobación explícita según el perfil.

Los permisos variarán por agente. `architect` y `review` tendrán capacidades más restrictivas que `build` o `verify`.

## 10. Graphify como subsistema de primera clase

`.graphifyignore` se compondrá mediante:

```text
base universal
+ fragmento del stack
+ estructura real del repositorio
+ decisiones del usuario
= .graphifyignore final
```

Acciones automáticas seguras:

- dependencias;
- builds;
- caches;
- cobertura;
- archivos minificados;
- binarios;
- temporales;
- artefactos claramente generados.

Rutas ambiguas que requieren decisión:

```text
generated/
fixtures/
examples/
migrations/
schemas/
vendor/
legacy/
notebooks/
scripts/
data/
docs/generated/
```

Las decisiones se persistirán para no repetir preguntas.

Eventos conceptuales:

```text
file.edited             → graph_dirty = true
file.created            → analizar patrón
session.idle            → actualizar si procede
git commit              → sincronizar
git checkout            → revisar estado
nuevo directorio        → revisar ignore
gran crecimiento        → auditoría
archivos sin clasificar → decisión pendiente
```

El MVP priorizará comandos explícitos antes de activar automatización avanzada en idle.

## 11. OpenRouter Policy

La política versionada documentará:

- privacidad predeterminada;
- proveedores permitidos;
- fallbacks;
- routers;
- límites de gasto;
- logs;
- continuidad de sesión;
- plugins permitidos;
- perfiles estándar y ZDR estricto.

Configuración conceptual inicial:

```text
main    → Auto Router
build   → router orientado a coding
explore → modelo rápido / throughput
review  → modelo fuerte de coding o reasoning
verify  → modelo barato y fiable
```

Principios:

- una API key por usuario;
- límites de gasto configurables;
- prompt logging desactivado;
- `data_collection: deny` como política base;
- ZDR como perfil opcional;
- fallbacks habilitados;
- provider pinning solo cuando exista una razón demostrada;
- response caching desactivado para tareas dependientes del estado del repositorio;
- prompt caching aprovechado cuando sea posible;
- metadata y usage activados para observabilidad.

## 12. Portabilidad y propiedad del estado

### Versionado en el repositorio portable

- configuración global;
- agentes, comandos, plugins, tools y skills;
- política de OpenRouter;
- configuración de RTK;
- observabilidad;
- templates;
- generador de `.graphifyignore`;
- scripts, schemas y tests.

### Versionado en cada proyecto

- `AGENTS.md`;
- `opencode.jsonc`;
- `.opencode/`;
- documentos de contexto;
- `.gitignore`;
- `.graphifyignore`;
- configuración de verificación;
- decisiones no sensibles;
- outputs de Graphify cuando se decida versionarlos.

### Exclusivamente local

- credenciales;
- autenticación;
- trazas;
- caches;
- bases de datos de observabilidad;
- logs privados;
- estado de sesión no compartible.

## 13. Estructura propuesta del repositorio portable

```text
portable-opencode/
├── bin/
├── global/
│   ├── opencode.jsonc
│   ├── tui.json
│   ├── AGENTS.md
│   ├── agents/
│   ├── commands/
│   ├── plugins/
│   ├── skills/
│   └── tools/
├── project/
├── openrouter/
│   ├── POLICY.md
│   ├── presets.yaml
│   ├── providers.yaml
│   └── guardrails.yaml
├── observability/
│   ├── POLICY.md
│   ├── proxy/
│   ├── phoenix/
│   ├── schemas/
│   └── doctor
├── knowledge/
│   ├── OKF.md
│   ├── schemas/
│   └── templates/
├── graphifyignore/
├── profiles/
├── scripts/
├── schemas/
├── tests/
└── docs/
```

Perfiles previstos:

```text
standard
strict-security
team
solo
typescript
python
data-science
observability-minimal
observability-langfuse
okf-strict
```

## 14. Criterios para considerar un proyecto `ready`

- propósito, alcance y stack definidos;
- arquitectura y convenciones documentadas;
- estructura técnica inicial creada;
- dependencias instaladas;
- aplicación mínima ejecutable;
- LSP configurado;
- formatter decidido;
- `.gitignore` y `.graphifyignore` revisados;
- primer grafo generado y auditado;
- `AGENTS.md` alineado con el proyecto real;
- verificaciones definidas y ejecutadas;
- observabilidad disponible o desactivada explícitamente;
- llamada de prueba a OpenRouter correlacionada con la sesión local;
- metadata OKF mínima en los documentos de contexto;
- ninguna decisión crítica pendiente;
- primer commit preparado.

## 15. MVP

Incluido inicialmente:

- estrategia explícita de soporte por plataforma;
- instalación idempotente y backup;
- configuración global de OpenCode;
- integración básica con OpenRouter;
- proxy local de observabilidad;
- Phoenix local para metadata, usage, coste y errores;
- plugin `portable-observability`;
- RTK y Graphify;
- `doctor` global;
- `init-project` para repositorios nuevos;
- documentos compatibles con el subconjunto mínimo de OKF;
- agentes base;
- comandos esenciales;
- permisos seguros;
- generador inicial de `.graphifyignore`;
- actualización explícita del grafo;
- handoff y compactación con estado esencial.

Diferido:

- hooks avanzados en idle;
- sincronización remota automática de presets;
- dashboards y evaluaciones avanzadas;
- SDK de OpenCode;
- policies experimentales obligatorias;
- adopción de repositorios existentes;
- marketplace de perfiles.

## 16. Riesgos de diseño

- exceso de automatización y hooks;
- duplicación de funciones nativas de OpenCode;
- acoplamiento a servicios remotos;
- grafo ruidoso por mala depuración;
- configuración excesivamente personal;
- falsa portabilidad multiplataforma;
- observabilidad demasiado pesada;
- captura accidental de información sensible;
- duplicación entre OKF, Graphify y documentación.

## 17. Decisiones adoptadas

- OpenCode será el runtime principal.
- OpenRouter será el plano de control de modelos, proveedores, routing, privacidad y costes.
- El proyecto se define como configuración conjunta de OpenCode + OpenRouter.
- La observabilidad local formará parte del núcleo.
- Phoenix será el backend de referencia del MVP, sujeto a validación.
- La documentación adoptará un subconjunto compatible con OKF.
- RTK y Graphify formarán parte del núcleo.
- Graphify se instalará desde el inicio.
- `.graphifyignore` será generado y refinado.
- El sistema se optimizará primero para proyectos nuevos.
- `/init-project` conservará el `/init` nativo.
- Los MCPs serán opcionales.
- La seguridad se expresará en configuración y permisos.
- Las ambigüedades se preguntarán y persistirán.
- El sistema será público, gratuito y configurable.

## 18. Decisiones abiertas

- nombre definitivo;
- lenguaje del CLI;
- estrategia multiplataforma;
- formato exacto del estado;
- outputs de Graphify que se versionarán;
- actualización y migración entre versiones;
- presets iniciales de OpenRouter;
- lenguaje y diseño del proxy de observabilidad;
- retención y granularidad de trazas;
- confirmación de Phoenix tras el spike;
- grado de conformidad OKF;
- política exacta de costes y privacidad;
- agentes globales frente a locales;
- hooks incluidos en el MVP;
- validación según versión de OpenCode;
- límites de personalización compatibles con la ruta recomendada.

## 19. Siguiente artefacto

Antes de escribir scripts debe crearse una **matriz de configuración** con estas columnas:

```text
Feature
Responsabilidad
Configuración global
Configuración por proyecto
Valor predeterminado
Perfil que puede modificarlo
Se genera dinámicamente
Requiere pregunta al usuario
Plugin, command o tool relacionado
Criterio de validación
Estado de soporte
```

Esta matriz será la frontera entre la visión y la implementación.

## 20. Referencias técnicas

- [OpenCode: providers y baseURL](https://opencode.ai/docs/providers/)
- [OpenCode: plugins y eventos](https://opencode.ai/docs/plugins/)
- [OpenRouter: Broadcast](https://openrouter.ai/docs/guides/features/broadcast)
- [OpenRouter: metadata y debugging](https://openrouter.ai/docs/api_reference/errors-and-debugging)
- [Arize Phoenix: OpenRouter tracing](https://arize.com/docs/phoenix/integrations/llm-providers/openrouter/openai-tracing)
- [Arize Phoenix](https://github.com/Arize-ai/phoenix)
- [Google Cloud: Open Knowledge Format v0.2](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
