Return-Path: <linux-tip-commits+bounces-5724-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B16ABFA8D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF368C38E2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8922D4E9;
	Wed, 21 May 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnDkSuru";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3yMveyS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602622A80D;
	Wed, 21 May 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842583; cv=none; b=XRJtE2rQGfKMTAtsKBXzkklB9W7j/KjwwIqiaIMuWuq8MmLkY8Y1X9hZiofd9nzCdEzzvrldXMmbKSUx8hks/bLNSEW/elSG2o91uoljlRjvcAc98ai6l83itoxntQeDDCtsXDFYMUcWfggLE8o5TU+t/VdMQETo72G23fylO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842583; c=relaxed/simple;
	bh=N8MOjW8mgMf7r3//8sydcfqC8vFdzQnYcct4uQ9iPiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Achv7PY21TBro78wxepIYVhWZ7jSbe8r7mCgOfOB7glSwkvLn7sxn+pdw0RZgYjj/YDSJK6RSlOYdoOAqtlG/k0ph+91eEKZsdtLnW4XEDcd7x9TvJ2QujMPB74A8bp92I4qeaTFZZZM/WLpJhvYPpMls0g4bnmfgHqGs7iKqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnDkSuru; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3yMveyS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3vi6mhsnKAUP+UkfVb5NkPZXqXLwh+BhbGjPpHMqWo=;
	b=UnDkSurutmbz6A6KR0pzKzm+lQAxdzex0mNXFwvMzH1sl1WfyWdGXf5Z2vLqm7fmOuXHkN
	UVjoNx4WqbFU3TDCFuJUhfCV9DF/LQsvdAMCde/uYoOUq3y1XHjnn0Ep1kZL3iPzfgmrI5
	MKCcNtU71CHl+drajllXFSRuy+O3ldKxY+9k1hHRCk4TVemG1NaX+Zul0t4WyFxfI9cBq0
	0Y1Qlv7X1sBp7gXUoc4hFv8s4V93FqSDpMmDJeA1CQ/kvkizsjzLm4C9k54QdvFw5xGi7M
	ui3zbrS3V8TdOn1Vr2HU/LmoajYCOBE05TC7Fp03B7+fGq7QSlQO2zORJsUJjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3vi6mhsnKAUP+UkfVb5NkPZXqXLwh+BhbGjPpHMqWo=;
	b=N3yMveySvgwxKK119Rh8eobQqED1m3AQCwfoYUjvnfEsvsgM/fssVh2/m9XHWpP6R3EiCK
	9lk0xx21z05y+LAA==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 csky,gx6605s-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Guo Ren <guoren@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022224.2586860-1-robh@kernel.org>
References: <20250506022224.2586860-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257872.406.28652684031332948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     c3205f0f855d17f09fc67bcc9e7897038c8d8e08
Gitweb:        https://git.kernel.org/tip/c3205f0f855d17f09fc67bcc9e7897038c8d8e08
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:23 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert csky,gx6605s-timer to DT schema

Convert the C-SKY gx6605s timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20250506022224.2586860-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt  | 42 ------------------------------------------
 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.yaml | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
deleted file mode 100644
index 6b04344..0000000
--- a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-=================
-gx6605s SOC Timer
-=================
-
-The timer is used in gx6605s soc as system timer and the driver
-contain clk event and clk source.
-
-==============================
-timer node bindings definition
-==============================
-
-	Description: Describes gx6605s SOC timer
-
-	PROPERTIES
-
-	- compatible
-		Usage: required
-		Value type: <string>
-		Definition: must be "csky,gx6605s-timer"
-	- reg
-		Usage: required
-		Value type: <u32 u32>
-		Definition: <phyaddr size> in soc from cpu view
-	- clocks
-		Usage: required
-		Value type: phandle + clock specifier cells
-		Definition: must be input clk node
-	- interrupt
-		Usage: required
-		Value type: <u32>
-		Definition: must be timer irq num defined by soc
-
-Examples:
----------
-
-	timer0: timer@20a000 {
-		compatible = "csky,gx6605s-timer";
-		reg = <0x0020a000 0x400>;
-		clocks = <&dummy_apb_clk>;
-		interrupts = <10>;
-		interrupt-parent = <&intc>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.yaml b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.yaml
new file mode 100644
index 0000000..888fc81
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/csky,gx6605s-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: gx6605s SOC Timer
+
+maintainers:
+  - Guo Ren <guoren@kernel.org>
+
+properties:
+  compatible:
+    const: csky,gx6605s-timer
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@20a000 {
+        compatible = "csky,gx6605s-timer";
+        reg = <0x0020a000 0x400>;
+        clocks = <&dummy_apb_clk>;
+        interrupts = <10>;
+    };

