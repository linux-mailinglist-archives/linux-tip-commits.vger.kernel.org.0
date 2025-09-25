Return-Path: <linux-tip-commits+bounces-6768-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E58BA19DB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C861C825B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DEB330869;
	Thu, 25 Sep 2025 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbFjixBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58UNggkj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F332F74A;
	Thu, 25 Sep 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836038; cv=none; b=tpuKD+mUq9prI4hDfY8cGeBE/dz/LMo2QcY8GZPOJaf/tMV6+vHUrdlrEhaBfHqGd1293QcCX8hgKPpSyS9ftcUK1s7oRVmxTDTnClOmK9Xv3LDJr1zZa+fy9sR8VR02mzB+0Yul61AJx/XCT7Wn5Hl2/kY47k5MWE6Pt4KcKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836038; c=relaxed/simple;
	bh=DfuhIwC3i/g7KoVf3hqt24sBYqcuOgSGJNnaZD0bp68=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YgNOXWhSSrznml/uIluRj5Dh4c72YB2UzTy5i2iqpci+R148DmPSwsUcfiqbST2bCnULjyRd4erge1QlAbHEyZUPX9zqruAyMoImBXrTN8CqcWse21sByLjEM49fO5i7vFi0rfx9Tl/ZAZCYpDEf59IQ782EW/2UD4zzS1XJn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbFjixBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58UNggkj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fFUBQGbsx3fhMPmOEGEJ3QqqBFbvKakhbBgWQ2ejXXU=;
	b=tbFjixBzb7NILr3ITWir5eiJ68rvHmHNeDfKvd85NyxOB47ovEq6KYJQXf2xJhM67WusTW
	xDpXHnaGzsX8YvU+CQy4RTbGdjp0ApLEnMTITKWONTWNEsZHOHJ35zpurKaf2lHLKdFEMG
	anRlhZrvyWj432khrzp0KPu8846rk6TZ4SzoG8zCJxCDrDaT2BR9/kdWdm7UfxvnqSyV1D
	ImLaue/vHRUr76U9vtnaeUxisGj+hEq95ZAXNKfBeuPGN6H7eBT/2ayxMFS5+vLjBorlWQ
	uM0rdd2QBmO0Uqn0SLbxiKYqPzoX1v/hVY7efHOWZ7i9huQV5gXQtZIBMHKkCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836032;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fFUBQGbsx3fhMPmOEGEJ3QqqBFbvKakhbBgWQ2ejXXU=;
	b=58UNggkjPbDIU1Ozk6P45vFgK77RA5rAcxoJrmT2uOQiTMYmgrheoGhCpw1ceDK6fJUVSF
	KLuCEjuJ4myG9eBg==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 faraday,fttmr010 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603135.709179.6839450229338235932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     ef0e000cd162a58dba10608ef6959f172d1bc5f4
Gitweb:        https://git.kernel.org/tip/ef0e000cd162a58dba10608ef6959f172d1=
bc5f4
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Wed, 11 Jun 2025 18:26:20 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:52:51 +02:00

dt-bindings: timer: Convert faraday,fttmr010 to DT schema

Convert the Faraday fttmr010 Timer binding to DT schema format. Adjust
the compatible string values to match what's in use. The number of
interrupts can also be anywhere from 1 to 8. The clock-names order was
reversed compared to what's used.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

