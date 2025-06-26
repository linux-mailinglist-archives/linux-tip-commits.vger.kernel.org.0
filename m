Return-Path: <linux-tip-commits+bounces-5929-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D632AEA01E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB7016B7F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349A2EBB88;
	Thu, 26 Jun 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqXqKk/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJ2j7fyO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF892EB5BA;
	Thu, 26 Jun 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947192; cv=none; b=OtwLv76VfNmJF+mtjOwi/g/Z9u2z8ux87futKBOz0YUmUbWbuC6vHcSRjafXYJc3T/EPjIfhy3ZedOtPtnCpvAKi1g6eGCPZGFzwWBOLTXxt8rnzNkQ9GhA/7PzjIwfUUIZbkfTonYpVC/ClOcCO5XCjDSuyrcJN4eA6FC5ojcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947192; c=relaxed/simple;
	bh=KhVh8JjQuqfXniEBWoff1GxD2OZcpfMODBBxDiKRXgo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CSrEj73Uo8nRy5Te8uPCMUitNep6mQxoXpAANaR0q281v+e413VWx/zIyAEcSa+3SOAhiji8gZjVbJ6svP39OeGIQOWbmBMPs4GHlB6lEJAPz1RJDRNkaEJqpuG9FpLjOreLz8kr9KNCIguK1unTMGCI75Y48PTxvaNfqCJ1cCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqXqKk/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJ2j7fyO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut8RmYCciKcpv6iW9/gzM1Ta8V1l5O34SHnwSAZlfn8=;
	b=qqXqKk/8PXQz4HOSVjmCNhuc9zM7YdO+JMXN6fN3+TNceAVU7cvCBdYjAxGVkB3tZrKu49
	/K/9qA/Zg3+A5sxsfGZxudCfwWCx2GhjrtYLvfAUnBCyfHwZ4N+K+E5k9LK6ABobzURrCl
	UmW4TLc2OQCxPtu0l5EGgvf4zrHLYGf+Fgvuj2nsXg/AmmbC9ve4z8G5ararLiHARl2bai
	6i2i+p8RE42B2XaePeSeCU+DF2CjgIQ0B5zbaChawZNNK7ULWUR1emH+RJc1y1HuCm9GzJ
	hmXWVstbfXUkL8iJY+1UtOG0SPpyl5OyuDO6EgARLYLug4SY9J2/6Rjo5+z9sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut8RmYCciKcpv6iW9/gzM1Ta8V1l5O34SHnwSAZlfn8=;
	b=xJ2j7fyOgqqQhRRjuTkVduSRNyqwsg3UR6tcK9hvgdVroYG7Eqw5IRmWX0TdPZOB0rkZOX
	gpV8lN0fb917z+DQ==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: Add MIPS P8700
 aclint-sswi
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Conor Dooley <conor.dooley@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-4-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-4-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094718853.406.964028946511027482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     ed651979bb780270ae14b35ca6bae68f658eddad
Gitweb:        https://git.kernel.org/tip/ed651979bb780270ae14b35ca6bae68f658eddad
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:07 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

dt-bindings: interrupt-controller: Add MIPS P8700 aclint-sswi

Add ACLINT-SSWI variant for the MIPS P8700 SoC. This CPU has a SSWI device
compliant with the RISC-V draft spec (see [1]).

CPU indexes on this platform are not continuous, instead it uses bit-fields
to encode hart,core,cluster numbers, thus the DT property
"riscv,hart-indexes" is mandatory for it.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/all/20250612143911.3224046-4-vladimir.kondratiev@mobileye.com
Link: https://github.com/riscvarchive/riscv-aclint [1]


---
 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
index 8d33090..c1ab865 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
@@ -4,23 +4,32 @@
 $id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-sswi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: T-HEAD C900 ACLINT Supervisor-level Software Interrupt Device
+title: ACLINT Supervisor-level Software Interrupt Device
 
 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
 
 description:
-  The SSWI device is a part of the THEAD ACLINT device. It provides
-  supervisor-level IPI functionality for a set of HARTs on a THEAD
-  platform. It provides a register to set an IPI (SETSSIP) for each
-  HART connected to the SSWI device.
+  The SSWI device is a part of the ACLINT device. It provides
+  supervisor-level IPI functionality for a set of HARTs on a supported
+  platforms. It provides a register to set an IPI (SETSSIP) for each
+  HART connected to the SSWI device. See draft specification
+  https://github.com/riscvarchive/riscv-aclint
+
+  Following variants of the SSWI ACLINT supported, using dedicated
+  compatible string
+  - THEAD C900
+  - MIPS P8700
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sophgo,sg2044-aclint-sswi
-      - const: thead,c900-aclint-sswi
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2044-aclint-sswi
+          - const: thead,c900-aclint-sswi
+      - items:
+          - const: mips,p8700-aclint-sswi
 
   reg:
     maxItems: 1
@@ -34,6 +43,14 @@ properties:
     minItems: 1
     maxItems: 4095
 
+  riscv,hart-indexes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 4095
+    description:
+      A list of hart indexes that APLIC should use to address each hart
+      that is mentioned in the "interrupts-extended"
+
 additionalProperties: false
 
 required:
@@ -43,8 +60,22 @@ required:
   - interrupt-controller
   - interrupts-extended
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mips,p8700-aclint-sswi
+    then:
+      required:
+        - riscv,hart-indexes
+    else:
+      properties:
+        riscv,hart-indexes: false
+
 examples:
   - |
+    //Example 1
     interrupt-controller@94000000 {
       compatible = "sophgo,sg2044-aclint-sswi", "thead,c900-aclint-sswi";
       reg = <0x94000000 0x00004000>;
@@ -55,4 +86,19 @@ examples:
                             <&cpu3intc 1>,
                             <&cpu4intc 1>;
     };
+
+  - |
+    //Example 2
+    interrupt-controller@94000000 {
+      compatible = "mips,p8700-aclint-sswi";
+      reg = <0x94000000 0x00004000>;
+      #interrupt-cells = <0>;
+      interrupt-controller;
+      interrupts-extended = <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+      riscv,hart-indexes = <0x0 0x1 0x10 0x11>;
+    };
+
 ...

