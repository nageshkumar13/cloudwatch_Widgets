# 📊 Regain – Production Observability Dashboard  
**Complete Widget Inventory (Single Reference Document)**

This document lists **all widgets present in the final CloudWatch dashboard**,  
**numbered**, **grouped by category**, with their **metrics, statistics, and purpose**.

This file is meant to be:
- A single source of truth

---

## 🌍 EDGE LAYER — CLOUDFRONT

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
| 1 | CloudFront Requests | Requests | Sum | TimeSeries | Total user traffic reaching CDN |
| 2 | CloudFront Error Rate (%) | 4xxErrorRate, 5xxErrorRate | Average | TimeSeries | User-facing errors at edge |
| 3 | CloudFront Cache Hit Rate (%) | CacheHitRate | Average | SingleValue | CDN efficiency & cost optimization |
| 4 | CloudFront Origin Latency | OriginLatency | p95, p99 | TimeSeries | Backend latency as seen by CDN |

---

## 🛡️ SECURITY LAYER — AWS WAF

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
| 5 | WAF Allowed vs Blocked Requests | AllowedRequests, BlockedRequests | Sum | TimeSeries | Legitimate traffic vs blocked attacks |
| 6 | WAF Blocked Requests (Last 5 min) | BlockedRequests | Sum | SingleValue | Detect ongoing or sudden attacks |

---

## 🚦 TRAFFIC LAYER — APPLICATION LOAD BALANCER (ALB)

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
| 7 | RequestCount | RequestCount | Average | TimeSeries | Incoming API / service traffic |
| 8 | Availability % | 5XX errors ÷ RequestCount (expression) | Sum | TimeSeries | SLO-style availability tracking |
| 9 | TargetResponseTime p99 | TargetResponseTime | p99 | TimeSeries | Worst-case request latency |
|10 | Request Count & Errors | RequestCount, HTTPCode_ELB_5XX_Count | Sum | TimeSeries (stacked) | Correlate traffic spikes with failures |

---

## 🧠 COMPUTE LAYER — AMAZON ECS

### ECS Service & Cluster Health

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
|11 | ECS Task Count | TaskCount | Average | TimeSeries | Total running tasks in cluster |
|12 | Backend CPU Utilization | CPUUtilization | Average | TimeSeries | Backend service load |
|13 | Frontend CPU Utilization | CPUUtilization | Average | TimeSeries | Frontend service load |

### ECS Scheduling & Jobs

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
|14 | Task Count (Summary) | TaskCount, PendingTaskCount | Sum / Avg (expression) | SingleValue | Detect scheduling pressure |
|15 | Running Job Tasks | TaskCount, PendingTaskCount | Sum / Avg (expression) | SingleValue | Background / batch job health |

---

## 🗄️ DATA LAYER — AMAZON RDS

### Core Resource Health

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
|16 | RDS CPU Utilization | CPUUtilization | Average | TimeSeries | Database compute saturation |
|17 | RDS Free Storage Space | FreeStorageSpace | Average | TimeSeries | Disk capacity monitoring |
|18 | RDS Freeable Memory | FreeableMemory | Average | TimeSeries | Memory headroom |
|19 | RDS Disk Queue Depth | DiskQueueDepth | Average | TimeSeries | Storage IO contention |

### Performance & Throughput

| # | Widget Name | Metrics | Stats | View | Purpose |
|---|------------|--------|-------|------|--------|
|20 | RDS Read / Write IOPS | ReadIOPS, WriteIOPS | Average | TimeSeries | Read/write workload |
|21 | RDS Read / Write Latency | ReadLatency, WriteLatency | Average | TimeSeries | Storage latency |
|22 | RDS Network Throughput | NetworkReceiveThroughput, NetworkTransmitThroughput | Average | TimeSeries | Network pressure |
|23 | RDS Database Connections | DatabaseConnections | Average | TimeSeries | Connection pool exhaustion risk |

---

## 🧠 HIGH-LEVEL FLOW REPRESENTED

CloudFront → WAF → ALB → ECS → RDS