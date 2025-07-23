Return-Path: <linux-tip-commits+bounces-6178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DBB0EBBC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DBD4E6DE9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A427702B;
	Wed, 23 Jul 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UPizMVM+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDf9PeJr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF46276038;
	Wed, 23 Jul 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255059; cv=none; b=L7CU03KjCIsTBQnX6Qoboc0u45PrmCRwYYPgJI+E7Se6QsK1kRMA+9ltcFGbqh6IoMQk4lkl20gGT4JY0patxJHL8hnoXiqeoULNCodZRm/oCOMjTFqP06I8Nats4Qc0e7t+HV9DL2s88AV5zps5f4uVIRHKcT5fDircoLUcnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255059; c=relaxed/simple;
	bh=VXhFW+Is2mISOazqWwec0seRoQmqoxlHfRjUy7MW2Ko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dEtfubQJmGuS24nIiEmC/H2tuWvJxLWJ+bMFK6vVktgl2aHi3zojLmwLOUklkH+nsKyPiwo/0UCTLBWsrfwp+jaR38nE38KjA5/VpeT8JSZzdoLBxjYyKIV9b8/EFbQf1zaCiXB9RIxkQUURY9d35P07DnGG4/9oO1+lTUC+FRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UPizMVM+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDf9PeJr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QprxoD37XOyfVVmJDAUmPJd2Dnp0VBK53Wd+ovHWxg=;
	b=UPizMVM+OukIE/jFcYu3ZzTQT5eM2e6YVtXxbQN+pGkqD8aBvYtPSf77v4aL2olXeiFOze
	re2nLzysEnEgu8y4tE+FlwoXLB+yBRoVgeSJvy6GmYX8Sf30yQjZfoeep7uZxn/2+DsHat
	AxyGoU1j1WTcWI8DL1yzSEaaOgU1JBIL1bedaNoiK/oiysnmbZT+TxBb/1VRZ+B9nvikWp
	S+MWfH1N0JSVE/4O+Cy48S6MOUW2paPnHphrK9hwhMMxQSi6z6aPH/VpOQ+dujthoh4uZH
	RXCUc2FbIcA2SFnyrp/M7IWNYqWgXYvUhXdIczGzLHUHbVUwSWXYezP65hxLrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QprxoD37XOyfVVmJDAUmPJd2Dnp0VBK53Wd+ovHWxg=;
	b=DDf9PeJr3UHYT8tpAobblcpV0NmUCDiS8Y809XVd9MKq1GUsZ9ELjDfqSRydaKreeDYwGX
	PcJxGF6/iD6DxWAg==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 faraday,fttmr010 to DT schema
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611232621.1508116-1-robh@kernel.org>
References: <20250611232621.1508116-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505522.1420.16942809963249460632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     253a421da69f79e41115b6c083e6c8bc833c5af4
Gitweb:        https://git.kernel.org/tip/253a421da69f79e41115b6c083e6c8bc833=
c5af4
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Wed, 11 Jun 2025 18:26:20 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

dt-bindings: timer: Convert faraday,fttmr010 to DT schema

Convert the Faraday fttmr010 Timer binding to DT schema format. Adjust
the compatible string values to match what's in use. The number of
interrupts can also be anywhere from 1 to 8. The clock-names order was
reversed compared to what's used.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250611232621.1508116-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

