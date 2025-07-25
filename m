Return-Path: <linux-tip-commits+bounces-6208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89CB11C81
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F310E3A699D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7752EBBB2;
	Fri, 25 Jul 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uK6IuG/N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydgX0eg6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B82EB5C1;
	Fri, 25 Jul 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439515; cv=none; b=ehP6kM1G+m1z4I3UGzxhx7sHL+hN/OoNZ/rKWJy4vhrVxRWkrfawOazf6TDkBm5lD/FRBd5IV7lEyGD9Ifzpg5I+ZeJMT810wwzTkuOKMfD5raxhpKX6REp3rthbJ0jWOSti0h8KfXl3SNpnxGP4U/VROiZTmbEu4J42o+lzTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439515; c=relaxed/simple;
	bh=txE6K/rdG4mI6uG5lqOY4YAb8tMEBAElzWeSyELF0yY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cd9C/ocn0KafxM1J53R8Sjv+3mSkrtI7nvH2ndvM+/pxWosywV9GpxsvcyHpC4W5qrkB1nnnk4ZwMb46xmoCS3xNA5paDe3MegOeONCwXXio4eJ5krZFCNI8rNNuYo2/PsvVvGEuruva2PQxpzBnEC5XiRP4ua9mkRnTy3xxVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uK6IuG/N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ydgX0eg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSMbX39mM3DquZLxx4AHQ+cnA9niF9DLploj03ASXr4=;
	b=uK6IuG/Ngnvw9zWjPGplANvFoRKKkxcKTpsRPTqkqhcNNUUeDrPVpEviRdzLLujYBSA9ct
	znP+Pv0EO5kvJnPBEagDyUpKGM7o0h/ZaAAEGHGFdHnMb6pBGlt7g8T3h+XMbwDzoYQIe4
	V8/E3lt7jBK9Cpbb0mV3aBPLFgRGXVuZyKZPpuSe1/fQv4sQOCy6/neqv2E59+j/DdIBA8
	YchPnjFvcZT9G+W79AyftP7ZL6EeFEKKgv3hlsO/kdHCU+ymxHMN99rA9usYiv+B3xZbRj
	5tZD5rKDDg+YEbDEYxMeWXaYuDcF62y9N+7s7Zb+w7EMDuAZMhzf+oCRT+YVTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSMbX39mM3DquZLxx4AHQ+cnA9niF9DLploj03ASXr4=;
	b=ydgX0eg6qARP3LcTuYFabf5pAOw4f23lnPAD9ZQEXEXapRwFOADIY6+XvsL4SOVqUa2p0W
	+pOORW4wT4mWOKBg==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 faraday,fttmr010 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611232621.1508116-1-robh@kernel.org>
References: <20250611232621.1508116-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950941.1420.1808863574169667696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7276dac8cd12b56c5120cf127380b7be15824047
Gitweb:        https://git.kernel.org/tip/7276dac8cd12b56c5120cf127380b7be158=
24047
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Wed, 11 Jun 2025 18:26:20 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:45:00 +02:00

dt-bindings: timer: Convert faraday,fttmr010 to DT schema

Convert the Faraday fttmr010 Timer binding to DT schema format. Adjust
the compatible string values to match what's in use. The number of
interrupts can also be anywhere from 1 to 8. The clock-names order was
reversed compared to what's used.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20250611232621.1508116-1-robh@kernel.org
---
 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt  | 38 +---
 Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml | 89 +++++++-
 2 files changed, 89 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.=
txt
 create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.=
yaml

diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt b/D=
ocumentation/devicetree/bindings/timer/faraday,fttmr010.txt
deleted file mode 100644
index 3cb2f4c..0000000
--- a/Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Faraday Technology timer
-
-This timer is a generic IP block from Faraday Technology, embedded in the
-Cortina Systems Gemini SoCs and other designs.
-
-Required properties:
-
-- compatible : Must be one of
-  "faraday,fttmr010"
-  "cortina,gemini-timer", "faraday,fttmr010"
-  "moxa,moxart-timer", "faraday,fttmr010"
-  "aspeed,ast2400-timer"
-  "aspeed,ast2500-timer"
-  "aspeed,ast2600-timer"
-
-- reg : Should contain registers location and length
-- interrupts : Should contain the three timer interrupts usually with
-  flags for falling edge
-
-Optionally required properties:
-
-- clocks : a clock to provide the tick rate for "faraday,fttmr010"
-- clock-names : should be "EXTCLK" and "PCLK" for the external tick timer
-  and peripheral clock respectively, for "faraday,fttmr010"
-- syscon : a phandle to the global Gemini system controller if the compatible
-  type is "cortina,gemini-timer"
-
-Example:
-
-timer@43000000 {
-	compatible =3D "faraday,fttmr010";
-	reg =3D <0x43000000 0x1000>;
-	interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
-		   <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
-		   <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
-	clocks =3D <&extclk>, <&pclk>;
-	clock-names =3D "EXTCLK", "PCLK";
-};
diff --git a/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml b/=
Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
new file mode 100644
index 0000000..3950632
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/faraday,fttmr010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday FTTMR010 timer
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  This timer is a generic IP block from Faraday Technology, embedded in the
+  Cortina Systems Gemini SoCs and other designs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: moxa,moxart-timer
+          - const: faraday,fttmr010
+      - enum:
+          - aspeed,ast2400-timer
+          - aspeed,ast2500-timer
+          - aspeed,ast2600-timer
+          - cortina,gemini-timer
+          - faraday,fttmr010
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+    description: One interrupt per timer
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Peripheral clock
+      - description: External tick clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: PCLK
+      - const: EXTCLK
+
+  resets:
+    maxItems: 1
+
+  syscon:
+    description: System controller phandle for Gemini systems
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cortina,gemini-timer
+    then:
+      required:
+        - syscon
+    else:
+      properties:
+        syscon: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@43000000 {
+        compatible =3D "faraday,fttmr010";
+        reg =3D <0x43000000 0x1000>;
+        interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
+                    <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
+                    <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+        clocks =3D <&pclk>, <&extclk>;
+        clock-names =3D "PCLK", "EXTCLK";
+    };

