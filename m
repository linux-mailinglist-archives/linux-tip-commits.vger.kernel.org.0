Return-Path: <linux-tip-commits+bounces-7722-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD80CC0062
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D4F3026999
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDC32E757;
	Mon, 15 Dec 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRObIOno";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuaytPqQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A332ED26;
	Mon, 15 Dec 2025 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835230; cv=none; b=u+xDTPC/v5i6FlSrtDnOBxK1mzYwd84l0MnQan+bRhDXg8HQ/5hOB1JpYs7jIxAdn/lkTBc1Q/dMVKfGk9y9T3tBb1e7DCgmMvskNiMpfXfeiG9yKRM7QAV66iqnzJOIMA7L4k24cNv33PTHkUvpx1BE7ZCgHBltTUNNVtdCfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835230; c=relaxed/simple;
	bh=R48Z0dAmotOCnB6lAUqeRq7rgt3fJy8JQBht8TwZQmQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rKCgZIpKUfOlCE4hhmseVh1AFGcqlGHOcLoowWMDtiIxfNnmhASXpzOe0sp5CFOuVDVk8u/jmskByOVMbDNGNhS659kN7eb+IUsXDUq8Pr7xIkGzsCsBD7ImqG4ic3Ylg6fXfhBKe1Hx2IHSqNfXOCSp01cbzVq2UHDQ9CKy6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRObIOno; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tuaytPqQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNdZW/kF+vQtu8/bEewGaTQ9/yN80pDMJGobw9ZDl+Q=;
	b=wRObIOnoXQ+WYd4i5BzkUJC7x1yu97wIIOvM0nRsuU6k9ffQBtYU6dcP/1KeHH6tSFeEtk
	UJpqtfFL7CODZNRs7p/7SyuuyvI3MGiqLMgrfz0tnlGCSzUShxFNIc4ttaxe93LYQQKTaX
	2qnYksJ/UoqPZMdeyyy8Tc4np6kj3k7tEjhoh49uZ2pVIiO2siqdbNaj1lM6s2hC1bpkcz
	3mjhmJVApbuDtykmPNNSAxKeVQjXLRpbbScfYzgujPpmHi3Q3nl3xy1cjmaGZtGtYZDPhp
	UUzZ36CNj7Bu9Lxjq4GUf5TYY7zLOPvK32KY6cWlw7/N8/IDsRfOm3kcTJVKQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNdZW/kF+vQtu8/bEewGaTQ9/yN80pDMJGobw9ZDl+Q=;
	b=tuaytPqQOpGJu38aA32ZFiq6vi+oErEll/kZa9c0XH51EI9jcBabVXQGSeQo/XPNtIg7OU
	H7P7WehULbd2l3Aw==
From: "tip-bot2 for Cosmin Tanislav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Document
 RZ/{T2H,N2H} ICU
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Rob Herring (Arm)" <robh@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201112933.488801-2-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201112933.488801-2-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583522273.510.8354099418404798853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a6568d82091d279c8fbcdb1d30b46c23756b9145
Gitweb:        https://git.kernel.org/tip/a6568d82091d279c8fbcdb1d30b46c23756=
b9145
Author:        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
AuthorDate:    Mon, 01 Dec 2025 13:29:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:32 +01:00

dt-bindings: interrupt-controller: Document RZ/{T2H,N2H} ICU

The Renesas RZ/T2H (R9A09G077) and Renesas RZ/N2H (R9A09G087) SoCs have an
Interrupt Controller (ICU) block that routes external interrupts to the
GIC's SPIs, with the ability of level-translation, and can also produce
software interrupts and aggregate error interrupts.

It has 16 software triggered interrupts (INTCPUn), 16 external pin
interrupts (IRQn), a System error interrupt (SEI), two Cortex-A55 error
interrupts (CA55_ERRn), two Cortex-R52 error interrupts for each of the two
cores (CR52x_ERRn), two Peripheral error interrupts (PERI_ERRn), two DSMIF
error interrupts (DSMIF_ERRn), and two ENCIF error interrupts (ENCIF_ERRn).

The IRQn and SEI interrupts are exposed externally, while the others are
software triggered.

INTCPU0 to INTCPU13, IRQ 0 to IRQ13 are non-safety interrupts, while
INTCPU14, INTCPU15, IRQ14, IRQ15 and SEI are safety interrupts, and are
exposed via a separate register space.

