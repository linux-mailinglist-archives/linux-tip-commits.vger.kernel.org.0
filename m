Return-Path: <linux-tip-commits+bounces-5730-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94535ABFAAC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A72B3AA7C6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680F221DB7;
	Wed, 21 May 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrMUKyLz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUuyFtGR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC1267B9B;
	Wed, 21 May 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842588; cv=none; b=K3t3u6RsbCJtBrzpvHs0X+agY/3gdhrxkTTDRqJaMrsrKc2w2t3vEqqT+AN3R1MSnFwNLUvND45wRL1CzUZ+pnCkMSKBcIXHtWldyZPn5kYZFi9ZkgEwP09SPGNkEJPVmItPSpkW3IszRkTRs8EY4zFNBalVIOQB5Mzk14JmhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842588; c=relaxed/simple;
	bh=DTtvgGCBZ/4/nrlinIbiXo9jdgMVessnR7doYXYRVHQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oLZyvTQqDLKYx9+XGEpPqnlw/qK7cCJx8CaHp+MHkWzWilLZFoMQIDu16uej8I88tA0314ol8sTN3merNihEJPI+4kV1j1ER5EltY/xlrd/YcfFjVjsznwcBNvaMWlrAASks7F5JGW1apIaE0TtyhZzok0ibtuSycbzMsSPTttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrMUKyLz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUuyFtGR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h0PLFSYMdAwjJGdbjPhTua2g9M5f2TwM12W3j8ki70=;
	b=yrMUKyLzakfovsvKPoPUPChazavOmMCcGOKkFLcvhjsGNOu0C3B6CtK4CiDF1UujtPGWs3
	I3yam8t7SmttZUIhRXd6y2TdxVkTHbyEPhcQ6eeBmA11XeiGjCi1cwbnKvTZ7OKHm6IAkj
	zNEaTAC1FUZITZg5i6b8f+WILjDZGTQ9Lnn3uw9Gv6d6rexsAwZPNXg4xdPwgznuJKJG0/
	Sqh4t1Y6d3Ip0xQRNobM6E/4vpn0u3yqjFI1NTos+NFQY8av6KDcSTlqPoI0CUVudPitGa
	GhoBsYbD6lHwPs9CJl8tAfGJ9NXFGS6N6GQK0ysWn+Mw2LAZTqmLcVMDh/4JOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4h0PLFSYMdAwjJGdbjPhTua2g9M5f2TwM12W3j8ki70=;
	b=MUuyFtGRh6XVt6nz5XEAK1dUUx4Jyw3HQt/n9Jky3OXoAHU0TbAe+qYkSlUJc9FAX9lEgN
	v2/4Hc026LzgHhCQ==
From: tip-bot2 for J. =?utf-8?q?Neusch=C3=A4fer?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert fsl,gtm to YAML
Cc: "Rob Herring (Arm)" <robh@kernel.org>, j.ne@posteo.net,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250412-gtm-yaml-v2-1-e4d2292ffefc@posteo.net>
References: <20250412-gtm-yaml-v2-1-e4d2292ffefc@posteo.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784258337.406.4455097189519017176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     eb7bc6920153a7d025c0b0001d5a6462fe08034f
Gitweb:        https://git.kernel.org/tip/eb7bc6920153a7d025c0b0001d5a6462fe0=
8034f
Author:        J. Neusch=C3=A4fer <j.ne@posteo.net>
AuthorDate:    Sat, 12 Apr 2025 14:56:20 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:32 +02:00

dt-bindings: timer: Convert fsl,gtm to YAML

Convert fsl,gtm.txt to YAML so that device trees using a Freescale
General-purpose Timers Module can be properly validated.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neusch=C3=A4fer <j.ne@posteo.net>
Link: https://lore.kernel.org/r/20250412-gtm-yaml-v2-1-e4d2292ffefc@posteo.net
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/fsl,gtm.txt  | 30 +----
 Documentation/devicetree/bindings/timer/fsl,gtm.yaml | 83 +++++++++++-
 2 files changed, 83 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,gtm.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,gtm.yaml

