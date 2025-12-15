Return-Path: <linux-tip-commits+bounces-7718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 289CECC00B0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8758306EF61
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E732D0F2;
	Mon, 15 Dec 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f71pimSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJo5bA/3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6230BF55;
	Mon, 15 Dec 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835223; cv=none; b=Xcj3pEU/fyeMJROxwiFcbJIYJp9XqUA76QC4T26YPlfmkKJLY9XbE45o8FWcLoUu8FE91QQTb5DT5VT+sU2LlTlEIVn8tjk48nE3LAzEcB3OH8z+N05fA5+iEdaIQxsHGbf370p0AdANO+zS67LkX4R5R3Mc54Gx0pMkiJuZ9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835223; c=relaxed/simple;
	bh=Z5+9Qmk+C2KflrkLfIXmUD/v6nhp/b6t2pG/BDtLS8c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ot8btZs9hO3QbBD5kL9CVyBKnZlozYk/v0TQand7iFQA02tBLXDd8VjQxdA2kQPLH2a3oZaN7vSqzxjczQknSy+myyaxRo7F/UFJnnRf2ijzEvVx2lETzq9PBGoucflqLgFkmMvBzYPMDkGGLVnHvU0AV7k2XtmcbREHYVB4XQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f71pimSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJo5bA/3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:46:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv+jUqDFrY0nNIFJIHJNbYVnoNu1BVhCFcgBhpgNoJU=;
	b=f71pimSnXA1ciBt8plgB2e8LUb479qrnLukuekYrW6f1+fyJz/iK4BH082gkD11titVlMt
	Nz3hxIjw6X3F79mBxVGvVdZTDiHKpRt5GcMQGHuT6mbIgvYc8efWkO0haaJKvp4Rb2/y/7
	m+32dhw0sHpH+HqhpOLK3W6vdfvW+IzJYT2KWyhdG60r/AqK3OBebY7lVxBujEzFqb6XU6
	LtpMNBTIFzAOoKyajobGKu+ovDCjdLmQvxLT0qhNfhlkvBz1VJVcFK3+tYlPQIL3zEZ1R3
	PXIq9JtvUiSo3yGgj5vPQoVf7KGRgGTuJ0QJEFjLpa8hfIJasriO1/2j95eXOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fv+jUqDFrY0nNIFJIHJNbYVnoNu1BVhCFcgBhpgNoJU=;
	b=pJo5bA/3E0DqYfPqYjTXoFgFhZhTEMnd1pjEvZ0op0+NAd28MlLrhZBvBEikc2tdrOrCWM
	haVszeCdO6LntnAQ==
From: "tip-bot2 for Cosmin Tanislav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] arm64: dts: renesas: r9a09g087: Add ICU support
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251201112933.488801-5-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201112933.488801-5-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583521910.510.16822991242218719932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     97232dc43e83987e2c5fc2fb875b31c745ac9c01
Gitweb:        https://git.kernel.org/tip/97232dc43e83987e2c5fc2fb875b31c745a=
c9c01
Author:        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
AuthorDate:    Mon, 01 Dec 2025 13:29:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:33 +01:00

arm64: dts: renesas: r9a09g087: Add ICU support

The Renesas RZ/N2H (R9A09G087) SoC has an Interrupt Controller (ICU) block
that routes external interrupts to the GIC's SPIs, with the ability of
level-translation, and can also produce software and aggregate error
interrupts.

Add support for it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251201112933.488801-5-cosmin-gabriel.tanisla=
v.xa@renesas.com
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 73 +++++++++++++++++++++-
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts=
/renesas/r9a09g087.dtsi
index 361a923..0e0a9c1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -759,6 +759,79 @@
 			#power-domain-cells =3D <0>;
 		};
=20
+		icu: interrupt-controller@802a0000 {
+			compatible =3D "renesas,r9a09g087-icu", "renesas,r9a09g077-icu";
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
+			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKM>;
+			power-domains =3D <&cpg>;
+		};
+
 		pinctrl: pinctrl@802c0000 {
 			compatible =3D "renesas,r9a09g087-pinctrl";
 			reg =3D <0 0x802c0000 0 0x10000>,

