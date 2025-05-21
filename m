Return-Path: <linux-tip-commits+bounces-5711-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F8ABFA3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4811E163FDE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1B224B07;
	Wed, 21 May 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QcQZ3DNp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQV0/CeM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA32222C8;
	Wed, 21 May 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842572; cv=none; b=GH90WnEev9DGjMDAPiQU4EynyHgH7/DuT3m1tGhqPaeMK1mhmYSlTuMIYsINFcrjfg2xTsP39afNYUY7ECNKDj4aFPcFTFyO1Ahc+WxcrwpHs7uunTJYkQ6yr7RJfSe2X0ii2jJUZpwPMQgAL1DjmSD0Zygd93+JNCewI75veBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842572; c=relaxed/simple;
	bh=ZZm9J0QA8ut6CzgaA85dk6aSz/4147J89HPClORcxFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H6oR3Y0VqIyVW6XMHMOWx3RKQP5iAQBA4v77WkYJ4K95/ajxhrzz/1/Kc8Tju17fdlgrChWZcxYfALrqW3H5Rq7QmqnR8nlmXBK0rp7s0qxQkmtQUkH3WXOWXM1PNtIGAA8GLNI8WrA4Bh2cSp9K4xj2JoQl6O2pmGzvjhGOkpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QcQZ3DNp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xQV0/CeM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buORNgRW8vw+gVcJcLD/TsEgFvM5Nol7z+wkTdHWjmw=;
	b=QcQZ3DNp338Hzx1uY1vHYfMmr+ehvKhurya5kAPbJAOsDpXodrdKUeY3b6sgYD9S7X/OCO
	7z/sZ6RnvUZ1nRbmWFnhlw8TsCd3sL4wvMfJpbxbsPGo4Z4APmVTgVxVuYom6MPOTRtNBn
	FiG+Nb2y9uJ10VJjtdUDEs5qfjkhKy+MrkPk5oWK4Lueujh5NsHHu4EKewdw68341NGOuu
	q0tfyuWNC60EmAnXqTsjNXwbDo6Gy5HhgkxaAG+znwkmI+0dE0/xS01gZKpTTMPjMwx8j5
	H0eAtYUmqWvYIi0NzZhUIOdktKIo4l858aiWci3IrpAtwd74Xy7cxaT0370JNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842569;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=buORNgRW8vw+gVcJcLD/TsEgFvM5Nol7z+wkTdHWjmw=;
	b=xQV0/CeMldTDgIViliTfHt+XiowcqVPkHFW5oGzyUNgG9pEGb2I3NvV5RbURcBL7lsCbh2
	tD97CzYeMzWfZ4Dw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert snps,archs-gfrc
 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022309.2588605-1-robh@kernel.org>
References: <20250506022309.2588605-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256801.406.4827275038413460439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     49f2f4d16fab95d6aba0da7460aef632ddc67858
Gitweb:        https://git.kernel.org/tip/49f2f4d16fab95d6aba0da7460aef632ddc67858
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:08 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert snps,archs-gfrc to DT schema

Convert the Synopsys ARC HS 64-bit Timer binding to DT schema format.
It's a straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022309.2588605-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/snps,archs-gfrc.txt  | 14 +---
 Documentation/devicetree/bindings/timer/snps,archs-gfrc.yaml | 30 +++++++-
 2 files changed, 30 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/snps,archs-gfrc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/snps,archs-gfrc.yaml

diff --git a/Documentation/devicetree/bindings/timer/snps,archs-gfrc.txt b/Documentation/devicetree/bindings/timer/snps,archs-gfrc.txt
deleted file mode 100644
index b6cd1b3..0000000
--- a/Documentation/devicetree/bindings/timer/snps,archs-gfrc.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Synopsys ARC Free Running 64-bit Global Timer for ARC HS CPUs
-- clocksource provider for SMP SoC
-
-Required properties:
-
-- compatible : should be "snps,archs-gfrc"
-- clocks     : phandle to the source clock
-
-Example:
-
-	gfrc {
-		compatible = "snps,archs-gfrc";
-		clocks = <&core_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/snps,archs-gfrc.yaml b/Documentation/devicetree/bindings/timer/snps,archs-gfrc.yaml
new file mode 100644
index 0000000..fb16f4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/snps,archs-gfrc.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/snps,archs-gfrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys ARC Free Running 64-bit Global Timer for ARC HS CPUs
+
+maintainers:
+  - Vineet Gupta <vgupta@synopsys.com>
+
+properties:
+  compatible:
+    const: snps,archs-gfrc
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer {
+        compatible = "snps,archs-gfrc";
+        clocks = <&core_clk>;
+    };

