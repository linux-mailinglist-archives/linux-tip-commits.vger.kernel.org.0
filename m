Return-Path: <linux-tip-commits+bounces-2851-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AECB89C7CC8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4040E1F224FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673E2071EF;
	Wed, 13 Nov 2024 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z3DViul4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqYV4WNE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12D202647;
	Wed, 13 Nov 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529253; cv=none; b=myTYFl2yQ82rKPLI3kuYLnFv7Tjz7caAJG9OJPuEjKFRrp3ez9lkSg4Vto1iUyCL61bgABrv744z8+XYh0MNfAJ0R95Yj+k1eNwUAj2YLhUwdHc9OcsIM749+bhbi8oubcXHTEM9HfFwCSaouAu/u3Yeu5eTBnr8XsVlZhNdAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529253; c=relaxed/simple;
	bh=8Tb3UQGnFxgYCnN1OMNrOwNslqhqUBg/PzxfPbkTdnc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O9t8ucMIiQJH6tnQc1B/pFqrXcjYe1nA0tKxcMaHdZiO8ifptJdzMGlns5Z/vohglOxBGBIvNEcWJXHPrSRe4zYfHEy+Yb5iEOJlSVKgLiE+Nz6ZtpdnA8LlBz/KHFkE72RElfXtrcpm+iEbgWasMCeVDqmYApQHbNbjb23KBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z3DViul4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqYV4WNE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8jYbjq2PVJU5yg5gLYShXdvhugpljYTevoHexHjIm8=;
	b=Z3DViul433PX/y0BMxsOgNvsDxFqLb1Bg/JE5/XtWDfDVzw/R0FTc2N+ILgmtFfu8KDEKp
	SaPsGcGqXClHGc33O9a0JEO+lJQP5MRslqDPKhRQYiu/c9aPKKQTgoJoXyQr6gdQqlDxV6
	WvbDXlINpsV6239qVtRr8K7+YenO7NLIxJ+Hwq3kQE0APXWhNYU4L8+zj+431nXE/j0Be/
	3BClcj5k6Xjo4DHX7sukdO5gs/O1whVZYUCLoEPvhq2713QRQmAXrIyGUcH3IMaM699cM4
	z5pDOPA0zozN5sBBZY91V3N7vlz+CiL1ygpDONQvoWeqULPX9MPlR3QBVz4+gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8jYbjq2PVJU5yg5gLYShXdvhugpljYTevoHexHjIm8=;
	b=mqYV4WNE9Rp4XEVRi3kgXUbQDx/u3rVnqMYILsGotD1aZm+gnZRV2/4zyAroi+42pmvwKu
	0cOmA02WxVXLSBCA==
From: "tip-bot2 for Ivaylo Ivanov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: actions,owl-timer: convert to YAML
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241103123513.2890107-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241103123513.2890107-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152924899.32228.2522301774377567807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ae4705e1b1bc4dedceb6b0956509e3eb2fedaaf1
Gitweb:        https://git.kernel.org/tip/ae4705e1b1bc4dedceb6b0956509e3eb2fe=
daaf1
Author:        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
AuthorDate:    Sun, 03 Nov 2024 14:35:11 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

dt-bindings: timer: actions,owl-timer: convert to YAML

Convert the Actions Semi Owl timer bindings to DT schema.

Changes during conversion:
 - Add a description
 - Add "clocks" as a required property, since the driver searches for it
 - Correct the given example according to owl-s500.dtsi

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241103123513.2890107-1-ivo.ivanov.ivanov1@g=
mail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/actions,owl-timer.txt  |  21 +------=
--------
 Documentation/devicetree/bindings/timer/actions,owl-timer.yaml | 107 +++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 MAINTAINERS                                                    |   2 +-
 3 files changed, 108 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer=
.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer=
.yaml

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/=
Documentation/devicetree/bindings/timer/actions,owl-timer.txt
deleted file mode 100644
index 977054f..0000000
--- a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Timer
-
-Required properties:
-- compatible      :  "actions,s500-timer" for S500
-                     "actions,s700-timer" for S700
-                     "actions,s900-timer" for S900
-- reg             :  Offset and length of the register set for the device.
-- interrupts      :  Should contain the interrupts.
-- interrupt-names :  Valid names are: "2hz0", "2hz1",
-                                      "timer0", "timer1", "timer2", "timer3"
-                     See ../resource-names.txt
-
-Example:
-
-		timer@b0168000 {
-			compatible =3D "actions,s500-timer";
-			reg =3D <0xb0168000 0x100>;
-			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names =3D "timer0", "timer1";
-		};
diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml b=
/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
new file mode 100644
index 0000000..646c554
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/actions,owl-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl timer
+
+maintainers:
+  - Andreas F=C3=A4rber <afaerber@suse.de>
+
+description:
+  Actions Semi Owl SoCs provide 32bit and 2Hz timers.
+  The 32bit timers support dynamic irq, as well as one-shot mode.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-timer
+      - actions,s700-timer
+      - actions,s900-timer
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - 2hz0
+        - 2hz1
+        - timer0
+        - timer1
+        - timer2
+        - timer3
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - interrupt-names
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - actions,s500-timer
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: 2hz0
+            - const: 2hz1
+            - const: timer0
+            - const: timer1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - actions,s700-timer
+              - actions,s900-timer
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: timer1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+      #address-cells =3D <1>;
+      #size-cells =3D <1>;
+      timer@b0168000 {
+        compatible =3D "actions,s500-timer";
+        reg =3D <0xb0168000 0x100>;
+        clocks =3D <&hosc>;
+        interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "2hz0", "2hz1", "timer0", "timer1";
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2250eb1..3a24287 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2004,7 +2004,7 @@ F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
-F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
 F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
 F:	arch/arm64/boot/dts/actions/

