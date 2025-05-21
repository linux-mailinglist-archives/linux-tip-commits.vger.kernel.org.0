Return-Path: <linux-tip-commits+bounces-5725-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E35ABFA4F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AE161591
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6771231A32;
	Wed, 21 May 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gYRhCYT3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDMe5UTg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780222B586;
	Wed, 21 May 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842583; cv=none; b=iAltRxckH6KQcqEsRVgHljOIiY9D1MNraJ85FQRqqRoeNtaFFCVL4GYPiF4DILsipve2TiXdpr85PcxqAzOibKf8xTQ8wTfeo3xTN6ns7HW8ue06E3wpcieXAoQXxEZFUS8G00/JPPdTb4KdzkkPnr/vxiYl5hmxInk6m02sMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842583; c=relaxed/simple;
	bh=RoL6MAn+oOTJXbLL/osL1Bo4dfugTQk+XMhwbzmVLP0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LBkLD6+3VFl+lai5ZCBqrOrkuyqMhy+Ub11YRHhg1NIO6DcOiDj00jDHum5Vy4+mAdU+V1lIsSvM/sGk/bjXmSXPqV3RaDx2a5gRqanGPlD4Ybm2ioGbfHbJJegJKxjGg95G78MZfYASRNb8Y8sryt+L/7xJherJQvqJgec/grs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gYRhCYT3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDMe5UTg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88W74Z93WNJ9RJMnsT5Lxsj4PXjrFVeYvOfZnp5DKt4=;
	b=gYRhCYT3Ntg37I/6S3tnak5pZ9xulOSV+CJSW7tZfG0Cv5o3rYL53DEPLEeGNffjHqarPQ
	XRHS+sF7H+n5OhZZbAzA2LWu1vgFXYadtq64HJfMH8QnElJfyKqcHzCSwrX++j+AGGhOTF
	Qj/H3W2YVOQL5JISYd1ZMc9JS+/+feS7jP5WRZWwRLRDvgPkChoG/V0JzpohV1G+IBsZ2z
	k4gT0FWK/2PIfoD3jVWPsLyoQVN9ZkPZoRt5fPPPJ1wS7epEWXBQAAJTsDcUwfc6059Vr9
	/pX5MPpyyZhIrr0vxGsBQSXXlKjKjTdijzG9ZdNfZqbnvVvFNh1KbtwCHf62AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88W74Z93WNJ9RJMnsT5Lxsj4PXjrFVeYvOfZnp5DKt4=;
	b=vDMe5UTgBdLDR8z9wWOimtPe9un1Sc6ijoufcLCthtAF5ETMCn5soU+HF/1Ntll8TxgD70
	uHSMeLWz0zeKsoCA==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert csky,mptimer to
 DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Guo Ren <guoren@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022228.2587029-1-robh@kernel.org>
References: <20250506022228.2587029-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257948.406.7442341595034534014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     157265afbdf257c99280511a3a557933d5b2e9f1
Gitweb:        https://git.kernel.org/tip/157265afbdf257c99280511a3a557933d5b2e9f1
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:27 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert csky,mptimer to DT schema

Convert the C-SKY Multi-processor timer binding to DT schema format.
It's a straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20250506022228.2587029-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/csky,mptimer.txt  | 42 +------
 Documentation/devicetree/bindings/timer/csky,mptimer.yaml | 46 +++++++-
 2 files changed, 46 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
deleted file mode 100644
index f5c7e99..0000000
--- a/Documentation/devicetree/bindings/timer/csky,mptimer.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-============================
-C-SKY Multi-processors Timer
-============================
-
-C-SKY multi-processors timer is designed for C-SKY SMP system and the
-regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
-
- - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
- - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
- - PTIM_CCVR "cr<3, 14>" Current counter value reg.
- - PTIM_LVR  "cr<6, 14>" Window value reg to trigger next event.
-
-==============================
-timer node bindings definition
-==============================
-
-	Description: Describes SMP timer
-
-	PROPERTIES
-
-	- compatible
-		Usage: required
-		Value type: <string>
-		Definition: must be "csky,mptimer"
-	- clocks
-		Usage: required
-		Value type: <node>
-		Definition: must be input clk node
-	- interrupts
-		Usage: required
-		Value type: <u32>
-		Definition: must be timer irq num defined by soc
-
-Examples:
----------
-
-	timer: timer {
-		compatible = "csky,mptimer";
-		clocks = <&dummy_apb_clk>;
-		interrupts = <16>;
-		interrupt-parent = <&intc>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.yaml b/Documentation/devicetree/bindings/timer/csky,mptimer.yaml
new file mode 100644
index 0000000..12cc528
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/csky,mptimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: C-SKY Multi-processors Timer
+
+maintainers:
+  - Flavio Suligoi <f.suligoi@asem.it>
+  - Guo Ren <guoren@kernel.org>
+
+description: |
+  C-SKY multi-processors timer is designed for C-SKY SMP system and the regs are
+  accessed by cpu co-processor 4 registers with mtcr/mfcr.
+
+   - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
+   - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
+   - PTIM_CCVR "cr<3, 14>" Current counter value reg.
+   - PTIM_LVR  "cr<6, 14>" Window value reg to trigger next event.
+
+properties:
+  compatible:
+    items:
+      - const: csky,mptimer
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer {
+        compatible = "csky,mptimer";
+        clocks = <&dummy_apb_clk>;
+        interrupts = <16>;
+    };

