Return-Path: <linux-tip-commits+bounces-7329-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2AC57A19
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 14:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54660425A9F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A7351FCD;
	Thu, 13 Nov 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OID3vU1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CY2tDoSr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7C3502B0;
	Thu, 13 Nov 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039260; cv=none; b=IX1PQSETqEJB6LYVl1UdrAozIsmRBx/G1n9ByT+1fRKACcFfm1f95dsPkPVjT76wCPyanEYAETMpgX1TIwpRRLFGPycuKsN1AZA40lGahdkjSak14+f4FYMLNU9T3D/xeP27je85ynXZ0RzsVe5ncv2nMObfIBaJN1oLkc37cNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039260; c=relaxed/simple;
	bh=vRNX/kXLYQqvpL8PciwjUnhMYG9zAmoZ2ckYxYSGvTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AM6vijBOkPW38KcjGWLn3T/YXVMK540PBwkIbOIC63kLUcUjl6C2DmjL89E8RgPtSHi57ov5ryzCvRG/qSzO4EujSUeysEmmmA8qNZ/wOgmHkPjzN1+HlTQSeRp1Qi63RrEh7EAVkCVmpW0uMr/s12r18X8xxa100kAIoq4EvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OID3vU1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CY2tDoSr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 13:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763039256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bIbIKlI1k8FR3weafnTREdprgUcvr6W/i+Ob7PTZic=;
	b=OID3vU1gvnBolcjd8b1ET7ism+zU+zQ14xQp9n9frUIl9v6WthtHb70S2uu6nLL6NWkl29
	puT9yA0kNZj5QKieoWAB0Ty689fdSuSnwKU2EYFNmVh5y5G7BMz1J64g1M7dc8g1cI2+BI
	Q1SnBUxXTchkdrtoX8GON3PHh5WcGor2Vvo4mFk36f0V6P9N0ftPdC8r4XTpF91BEsm6Q+
	Y0ueOgDx7WY7p8y8W+8CrapHnid6NYw9yQcqM6p7Di21QmwORHP8gTTZ32JVx9m81BBW0H
	JtDeGBdcvSCcI7iM0yTeW0E0fyZ/IduTxUcNXhXmadisB4xLRlmEPKxg2DbK/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763039256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bIbIKlI1k8FR3weafnTREdprgUcvr6W/i+Ob7PTZic=;
	b=CY2tDoSrymBi5qJI8U1NJI/4wWWKUf7uiA333rwaPRJI0ZC1NgeW4KFk5LrDC6tRHjqFy5
	Qzv0zgcFMa2DIVDg==
From: "tip-bot2 for Xianwei Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] arm64: dts: amlogic: Add gpio_intc node for
 Amlogic S6 SoCs
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-3-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-3-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176303925575.498.9725584638753618907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     4b6111d677c7ff87a52e83e639fadb8b09d38707
Gitweb:        https://git.kernel.org/tip/4b6111d677c7ff87a52e83e639fadb8b09d=
38707
Author:        Xianwei Zhao <xianwei.zhao@amlogic.com>
AuthorDate:    Wed, 05 Nov 2025 17:45:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Nov 2025 14:04:16 +01:00

arm64: dts: amlogic: Add gpio_intc node for Amlogic S6 SoCs

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251105-irqchip-gpio-s6-s7-s7d-v1-3-b4d1fe478=
1c1@amlogic.com
---
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dt=
s/amlogic/amlogic-s6.dtsi
index 5f602f1..f91368b 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
@@ -189,6 +189,16 @@
 					gpio-ranges =3D <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+
+			gpio_intc: interrupt-controller@4080 {
+				compatible =3D "amlogic,s6-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg =3D <0x0 0x4080 0x0 0x20>;
+				interrupt-controller;
+				#interrupt-cells =3D <2>;
+				amlogic,channel-interrupts =3D
+					<10 11 12 13 14 15 16 17 18 19 20 21>;
+			};
 		};
 	};
 };

