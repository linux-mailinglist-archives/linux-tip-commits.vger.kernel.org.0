Return-Path: <linux-tip-commits+bounces-7312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA08C4FD85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7173B96E5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC93B352F98;
	Tue, 11 Nov 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFsWxtJa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUq56JAp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9632692A;
	Tue, 11 Nov 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896196; cv=none; b=A8gruIhGu3RB/YhybpJXvcFcMr4wSIqDG/DQbhFa2NihJjEeIFelsj/koxPMc9KSZD+Vc4G1YtU3+Bzck1EoCyrzhx8pxM+0SlnmoGGJXR49KKxyjc0OPmgziJi1Q01KxyTzI2r4jElYJgVJrqi+CdzOd8e3ifPzZeK1Uz/CTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896196; c=relaxed/simple;
	bh=9LGiWZNiBR6YkihRJd1F0bRbh6+CANxH9U41L0GdTYo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ky61x+C3RoICySoayoWi11cMkzKB7XgEquVtChOvKYGNGd0DdChhpJmgi8ZsHaibbJc3HySTnpqz91g4RbuRdA1XYwHtOtbieN2YSVQRHQapUkuoCrKhOFBSzXjBtXbQktS2tmpGcH85plGTFgsK0lAKrjDpika5C2ybdWDohME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFsWxtJa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUq56JAp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762896193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JwSNoaXLW8SzNg1NbVSXr2ywjxDw0DFKSIHlii6M2c=;
	b=UFsWxtJaypIjwsOfmZQm0wn0PgwNNvNsDMhiBE1hMc8zDx/HUPzd8rAlJtOxtD1elGBhg4
	9w8wRrrXVPc/gVkBAR7L9vapCCOg3UjN1Fy/BKj4BcsjOmGzZN1kM+QD19cwn3ZkRjZ6Ut
	GeXrGNxOdzdjsHH/Pid+BiXRxJM94OuvkGP/2G9hfABIkcWhqyF382LDFPQ81gNmm2tmtz
	ALmoRXOgHRa7TvLoSsqg5wA9EzN6spPZJ1KAg5woLroRt26Fv+ObMWeCUhShFwq9CdEOeb
	M26gTSheScCjQKTq/RyyiPKFSOjVc7aIY7vurmvi1iqXski00u6vVpUzs3Vvpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762896193;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JwSNoaXLW8SzNg1NbVSXr2ywjxDw0DFKSIHlii6M2c=;
	b=jUq56JApLpnLAjvrVii9MeG4oZSnPcY7ZTGAwFOEsJolQas7PTjQBSZ9kX5HshmYkKAhe9
	igtnlJu6cDiNIHCw==
From: "tip-bot2 for Ryan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] dt-bindings: interrupt-controller: aspeed,ast2700:
 Correct #interrupt-cells and interrupts count
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Thomas Gleixner <tglx@linutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251030060155.2342604-2-ryan_chen@aspeedtech.com>
References: <20251030060155.2342604-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289619229.498.17017884706998621350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7083e142256f92d079d2749e002f2f2499e5f63c
Gitweb:        https://git.kernel.org/tip/7083e142256f92d079d2749e002f2f2499e=
5f63c
Author:        Ryan Chen <ryan_chen@aspeedtech.com>
AuthorDate:    Thu, 30 Oct 2025 14:01:55 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:20:45 +01:00

dt-bindings: interrupt-controller: aspeed,ast2700: Correct #interrupt-cells a=
nd interrupts count

Update the AST2700 interrupt controller binding to match the actual
hardware and the irq-aspeed-intc driver behavior.

 - Interrupts:

    First-level INTC banks request multiple interrupt lines to the root
    GIC, with a maximum of 10 per bank. Second-level INTC banks request
    only one interrupt line to their parent INTC-IC. Therefore, set the
    interrupts property to allow a minimum of 1 and a maximum of 10
    entries.

 - #interrupt-cells:

    Set '#interrupt-cells' to <1> since the aspeed intc driver does not
    support specifying a trigger type; only the interrupt index is used.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20251030060155.2342604-2-ryan_chen@aspeedtech.=
com
---
 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.y=
aml | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,as=
t2700-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/aspe=
ed,ast2700-intc.yaml
index 55636d0..999df5b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-i=
ntc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-i=
ntc.yaml
@@ -25,13 +25,14 @@ properties:
   interrupt-controller: true
=20
   '#interrupt-cells':
-    const: 2
+    const: 1
     description:
       The first cell is the IRQ number, the second cell is the trigger
       type as defined in interrupt.txt in this directory.
=20
   interrupts:
-    maxItems: 6
+    minItems: 1
+    maxItems: 10
     description: |
       Depend to which INTC0 or INTC1 used.
       INTC0 and INTC1 are two kinds of interrupt controller with enable and =
raw
@@ -74,13 +75,17 @@ examples:
         interrupt-controller@12101b00 {
             compatible =3D "aspeed,ast2700-intc-ic";
             reg =3D <0 0x12101b00 0 0x10>;
-            #interrupt-cells =3D <2>;
+            #interrupt-cells =3D <1>;
             interrupt-controller;
             interrupts =3D <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
         };
     };

