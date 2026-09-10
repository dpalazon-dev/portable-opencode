# Portable OpenCode + OpenRouter

**Documento:** Especificación conceptual y funcional  
**Estado:** Draft v0.3 — alcance aprobado por el propietario; evidencia técnica pendiente
**Nombre provisional:** `portable-opencode`

## 1. Definición

`portable-opencode` es un sistema versionado, portable, reproducible y configurable para desplegar un entorno de **agentic coding** construido conjuntamente sobre **OpenCode y OpenRouter**.

No es únicamente una distribución de OpenCode. OpenCode actúa como runtime y superficie de interacción; OpenRouter funciona como plano de control de modelos, proveedores, privacidad, costes y routing. RTK, Graphify, la observabilidad local y una capa mínima de automatización completan el sistema.

El objetivo del MVP es permitir que el propietario del repositorio pueda:

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

Será **opinionated by default, configurable by design**: ofrecerá una única configuración personal canónica, con sustituciones explícitas cuando exista una necesidad demostrada. Los perfiles, equipos y organizaciones quedan fuera del MVP.

## 3. Principios de diseño

### 3.1. Aprovechar OpenCode antes de extenderlo

Se utilizarán primero sus capacidades nativas: configuración jerárquica, agentes, subagentes, comandos, skills, permisos, plugins, custom tools, LSP, formatters, watcher, compactación y sesiones.

### 3.2. Convención fuerte, sustitución sencilla

Cada decisión importante tendrá un valor predeterminado, una justificación, un mecanismo de sustitución y un criterio de validación.

### 3.3. Separación de responsabilidades

La instalación del entorno, la configuración de OpenCode y OpenRouter, la preparación del proyecto, la observabilidad y los secretos locales son ámbitos distintos.

### 3.4. Seguridad codificada

Las restricciones críticas deben reflejarse en permisos, herramientas y límites explícitos, no depender únicamente del prompt. Los hooks solo se incorporarán cuando una necesidad repetida y evidencia técnica justifiquen su ciclo de vida.

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

OpenCode conservará sus agentes nativos y portable-opencode mapeará sus responsabilidades a tres roles semánticos estables:

```text
main
reason
fast
```

La política de OpenRouter decidirá qué modelo, proveedor, fallback, privacidad y generación corresponde a cada rol. El mapeo inicial es `build → main`, `plan/review/verify → reason` y `general/explore/scout/small_model → fast`. Los slugs gestionados son `portable-main`, `portable-reason` y `portable-fast`; la sintaxis exacta con la que OpenCode los consume queda pendiente de SPIKE-002.

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

**Backend propuesto para el MVP:** Arize Phoenix local, sujeto a SPIKE-003 y a la aceptación de DEC-010. No se define un backend alternativo ni un perfil de equipos dentro del MVP.

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
- retención predeterminada de 30 días, modificable mediante una operación explícita.

Comandos previstos por el contrato CLI:

