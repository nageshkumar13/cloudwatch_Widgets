# 📊 Regain – Production Observability Dashboard  
**Complete Widget Inventory (Single Source of Truth)**

This document provides a **complete, authoritative inventory of all widgets** present in the Regain Production CloudWatch dashboard.

Each widget is:
- **Numbered**
- **Grouped by architectural layer**
- Documented with **metrics, statistics, view type, and purpose**

This README is intended to serve as:
- 📌 A single reference for engineers
- 📌 A review artifact during incidents
- 📌 An architecture explanation for audits and interviews

---

## 🧭 Architecture Flow Represented


---

## 🌍 EDGE LAYER — AMAZON CLOUDFRONT

| # | Widget Name | Metrics | Statistics | View | Purpose |
|---|------------|--------|------------|------|--------|
| 1 | CloudFront Requests | Requests | Sum | TimeSeries | Measure total end-user traffic reaching the CDN |
| 2 | CloudFront Error Rate (%) | 4xxErrorRate, 5xxErrorRate | Average | TimeSeries | Detect user-visible errors at the edge |
| 3 | CloudFront Cache Hit Rate (%) | CacheHitRate | Average | SingleValue | Evaluate CDN efficiency and cache effectiveness |
| 4 | CloudFront Origin Latency (p95 / p99) | OriginLatency | p95, p99 | TimeSeries | Measure backend latency as experienced by CloudFront |

---

## 🛡️ SECURITY LAYER — AWS WAF

| # | Widget Name | Metrics | Statistics | View | Purpose |
|---|------------|--------|------------|------|--------|
| 5 | WAF Allowed vs Blocked Requests | AllowedRequests, BlockedRequests | Sum | TimeSeries | Compare legitimate traffic against blocked threats |
| 6 | WAF Blocked Requests (Last 5 min) | BlockedRequests | Sum | SingleValue | Detect spikes indicating active or ongoing attacks |

---

## 🚦 TRAFFIC LAYER — APPLICATION LOAD BALANCER (ALB)

| # | Widget Name | Metrics | Statistics | View | Purpose |
|---|------------|--------|------------|------|--------|
| 7 | Request Count | RequestCount | Average | TimeSeries | Track incoming application traffic |
| 8 | Availability % | 1 − (5XX / RequestCount) | Sum (expression) | TimeSeries | SLO-style availability monitoring |
| 9 | Target Response Time (p99) | TargetResponseTime | p99 | TimeSeries | Observe worst-case request latency |
|10 | ALB Request Count & Errors | RequestCount, HTTPCode_ELB_5XX_Count | Sum | TimeSeries (stacked) | Correlate traffic volume with error spikes |

---

## 🧠 COMPUTE LAYER — AMAZON ECS  
### Single-Service Cluster Architecture

> The application runs as **a single ECS service**.  
> Therefore, monitoring focuses on **cluster health, task counts, and scheduling pressure**, rather than per-service CPU splits.

### ECS Cluster & Scheduling Health

| # | Widget Name | Metrics | Statistics | View | Purpose |
|---|------------|--------|------------|------|--------|
|11 | ECS Task Count | TaskCount | Average | TimeSeries | Track total running tasks in the ECS cluster |
|12 | Task Count (Summary) | TaskCount, PendingTaskCount | Sum / Average (expression) | SingleValue | Detect scaling delays or scheduling pressure |
|13 | Running Job Tasks | TaskCount, PendingTaskCount | Sum / Average (expression) | SingleValue | Monitor background or batch workloads |

---

## 🗄️ DATA LAYER — AMAZON RDS

### Core Resource Health

| # | Widget Name | Metrics | Statistics | View | Purpose |
|---|------------|--------|------------|------|--------|
|14 | RDS CPU Utilization | CPUUtilization | Average | TimeSeries | Detect database compute saturation |
|15 | RDS Free Storage Space | FreeStorageSpace | Average | TimeSeries | Monitor remaining disk capacity |
|16 | RDS Freeable Memory | FreeableMemory | Average | TimeSeries | Ensure sufficient memory headroom |
|17 | RDS Disk Queue Depth | DiskQueueDepth | Average | TimeSeries | Identify storage IO contention |

### Performance & Throughput

| # | Widget Name | Metrics | Statistics | View | Purpose |
|---|------------|--------|------------|------|--------|
|18 | RDS Read / Write IOPS | ReadIOPS, WriteIOPS | Average | TimeSeries | Observe read/write workload intensity |
|19 | RDS Read / Write Latency | ReadLatency, WriteLatency | Average | TimeSeries | Detect slow disk operations |
|20 | RDS Network Throughput | NetworkReceiveThroughput, NetworkTransmitThroughput | Average | TimeSeries | Monitor network pressure |
|21 | RDS Database Connections | DatabaseConnections | Average | TimeSeries | Identify connection pool exhaustion risk |

---

## ✅ Key Design Principles Reflected

- **Single-service ECS architecture** (no misleading frontend/backend split)
- **User-centric monitoring** starting at the edge
- **Clear correlation paths** from traffic → errors → compute → database
- **Terraform-driven, parameterized dashboard**
- **Production-ready and audit-friendly**

---

## 📌 Usage Notes

- This dashboard is deployed via **Terraform** using a `dashboard.json.tmpl` template.
- All identifiers (ALB, ECS cluster, RDS, CloudFront, WAF) are injected via `templatefile()`.
- The README should be updated **only when widgets are added or removed**.

---

**End of document.**
