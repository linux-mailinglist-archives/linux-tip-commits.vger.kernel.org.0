Return-Path: <linux-tip-commits+bounces-5706-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E1EABFA52
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F66B188BFE5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B59221737;
	Wed, 21 May 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QQizQK0x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BjM4uCsk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CD21A420;
	Wed, 21 May 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842568; cv=none; b=mTVtqo20iMAwi6RE1Ylo3o1CLwlmFUfEfmBUDlmjM78h6Ou8SW2Ae8ZrSneVeY7/n01cfQyTrE7EdWFzNtt2OyzXBAyS1EXVr2NWtFtEkoKh+eU4b+z9gerHquj5TReU26Z8zG3CWciLrflxB8Nr5o0WjXVS6N1ks4lsVRHgUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842568; c=relaxed/simple;
	bh=AFswaxu1D/kc2/90e/73OjgOVtbQZHbuA0+XTp8JX9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VzoJG29/+KHWP4/+9+Uv1sYfyASkkDhs4gPeS+CcBFh24GbihPTLb66bJG4yGWrft8tr6VaeNrmILAAfpmLUv+043Cl9jeNGNXyBFJ9iWY7miTF6vueFVK1eraRlr/QfBEWKWWnV22CrPs0j7u7FbOS/IE0TpCU98GemlB6ZasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QQizQK0x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BjM4uCsk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842565;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuKF6+4HSBnOBnjMKkjS7OfzJVXOgQpBEipRBZWHRE0=;
	b=QQizQK0xJocSSDKsEvIm9dPT42jcBkGBhSIeOPtpqGMGGjo3SZHD9Dc+V7zeASAGYDpHVb
	/Y/2kg/HpMNEKux90xyC4RON6qhRHFGXKEGcyTOrv5VQYS9VK5tPUBr1SOAgKqUXpuBdYM
	wijuyCjuxSmrpejCVr+NR/WMwSD5/gfbjY6Wi8qoP4FDRQ7SYKwX3QoHIdhjbLfXglJAU/
	gmKWA0fKAuRTCsqX+/6b7AxtBuNO2xyNemd26fYidvbnRyVYo6XmD2DOksqSfIObnluHj+
	2W4UK1Fiiicf9tatK8VkHONC6D1/wShRFZsJNoONUuRoJc+toUb/xnDfZzU58Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842565;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuKF6+4HSBnOBnjMKkjS7OfzJVXOgQpBEipRBZWHRE0=;
	b=BjM4uCsk1bW3RcC1E8TCWGd3DKZlh21m6vi5H/rxwHM5ZLom0yaitDtHQMf8huzZJPSkqE
	Nrxq1gM0FnGM9rDg==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 ti,keystone-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022330.2589598-1-robh@kernel.org>
References: <20250506022330.2589598-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256404.406.12210120289861025338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     4d54b0b401f4ba97cbd0d65ddfe3dda2576a2500
Gitweb:        https://git.kernel.org/tip/4d54b0b401f4ba97cbd0d65ddfe3dda2576a2500
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:29 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:34 +02:00

dt-bindings: timer: Convert ti,keystone-timer to DT schema

Convert the TI Keystone Timer binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022330.2589598-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/ti,keystone-timer.txt  | 29 +---
 Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml | 63 +++++++-
 2 files changed, 63 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt b/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
deleted file mode 100644
index d3905a5..0000000
--- a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Device tree bindings for Texas instruments Keystone timer
-
-This document provides bindings for the 64-bit timer in the KeyStone
-architecture devices. The timer can be configured as a general-purpose 64-bit
-timer, dual general-purpose 32-bit timers. When configured as dual 32-bit
-timers, each half can operate in conjunction (chain mode) or independently
-(unchained mode) of each other.
-
-It is global timer is a free running up-counter and can generate interrupt
-when the counter reaches preset counter values.
-
-Documentation:
-https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
-
-Required properties:
-
-- compatible : should be "ti,keystone-timer".
-- reg : specifies base physical address and count of the registers.
-- interrupts : interrupt generated by the timer.
-- clocks : the clock feeding the timer clock.
-
-Example:
-
-timer@22f0000 {
-	compatible = "ti,keystone-timer";
-	reg = <0x022f0000 0x80>;
-	interrupts = <GIC_SPI 110 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clktimer15>;
-};
diff --git a/Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml b/Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml
new file mode 100644
index 0000000..1caf5ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ti,keystone-timer.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ti,keystone-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Keystone timer
+
+maintainers:
+  - Alexander A. Klimov <grandmaster@al2klimov.de>
+  - Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
+
+description: >
+  A 64-bit timer in the KeyStone architecture devices. The timer can be
+  configured as a general-purpose 64-bit timer, dual general-purpose 32-bit
+  timers. When configured as dual 32-bit timers, each half can operate in
+  conjunction (chain mode) or independently (unchained mode) of each other.
+
+  It is global timer is a free running up-counter and can generate interrupt
+  when the counter reaches preset counter values.
+
+  Documentation:
+  https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
+
+properties:
+  compatible:
+    const: ti,keystone-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: irq
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: timer
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@22f0000 {
+        compatible = "ti,keystone-timer";
+        reg = <0x022f0000 0x80>;
+        interrupts = <110 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clktimer15>;
+    };