```text
portable-opencode observability start
portable-opencode observability stop
portable-opencode observability status
portable-opencode observability open
portable-opencode observability purge
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
- reglas globales y los recursos nativos que estén demostrados como necesarios;
- permisos seguros;
- diagnóstico final.

Esta capa no conoce el stack ni la arquitectura de un proyecto concreto.

La instalación inicial se distribuye mediante **GitHub Releases públicas** y comienza con un único comando de PowerShell. Un launcher o gate de adquisición ya confiable autentica los bytes exactos de `bootstrap.ps1` antes de pedir a PowerShell que los ejecute; después el bootstrap activa la CLI transaccionalmente. El mecanismo concreto sigue bloqueado por `DEC-012`. `bootstrap.ps1` solo establece y verifica una versión del CLI; `portable-opencode install` realiza el preflight estrictamente no mutante, genera el plan, pide aprobación, instala en orden de dependencias y ejecuta el diagnóstico final. El onboarding puede abrir páginas oficiales, esperar al usuario y reanudar la operación desde checkpoints privados no sensibles en `%LOCALAPPDATA%\portable-opencode\environment-state.json`. Si la autenticación cambia el estado remoto, el CLI vuelve a inspeccionar, genera un segundo plan y solicita una segunda aprobación; el modo `--json` nunca abre navegador ni interfaz nativa.

El flujo de autenticación es browser-assisted y delega la captura y custodia de credenciales al mecanismo privado nativo de OpenCode. `portable-opencode` no recibe ni almacena API keys. GitHub, Git y SSH son opcionales para descargar e instalar el entorno; la TUI y el instalador gráfico permanecen diferidos. El contrato completo está en [`DESIGN-013`](design/GUIDED_INSTALLATION_AND_ONBOARDING.md).

### Capa 2: scaffold portable del proyecto

`portable-opencode init-project <ruta>`:

1. valida que la ruta esté vacía o recién creada;
2. inicializa Git cuando no exista y sea seguro hacerlo;
3. crea la estructura documental;
4. copia la configuración local de OpenCode;
5. genera `.graphifyignore` provisional;
6. crea `graphify-out/` y el estado local;
7. materializa solo los assets nativos canónicos y las herramientas justificadas por contrato;
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
11. marca el proyecto como `ready` solo si `project doctor` satisface los predicados de readiness.

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
│   │   ├── review.md
│   │   └── verify.md
│   └── commands/
│       ├── init-project.md
│       ├── review.md
│       ├── verify.md
│       └── graph-update.md
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
│   ├── graph.json
│   ├── GRAPH_REPORT.md
│   └── manifest.json
└── .portable-opencode/
    ├── state.json
    └── verification.json
```

Solo se crean directorios de assets nativos que contengan archivos reales. `manifest.json` es condicional hasta que SPIKE-004 demuestre su portabilidad y ausencia de rutas privadas.

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

### `review`

Revisa diff, contratos, diagnósticos, tests e impacto estructural. No modifica.

### `verify`

Ejecuta el manifiesto de verificación canónico. No edita ni repara silenciosamente.

Los agentes nativos `general`, `explore` y `scout` se conservan para delegación y exploración; no se crean copias personalizadas sin una necesidad repetida.

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

Comandos de proyecto iniciales:

```text
/init-project
/review
/verify
/graph-update
```

El CLI de control permanece separado de OpenCode y expone `status`, `inspect`, `plan`, `apply`, `doctor`, `install`, `init-project`, `project status`, `project doctor` y el ciclo `observability start|stop|status|open|purge`. No se asume un catálogo de plugins ni de tools personalizados antes de que exista una brecha nativa demostrada.

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

Los permisos variarán por agente. `review` y `verify` tendrán capacidades más restrictivas que `build`; ambos son no mutantes. `git push`, la destrucción y la mutación fuera del proyecto permanecen denegadas o requieren aprobación explícita según el contrato aplicable.

## 10. Graphify como subsistema de primera clase

`.graphifyignore` se compondrá mediante:

```text
base universal
+ fragmento del stack
+ estructura real del repositorio
+ decisiones del usuario
= .graphifyignore final
```

La política de salida del MVP es explícita:

- se versionan `graphify-out/graph.json` y `graphify-out/GRAPH_REPORT.md`;
- `graphify-out/manifest.json` se versiona solo tras validación de SPIKE-004;
- HTML, cachés, costes, logs de consultas y exports opcionales permanecen fuera de Git;
- `graphify-out/` se excluye de la extracción del propio grafo.

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

Eventos conceptuales que pueden marcar el estado como `dirty`:

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

El MVP prioriza comandos explícitos (`/graph-update` y el CLI cuando corresponda) antes de activar automatización avanzada en idle o hooks.

## 11. OpenRouter Policy

La política versionada documentará:

- privacidad predeterminada;
- proveedores permitidos;
- fallbacks;
- routers;
- límites de gasto;
- logs;
- continuidad de sesión;
- privacidad y recolección de datos.

Configuración conceptual inicial:

```text
main  → implementación y coding interactivo
reason → planificación, revisión y verificación
fast  → exploración y tareas ligeras
```

Principios:

