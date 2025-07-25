Return-Path: <linux-tip-commits+bounces-6205-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65425B11C75
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0C1CE3927
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576572EA173;
	Fri, 25 Jul 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8D2WY9F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/DnObvy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B32E7F19;
	Fri, 25 Jul 2025 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439510; cv=none; b=Qhpb3cYh3zE9ligOrLU9oFTW2itWXHf4ud02uM0kWz82YnrP2Er9e98M3nzeHnA7Nh0K43pMO0r2XS9Xbg363txUXdaHhs2nBlc7SyZsbiBIMNKBg1600EYsuVMkoimewdf6q/RMf2gYf9UJ1Dn/Ia/AUp0785sRJmBQLjgMLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439510; c=relaxed/simple;
	bh=UKVj9cTzbbipam8kbY83ZKByPm1H70NfHdpi8HANMJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uQx1hVSc94/77kqQWzhLCQBEJzANPlTjfvEwDYjfxUJ4B/40rqPueiJGTRRgikyXz+O5o7uX5TjRl7kzw2g7jiKdC02wrIhDIvY1CcaR4gxDcN4OwZOn1aFP1XLDGtLPjn7OkJmN3z6rPvl2ihlLiIwCyshaP03PI0U5U9n6TYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8D2WY9F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/DnObvy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wscMXghS35QxoPLMNKz4ldgJQfYFXQjefrvrRiqcBlU=;
	b=s8D2WY9FmYpKSsBzsR3a09PuZlg2dMFrT9MLCigp2GCKaG2YjAQ+7x2iIaKXc9WQUGUIqN
	WfWAJHJCgwQ0JqFoW1Vl636zNnh1NS13tWVVdHfa5MHU0ALZVlksdM36mn7ZiLDMq3x0WH
	OGq4guYUg83D7El3mVNpVcdKNf6zQleJKNi/k8EILXE9j4t4RvUAWfneC6SPzpM8MjIEwb
	pf+I/T2hZN5Gb2i+vt797E08ICeNYWk+i/7orS372Q3SVcWqEU6qSI/91kZL0C0kHrteAz
	0b7nTAF2goKy+mg1/dOy5Dwl+f9CeA8587LKBL5d8cYldTh+ZMvOxfwV/bEndw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wscMXghS35QxoPLMNKz4ldgJQfYFXQjefrvrRiqcBlU=;
	b=N/DnObvy1CApbP5fZjSbpj1+kK27EoP+PiRpzXbiKufFcYY3A87nVQVnoy5aMBCPA/fGGO
	ywhCKxHq7Ct0SyDw==
From: "tip-bot2 for Ben Zong-You Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Add Andes machine timer
Cc: "Ben Zong-You Xie" <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250711133025.2192404-6-ben717@andestech.com>
References: <20250711133025.2192404-6-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950587.1420.13476286643465202699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     1294b89e0d11966231ce237ed2ef0f24bf2cff84
Gitweb:        https://git.kernel.org/tip/1294b89e0d11966231ce237ed2ef0f24bf2=
cff84
Author:        Ben Zong-You Xie <ben717@andestech.com>
AuthorDate:    Fri, 11 Jul 2025 21:30:21 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:04:51 +02:00

dt-bindings: timer: Add Andes machine timer

Add the DT binding documentation for Andes machine timer.

The RISC-V architecture defines a machine timer that provides a real-time
counter and generates timer interrupts. Andes machiner timer (PLMT0) is
the implementation of the machine timer, and it contains memory-mapped
registers (mtime and mtimecmp). This device supports up to 32 cores.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250711133025.2192404-6-ben717@andestech.com
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

