Return-Path: <linux-tip-commits+bounces-7719-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96ACC0044
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 707D8301C365
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E132E738;
	Mon, 15 Dec 2025 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pv4IiSAt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+7yHn1or"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7A732C31C;
	Mon, 15 Dec 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835224; cv=none; b=eDaokzfKxtichcHeQ6qfn1F8TGlodqWNWyJPcGPIcVwT9+kqZAnfqboJEzr17VcNfYbaE62fpsKJQ3HxQX/4+FazcWNThGx9kvxlm7rVewP0q3Xu0W/T3i4W6vsuNS8Cssy9kXLm2Ezmjfz20m86yN/QueDU3+D0fxYwwjJm9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835224; c=relaxed/simple;
	bh=jethNkdpJtJByfdj5HlL546P1Cp3jYRNO+/Pt/8nIUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KM1ftwMpXe3EDTg2R2Lxh42YLPWljXGKXqFh4MzA/QySTJMNstS+9hUHwH/cI0C4H2dsABj0NrRbGpRHmWX3zvUgYp8Lv/SeyrsM2QYr8L+f6R7Vg0Iz1lwetCtdKX8+QxeyGsidnZzFw4foOOy/wfQ619LkI8OGCxyGMXI2zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pv4IiSAt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+7yHn1or; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMjI2frDIhpCRCrK821SewQn4wjAlksKphsqpdrKItg=;
	b=Pv4IiSAtAQtLFOKXdniDWI0NEaR/DK5RpYH27sT5FssHOUwbM66xJPkvKQwSJwE4y2Pu2k
	X40uMcWQYMxiKl17rPJuijfdVgM3beP0Q8dxK0BgHtimCH3FMSe7JehVLFQClybPchVIzr
	h3ZBHhfTafDblgrBUHhMWhDShCDTd8OX5rqO5HdVKxIgTFAq3GiwwrWxA88OBBJhyiig8B
	LUVhtRz05Vg8I8TwKgAUW2TFJghmzRGIpPRzi/cEndnpXf6Vy4nyeKvHGK1nKlyonz1qlc
	JQ8sls1ZqJAy3+6nvzb/+anuqEbhS7HG+y8bsDmnVBNdAD3uYg6aACKOuYIboQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMjI2frDIhpCRCrK821SewQn4wjAlksKphsqpdrKItg=;
	b=+7yHn1or70o6ngN9+n68pnR0c/Nr5C6BYV2Khy1FNwDNrDsYzT/W82yl+HRXy93NqPhXVl
	9UQH01GnDnwRltAw==
From: "tip-bot2 for Cosmin Tanislav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] arm64: dts: renesas: r9a09g077: Add ICU support
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251201112933.488801-4-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201112933.488801-4-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583522037.510.2787917344082896454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9b1138aef9a254dfc3412673a2dccfcd7f54c844
Gitweb:        https://git.kernel.org/tip/9b1138aef9a254dfc3412673a2dccfcd7f5=
4c844
Author:        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
AuthorDate:    Mon, 01 Dec 2025 13:29:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:32 +01:00

arm64: dts: renesas: r9a09g077: Add ICU support

The Renesas RZ/T2H (R9A09G077) SoC has an Interrupt Controller (ICU) block
that routes external interrupts to the GIC's SPIs, with the ability of
level-translation, and can also produce software and aggregate error
interrupts.

Add support for it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251201112933.488801-4-cosmin-gabriel.tanisla=
v.xa@renesas.com
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 73 +++++++++++++++++++++-
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts=
/renesas/r9a09g077.dtsi
index f5fa6ca..e5c9838 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -756,6 +756,79 @@
 			#power-domain-cells =3D <0>;
 		};
=20
+		icu: interrupt-controller@802a0000 {
+			compatible =3D "renesas,r9a09g077-icu";
+			reg =3D <0 0x802a0000 0 0x10000>,
+			      <0 0x812a0000 0 0x50>;
+			#interrupt-cells =3D <2>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 7 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 10 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 11 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 14 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 15 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 16 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 17 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 18 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 20 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 29 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 406 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 407 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 408 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 409 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 410 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 411 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 412 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 413 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 415 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 416 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names =3D "intcpu0", "intcpu1", "intcpu2",
+					  "intcpu3", "intcpu4", "intcpu5",
+					  "intcpu6", "intcpu7", "intcpu8",
+					  "intcpu9", "intcpu10", "intcpu11",
+					  "intcpu12", "intcpu13", "intcpu14",
+					  "intcpu15",
+					  "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "irq8", "irq9", "irq10", "irq11",
+					  "irq12", "irq13", "irq14", "irq15",
+					  "sei",
+					  "ca55-err0", "ca55-err1",
+					  "cr520-err0", "cr520-err1",
+					  "cr521-err0", "cr521-err1",
+					  "peri-err0", "peri-err1",
+					  "dsmif-err0", "dsmif-err1",
+					  "encif-err0", "encif-err1";
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKM>;
+			power-domains =3D <&cpg>;
+		};
+
 		pinctrl: pinctrl@802c0000 {
 			compatible =3D "renesas,r9a09g077-pinctrl";
 			reg =3D <0 0x802c0000 0 0x10000>,

