# Monitoring Stack for STANS Navigation System

This directory contains a complete monitoring stack with Prometheus, Grafana, Alertmanager, Node Exporter, and cAdvisor for monitoring the STANS Navigation System.

Components

1. Prometheus

- Purpose: Metrics collection and storage

- Port: 9090

- Features:

- Time-series database

- Alerting engine

- Service discovery

- Query language (PromQL)

1. Grafana

- Purpose: Visualization and dashboards

- Port: 3000

- Default Credentials: admin/admin

- Features:

- Beautiful dashboards

- Alert visualization

- Multiple data sources

- Plugin ecosystem

1. Alertmanager

- Purpose: Alert routing and notification

- Port: 9093

- Features:

- Alert grouping

- Alert deduplication

- Multiple receivers (email, Slack, etc.)

- Alert inhibition

1. Node Exporter

- Purpose: System-level metrics

- Port: 9100

- Metrics: CPU, memory, disk, network, etc.

1. cAdvisor

- Purpose: Container metrics

- Port: 8081

- Metrics: Container CPU, memory, filesystem, network

Quick Start

1. Start Monitoring Stack

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

cd monitoring

docker-compose up -d

1. Access Services

- Prometheus: <http://localhost:9090>

- Grafana: <http://localhost:3000> (admin/admin)

- Alertmanager: <http://localhost:9093>

- Node Exporter: <http://localhost:9100/metrics>

- cAdvisor: <http://localhost:8081>

1. Verify Setup

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check all services are running

docker-compose ps

## Check Prometheus targets

curl <http://localhost:9090/api/v1/targets>

## Check Grafana health

curl <http://localhost:3000/api/health>

Configuration

Prometheus Configuration

Edit prometheus/prometheus.yml to:

- Add new scrape targets

- Adjust scrape intervals

- Configure alert rules

- Set up service discovery

Alertmanager Configuration

Edit alertmanager/alertmanager.yml to:

- Configure email notifications

- Set up Slack webhooks

- Define routing rules

- Configure inhibition rules

Grafana Configuration

- Datasources: Automatically configured via provisioning

- Dashboards: Add JSON files to grafana/dashboards/

- Plugins: Install via Grafana UI or CLI

Alerts

Configured Alerts

Application Alerts

- STANSApplicationDown: Application is down (Critical)

- STANSHighErrorRate: Error rate above 5% (Warning)

- STANSHighResponseTime: 95th percentile response time > 1s (Warning)

- STANSHighCPUUsage: CPU usage above 80% (Warning)

- STANSHighMemoryUsage: Memory usage above 90% (Warning)

- STANSDiskSpaceLow: Disk space below 10% (Warning)

System Alerts

- NodeDown: Node is down (Critical)

- NodeHighCPU: Node CPU usage above 80% (Warning)

- NodeHighMemory: Node memory usage above 90% (Warning)

Alert Routing

- Critical alerts: Sent to oncall team and Slack #stans-critical

- Warning alerts: Sent to team email and Slack #stans-warnings

Dashboards

Creating Custom Dashboards

