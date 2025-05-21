Return-Path: <linux-tip-commits+bounces-5713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A73ABFA44
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FC7A3E3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C6E22686F;
	Wed, 21 May 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E2OtUiJz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+1GBa1mX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF522370F;
	Wed, 21 May 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842574; cv=none; b=W66lY6c9rZc6UrQyds3FLI4YQX4sjddyMY/orhMEfNt272RrnlzRwW1l/ORM2khKE6RfZ+v4nBU7tYaj+Dk66N3QOQYKhGMbygPyDXGSuaUcbV27d7joNGPqoS997vg5If7lsAnSMBFquvW56wLYWCYFBKw9FJsQa5e5E/jBSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842574; c=relaxed/simple;
	bh=eY0qRG5hTJsaQtAbd4mEMrd5tFe9D8waA6thWoZXmHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A0myyI3rAhbQIkRzhNg2PP3yB2uyQcACOxYt4nmhRr0+7Kx/CrYNsCBzLZ7Ye5KblYzwhPoUGtZXVEO7rTNF3nRmCbLNVRiDaTdwIOUQaOr5TNsyHHS8rQ84aUwdztvio4RhPN/EW5eRYsDuKdVXvnE+4SMxLgOtU3WlZogGHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E2OtUiJz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+1GBa1mX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6SvgIWuRF+rI4Vb1ofsh4nH0NjJogFx2Lp2kY2X4uE=;
	b=E2OtUiJzEZDDkfMEYe6Lwoc1TkxhRLlz+4qxcBvkweRoROCFS597DXYzqh61Rw0wDCiSUr
	cDLr50mrDj3qWwzsRRoV/B7g7mzNgqAltFYRNU5gq10aPoa/IMs2spLkr7z/qfJDzA/xw9
	08o43YrnRyKib9W9OcyTbjs2cAMAs8/UeyknzioHxyCyUOciMXe28dI3I+dVIloY+BRR5S
	LrVGNV8KZUymxWlDzyZD3DDP3XT9gvPSExbsPeWm3l5ETmsaOsRZ3RIgVt/0H/tSQ4mk6F
	OLsS4V656G/9mTpdbnOM1+l0hBVmFsH0aYygYm33dhAyCjrMfQMfCQm9Uh6UGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6SvgIWuRF+rI4Vb1ofsh4nH0NjJogFx2Lp2kY2X4uE=;
	b=+1GBa1mXPvSbHa11fHfj/rgtUMTyO2istbmJa/AmXNZg6Gu/jDmlMukiOrsjJdmJevALKn
	L9zU+VkBCbf+kOAw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] dt-bindings: timer: Convert jcore,pit to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022253.2587999-1-robh@kernel.org>
References: <20250506022253.2587999-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256989.406.9397007136555067613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     f8470be859a8660c1993fa44053c473c82eb454b
Gitweb:        https://git.kernel.org/tip/f8470be859a8660c1993fa44053c473c82eb454b
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:52 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert jcore,pit to DT schema

Convert the J-Core PIT Timer binding to DT schema format. It's a
straight-forward conversion.

Since the 'reg' entries are based on number of cores, we can't put
constraints on it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022253.2587999-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/jcore,pit.txt  | 24 +-----
 Documentation/devicetree/bindings/timer/jcore,pit.yaml | 43 +++++++++-
 2 files changed, 43 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.yaml

diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.txt b/Documentation/devicetree/bindings/timer/jcore,pit.txt
deleted file mode 100644
index af5dd35..0000000
--- a/Documentation/devicetree/bindings/timer/jcore,pit.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-J-Core Programmable Interval Timer and Clocksource
-
-Required properties:
-
-- compatible: Must be "jcore,pit".
-
-- reg: Memory region(s) for timer/clocksource registers. For SMP,
-  there should be one region per cpu, indexed by the sequential,
-  zero-based hardware cpu number.
-
-- interrupts: An interrupt to assign for the timer. The actual pit
-  core is integrated with the aic and allows the timer interrupt
-  assignment to be programmed by software, but this property is
-  required in order to reserve an interrupt number that doesn't
-  conflict with other devices.
-
-
-Example:
-
-timer@200 {
-	compatible = "jcore,pit";
-	reg = < 0x200 0x30 0x500 0x30 >;
-	interrupts = < 0x48 >;
-};
diff --git a/Documentation/devicetree/bindings/timer/jcore,pit.yaml b/Documentation/devicetree/bindings/timer/jcore,pit.yaml
new file mode 100644
index 0000000..9e6e25b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/jcore,pit.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/jcore,pit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: J-Core Programmable Interval Timer and Clocksource
+
+maintainers:
+  - Rich Felker <dalias@libc.org>
+
+properties:
+  compatible:
+    const: jcore,pit
+
+  reg:
+    description:
+      Memory region(s) for timer/clocksource registers. For SMP, there should be
+      one region per cpu, indexed by the sequential, zero-based hardware cpu
+      number.
+
+  interrupts:
+    description:
+      An interrupt to assign for the timer. The actual pit core is integrated
+      with the aic and allows the timer interrupt assignment to be programmed by
+      software, but this property is required in order to reserve an interrupt
+      number that doesn't conflict with other devices.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@200 {
+        compatible = "jcore,pit";
+        reg = <0x200 0x30 0x500 0x30>;
+        interrupts = <0x48>;
+    };

