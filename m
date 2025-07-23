Return-Path: <linux-tip-commits+bounces-6176-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B9AB0EBB6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB03B2307
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B309275AF6;
	Wed, 23 Jul 2025 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dWG3N3Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQFMWT8k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DF275105;
	Wed, 23 Jul 2025 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255056; cv=none; b=W/IbJtg2aKpu1EPW/qPvNmkDN06skCWJ1QeB1zwp7GexaS+5dCdsoJoJNG73LWz4mWqQgz/XUQYGEzWf99CSvENFWqagn+9vRHB9/EUajgOYZ6+BsH55tOYq/P49ChhA4uyaTfA0XRqucA7+H5xF21HPLycPX1sveQoCRpQRhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255056; c=relaxed/simple;
	bh=F7b/4DJ7TdR1k/xMJMC/LS3iywFgtFDcuqKbyH59YYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f6+iWVsPnzWfdIbj8HfWO288R3QF+XeZgl9+CCOyrcntJp3kaEQvrZ8QLQkhVMRQFDrqJ9f9xQJYaj9Psbod61wCPKaZMsQmsoUKq2wWtuQBgvyOR5tWJOCqXVw2bSF6T0CKSeTi4n9qozxQ5mV1Lip94gRh83kcR0EEuOTePCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dWG3N3Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQFMWT8k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh7MBBDlyMxbqc4CRvAN1Op6EwDITe2qXmFrTJuwY0o=;
	b=2dWG3N3QtRnSsDrOY1HnIZ02CkDpuO3cKc22dv1IJxoXA90t8jABdSahPZ4hc1PNU9Mve1
	z5p4GwfegljI9p8M07/mJlG1Tu1xxVOwWPGO6Xfz8OCsePceWAwasue5QoTACOYblJndIK
	+gEqIWCdyf80qmA673dX4OeU2YK6qvnrgBtywraQdXxGcC0CRjJRs/Lgp6LUFmUCuiB61r
	VDQfHlX9y35OdojRY8852yLMaqWDUpDns42UEGzpzaSpqnXFesW1MiJ6nF2yL0Bj99tRiI
	/1D2Ak0xZe3Dd5ihftRD4eCmhqKatu9bLM50ZrUBt4QHkLe9KckZn9b/Fb5jSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh7MBBDlyMxbqc4CRvAN1Op6EwDITe2qXmFrTJuwY0o=;
	b=CQFMWT8ktYbrXiZQ2xcTzC6GZ2YBdGwMz9x0cspz1YfGqdFwo5E9ZkXGpwZO9mu0nWZ7Az
	1FebaxZ9Q2D2/FAw==
From: "tip-bot2 for Ben Zong-You Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: add Andes machine timer
Cc: Conor Dooley <conor.dooley@microchip.com>,
 "Ben Zong-You Xie" <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250711133025.2192404-6-ben717@andestech.com>
References: <20250711133025.2192404-6-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505182.1420.17805798791873450946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     c4a134f5af13776bc546a51b5ee68f0f48d390d8
Gitweb:        https://git.kernel.org/tip/c4a134f5af13776bc546a51b5ee68f0f48d=
390d8
Author:        Ben Zong-You Xie <ben717@andestech.com>
AuthorDate:    Fri, 11 Jul 2025 21:30:21 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jul 2025 18:17:20 +02:00

dt-bindings: timer: add Andes machine timer

Add the DT binding documentation for Andes machine timer.

The RISC-V architecture defines a machine timer that provides a real-time
counter and generates timer interrupts. Andes machiner timer (PLMT0) is
the implementation of the machine timer, and it contains memory-mapped
registers (mtime and mtimecmp). This device supports up to 32 cores.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Link: https://lore.kernel.org/r/20250711133025.2192404-6-ben717@andestech.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/andestech,plmt0.yaml | 53 +++++++-
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,plmt0.y=
aml

diff --git a/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml b/D=
ocumentation/devicetree/bindings/timer/andestech,plmt0.yaml
new file mode 100644
index 0000000..90b6120
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/andestech,plmt0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes machine-level timer
+
+description:
+  The Andes machine-level timer device (PLMT0) provides machine-level timer
+  functionality for a set of HARTs on a RISC-V platform. It has a single
+  fixed-frequency monotonic time counter (MTIME) register and a time compare
+  register (MTIMECMP) for each HART connected to the PLMT0. A timer interrup=
t is
+  generated if MTIME >=3D MTIMECMP.
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - andestech,qilai-plmt
+      - const: andestech,plmt0
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 32
+    description:
+      Specifies which harts are connected to the PLMT0. Each item must points
+      to a riscv,cpu-intc node, which has a riscv cpu node as parent. The
+      PLMT0 supports 1 hart up to 32 harts.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@100000 {
+      compatible =3D "andestech,qilai-plmt", "andestech,plmt0";
+      reg =3D <0x100000 0x100000>;
+      interrupts-extended =3D <&cpu0intc 7>,
+                            <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>;
+    };

