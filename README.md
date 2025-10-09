# Automatización y Escalabilidad Elástica de Pipelines Bioinformáticos con Nextflow y Cloud Computing
Curso: 2025
 
Integrantes: 
- Javier Alejandro Di Salvo, 
- Gisela Pattarone, 
- Federico Trotta.

# DNA Processing Pipeline

Pipeline desarrollado en **Nextflow** para procesar secuencias de ADN a través de tres etapas secuenciales:  
**Complementación**, **Transcripción** y **Traducción**.  
Cada etapa se ejecuta en un entorno reproducible mediante contenedores Docker basados en **Biocontainers (BioPython)**.

---

## Objetivo del proyecto

Implementar un pipeline bioinformático modular y reproducible que permita transformar una secuencia de ADN en su:
1. Cadena complementaria  
2. Secuencia de ARN mensajero (transcripción)  
3. Secuencia proteica (traducción)

Este flujo ilustra los principios básicos de procesamiento de secuencias biológicas utilizando **Nextflow**, **Docker** y **BioPython**.

---

## ⚙️ Descripción del flujo de trabajo

### Procesos involucrados

| Proceso      | Descripción | Script asociado | Entrada | Salida |
|---------------|-------------|-----------------|----------|---------|
| `complement`  | Genera la secuencia complementaria de ADN | `scripts/complement.py` | `dna.txt` | Cadena complementaria |
| `transcribe`  | Transcribe el ADN a ARN | `scripts/transcribe.py` | Output de `complement` | Cadena de ARN |
| `translate`   | Traduce la secuencia de ARN en proteína | `scripts/translate.py` | Output de `transcribe` | Secuencia proteica |

---

## Diagrama del pipeline

```mermaid
flowchart LR
    A[input/dna.txt] --> B[Complement]
    B --> C[Transcribe]
    C --> D[Translate]
    D --> E[Output: Protein Sequence]
````

---

## Uso de contenedores

Todos los procesos se ejecutan dentro del contenedor público de **BioPython**:

```yaml
biocontainers/biopython:1.79--pyhdfd78af_3
```

Esto asegura un entorno homogéneo y reproducible, independientemente del sistema operativo del usuario.

---

## Ejecución del pipeline

### 1. Clonar el repositorio

```bash
git clone <URL-del-repo>
cd dna-pipeline
```

### 2. Estructura esperada del proyecto

```
.
├── main.nf
├── nextflow.config
├── scripts/
│   ├── complement.py
│   ├── transcribe.py
│   └── translate.py
├── input/
│   └── dna.txt
├── results/
└── reports/
```

### 3. Ejecutar el pipeline con Docker

```bash
nextflow run main.nf -profile docker -with-report -with-timeline -with-trace
```

### 4. Generar el DAG del flujo

```bash
nextflow dag main.nf | dot -Tpng > reports/dag.png
```

---

## Reproducibilidad y trazabilidad

El pipeline implementa herramientas de auditoría integradas de Nextflow:

| Reporte      | Descripción                                        | Archivo                 |
| ------------ | -------------------------------------------------- | ----------------------- |
| **Trace**    | Registro detallado de procesos, tiempos y recursos | `reports/trace.txt`     |
| **Report**   | Resumen HTML de ejecución                          | `reports/report.html`   |
| **Timeline** | Visualización temporal de cada tarea               | `reports/timeline.html` |

---

## Ejecución distribuida (opcional)

Se incluye un perfil `cluster` en `nextflow.config` para ejecución en **entornos Kubernetes o SLURM**, facilitando escalabilidad horizontal.

---

## Métricas de performance

El pipeline puede escalar horizontalmente al procesar múltiples archivos de entrada:

```bash
input/
├── dna_1.txt
├── dna_2.txt
└── dna_3.txt
```

Cada archivo genera resultados independientes en `results/`, optimizando el uso de CPU y memoria.

---

## Dependencias

* **Nextflow ≥ 23.10.0**
* **Docker ≥ 24.0**
* **BioPython** (desde imagen biocontainers)
* **Graphviz** (para generar DAG)

---

El presente repositorio corresponde al "Trabajo Final Integrador Automatización y Escalabilidad Elástica de Pipelines Bioinformáticos con Nextflow y Cloud Computing" - Javier Di Salvo, Gisela Pattarone, Federico Trotta
```