Document them, and use RZ/T2H as a fallback for RZ/N2H as the ICU is
entirely compatible.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251201112933.488801-2-cosmin-gabriel.tanisla=
v.xa@renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,r9a09g077-icu=
.yaml | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/re=
nesas,r9a09g077-icu.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
9a09g077-icu.yaml b/Documentation/devicetree/bindings/interrupt-controller/re=
nesas,r9a09g077-icu.yaml
new file mode 100644
index 0000000..78c01d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,r9a09g07=
7-icu.yaml
@@ -0,0 +1,236 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,r9a09g077-ic=
u.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/{T2H,N2H} Interrupt Controller
+
+maintainers:
+  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description:
+  The Interrupt Controller (ICU) handles software-triggered interrupts
+  (INTCPU), external interrupts (IRQ and SEI), error interrupts and DMAC
+  requests.
+
+properties:
+  compatible:
+    oneOf:
+      - const: renesas,r9a09g077-icu # RZ/T2H
+
+      - items:
+          - enum:
+              - renesas,r9a09g087-icu # RZ/N2H
+          - const: renesas,r9a09g077-icu
+
+  reg:
+    items:
+      - description: Non-safety registers (INTCPU0-13, IRQ0-13)
+      - description: Safety registers (INTCPU14-15, IRQ14-15, SEI)
+
+  '#interrupt-cells':
+    description: The first cell is the SPI number of the interrupt, as per u=
ser
+      manual. The second cell is used to specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts:
+    items:
+      - description: Software interrupt 0
+      - description: Software interrupt 1
+      - description: Software interrupt 2
+      - description: Software interrupt 3
+      - description: Software interrupt 4
+      - description: Software interrupt 5
+      - description: Software interrupt 6
+      - description: Software interrupt 7
+      - description: Software interrupt 8
+      - description: Software interrupt 9
+      - description: Software interrupt 10
+      - description: Software interrupt 11
+      - description: Software interrupt 12
+      - description: Software interrupt 13
+      - description: Software interrupt 14
+      - description: Software interrupt 15
+      - description: External pin interrupt 0
+      - description: External pin interrupt 1
+      - description: External pin interrupt 2
+      - description: External pin interrupt 3
+      - description: External pin interrupt 4
+      - description: External pin interrupt 5
+      - description: External pin interrupt 6
+      - description: External pin interrupt 7
+      - description: External pin interrupt 8
+      - description: External pin interrupt 9
+      - description: External pin interrupt 10
+      - description: External pin interrupt 11
+      - description: External pin interrupt 12
+      - description: External pin interrupt 13
+      - description: External pin interrupt 14
+      - description: External pin interrupt 15
+      - description: System error interrupt
+      - description: Cortex-A55 error event 0
+      - description: Cortex-A55 error event 1
+      - description: Cortex-R52 CPU 0 error event 0
+      - description: Cortex-R52 CPU 0 error event 1
+      - description: Cortex-R52 CPU 1 error event 0
+      - description: Cortex-R52 CPU 1 error event 1
+      - description: Peripherals error event 0
+      - description: Peripherals error event 1
+      - description: DSMIF error event 0
+      - description: DSMIF error event 1
+      - description: ENCIF error event 0
+      - description: ENCIF error event 1
+
+  interrupt-names:
+    items:
+      - const: intcpu0
+      - const: intcpu1
+      - const: intcpu2
+      - const: intcpu3
+      - const: intcpu4
+      - const: intcpu5
+      - const: intcpu6
+      - const: intcpu7
+      - const: intcpu8
+      - const: intcpu9
+      - const: intcpu10
+      - const: intcpu11
+      - const: intcpu12
+      - const: intcpu13
+      - const: intcpu14
+      - const: intcpu15
+      - const: irq0
+      - const: irq1
+      - const: irq2
+      - const: irq3
+      - const: irq4
+      - const: irq5
+      - const: irq6
+      - const: irq7
+      - const: irq8
+      - const: irq9
+      - const: irq10
+      - const: irq11
+      - const: irq12
+      - const: irq13
+      - const: irq14
+      - const: irq15
+      - const: sei
+      - const: ca55-err0
+      - const: ca55-err1
+      - const: cr520-err0
+      - const: cr520-err1
+      - const: cr521-err0
+      - const: cr521-err1
+      - const: peri-err0
+      - const: peri-err1
+      - const: dsmif-err0
+      - const: dsmif-err1
+      - const: encif-err0
+      - const: encif-err1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
+
+    icu: interrupt-controller@802a0000 {
+      compatible =3D "renesas,r9a09g077-icu";
+      reg =3D <0x802a0000 0x10000>,
+            <0x812a0000 0x50>;
+      #interrupt-cells =3D <2>;
+      #address-cells =3D <0>;
+      interrupt-controller;
+      interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 7 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 14 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 16 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 17 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 18 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 408 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 409 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 412 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 413 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 415 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 416 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>;
+      interrupt-names =3D "intcpu0", "intcpu1", "intcpu2",
+                        "intcpu3", "intcpu4", "intcpu5",
+                        "intcpu6", "intcpu7", "intcpu8",
+                        "intcpu9", "intcpu10", "intcpu11",
+                        "intcpu12", "intcpu13", "intcpu14",
+                        "intcpu15",
+                        "irq0", "irq1", "irq2", "irq3",
+                        "irq4", "irq5", "irq6", "irq7",
+                        "irq8", "irq9", "irq10", "irq11",
+                        "irq12", "irq13", "irq14", "irq15",
+                        "sei",
+                        "ca55-err0", "ca55-err1",
+                        "cr520-err0", "cr520-err1",
+                        "cr521-err0", "cr521-err1",
+                        "peri-err0", "peri-err1",
+                        "dsmif-err0", "dsmif-err1",
+                        "encif-err0", "encif-err1";
+      clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKM>;
+      power-domains =3D <&cpg>;
+    };

