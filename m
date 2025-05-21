Return-Path: <linux-tip-commits+bounces-5723-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3AABFA79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2438F1890ED6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 15:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915D22CBF8;
	Wed, 21 May 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUqEc7Wc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azzM6T6k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266C22A7EF;
	Wed, 21 May 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842582; cv=none; b=L5ai2wnewaMShVVhxZjAo5hodfmTiuzxnTHom4D/Taq82d5T/0SsoqxOPiwTiC4XZU/doy9jlOSv59koJC3fsP0xEGukfHJHdidLfd8iXsPu/PuSXJedkQIlKcSDZe6Z0kPF9hdWpAhlJY8Sv2YvkQuYrV8Xp/jgTLUk9xRoqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842582; c=relaxed/simple;
	bh=yoxZN/H7xPt8SCIyqYkRzlrAfX0wqWxnTB1MBwxzh+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YqXEJVyOkRTIuxaEXWnKnZkWDyfE2KvU+eZcnNTrRJHRV8JeZvnmSbNNef0Y1gGzwu3D/68kLhaE/I2iKi1zKtfzQcA50QqJdqxk6znhZ7DLPNrTR/0fhHnXqltKI8Ttx9S/FmYdGnv29RZlldL3hrmIuJKkBsVIwkEHzdY5iz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUqEc7Wc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=azzM6T6k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 15:49:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747842578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDuoTdLtmCwn5Zf8SUw5p3YPsMsqK6nW45uw1BJKzIQ=;
	b=jUqEc7WcvDjVJ0ZtrEGzrpySNjgc756xMfK2XEFnn/pkuJiJIhjxyksD2uRbmY0lZ/eUi/
	e8oKwyAC3RF1nlhW0gS6Ntcvoi8N2lqVNuH1X7VtnBtTTwQiXZvmDpsYM5BR25Jl9+0b/z
	LxdJ87URp3H/eZFHmr2aJkSCS7//KWYYT2pTK30ymBruB3OTGlUWnaz3FmP2oam1cjvLCT
	nku78wKWBolrygTwk8/ruPhIP7T2dJEFQxAOLBwcWELE7VY4tihgHGZViTzgDDz25o8aVR
	bSHfdkKHcXG1pBBn+Ambu8em3SpBVK63JpaudUr7OdRmM/yFSLtUf92qtlrhUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747842578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDuoTdLtmCwn5Zf8SUw5p3YPsMsqK6nW45uw1BJKzIQ=;
	b=azzM6T6kctGGOfwNNB/n7lmv7MJtA7ZiW/8cuDbH0094Crp7QSmamxB28HLKMncRH88YQ/
	feHu8sZZzP4r46DQ==
From: "tip-bot2 for Rob Herring (Arm)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Convert
 cnxt,cx92755-timer to DT schema
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250506022232.2587186-1-robh@kernel.org>
References: <20250506022232.2587186-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174784257793.406.8772040826358964040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     c55cddf6201c3c88b66dd37207d87e555c34f6cb
Gitweb:        https://git.kernel.org/tip/c55cddf6201c3c88b66dd37207d87e555c34f6cb
Author:        Rob Herring (Arm) <robh@kernel.org>
AuthorDate:    Mon, 05 May 2025 21:22:31 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 16 May 2025 11:10:33 +02:00

dt-bindings: timer: Convert cnxt,cx92755-timer to DT schema

Convert the Conexant Digicolor SoCs Timer binding to DT schema format.
It's a straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Link: https://lore.kernel.org/r/20250506022232.2587186-1-robh@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/cnxt,cx92755-timer.yaml | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/timer/digicolor-timer.txt     | 18 ------------------
 2 files changed, 49 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/cnxt,cx92755-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/digicolor-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/cnxt,cx92755-timer.yaml b/Documentation/devicetree/bindings/timer/cnxt,cx92755-timer.yaml
new file mode 100644
index 0000000..8f1a5af
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cnxt,cx92755-timer.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cnxt,cx92755-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Conexant Digicolor SoCs Timer Controller
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  compatible:
+    const: cnxt,cx92755-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Contains 8 interrupts, one for each timer
+    items:
+      - description: interrupt for timer 0
+      - description: interrupt for timer 1
+      - description: interrupt for timer 2
+      - description: interrupt for timer 3
+      - description: interrupt for timer 4
+      - description: interrupt for timer 5
+      - description: interrupt for timer 6
+      - description: interrupt for timer 7
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
+    timer@f0000fc0 {
+      compatible = "cnxt,cx92755-timer";
+      reg = <0xf0000fc0 0x40>;
+      interrupts = <19>, <31>, <34>, <35>, <52>, <53>, <54>, <55>;
+      clocks = <&main_clk>;
+    };
diff --git a/Documentation/devicetree/bindings/timer/digicolor-timer.txt b/Documentation/devicetree/bindings/timer/digicolor-timer.txt
deleted file mode 100644
index d1b659b..0000000
--- a/Documentation/devicetree/bindings/timer/digicolor-timer.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Conexant Digicolor SoCs Timer Controller
-
-Required properties:
-
-- compatible : should be "cnxt,cx92755-timer"
-- reg : Specifies base physical address and size of the "Agent Communication"
-  timer registers
-- interrupts : Contains 8 interrupts, one for each timer
-- clocks: phandle to the main clock
-
-Example:
-
-	timer@f0000fc0 {
-		compatible = "cnxt,cx92755-timer";
-		reg = <0xf0000fc0 0x40>;
-		interrupts = <19>, <31>, <34>, <35>, <52>, <53>, <54>, <55>;
-		clocks = <&main_clk>;
-	};

