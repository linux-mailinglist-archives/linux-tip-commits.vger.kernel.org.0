Return-Path: <linux-tip-commits+bounces-4446-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E3DA6EB4C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E9E1894548
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA52561AC;
	Tue, 25 Mar 2025 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T8T2fyy5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5EZIwXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FF204693;
	Tue, 25 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890503; cv=none; b=oWd0kyY/H9kEfBAoo67fxRoX8z0CqHZFTHneIfZJ0w4qij3zt1W5Tpx4t366uzGHgawm0+lEBiHdho0c8dJoLLE3lyolsp1fVOxamHiXkn8aFBAUqvtbUDnJDGpHI9TixOEtYDOBLDuyQxzCvnXNBZciwhrQ2b7+ce8hmBytlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890503; c=relaxed/simple;
	bh=q6MfH5NCp19KF1mUEPyfSCIJIcymaiwn2kWwEnepj0c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fjs/D103Fqgz2iw2tZ9bm2LD6+hzvm+jdjetBhwTS6ptACAG//gLphJgcc68OQ3vEiZIF2Lg7s9eRPtfiUzph04YLzKwFttuoH7vATXMecvXz1SzmRVUHMz7fuuB2RqfXavRDcLcRhclDX5PaqTy58aas7J2GKci5solz8brlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T8T2fyy5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5EZIwXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wWwzaT75MH78zLxQqInSw3EvNVmqOPaIrioCleKZPo=;
	b=T8T2fyy5myxYO2EwUO8IplKHDBpVtZEgm6QNQWaGFdZ80cuxFmVqGyxYGu1Fn15BhWWKRY
	uQlDrPLbt8GrhsW/eFVSq4q5NRvPl7LN/dGKSf9fKH5ZbhC7zu8CdZbt2P9PF9l0cZUVmm
	2+8Mw/dz+RWNyTtLblB6clAw84xEMxRzkH9o8P/c8agHJO/DeeTmefSudlL8fyGEYHxQ13
	Od4hilVrwQUK8BvbNmdDBjFxURbCIqH06Wb/+OkQlRpCijeEvgFyANxUIolonUHBhUcY17
	ksDQ09a8mxN8e7zTzz/ngpH5rIqcmwHdImT8vEshGjs79Uyc5VNfUNeZFvteAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wWwzaT75MH78zLxQqInSw3EvNVmqOPaIrioCleKZPo=;
	b=a5EZIwXppiox12l15pj4/5Qwz4QZIJPqw1M0r04yVjyLluqbOcKTlS0R3wfwzY4nwT9Oj7
	5Qq9LUUTh0KEFYBg==
From: "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] dt-bindings: timer: Correct indentation and
 style in DTS example
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 niklas.soderlund+renesas@ragnatech.se,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250107131024.246561-1-krzysztof.kozlowski@linaro.org>
References: <20250107131024.246561-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049911.14745.12001364852281435562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     53b552f1cc102d20fc9313e0ad398de1cc8a94bc
Gitweb:        https://git.kernel.org/tip/53b552f1cc102d20fc9313e0ad398de1cc8=
a94bc
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Tue, 07 Jan 2025 14:10:22 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 07 Mar 2025 17:55:59 +01:00

dt-bindings: timer: Correct indentation and style in DTS example

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20250107131024.246561-1-krzysztof.kozlowski@l=
inaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/arm,twd-timer.yaml  |  6 +-
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml    | 44 +++----
 Documentation/devicetree/bindings/timer/renesas,em-sti.yaml | 10 +-
 Documentation/devicetree/bindings/timer/renesas,mtu2.yaml   | 14 +-
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml   | 10 +-
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml    | 22 ++--
 Documentation/devicetree/bindings/timer/renesas,tpu.yaml    |  8 +-
 Documentation/devicetree/bindings/timer/sifive,clint.yaml   |  2 +-
 8 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml b/Doc=
