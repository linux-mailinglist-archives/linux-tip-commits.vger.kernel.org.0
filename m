Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CF80AEA8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 22:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1417C1C204AB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 21:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01157892;
	Fri,  8 Dec 2023 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sL4gUh4z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OL+OP7o1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BB1985;
	Fri,  8 Dec 2023 13:14:39 -0800 (PST)
Date: Fri, 08 Dec 2023 21:14:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702070078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4gR2RBzl4XZ+OuFIyikjZWovbgyoPQsIk2ZHiKmq4c=;
	b=sL4gUh4zzzybyMCXc54pjQ2iVXXLgYgPDp9VnlyeGY6Jz5wCEoogHvdEuPX7tFwdfj8vzw
	OrcMk+3YT4NhRfpgWANoaNzqiUGYZh8O0qHDJydDj6CQb8981WQkNa+xCg1IceN9fFyD2e
	8qRcj4qDm0bv/aMZ0sHacgLgq3QxdJY99Pl15bZvr9XOpVGUX04yTOzRZ8G4mNGbk1V04u
	SQ/ERfkAXlGMZ9Ao9X6WCaWiF8dQrlZXkwdI7vn1HhZkSbL/w6JK2MOpD3yLKYA+nlGctY
	lPuco0/4WnDKIYy1mAPUbMFLtxU4PjfINscd5KpzHC8q/2UdyA7jAdWJgQKSxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702070078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4gR2RBzl4XZ+OuFIyikjZWovbgyoPQsIk2ZHiKmq4c=;
	b=OL+OP7o1NZ+OUvioLce9IOhG5Swf8g7BN232m+FFdmJO/Q5kpnKMS3vDMPuz3wDsOEiAQu
	OKBQaWUYLGsHV7Bg==
From: "tip-bot2 for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: mpm: Pass MSG RAM
 slice through phandle
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230328-topic-msgram_mpm-v7-1-6ee2bfeaac2c@linaro.org>
References: <20230328-topic-msgram_mpm-v7-1-6ee2bfeaac2c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170207007784.398.672518304250442085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3ff156f0d4e71f96b15f9b16f3b6a82b617c4bb7
Gitweb:        https://git.kernel.org/tip/3ff156f0d4e71f96b15f9b16f3b6a82b617c4bb7
Author:        Konrad Dybcio <konrad.dybcio@linaro.org>
AuthorDate:    Mon, 27 Nov 2023 16:52:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 08 Dec 2023 22:06:36 +01:00

dt-bindings: interrupt-controller: mpm: Pass MSG RAM slice through phandle

Due to the wild nature of the Qualcomm RPM Message RAM, the kernel can't
really use 'reg' to point to the MPM's slice of Message RAM without cutting
into an already-defined RPM MSG RAM node used for GLINK and SMEM.

Document passing the register space as a slice of SRAM through the
qcom,rpm-msg-ram property. This also makes 'reg' deprecated.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v7-1-6ee2bfeaac2c@linaro.org

---
 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
index 509d20c..4ce7912 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -29,6 +29,12 @@ properties:
     maxItems: 1
     description:
       Specifies the base address and size of vMPM registers in RPM MSG RAM.
+    deprecated: true
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the APSS MPM slice of the RPM Message RAM
 
   interrupts:
     maxItems: 1
@@ -64,33 +70,45 @@ properties:
 
 required:
   - compatible
-  - reg
   - interrupts
   - mboxes
   - interrupt-controller
   - '#interrupt-cells'
   - qcom,mpm-pin-count
   - qcom,mpm-pin-map
+  - qcom,rpm-msg-ram
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    mpm: interrupt-controller@45f01b8 {
-        compatible = "qcom,mpm";
-        interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-        reg = <0x45f01b8 0x1000>;
-        mboxes = <&apcs_glb 1>;
-        interrupt-controller;
-        #interrupt-cells = <2>;
-        interrupt-parent = <&intc>;
-        qcom,mpm-pin-count = <96>;
-        qcom,mpm-pin-map = <2 275>,
-                           <5 296>,
-                           <12 422>,
-                           <24 79>,
-                           <86 183>,
-                           <90 260>,
-                           <91 260>;
+
+    remoteproc-rpm {
+        compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
+
+        glink-edge {
+            compatible = "qcom,glink-rpm";
+
+            interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+            qcom,rpm-msg-ram = <&rpm_msg_ram>;
+            mboxes = <&apcs_glb 0>;
+        };
+
+        mpm: interrupt-controller {
+            compatible = "qcom,mpm";
+            qcom,rpm-msg-ram = <&apss_mpm>;
+            interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&apcs_glb 1>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupt-parent = <&intc>;
+            qcom,mpm-pin-count = <96>;
+            qcom,mpm-pin-map = <2 275>,
+                               <5 296>,
+                               <12 422>,
+                               <24 79>,
+                               <86 183>,
+                               <91 260>;
+        };
     };

