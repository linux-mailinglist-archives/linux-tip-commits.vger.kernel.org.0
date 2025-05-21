Return-Path: <linux-tip-commits+bounces-5714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6ABABFA40
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C3117D6FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E8226CF8;
	Wed, 21 May 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDqHFrdq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2n7t4Nh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E432253E0;
	Wed, 21 May 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842575; cv=none; b=XIWnoymYWUfaH6hQFqx2TAUhfmfrHRDHddMVzsl2g6j21IUE7kh0mhXazKGn06CGszTv8qAQKkQpG/BOjfnKmlzean7S8xHo2xV5g2fMhdQRRY+42SqokPuYSvV2UgeERwy3Vw0JhMarBa+ZpTCVu+TViwMq3BeDAzTZAN38oCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842575; c=relaxed/simple;
	bh=ibovuddDWoRIPLq3W4rW1tVBgq77dcS7P/MMYq5B/lk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HDmUi36dNwQ80JGfMjto2a0ka9s/XPDGibbBgbg2nryHDGYqPF5mAn1+N+8apzikTn1n+u42RcrM8LWKSwT3hdAY/65hUsKRTlaN9K6RRGtqU9pkTm2HZenp9VXWs/PjmCoRfAMff1xLV9gQwwYPS0G9Hk5muWvIeJFDS2p1EVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDqHFrdq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2n7t4Nh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg1DCJMXweYljS/+nHgOKWSHR2A2F3Pyh7wc8R+DMtg=;
	b=cDqHFrdqFcjtr0k7lYeN3GNMNhwOiciBIewvu0Uu8ZfzTY1C+XzQqx+mxHNb4uyYg5auEV
	kjFzdZOYlEuxKx6FOj+v5lyTQcVVVvH6SgCZ/bsF/ToA2sAzHOXtNLFnsAEb43DrEM6tVX
	KfUU2w6w2H9Nfi27xc4/oaU8z3CMhQdZ0xKNfjlre/62wd9khtLwd5GZodmmbeBpieVxrR
	K03BfRl+WoRT8BGJ4PJOWMq4Gil9bbRuu2cGLSLh82CruT+vxU//inVSKD8uhlNiV5aggN
	7XR25yUtdqF+fWlNWH74gB4qAJKsRdUo8+L8ClEFS9S25br8yniEPPE+TDqr9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg1DCJMXweYljS/+nHgOKWSHR2A2F3Pyh7wc8R+DMtg=;
	b=Q2n7t4NhEePaFfvztlpaL58zjjN5Y3oHhqbUqr622xLqwry2PKRgNAIZv3Wenhly1LPSFN
	QvyDatTNn7vxk2Cw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 img,pistachio-gptimer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022249.2587839-1-robh@kernel.org>
References: <20250506022249.2587839-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257066.406.4748610289506778761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     e7ddb13fa6203cad3546104c4f5edbbc70cc59cf
Gitweb:        https://git.kernel.org/tip/e7ddb13fa6203cad3546104c4f5edbbc70cc59cf
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:48 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert img,pistachio-gptimer to DT schema

Convert the ImgTec Pistachio Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022249.2587839-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt  | 28 ----------------------------
 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.yaml | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/img,pistachio-gptimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
deleted file mode 100644
index 7afce80..0000000
--- a/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Pistachio general-purpose timer based clocksource
-
-Required properties:
- - compatible: "img,pistachio-gptimer".
- - reg: Address range of the timer registers.
- - interrupts: An interrupt for each of the four timers
- - clocks: Should contain a clock specifier for each entry in clock-names
- - clock-names: Should contain the following entries:
-                "sys", interface clock
-                "slow", slow counter clock
-                "fast", fast counter clock
- - img,cr-periph: Must contain a phandle to the peripheral control
-		  syscon node.
-
-Example:
-	timer: timer@18102000 {
-		compatible = "img,pistachio-gptimer";
-		reg = <0x18102000 0x100>;
-		interrupts = <GIC_SHARED 60 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SHARED 61 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SHARED 62 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SHARED 63 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clk_periph PERIPH_CLK_COUNTER_FAST>,
-		         <&clk_periph PERIPH_CLK_COUNTER_SLOW>,
-			 <&cr_periph SYS_CLK_TIMER>;
-		clock-names = "fast", "slow", "sys";
-		img,cr-periph = <&cr_periph>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.yaml b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.yaml
new file mode 100644
index 0000000..a8654bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/img,pistachio-gptimer.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/img,pistachio-gptimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pistachio general-purpose timer
+
+maintainers:
+  - Ezequiel Garcia <ezequiel.garcia@imgtec.com>
+
+properties:
+  compatible:
+    const: img,pistachio-gptimer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Timer0 interrupt
+      - description: Timer1 interrupt
+      - description: Timer2 interrupt
+      - description: Timer3 interrupt
+
+  clocks:
+    items:
+      - description: Fast counter clock
+      - description: Slow counter clock
+      - description: Interface clock
+
+  clock-names:
+    items:
+      - const: fast
+      - const: slow
+      - const: sys
+
+  img,cr-periph:
+    description: Peripheral control syscon phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - img,cr-periph
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/pistachio-clk.h>
+
+    timer@18102000 {
+        compatible = "img,pistachio-gptimer";
+        reg = <0x18102000 0x100>;
+        interrupts = <GIC_SHARED 60 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 61 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 62 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SHARED 63 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_periph PERIPH_CLK_COUNTER_FAST>,
+                 <&clk_periph PERIPH_CLK_COUNTER_SLOW>,
+                 <&cr_periph SYS_CLK_TIMER>;
+        clock-names = "fast", "slow", "sys";
+        img,cr-periph = <&cr_periph>;
+    };