umentation/devicetree/bindings/timer/arm,twd-timer.yaml
index 5684df6..eb11273 100644
--- a/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,twd-timer.yaml
@@ -50,7 +50,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
     timer@2c000600 {
-            compatible =3D "arm,arm11mp-twd-timer";
-            reg =3D <0x2c000600 0x20>;
-            interrupts =3D <GIC_PPI 13 0xf01>;
+        compatible =3D "arm,arm11mp-twd-timer";
+        reg =3D <0x2c000600 0x20>;
+        interrupts =3D <GIC_PPI 13 0xf01>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,cmt.yaml
index 5e09c04..260b05f 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -178,29 +178,29 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a7790-sysc.h>
     cmt0: timer@ffca0000 {
-            compatible =3D "renesas,r8a7790-cmt0", "renesas,rcar-gen2-cmt0";
-            reg =3D <0xffca0000 0x1004>;
-            interrupts =3D <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&cpg CPG_MOD 124>;
-            clock-names =3D "fck";
-            power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
-            resets =3D <&cpg 124>;
+        compatible =3D "renesas,r8a7790-cmt0", "renesas,rcar-gen2-cmt0";
+        reg =3D <0xffca0000 0x1004>;
+        interrupts =3D <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&cpg CPG_MOD 124>;
+        clock-names =3D "fck";
+        power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets =3D <&cpg 124>;
     };
=20
     cmt1: timer@e6130000 {
-            compatible =3D "renesas,r8a7790-cmt1", "renesas,rcar-gen2-cmt1";
-            reg =3D <0xe6130000 0x1004>;
-            interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&cpg CPG_MOD 329>;
-            clock-names =3D "fck";
-            power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
-            resets =3D <&cpg 329>;
+        compatible =3D "renesas,r8a7790-cmt1", "renesas,rcar-gen2-cmt1";
+        reg =3D <0xe6130000 0x1004>;
+        interrupts =3D <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&cpg CPG_MOD 329>;
+        clock-names =3D "fck";
+        power-domains =3D <&sysc R8A7790_PD_ALWAYS_ON>;
+        resets =3D <&cpg 329>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml b/Do=
cumentation/devicetree/bindings/timer/renesas,em-sti.yaml
index 233d74d..a7385d8 100644
--- a/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,em-sti.yaml
@@ -38,9 +38,9 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     timer@e0180000 {
-            compatible =3D "renesas,em-sti";
-            reg =3D <0xe0180000 0x54>;
-            interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&sti_sclk>;
-            clock-names =3D "sclk";
+        compatible =3D "renesas,em-sti";
+        reg =3D <0xe0180000 0x54>;
+        interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&sti_sclk>;
+        clock-names =3D "sclk";
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,mtu2.yaml
index 15d8ddd..e56c12f 100644
--- a/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
@@ -66,11 +66,11 @@ examples:
     #include <dt-bindings/clock/r7s72100-clock.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     mtu2: timer@fcff0000 {
-            compatible =3D "renesas,mtu2-r7s72100", "renesas,mtu2";
-            reg =3D <0xfcff0000 0x400>;
-            interrupts =3D <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names =3D "tgi0a";
-            clocks =3D <&mstp3_clks R7S72100_CLK_MTU2>;
-            clock-names =3D "fck";
-            power-domains =3D <&cpg_clocks>;
+        compatible =3D "renesas,mtu2-r7s72100", "renesas,mtu2";
+        reg =3D <0xfcff0000 0x400>;
+        interrupts =3D <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "tgi0a";
+        clocks =3D <&mstp3_clks R7S72100_CLK_MTU2>;
+        clock-names =3D "fck";
+        power-domains =3D <&cpg_clocks>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,ostm.yaml
index e8c6421..9ba858f 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -71,9 +71,9 @@ examples:
     #include <dt-bindings/clock/r7s72100-clock.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     ostm0: timer@fcfec000 {
-            compatible =3D "renesas,r7s72100-ostm", "renesas,ostm";
-            reg =3D <0xfcfec000 0x30>;
-            interrupts =3D <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
-            clocks =3D <&mstp5_clks R7S72100_CLK_OSTM0>;
-            power-domains =3D <&cpg_clocks>;
+        compatible =3D "renesas,r7s72100-ostm", "renesas,ostm";
+        reg =3D <0xfcfec000 0x30>;
+        interrupts =3D <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
+        clocks =3D <&mstp5_clks R7S72100_CLK_OSTM0>;
+        power-domains =3D <&cpg_clocks>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index 75b0e7c..b122959 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -122,15 +122,15 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a7779-sysc.h>
     tmu0: timer@ffd80000 {
-            compatible =3D "renesas,tmu-r8a7779", "renesas,tmu";
-            reg =3D <0xffd80000 0x30>;
-            interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names =3D "tuni0", "tuni1", "tuni2", "ticpi2";
-            clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
-            clock-names =3D "fck";
-            power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;
-            #renesas,channels =3D <3>;
+        compatible =3D "renesas,tmu-r8a7779", "renesas,tmu";
+        reg =3D <0xffd80000 0x30>;
+        interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "tuni0", "tuni1", "tuni2", "ticpi2";
+        clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
+        clock-names =3D "fck";
+        power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;
+        #renesas,channels =3D <3>;
     };
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tpu.yaml
index 01554df..7a473b3 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
@@ -49,8 +49,8 @@ additionalProperties: false
 examples:
   - |
     tpu: tpu@ffffe0 {
-            compatible =3D "renesas,tpu";
-            reg =3D <0xffffe0 16>, <0xfffff0 12>;
-            clocks =3D <&pclk>;
-            clock-names =3D "fck";
+        compatible =3D "renesas,tpu";
+        reg =3D <0xffffe0 16>, <0xfffff0 12>;
+        clocks =3D <&pclk>;
+        clock-names =3D "fck";
     };
diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Docu=
mentation/devicetree/bindings/timer/sifive,clint.yaml
index 76d83ae..73edde5 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -77,6 +77,6 @@ examples:
                             <&cpu2intc 3>, <&cpu2intc 7>,
                             <&cpu3intc 3>, <&cpu3intc 7>,
                             <&cpu4intc 3>, <&cpu4intc 7>;
-       reg =3D <0x2000000 0x10000>;
+      reg =3D <0x2000000 0x10000>;
     };
 ...