- una API key por usuario;
- límites de gasto configurables cuando la superficie remota los soporte;
- prompt logging desactivado;
- `data_collection: deny` como política base cuando sea expresable y verificable;
- fallbacks habilitados;
- provider pinning solo cuando exista una razón demostrada;
- response caching desactivado para tareas dependientes del estado del repositorio;
- prompt caching aprovechado cuando sea posible;
- metadata y usage activados para observabilidad;
- la manifest local de presets será `config/openrouter/presets.jsonc`, sin credenciales.

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

## 13. Estructura canónica del repositorio portable

```text
portable-opencode/
├── config/
│   ├── components.jsonc
│   ├── global/
│   │   ├── opencode.jsonc
│   │   └── AGENTS.md
│   ├── openrouter/
│   │   └── presets.jsonc
│   └── resources/
│       ├── environment.jsonc
│       └── project.jsonc
├── templates/project/
│   ├── opencode.jsonc
│   ├── AGENTS.md
│   ├── .opencode/
│   │   ├── agents/review.md, verify.md
│   │   └── commands/init-project.md, review.md, verify.md, graph-update.md
│   ├── docs/context/
│   └── .portable-opencode/
│       ├── state.json
│       └── verification.json
├── scripts/
├── schemas/
└── docs/
```

Este árbol expresa intención canónica; no obliga a crear directorios o assets que aún no tengan una necesidad repetida o evidencia de integración. No existe un catálogo de perfiles en el MVP. La TUI permanece diferida hasta que el CLI sea efectivo.

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
- `graph.json` y `GRAPH_REPORT.md` válidos; `manifest.json` solo si SPIKE-004 lo habilita;
- `AGENTS.md` alineado con el proyecto real;
- verificaciones definidas y ejecutadas;
- observabilidad disponible o marcada explícitamente como degradada/desactivada;
- llamada de prueba a OpenRouter correlacionada con la sesión local;
- metadata OKF mínima en los documentos de contexto;
- ninguna decisión crítica pendiente;
- `project doctor` sin bloqueos.

## 15. MVP

Incluido inicialmente:

- una configuración personal Windows-native y PowerShell;
- onboarding CLI guiado, reanudable y browser-assisted desde una Release pública;
- un CLI headless con inspección, plan, apply, diagnóstico y estado;
- instalación idempotente y backups de recursos gestionados;
- configuración global de OpenCode y scaffold de proyecto raíz;
- integración básica con OpenRouter a través de tres roles semánticos;
- RTK y Graphify con límites de salida explícitos;
- documentos compatibles con el subconjunto mínimo de OKF;
- agentes nativos más `review` y `verify` no mutantes;
- permisos seguros y estado verificable;
- generador inicial de `.graphifyignore`;
- actualización explícita del grafo;
- `init-project` para repositorios nuevos o recién inicializados;
- continuidad mediante contexto, decisiones, estado y verificación.

Condicionado a evidencia y decisiones aún abiertas:

- proxy local y backend Phoenix para observabilidad (`DEC-010`, SPIKE-003);
- versiones y mecanismos de instalación de componentes (SPIKE-001/002/004);
- lenguaje y distribución del CLI (`DEC-009`, `DEC-012`);
- integración exacta de presets OpenRouter desde OpenCode (SPIKE-002).

Diferido:

- hooks avanzados en idle;
- sincronización remota automática de presets;
- dashboards y evaluaciones avanzadas;
- SDK de OpenCode;
- policies experimentales obligatorias;
- adopción de repositorios existentes;
- perfiles, equipos, organizaciones y marketplace;
- TUI de configuración hasta que el CLI sea efectivo.

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

