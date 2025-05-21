Return-Path: <linux-tip-commits+bounces-5717-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CCABFA62
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D20C7B6B83
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16977228C92;
	Wed, 21 May 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmt840KR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sPGtXSC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC33226D0B;
	Wed, 21 May 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842578; cv=none; b=QneTrzvvkHDXMV4JDJGOeA3ZgYCW7jK/IV0R0UDy81lduCxDC2K8IGb59zb3/Fn2WXr3OesQ7uqrgVElKA8UC0k/NfJB5uNvshGFsIfl7GkoUMdQ32BLZQJe70ytE2xdt4EmOIcxg9iGiUisa8lFvmOx5BVgSX/DYbOR0X53Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842578; c=relaxed/simple;
	bh=fNGVXBuqFzdmkFwTg7lUi4mtOR+yZL8Ispz4s0oQgP8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NhOMGYJo/P90zqBZGUjxyyRERYh1liIW6oO6wmjXnZ0mpDNwwTbsuxXNiLJY/afYHBRHzAu+DHhfjdTPWVr4ZQhpzJ/IZj6vsRDwoRch9K2mWm8CkApEGKW82qJinyv48F9aLXgJtbzMs5F5SL9qm2SYsFtBRnS+1saTJCuFd+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmt840KR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sPGtXSC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgdVOD998YHgfr6Uvy+XgzD4X2u87x2Ydb1jrNSsa4A=;
	b=gmt840KRtsBA/+HclZL/az71kl2K0yi3FoyNFRhx60FlcrSZD0CuyPOFPWDyl9p46fboU9
	aM9HI7imTFurOWHub/HnVsRsQ8LlTYE/TOwFm59X9Vno49J6H29PSNrO4dzJqbDCbXU0lg
	ZCCgMZWd09Qm0m4KO38YP1RU+LaNodTjOcpOAdnxgel+0VkdmW5v2EMY0TWRGSf7dOd2LR
	8aNoHgo5eXiNdEVbHiMfnHtWSnPeHwjYgxI+gHS3sQEYc9Abs0nUMcWTyqCzvPm7uh4pi0
	dmtWwVYB2tVH1LVkdt1opJj4uxtXoPmHNIkybZiDAPYRGsjD2Rpfodrbc6JHPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgdVOD998YHgfr6Uvy+XgzD4X2u87x2Ydb1jrNSsa4A=;
	b=0sPGtXSClBPRZq5fVkQk0CB2D4LtDbPK8HB/tPYedDQtZjjP7HII2RNGG8ZFzaTVLRYmyR
	wWkZtsFiK9aT30CA==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 cirrus,clps711x-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022215.2586595-1-robh@kernel.org>
References: <20250506022215.2586595-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257230.406.2964489299683715870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     d65a30c30e54666cf63ba671e93d2fcbc8863a54
Gitweb:        https://git.kernel.org/tip/d65a30c30e54666cf63ba671e93d2fcbc8863a54
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:14 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert cirrus,clps711x-timer to DT schema

Convert the Cirrus CLPS711x timer binding to DT schema format. It's a
straight-forward conversion.

Drop the aliases node and second example which aren't relevant.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022215.2586595-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt  | 29 -----------------------------
 Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.yaml | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
deleted file mode 100644
index d4c62e7..0000000
--- a/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Cirrus Logic CLPS711X Timer Counter
-
-Required properties:
-- compatible: Shall contain "cirrus,ep7209-timer".
-- reg       : Address and length of the register set.
-- interrupts: The interrupt number of the timer.
-- clocks    : phandle of timer reference clock.
-
-Note: Each timer should have an alias correctly numbered in "aliases" node.
-
-Example:
-	aliases {
-		timer0 = &timer1;
-		timer1 = &timer2;
-	};
-
-	timer1: timer@80000300 {
-		compatible = "cirrus,ep7312-timer", "cirrus,ep7209-timer";
-		reg = <0x80000300 0x4>;
-		interrupts = <8>;
-		clocks = <&clks 5>;
-	};
-
-	timer2: timer@80000340 {
-		compatible = "cirrus,ep7312-timer", "cirrus,ep7209-timer";
-		reg = <0x80000340 0x4>;
-		interrupts = <9>;
-		clocks = <&clks 6>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.yaml b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.yaml
new file mode 100644
index 0000000..507b777
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cirrus,clps711x-timer.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/cirrus,clps711x-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CLPS711X Timer Counter
+
+maintainers:
+  - Alexander Shiyan <shc_work@mail.ru>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - cirrus,ep7312-timer
+          - const: cirrus,ep7209-timer
+      - const: cirrus,ep7209-timer
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
+    timer@80000300 {
+        compatible = "cirrus,ep7312-timer", "cirrus,ep7209-timer";
+        reg = <0x80000300 0x4>;
+        interrupts = <8>;
+        clocks = <&clks 5>;
+    };

