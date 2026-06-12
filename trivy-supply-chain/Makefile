TRIVY ?= docker run --rm -v $(PWD):/work -w /work aquasec/trivy:0.55.0
REPORTS_DIR := reports

.PHONY: prepare scan-images

prepare:
	@mkdir -p $(REPORTS_DIR)

scan-images: prepare
	@bash runbook/scan_image.sh
