Return-Path: <linux-tip-commits+bounces-3633-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FFA4576F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 09:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A8C18995E0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F335271831;
	Wed, 26 Feb 2025 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YK25YhJR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0euFBWq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D926BDAF;
	Wed, 26 Feb 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556300; cv=none; b=uNgm1DdnXCmlvHAaiX85FhnMMSgLbfofcCne/ND3NzOzW8XTHg+Vttpl2gvJjhb2Afwxn82E1YqXqgWdMDw0qbVPAOwtGytmEWYU6eGMwDKDm+Lh11/qoFdqaNPPovxUm2oc89eCfDi9aLNXQoCTbrVPbm/As12egRVwUM4VT1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556300; c=relaxed/simple;
	bh=k1+wLK37e3LpD+WLiK+v9tEmFt4zkEW9z2vFcAOTdCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MKFf171Do2Z0SA3f177V4XDN539IizzKDJJFEm2HpTf+lJgkwXzuAFIVswkeF3O40O5xP7//gf5bs3joCi+W1V4ST0OP2MQlrBTVr6UhMvP/nE38BhhzmKipZ9hWTdT0E8cpv9wYiyVrzLYMpB22TCNHxHOUuQ64VdGqouQ+yX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YK25YhJR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0euFBWq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 07:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740556297;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVYsUCjhCiUZqiv5v7o4CWa5IDODULzUkS47aizP7Vg=;
	b=YK25YhJRko+qgfJFEJ0qzi06XhiuBx9wJR5CoHPsaEfAuNH9gGO/r50B4bBE6xN3vkX0gU
	r/3UoyHH5bOAyRcA03V6SHhNe3rGj0IarmdxvvwhJsCxLjk94+MZJGIBDEmzEHmL2KxVBd
	N4CyL7XGKxcMvMUEI2DxKsD7YSkwXrF1U73UgrtY/D/RKATC+KGRYDp6pYILl94v7fzQd/
	p9Oi8+fxnKddkl6fEwb0VJ2upgwo7icbAHzfnhhCOdP6PZG+YPFdXmaulCwRYH3jF9onoI
	28SjAN3Rt3H0sPo5q4u4sv7QbhVOqWwkbEzRKqdfBZKYUWz9boOT3eUjCzTiSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740556297;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVYsUCjhCiUZqiv5v7o4CWa5IDODULzUkS47aizP7Vg=;
	b=g0euFBWqvs4BGLPKvwNL42mEXoX1QubPN77l9PmPahqqz4Nw336qkr/kS/2ohGKHogBKtA
	JZ70nnssOvTcA3Ag==
From: "tip-bot2 for Chen Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI
Cc: Chen Wang <unicorn_wang@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Rob Herring (Arm)" <robh@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C44de02977624be334ba6328acfdbb2a375f2071f=2E17405?=
 =?utf-8?q?35748=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3C44de02977624be334ba6328acfdbb2a375f2071f=2E174053?=
 =?utf-8?q?5748=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174055629685.10177.15134432668069964917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a41d042757fb36f982413622e890a1c41e043000
Gitweb:        https://git.kernel.org/tip/a41d042757fb36f982413622e890a1c41e043000
Author:        Chen Wang <unicorn_wang@outlook.com>
AuthorDate:    Wed, 26 Feb 2025 10:15:01 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 08:41:27 +01:00

dt-bindings: interrupt-controller: Add Sophgo SG2042 MSI

Add binding for Sophgo SG2042 MSI controller.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/44de02977624be334ba6328acfdbb2a375f2071f.1740535748.git.unicorn_wang@outlook.com

---
 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
new file mode 100644
index 0000000..e1ffd55
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 MSI Controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  This interrupt controller is in Sophgo SG2042 for transforming interrupts from
+  PCIe MSI to PLIC interrupts.
+
+allOf:
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-msi
+
+  reg:
+    items:
+      - description: clear register
+      - description: msi doorbell address
+
+  reg-names:
+    items:
+      - const: clr
+      - const: doorbell
+
+  msi-controller: true
+
+  msi-ranges:
+    maxItems: 1
+
+  "#msi-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - msi-controller
+  - msi-ranges
+  - "#msi-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    msi-controller@30000000 {
+      compatible = "sophgo,sg2042-msi";
+      reg = <0x30000000 0x4>, <0x30000008 0x4>;
+      reg-names = "clr", "doorbell";
+      msi-controller;
+      #msi-cells = <0>;
+      msi-ranges = <&plic 64 IRQ_TYPE_LEVEL_HIGH 32>;
+    };

