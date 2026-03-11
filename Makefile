# SPDX-FileCopyrightText: 2026 Stichting GIDS Open Standaarden
# SPDX-FileCopyrightText: 2026 Roland Groen
#
# SPDX-License-Identifier: EUPL-1.2

builder:
	docker build -t ig-builder .

ig:
	docker run --rm --name=ig-builder \
		-v ./input:/app/input \
		-v ./output:/app/output \
		-v ./ig.ini:/app/ig.ini \
		-v ./sushi-config.yaml:/app/sushi-config.yaml \
		-v ./build-cache:/app/input-cache \
		ig-builder
