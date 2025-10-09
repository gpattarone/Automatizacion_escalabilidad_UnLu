# Automatización y Escalabilidad Elástica de Pipelines Bioinformáticos con Nextflow y Cloud Computing
Curso: 2025
 
Integrantes: 
- Javier Alejandro Di Salvo, 
- Gisela Pattarone, 
- Federico Trotta.

# DNA Processing Pipeline

Pipeline desarrollado en **Nextflow (DSL2)** para procesar secuencias de ADN a través de tres etapas secuenciales:  
**Complementación**, **Transcripción** y **Traducción**.  
Cada etapa se ejecuta en un entorno reproducible mediante contenedores **Docker** basados en **Biocontainers (BioPython)**.

---

## Objetivo del proyecto

Implementar un pipeline bioinformático modular y reproducible que permita transformar una secuencia de ADN en su:
1. Cadena complementaria  
2. Secuencia de ARN mensajero (transcripción)  
3. Secuencia proteica (traducción)

El flujo demuestra principios de **Nextflow modular**, **contenedores Docker** y **BioPython** aplicados a procesamiento básico de secuencias biológicas.

---

## Descripción del flujo de trabajo

### Procesos involucrados

| Proceso      | Descripción | Script asociado | Módulo Nextflow | Entrada | Salida |
|---------------|-------------|-----------------|-----------------|----------|---------|
| `complement`  | Genera la secuencia complementaria de ADN | `scripts/complement.py` | `modules/complement.nf` | `dna.txt` | Cadena complementaria |
| `transcribe`  | Transcribe el ADN a ARN | `scripts/transcribe.py` | `modules/transcribe.nf` | Output de `complement` | Cadena de ARN |
| `translate`   | Traduce la secuencia de ARN en proteína | `scripts/translate.py` | `modules/translate.nf` | Output de `transcribe` | Secuencia proteica |

---

## Diagrama del pipeline

```mermaid
flowchart LR
    A[input/dna.txt]:::file --> B[Complement]
    B --> C[Transcribe]
    C --> D[Translate]
    D --> E[[Output: Protein Sequence]]

    classDef file fill:#e8f4fa,stroke:#333,stroke-width:1px,color:#000;
    classDef process fill:#cde7f0,stroke:#333,stroke-width:1px,color:#000;
    classDef output fill:#d5ead5,stroke:#333,stroke-width:1px,color:#000,font-weight:bold;

    class A file;
    class B,C,D process;
    class E output;
````

---

## Estructura del proyecto

```
dna-pipeline/
├── envs/
│   └── biopython.yaml
├── input/
│   └── dna.txt
├── modules/
│   ├── complement.nf
│   ├── transcribe.nf
│   └── translate.nf
├── scripts/
│   ├── complement.py
│   ├── transcribe.py
│   └── translate.py
├── main.nf
├── nextflow.config
└── README.md
```

---

## Uso de contenedores

Todos los procesos se ejecutan dentro del contenedor público de **BioPython**:

```yaml
biocontainers/biopython:1.79--pyhdfd78af_3
```

Esto asegura un entorno homogéneo y reproducible, independiente del sistema operativo.

---

## Ejecución del pipeline

### 1. Clonar el repositorio

```bash
git clone <URL-del-repo>
cd dna-pipeline
```

### 2. Ejecutar el pipeline con Docker

```bash
nextflow run main.nf -profile docker -with-report -with-timeline -with-trace
```

### 3. Generar el diagrama del flujo (DAG)

```bash
nextflow dag main.nf | dot -Tpng > reports/dag.png
```

---

## Perfiles de ejecución

| Perfil    | Descripción                                                          |
| --------- | -------------------------------------------------------------------- |
| `local`   | Ejecución sin contenedores (desarrollo o pruebas rápidas)            |
| `docker`  | Ejecución reproducible usando el contenedor público de Biocontainers |
| `cluster` | Ejecución distribuida en Kubernetes o SLURM (opcional)               |

---

## Reproducibilidad y trazabilidad

El pipeline genera automáticamente reportes de auditoría:

| Reporte      | Descripción                                        | Archivo                 |
| ------------ | -------------------------------------------------- | ----------------------- |
| **Trace**    | Registro detallado de procesos, tiempos y recursos | `reports/trace.txt`     |
| **Report**   | Resumen HTML de ejecución                          | `reports/report.html`   |
| **Timeline** | Visualización temporal de tareas                   | `reports/timeline.html` |

---

## 📈 Escalabilidad

El pipeline puede procesar múltiples archivos en paralelo:

```bash
input/
├── dna_1.txt
├── dna_2.txt
└── dna_3.txt
```

Cada archivo genera su resultado en `results/`, permitiendo evaluar el escalamiento horizontal.

---

## Dependencias

* **Nextflow ≥ 23.10.0**
* **Docker ≥ 24.0**
* **BioPython** (incluido en la imagen `biocontainers/biopython`)
* **Graphviz** (para generar el DAG)

---

El presente repositorio corresponde al "Trabajo Final Integrador Automatización y Escalabilidad Elástica de Pipelines Bioinformáticos con Nextflow y Cloud Computing" - Javier Di Salvo, Gisela Pattarone, Federico Trotta
```