- OpenCode será el runtime principal y OpenRouter el plano de control de modelos, proveedores, routing, privacidad y costes (`DEC-014`, límites de responsabilidad en `ARCHITECTURE.md`).
- El MVP será personal-first, Windows-native, PowerShell y Windows Terminal; la reutilización pública no amplía el alcance MVP (`DEC-014`, `DEC-015`).
- La configuración de proyecto usa `opencode.jsonc` en la raíz y assets nativos bajo `.opencode/`; la configuración global y la procedencia se gestionan por separado (`DEC-017`).
- Se conservan los agentes nativos y solo se añaden `review` y `verify` como subagentes no mutantes; los roles semánticos son `main`, `reason` y `fast` (`DEC-018`).
- Se versiona la allowlist mínima de Graphify: `graph.json`, `GRAPH_REPORT.md` y, condicionalmente, `manifest.json` (`DEC-019`).
- La reconciliación remota gestiona únicamente `portable-main`, `portable-reason` y `portable-fast`, con plan, aprobación, versionado y sin borrado automático (`DEC-020`).
- La materialización distingue `rendered`, `copied`, `linked`, `queried` y `private`, y solo muta recursos con ownership probado (`DEC-021`).
- El primer onboarding usa una Release pública, un bootstrap PowerShell mínimo y checkpoints privados; la autenticación permanece bajo custodia nativa de OpenCode (`DEC-022`, [`DESIGN-013`](design/GUIDED_INSTALLATION_AND_ONBOARDING.md)).
- La documentación usa el subconjunto mínimo de metadatos compatible con OKF (`DEC-011`); RTK y Graphify forman parte del diseño canónico, sujetos a sus spikes de integración.
- Las operaciones ambiguas o destructivas requieren intervención y los secretos/estado privado permanecen fuera de Git.

## 18. Decisiones abiertas

Las siguientes decisiones técnicas siguen evidence-gated y no deben resolverse por preferencia del agente:

- `DEC-009`: lenguaje principal y forma de empaquetado del CLI;
- `DEC-010`: aceptación de Phoenix como backend de observabilidad;
- `DEC-012`: mecanismo final de distribución;
- versión, rutas efectivas y precedencia de OpenCode (`SPIKE-001`);
- representación de presets y política de modelos/proveedores (`SPIKE-002`);
- versiones y comportamiento Windows de Graphify y RTK (`SPIKE-004`).

Preguntas concretas para el propietario, resueltas el 2026-09-09:

1. ¿Aprueba que el alcance normativo del MVP sea personal-first y Windows-native, sin perfiles, equipos, organizaciones ni backend alternativo de observabilidad? **Aprobada.**
2. ¿Aprueba como superficie canónica el CLI de `DESIGN-009`, incluyendo el namespace `observability` y `purge`, y el árbol de recursos de `DESIGN-008`? **Aprobada.**
3. ¿Aprueba que esta especificación pase a ser v0.3 draft para revisión, manteniendo `DEC-009`, `DEC-010` y `DEC-012` abiertas hasta disponer de evidencia? **Aprobada.**
4. ¿Debe conservarse alguna promesa de producto de la v0.2 que no esté reflejada en el contexto actual, en particular la gratuidad, perfiles o compatibilidad con equipos? **No; no se conserva ninguna promesa adicional de la v0.2.**

## 19. Siguiente artefacto

La matriz de configuración ya existe como `DESIGN-001` y sus contratos operativos se han desglosado en `DESIGN-007` a `DESIGN-013`. El propietario ha aprobado el alcance de esta v0.3, las cuatro preguntas anteriores y `DESIGN-013`. La siguiente acción es crear el plan de implementación sin resolver por preferencia los gates técnicos pendientes; los spikes de runtime siguen sujetos a sus gates.

Tras la aprobación, la secuencia es:

1. incorporar únicamente las decisiones aprobadas en la especificación y el contexto;
2. ejecutar los spikes runtime pendientes en el orden documentado;
3. resolver las decisiones evidence-gated con resultados reproducibles;
4. implementar el CLI y los templates sin inventar rutas, versiones o mecanismos.

La matriz canónica conserva estas columnas:

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

Esta matriz y los diseños enlazados son la frontera entre la visión y la implementación.

## 20. Referencias técnicas

- [OpenCode: providers y baseURL](https://opencode.ai/docs/providers/)
- [OpenCode: plugins y eventos](https://opencode.ai/docs/plugins/)
- [OpenRouter: Broadcast](https://openrouter.ai/docs/guides/features/broadcast)
- [OpenRouter: metadata y debugging](https://openrouter.ai/docs/api_reference/errors-and-debugging)
- [Arize Phoenix: OpenRouter tracing](https://arize.com/docs/phoenix/integrations/llm-providers/openrouter/openai-tracing)
- [Arize Phoenix](https://github.com/Arize-ai/phoenix)
- [Google Cloud: Open Knowledge Format v0.2](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)
