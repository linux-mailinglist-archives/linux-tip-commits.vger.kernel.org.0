Return-Path: <linux-tip-commits+bounces-5708-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242BDABFA4A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716EB7B6005
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BB72222CE;
	Wed, 21 May 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aX/iIFvc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eq2Ilt/y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16E221710;
	Wed, 21 May 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842570; cv=none; b=q2eNdjnUUXUJ8Zp2Xed0wIpTRLgGfzw994dB145SdnwKLsIap4x25zN8u559sq0tYS6ugtcpLyk7t6wvK8p0V5J3KV43LbtUEyuQRCCCyOSx9EG55ZDGH/a7UJnorkQpSQ8VuTSQeSB6fleMkzYAUZclDEtMSmPqwxuuFmeLfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842570; c=relaxed/simple;
	bh=e23HZXreHhOW/CNkKQDeouI2EAz4g144UTHtL2Jo7tE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M4410hQkZxKpUcarX+2c/wrfOc4NbiK0EC1vpaBPF9Cs/UgZ6P8SMZfCaFdO91zmsXqXCflNp7x77R40X2lvpWCDt6vE0XpZhQY80er5glsw25qCF+/Ip76k1VyyKGczaoeaP23wDQdfWrVnLrd9qpN2xCOSZGr4T+PZxQUa874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aX/iIFvc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eq2Ilt/y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842566;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/0Kj6sNhl3VFQ9X4mXxaMQbWBCVUUrC/KiLDzhjFcI=;
	b=aX/iIFvc9mOdVyy38TzrlKKSCXorAelxAhaVzaP9rF4YKFMS4cVvI49PeJinmwt8SztLzF
	jm56jiLRsmFPOiFQOd3TMf4746zBCzNSKaOK2Wl90ro2SdXD1qcjYMpH8aZXu2XUPK+p18
	ullxH7V5L+g7Vw68kLuWbBqngRLtnbT8UBOl2Tb9kfYvFnCBnRqyLauV7bRypcQ6dDMcFz
	uTLelU3XWDZnOM5QEYfCjcxYJ0+JxROL89RIh/Pw/1kScr2K3gvNlUgDt7gXtRPAWVjVtA
	aElH5ESpSVSnCbDhZrVhrVDuFEIULj34jhtFn6pQ/nnwZ7VtyLBNugrzux+OAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842566;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/0Kj6sNhl3VFQ9X4mXxaMQbWBCVUUrC/KiLDzhjFcI=;
	b=Eq2Ilt/yp1YEalNLqGrDcsZ5o+s/g+eSW/jsaegPx+bL3hZKzMB6jnlYudjkfrAQFSOltA
	OotDsjLjWgf3e5Ag==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 socionext,milbeaut-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022322.2589193-1-robh@kernel.org>
References: <20250506022322.2589193-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784256564.406.4520983223831021935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     7e5ce1944d0f4543e233e7c3011f37d59c4bbf85
Gitweb:        https://git.kernel.org/tip/7e5ce1944d0f4543e233e7c3011f37d59c4bbf85
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:23:20 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:34 +02:00

dt-bindings: timer: Convert socionext,milbeaut-timer to DT schema

Convert the Socionext Milbeaut Timer binding to DT schema format.
It's a straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20250506022322.2589193-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt  | 17 -----------------
 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.yaml | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
deleted file mode 100644
index ac44c4b..0000000
--- a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Milbeaut SoCs Timer Controller
-
-Required properties:
-
-- compatible : should be "socionext,milbeaut-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The interrupt of the first timer.
-- clocks: phandle to the input clk.
-
-Example:
-
-timer {
-	compatible = "socionext,milbeaut-timer";
-	reg = <0x1e000050 0x20>
-	interrupts = <0 91 4>;
-	clocks = <&clk 4>;
-};
diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.yaml b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.yaml
new file mode 100644
index 0000000..9ab72b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/socionext,milbeaut-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Milbeaut SoCs Timer Controller
+
+maintainers:
+  - Sugaya Taichi <sugaya.taichi@socionext.com>
+
+properties:
+  compatible:
+    const: socionext,milbeaut-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@1e000050 {
+        compatible = "socionext,milbeaut-timer";
+        reg = <0x1e000050 0x20>;
+        interrupts = <0 91 4>;
+        clocks = <&clk 4>;
+    };

