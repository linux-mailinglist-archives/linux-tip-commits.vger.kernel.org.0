Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70832CE2F5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgLCXsd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgLCXsc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD0C061A52;
        Thu,  3 Dec 2020 15:47:52 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fe1dZJ0fYS6JjnK+yYARCDAyN4MkcEXIge7MgZ5/IFw=;
        b=UIm2j+2adKfI9wkBK3bDWS1SGho6IlLOOkcqFHDIg2+ngtPCi4fAd2b9bH8hoUCka/wC1K
        1tcLEzmt/vvE3qYNGYA2KfrHs2hbyFJKYzBPLc9C/9QFGt77ei9XKdxaw5KRF0Rbe6aQ1Y
        sV102u3Seu4ugQIafHFOUgeg0nVvyPeZRBZuQSwnOC+3hXWMkO96wkYN1ku18JiepHXpec
        ufapK8z3TY+1PpBwSn3+JFsEHG0skXrZD8MTV1NCoxP/VxhA51RcxwhXXXB/ldLYGj/zlJ
        1v81zJPE9VJTBnLM1/1BBflGPohHwTQtAPNESPPEP6QlWtEJleGVv7SNhKaL0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fe1dZJ0fYS6JjnK+yYARCDAyN4MkcEXIge7MgZ5/IFw=;
        b=7aI2fNvKTuBOwff48AFIl+l5m8Ly5XHjeK8uKBAZepOHWUmNOA8S2o97nFmT5+y8Jnn9BU
        3OUphDwKxFVDwICA==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas: tmu: Convert to json-schema
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        niklas.soderlund+renesas@ragnatech.se, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201110162014.3290109-3-geert+renesas@glider.be>
References: <20201110162014.3290109-3-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160703926978.3364.10119610755223230693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b7c0fed5ccf2c5cb4bb43ddc6b1625f042a83d0a
Gitweb:        https://git.kernel.org/tip/b7c0fed5ccf2c5cb4bb43ddc6b1625f042a=
83d0a
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 10 Nov 2020 17:20:14 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:26 +01:00

dt-bindings: timer: renesas: tmu: Convert to json-schema

Convert the Renesas R-Mobile/R-Car Timer Unit (TMU) Device Tree binding
documentation to json-schema.

Document missing properties.
Update the example to match reality.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20201110162014.3290109-3-geert+renesas@glider=
.be
---
 Documentation/devicetree/bindings/timer/renesas,tmu.txt  |  50 +----
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml |  99 +++++++-
 2 files changed, 99 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.yaml

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Docume=
ntation/devicetree/bindings/timer/renesas,tmu.txt
deleted file mode 100644
index a36cd61..0000000
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Renesas R-Mobile/R-Car Timer Unit (TMU)
-
-The TMU is a 32-bit timer/counter with configurable clock inputs and
-programmable compare match.
-
-Channels share hardware resources but their counter and compare match value
-are independent. The TMU hardware supports up to three channels.
-
-Required Properties:
-
-  - compatible: must contain one or more of the following:
-    - "renesas,tmu-r8a7740" for the r8a7740 TMU
-    - "renesas,tmu-r8a774a1" for the r8a774A1 TMU
-    - "renesas,tmu-r8a774b1" for the r8a774B1 TMU
-    - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
-    - "renesas,tmu-r8a774e1" for the r8a774E1 TMU
-    - "renesas,tmu-r8a7778" for the r8a7778 TMU
-    - "renesas,tmu-r8a7779" for the r8a7779 TMU
-    - "renesas,tmu-r8a77970" for the r8a77970 TMU
-    - "renesas,tmu-r8a77980" for the r8a77980 TMU
-    - "renesas,tmu" for any TMU.
-      This is a fallback for the above renesas,tmu-* entries
-
-  - reg: base address and length of the registers block for the timer module.
-
-  - interrupts: interrupt-specifier for the timer, one per channel.
-
-  - clocks: a list of phandle + clock-specifier pairs, one for each entry
-    in clock-names.
-  - clock-names: must contain "fck" for the functional clock.
-
-Optional Properties:
-
-  - #renesas,channels: number of channels implemented by the timer, must be 2
-    or 3 (if not specified the value defaults to 3).
-
-
-Example: R8A7779 (R-Car H1) TMU0 node
-
-	tmu0: timer@ffd80000 {
-		compatible =3D "renesas,tmu-r8a7779", "renesas,tmu";
-		reg =3D <0xffd80000 0x30>;
-		interrupts =3D <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
-		clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
-		clock-names =3D "fck";
-
-		#renesas,channels =3D <3>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
new file mode 100644
index 0000000..c541887
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/renesas,tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Mobile/R-Car Timer Unit (TMU)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+description:
+  The TMU is a 32-bit timer/counter with configurable clock inputs and
+  programmable compare match.
+
+  Channels share hardware resources but their counter and compare match value
+  are independent. The TMU hardware supports up to three channels.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,tmu-r8a7740  # R-Mobile A1
+          - renesas,tmu-r8a774a1 # RZ/G2M
+          - renesas,tmu-r8a774b1 # RZ/G2N
+          - renesas,tmu-r8a774c0 # RZ/G2E
+          - renesas,tmu-r8a774e1 # RZ/G2H
+          - renesas,tmu-r8a7778  # R-Car M1A
+          - renesas,tmu-r8a7779  # R-Car H1
+          - renesas,tmu-r8a77970 # R-Car V3M
+          - renesas,tmu-r8a77980 # R-Car V3H
+      - const: renesas,tmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#renesas,channels':
+    description:
+      Number of channels implemented by the timer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 2, 3 ]
+    default: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - renesas,tmu-r8a7740
+            - renesas,tmu-r8a7778
+            - renesas,tmu-r8a7779
+then:
+  required:
+    - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7779-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7779-sysc.h>
+    tmu0: timer@ffd80000 {
+            compatible =3D "renesas,tmu-r8a7779", "renesas,tmu";
+            reg =3D <0xffd80000 0x30>;
+            interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
+            clock-names =3D "fck";
+            power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;
+            #renesas,channels =3D <3>;
+    };
