Return-Path: <linux-tip-commits+bounces-5732-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82DABFA8F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841C31B61EB6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416682820DE;
	Wed, 21 May 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lmw9wwIR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NH4GMekd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04222B586;
	Wed, 21 May 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842590; cv=none; b=jAQ7gPCs8D6VIvVbPTiGydNOXV2X109V0EYmoxSlDf9EvSdFjXa7ViScdcL1VoX87vG2F3ozQ0LGB4KPympP3+xuvJFP4PeWrZ++K5U3Gb85DMFieDvyXsu0XZcY/AqJCP8f3ZNnvALPjJOU9+y7VEwOCpo2M05ApP1gxae1OKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842590; c=relaxed/simple;
	bh=rXWZrBlFWj6RpqBa8ewK64fcW9SFImDWeqnUwkPhoHk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PNJjK+5ue3orSH/peewGl9yJDH5sYzhFIf0+KbMNtSe8TyVM7aQCPJM52/IU6T4EzSV9c5CkV44/j+UJy/QIF6S6pKRu0hRGAQYoeGCduaQ9vTRfvSH/RD30XQE6rWjeCJIX4zI1lJPukG9tdka1ZfuQS3V4HH8pmshh+fDlQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lmw9wwIR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NH4GMekd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqhbuhZcifi0iboyMXbWxIS3nbNr+P7UOthD/WLue5U=;
	b=lmw9wwIRBVuasFTdwvJRT+euoJ10fsZbgMCcY/x7KXSc6Xcc/DR3YKhEJwsEl6AO58F0WO
	2xqM5os5JZS1QUak/40xJpScl12lnrarEWEsyf7tFs06WXZb8LLS6cSnx08SfM1TlHixBL
	M4tmTDzss9tlQZi0G0EcY75hH64weGoiEIcji5r1jnTl8Aruce4HwL+By9g2XbtUCeu9Df
	g8oCctorQ6RN0RzXlw8QUshl3Osc2boqqziKHKUN7Ur8WVTXzWKpCdJRNxivKv1zBVODx/
	ms4ooqgDgw4JgEcqHg55WOh3rnNSg82PCWxhngGnzW7MAYjwoez3yOUGHMG7Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqhbuhZcifi0iboyMXbWxIS3nbNr+P7UOthD/WLue5U=;
	b=NH4GMekdoJ3xrZoIgWOXl+jwJVUZA+TDuj5imKkGvgcBUkxj/YeTdxANLa5WrhFdmCSUS2
	r6t6/GJ/1mAmpPCg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] dt-bindings: timer: Add NXP System Timer Module
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Thomas Fossati <thomas.fossati@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250417151623.121109-2-daniel.lezcano@linaro.org>
References: <20250417151623.121109-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258593.406.9430531057971147561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     eec34ebb65aab20d2488808770b7f080104d4426
Gitweb:        https://git.kernel.org/tip/eec34ebb65aab20d2488808770b7f080104d4426
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 17 Apr 2025 17:16:18 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:32 +02:00

dt-bindings: timer: Add NXP System Timer Module

Add the System Timer Module description found on the NXP s32 platform
and the compatible for the s32g2 variant.

Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250417151623.121109-2-daniel.lezcano@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/nxp,s32g2-stm.yaml | 64 +++++++-
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,s32g2-stm.yaml

diff --git a/Documentation/devicetree/bindings/timer/nxp,s32g2-stm.yaml b/Documentation/devicetree/bindings/timer/nxp,s32g2-stm.yaml
new file mode 100644
index 0000000..b44b979
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,s32g2-stm.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/nxp,s32g2-stm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP System Timer Module (STM)
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+description:
+  The System Timer Module supports commonly required system and application
+  software timing functions. STM includes a 32-bit count-up timer and four
+  32-bit compare channels with a separate interrupt source for each channel.
+  The timer is driven by the STM module clock divided by an 8-bit prescale
+  value.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-stm
+      - items:
+          - const: nxp,s32g3-stm
+          - const: nxp,s32g2-stm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Counter clock
+      - description: Module clock
+      - description: Register clock
+
+  clock-names:
+    items:
+      - const: counter
+      - const: module
+      - const: register
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@4011c000 {
+        compatible = "nxp,s32g2-stm";
+        reg = <0x4011c000 0x3000>;
+        interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
+        clock-names = "counter", "module", "register";
+    };