- Log in to Grafana (<http://localhost:3000>)

- Click "+" → "Dashboard"

- Add panels and queries

- Save dashboard

- Export JSON to grafana/dashboards/

Importing Dashboards

- Go to Grafana → "+" → "Import"

- Upload JSON file or paste JSON

- Select Prometheus datasource

- Import

Metrics

Application Metrics

To expose metrics from the STANS application, add a /metrics endpoint that returns Prometheus-formatted metrics:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

// Example metrics endpoint

app.get('/metrics', (req, res) => {

  res.set('Content-Type', 'text/plain');

  res.send(`

## HELP http_requests_total Total number of HTTP requests

## TYPE http_requests_total counter

http_requests_total{method="GET",path="/",status="200"} 1234

## HELP http_request_duration_seconds HTTP request duration

## TYPE http_request_duration_seconds histogram

http_request_duration_seconds_bucket{le="0.1"} 100

http_request_duration_seconds_bucket{le="0.5"} 200

http_request_duration_seconds_bucket{le="1.0"} 250

http_request_duration_seconds_bucket{le="+Inf"} 300

  `);

});

System Metrics

Node Exporter provides:

- CPU usage and load

- Memory usage

- Disk I/O and space

- Network traffic

- System uptime

Container Metrics

cAdvisor provides:

- Container CPU usage

- Container memory usage

- Container network I/O

- Container filesystem usage

- Container lifecycle events

Queries

Common Prometheus Queries

Application Health

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Application is up

up{job="stans-app"}

## Request rate

rate(http_requests_total{job="stans-app"}[5m])

## Error rate

rate(http_requests_total{job="stans-app",status=~"5.."}[5m])

## Response time (95th percentile)

histogram_quantile(0.95, rate(http_request_duration_seconds_bucket{job="stans-app"}[5m]))

Resource Usage

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## CPU usage

rate(container_cpu_usage_seconds_total{name="stans-app"}[5m])

## Memory usage

container_memory_usage_bytes{name="stans-app"}

## Memory usage percentage

container_memory_usage_bytes{name="stans-app"} / container_spec_memory_limit_bytes{name="stans-app"} * 100

System Metrics

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Node CPU usage

100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

## Node memory usage

(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100

## Disk usage

(1 - (node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"})) * 100

Maintenance

Backup Data

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Backup Prometheus data

docker exec prometheus tar -czf /tmp/prometheus-backup.tar.gz /prometheus

docker cp prometheus:/tmp/prometheus-backup.tar.gz ./backups/

## Backup Grafana data

docker exec grafana tar -czf /tmp/grafana-backup.tar.gz /var/lib/grafana

docker cp grafana:/tmp/grafana-backup.tar.gz ./backups/

Restore Data

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Restore Prometheus data

docker cp ./backups/prometheus-backup.tar.gz prometheus:/tmp/

docker exec prometheus tar -xzf /tmp/prometheus-backup.tar.gz -C /

## Restore Grafana data

docker cp ./backups/grafana-backup.tar.gz grafana:/tmp/

docker exec grafana tar -xzf /tmp/grafana-backup.tar.gz -C /

Update Configuration

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Reload Prometheus configuration

curl -X POST <http://localhost:9090/-/reload>

## Reload Alertmanager configuration

curl -X POST <http://localhost:9093/-/reload>

## Restart Grafana

docker-compose restart grafana

Clean Up

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Stop all services

docker-compose down

## Remove volumes (WARNING: deletes all data)

docker-compose down -v

## Remove old data

docker system prune -a

Troubleshooting

Prometheus Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check Prometheus logs

docker logs prometheus

## Check configuration

docker exec prometheus promtool check config /etc/prometheus/prometheus.yml

## Check targets

curl <http://localhost:9090/api/v1/targets>

Grafana Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check Grafana logs

docker logs grafana

## Check datasource connection

curl <http://localhost:3000/api/datasources>

## Reset admin password

docker exec grafana grafana-cli admin reset-admin-password newpassword

Alertmanager Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check Alertmanager logs

docker logs alertmanager

## Check Configuration

docker exec alertmanager amtool check config /etc/alertmanager/alertmanager.yml

## Test alerts

curl -X POST <http://localhost:9093/api/v1/alerts> -d '[{"labels":{"alertname":"Test"}}]'

Security

Secure Prometheus

- Enable authentication in prometheus.yml

- Use TLS for connections

- Restrict network access

- Use firewall rules

Secure Grafana

- Change default password

- Enable anonymous access (if needed)

- Configure LDAP/OAuth

- Use HTTPS

Secure Alertmanager

- Use TLS for notifications

- Secure webhook URLs

- Validate alert sources

- Use rate limiting

Best Practices

- Retention: Configure appropriate data retention periods

- Sampling: Use appropriate scrape intervals

- Labeling: Use consistent labeling strategy

- Alerting: Set appropriate alert thresholds

- Dashboards: Create meaningful dashboards

- Documentation: Document metrics and alerts

- Testing: Test alert rules regularly

- Backups: Regular backup of configuration and data

Integration

Slack Integration

- Create Slack webhook

- Update alertmanager/alertmanager.yml

- Test webhook URL

Email Integration

- Configure SMTP settings

- Update alertmanager/alertmanager.yml

- Test email delivery

PagerDuty Integration

- Install PagerDuty receiver

- Configure routing rules

- Test integration

Performance Tuning

Prometheus

- Adjust storage.tsdb.retention.time

- Configure storage.tsdb.retention.size

- Tune scrape_interval and evaluation_interval

- Use remote storage for long-term retention

Grafana

- Enable caching

- Use dashboard folders

- Optimize queries

- Use query caching

Support

- Prometheus Documentation

- Grafana Documentation

- Alertmanager Documentation

- Node Exporter

- cAdvisor

License

This monitoring configuration is part of the STANS Navigation System project.
