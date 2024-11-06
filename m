Return-Path: <linux-tip-commits+bounces-2775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB59BFA29
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 00:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D9C1C21D63
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 23:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5220E03E;
	Wed,  6 Nov 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUReX7eQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuPB028V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FC20E024;
	Wed,  6 Nov 2024 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935958; cv=none; b=Kx6OugslWvTyylnsl9tvrKOu9Bn+PiePSaRN5FsqgeCMD7IRCkT7JaY82N127qV0cFiJLbi8THUSby+GWHfEA/SJKeHMnaRbtkMKWDbpxiCr/FiqZdrcNCerNDl3PDOWDt0rsfYgK/ury/1JuebYSD2NkKEEEDctiQqIq5mvl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935958; c=relaxed/simple;
	bh=PqlyTGEH5AtUAytLW+FEHLigrAfJU2/su1H5gSxSIXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ViSXst30OXVbJw+8U81quJBkgBCQ33NTL6/geRHrHEe15N+A7myUo2eln57LGNmtPt/p9LyEwsY8MhjommnAu/EtylVR8YlH1rXH8ZJUDfEoOukd1BTVfDf2XohEVHDdIURGP070OF5J73TebuvW+TdVhwdFARt/yr7V4/FhGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUReX7eQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuPB028V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 23:32:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730935954;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acU13DprxTh1tWdld2+/T3W8ymzl80rxnZg5/uDtsbw=;
	b=zUReX7eQmDNuZS4USoG2f9xCY86gfBvoeosyfMSNFtqB22+lwL8z78V3Qql85AZlzyG+69
	Wkmy8sxpVb0IASmKZ2jgrDrQrJygwtqEYp07fv0Im1mYUsDPhVwY3xUPpxrMnlOaVqll6o
	hIU54AeVh1Ltu7UHujzQFlfUzI0DEOtMn6GG0Q3Wxs1EXU3OgbYTOgpMb8gigC2LtZE0FB
	YXvVuQZlikqs6pTBeOFAq2Dp5GtP3jfd7f/zPNkSxl/2K/OlX3v3ZC1WtGP+8YWteVDjP4
	o28TMW6qVGKbNz5k8YI1qJY84PQJsqun9zLumyJHA4uZ2zN4OruKbKw6Qb24ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730935954;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=acU13DprxTh1tWdld2+/T3W8ymzl80rxnZg5/uDtsbw=;
	b=kuPB028Vw9qqq5v11WSxAmqyFvZ9rWAnLwYA1V9FbZwlZ7Ikjd95N+cmtXYVDW0xbXydes
	z9qKEqt4DpHxNmBQ==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: Add T-HEAD C900
 ACLINT SSWI device
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241031060859.722258-2-inochiama@gmail.com>
References: <20241031060859.722258-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173093595402.32228.1049927571662435176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2631c2b8e5c3406af62b60413ea04e155be9ebcc
Gitweb:        https://git.kernel.org/tip/2631c2b8e5c3406af62b60413ea04e155be9ebcc
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 31 Oct 2024 14:08:57 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 00:28:27 +01:00

dt-bindings: interrupt-controller: Add T-HEAD C900 ACLINT SSWI device

Sophgo SG2044 has a new version of T-HEAD C920, which implement a fully
featured T-HEAD ACLINT device. This ACLINT device contains a SSWI device to
support fast S-mode IPI.

Add necessary compatible string for the T-HEAD ACLINT SSWI device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/all/20241031060859.722258-2-inochiama@gmail.com
Link: https://www.xrvm.com/product/xuantie/C920

---
 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
new file mode 100644
index 0000000..8d33090
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-sswi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD C900 ACLINT Supervisor-level Software Interrupt Device
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The SSWI device is a part of the THEAD ACLINT device. It provides
+  supervisor-level IPI functionality for a set of HARTs on a THEAD
+  platform. It provides a register to set an IPI (SETSSIP) for each
+  HART connected to the SSWI device.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2044-aclint-sswi
+      - const: thead,c900-aclint-sswi
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 0
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@94000000 {
+      compatible = "sophgo,sg2044-aclint-sswi", "thead,c900-aclint-sswi";
+      reg = <0x94000000 0x00004000>;
+      #interrupt-cells = <0>;
+      interrupt-controller;
+      interrupts-extended = <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+    };
+...

