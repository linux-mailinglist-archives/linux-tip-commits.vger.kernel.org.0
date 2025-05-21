Return-Path: <linux-tip-commits+bounces-5710-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D13ABFA3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C8F162872
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8914722258F;
	Wed, 21 May 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UkpFAkg1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Gw9KV0s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E21221D99;
	Wed, 21 May 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842571; cv=none; b=dcf58CepbsXLFNeBPAPZ1Yb0Ax2NbCuyZsjssPn7oCrL8ecxIZzVAnu77nphk9ii+5EaPPZ4kbPyGlj7RSlIgUsNHt+ipnmT/sfLwC3fCqreL+BVkG/G2I8BCW1gxAmYCv1e0x5A2EzcKlcLqn2Ls89f9lTVIST3RV/5iyk9H9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842571; c=relaxed/simple;
	bh=6p5b3Ln2HJ0pFMusYwZbnivPTVKQXgvoc9rYGT5WKy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O5APTNJsXxB0VX6RI6jo848pyVs3umXTFVwDEKEKv0rc/DSS/4udW2lrtRK2bre07iDFKgmRBTw8w7cD9ePJJW5jK2ZoEYrSgQj8f7+Fu2ixqIl5HaKhiQL8NdDyYbhxXjsxDaabbM6E8j2toD50VVHghwtbpOFN71clyZpGcys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UkpFAkg1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Gw9KV0s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842568;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mW/5DG8BBo62ZUBpNGGJbPAFG3+wfO6D3SCgKrEtsWc=;
	b=UkpFAkg1vielpi3B5Sfe31Bkd2g5UsTs7ZgoSfUbK/DyhqKthqFJsDfc3XwaEwURkD/m/w
	8rGalN9/tx4orVF4GCuQsBLl2w+2G3ylL+QQqofeuAkRIhpmjXwy6XYLpyN47xNhHz+E4L
	JgoiZAtE2kzNaEa91vlMufNTq1HDmFFMdDGMp36wwor34dyLGsKqhaQPijPDyisv6vsVuS
	3nuzqUGkvJzA/hQs7EeiO/dBZvE1xOE0zuw0RGJ794cRADX6Yl6T3qUV15T4kkd0QvW2hp
	9fcYuiW/9x4/+3qlV+aUMOGqFAD1RHEGNjrz/iB61a3GiQxGIz/YyC7zcETJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842568;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mW/5DG8BBo62ZUBpNGGJbPAFG3+wfO6D3SCgKrEtsWc=;
	b=5Gw9KV0sGZSKmh3ZMDNzkQA36FALMcqs5KRyUDa1VTSC3Rzl4kGKbvDKT05ABKZKAHFb3a
	KhW6U6XvDi07V0Dw==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert snps,archs-rtc
 to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022313.2588796-1-robh@kernel.org>
References: <20250506022313.2588796-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256723.406.1361577587606316271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     58ac7dc3ca92cba2238f9af71d018af177439938
Gitweb:        https://git.kernel.org/tip/58ac7dc3ca92cba2238f9af71d018af177439938
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:12 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert snps,archs-rtc to DT schema

Convert the Synopsys ARC HS RTC Timer binding to DT schema format.
It's a straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022313.2588796-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/snps,archs-rtc.txt  | 14 +---
 Documentation/devicetree/bindings/timer/snps,archs-rtc.yaml | 30 +++++++-
 2 files changed, 30 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/snps,archs-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/snps,archs-rtc.yaml

diff --git a/Documentation/devicetree/bindings/timer/snps,archs-rtc.txt b/Documentation/devicetree/bindings/timer/snps,archs-rtc.txt
deleted file mode 100644
index 47bd7a7..0000000
--- a/Documentation/devicetree/bindings/timer/snps,archs-rtc.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Synopsys ARC Free Running 64-bit Local Timer for ARC HS CPUs
-- clocksource provider for UP SoC
-
-Required properties:
-
-- compatible : should be "snps,archs-rtc"
-- clocks     : phandle to the source clock
-
-Example:
-
-	rtc {
-		compatible = "snps,arc-rtc";
-		clocks = <&core_clk>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/snps,archs-rtc.yaml b/Documentation/devicetree/bindings/timer/snps,archs-rtc.yaml
new file mode 100644
index 0000000..7478810
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/snps,archs-rtc.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/snps,archs-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys ARC Free Running 64-bit Local Timer for ARC HS CPUs
+
+maintainers:
+  - Vineet Gupta <vgupta@synopsys.com>
+
+properties:
+  compatible:
+    const: snps,archs-rtc
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
+    rtc {
+      compatible = "snps,archs-rtc";
+      clocks = <&core_clk>;
+    };

