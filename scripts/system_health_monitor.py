from kubernetes import client, config
import requests
import psutil
import time
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def check_k8s_resources():
    try:
        config.load_kube_config()
        v1 = client.CoreV1Api()

        print("\n--- Kubernetes Pods ---")
        pods = v1.list_pod_for_all_namespaces()
        for pod in pods.items:
            print(f"{pod.metadata.namespace}/{pod.metadata.name}: {pod.status.phase}")

        print("\n--- Kubernetes Services ---")
        services = v1.list_service_for_all_namespaces()
        for svc in services.items:
            print(f"{svc.metadata.namespace}/{svc.metadata.name}: {svc.spec.cluster_ip}")
    except Exception as e:
        print("[ERROR] K8s resources:", e)

def check_ingress(hostname="wisecow.local"):
    try:
        print("\n--- Ingress Health ---")
        response = requests.get(f"http://{hostname}", timeout=5)
        if response.status_code == 200:
            print("Ingress is healthy (200 OK)")
        else:
            print(f"Ingress unhealthy ({response.status_code})")
    except Exception as e:
        print("[ERROR] Ingress check failed:", e)

def check_system_health():
    print("\n--- System Resource Usage ---")
    print(f"CPU: {psutil.cpu_percent()}%")
    print(f"Memory: {psutil.virtual_memory().percent}%")

if __name__ == "__main__":
    try:
        while True:
            print("\n===== System Health Monitor =====")
            check_k8s_resources()
            check_ingress()
            check_system_health()
            print("=================================\n")
            time.sleep(60)
    except KeyboardInterrupt:
        print("\nMonitoring stopped.")

