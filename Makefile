#!/usr/bin/env make

include Makehelp.mk

.EXPORT_ALL_VARIABLES:

SUBFOLDER ?= .

## Check that all .tf files are in canonical format
check:
	docker-compose run --rm terra terraform fmt -check -diff -recursive
.PHONY: check

## Format .tf files
fmt:
	docker-compose run --rm terra terraform fmt -diff -recursive
.PHONY: fmt

## Validate with tflint
lint:
	cat .run-tflint.sh | docker-compose run --rm terra bash
.PHONY: lint

## Scans all modules for potential security issues
tfsec:
	cat .run-tfsec.sh | docker-compose run --rm terra bash
.PHONY: tfsec

## Generate markdown documentation for a terraform module (expect SUBFOLDER)
readme:
	docker-compose run --rm terra bash -c "sed -i '1,/<!-- TERRAFORM-DOCS-GENERATION -->/!d' README.md; terraform-docs markdown . >> README.md"
.PHONY: readme

## Terraform 0.13upgrade
0.13upgrade:
	cat .terraform-0.13upgrade.sh | docker-compose run --rm terra bash
.PHONY: all-readme