diff --git a/Documentation/devicetree/bindings/timer/fsl,gtm.txt b/Documentat=
ion/devicetree/bindings/timer/fsl,gtm.txt
deleted file mode 100644
index fc1c571..0000000
--- a/Documentation/devicetree/bindings/timer/fsl,gtm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Freescale General-purpose Timers Module
-
-Required properties:
-  - compatible : should be
-    "fsl,<chip>-gtm", "fsl,gtm" for SOC GTMs
-    "fsl,<chip>-qe-gtm", "fsl,qe-gtm", "fsl,gtm" for QE GTMs
-    "fsl,<chip>-cpm2-gtm", "fsl,cpm2-gtm", "fsl,gtm" for CPM2 GTMs
-  - reg : should contain gtm registers location and length (0x40).
-  - interrupts : should contain four interrupts.
-  - clock-frequency : specifies the frequency driving the timer.
-
-Example:
-
-timer@500 {
-	compatible =3D "fsl,mpc8360-gtm", "fsl,gtm";
-	reg =3D <0x500 0x40>;
-	interrupts =3D <90 8 78 8 84 8 72 8>;
-	interrupt-parent =3D <&ipic>;
-	/* filled by u-boot */
-	clock-frequency =3D <0>;
-};
-
-timer@440 {
-	compatible =3D "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
-	reg =3D <0x440 0x40>;
-	interrupts =3D <12 13 14 15>;
-	interrupt-parent =3D <&qeic>;
-	/* filled by u-boot */
-	clock-frequency =3D <0>;
-};
diff --git a/Documentation/devicetree/bindings/timer/fsl,gtm.yaml b/Documenta=
tion/devicetree/bindings/timer/fsl,gtm.yaml
new file mode 100644
index 0000000..1f35f1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,gtm.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/fsl,gtm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale General-purpose Timers Module
+
+maintainers:
+  - J. Neusch=C3=A4fer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    oneOf:
+      # for SoC GTMs
+      - items:
+          - enum:
+              - fsl,mpc8308-gtm
+              - fsl,mpc8313-gtm
+              - fsl,mpc8315-gtm
+              - fsl,mpc8360-gtm
+          - const: fsl,gtm
+
+      # for QE GTMs
+      - items:
+          - enum:
+              - fsl,mpc8360-qe-gtm
+              - fsl,mpc8569-qe-gtm
+          - const: fsl,qe-gtm
+          - const: fsl,gtm
+
+      # for CPM2 GTMs (no known examples)
+      - items:
+          # - enum:
+          #     - fsl,<chip>-cpm2-gtm
+          - const: fsl,cpm2-gtm
+          - const: fsl,gtm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Interrupt for timer 1 (e.g. GTM1 or GTM5)
+      - description: Interrupt for timer 2 (e.g. GTM2 or GTM6)
+      - description: Interrupt for timer 3 (e.g. GTM3 or GTM7)
+      - description: Interrupt for timer 4 (e.g. GTM4 or GTM8)
+
+  clock-frequency: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@500 {
+        compatible =3D "fsl,mpc8360-gtm", "fsl,gtm";
+        reg =3D <0x500 0x40>;
+        interrupts =3D <90 IRQ_TYPE_LEVEL_LOW>,
+                     <78 IRQ_TYPE_LEVEL_LOW>,
+                     <84 IRQ_TYPE_LEVEL_LOW>,
+                     <72 IRQ_TYPE_LEVEL_LOW>;
+        /* filled by u-boot */
+        clock-frequency =3D <0>;
+    };
+
+  - |
+    timer@440 {
+        compatible =3D "fsl,mpc8360-qe-gtm", "fsl,qe-gtm", "fsl,gtm";
+        reg =3D <0x440 0x40>;
+        interrupts =3D <12>, <13>, <14>, <15>;
+        /* filled by u-boot */
+        clock-frequency =3D <0>;
+    };
+
+...

