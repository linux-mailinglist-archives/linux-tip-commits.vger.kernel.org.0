Return-Path: <linux-tip-commits+bounces-7327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ACAC579C9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 14:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D54D9425176
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4A1350A2F;
	Thu, 13 Nov 2025 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O4k34S96";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U3l88cFr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB62D63EF;
	Thu, 13 Nov 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039258; cv=none; b=WBEma2ReLjST9VvVKIEs/P+Zs919XKU8qz6CVxzzjqSLFNZL7qOoBlZEyvkPWTsl7uvJL3z34j5HE9nv2HjbC8QAUjdjczhkH0t/K8OF+vVQuYdtGAde6BnZavzf6ObsGic65bPvmhaMR8l4ChP6zdaq5iwDq4XdqeX3oaDa18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039258; c=relaxed/simple;
	bh=FkEBdH8Si+BtWTCddylgdPG3tp50oFvMntW/qu64G7U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eY/vb42hM9NiCpVsydAbO4h3khh+rjPF17xTorgmzUS+euNGdUBRTKRltMiArK+RjuJP9YEJyIMnHhRT9oLzW/HEOJpCXM7xk70xFoVj1YIGuSqtFpq8Je6U9NCocuwvaAvg8oQrnqLsZnV2RT0wwwr4p1pNvckZcWW95cTXUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O4k34S96; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U3l88cFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 13:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763039255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZCgGi8kg8Vx+51T1jcvGcCWAWu4auERrN6bj0GL/lo=;
	b=O4k34S96tQLR2v2NYZn3be6StFYRJZsGppmpBrDvRq8WhBTN8uzBMkSvJvAaY4H/dnKXJY
	08uoI8FcCYOp5l8UYm6IzXXDyrUG/De9aDxDuVaJXCRRCjFGN6O+41bEVvEGjl9w7ykVZN
	+qOHHaQLg3ZOZ8cc5Apn50JHjMZGNdi6RGfOrsg8cHC8qPrNea6j4XuYNnbs+d/Il7L4Ej
	yXnnN9fKY01+NcFA7lCKd8dZ+0+CwJOe4UpRZC+z3wCzS95vfE2g9OrfOQchG+DIP6WoYM
	Ba7AcSL8y5dhmxNdpdzaerkepBhWDtkvK7UDdoL2wOKbDVsJDIP0jziAxdMLCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763039255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZCgGi8kg8Vx+51T1jcvGcCWAWu4auERrN6bj0GL/lo=;
	b=U3l88cFrFQ9lIo+hSiCorBPGcI9NJ5nTEaL6HNKH2gjbf1W7LpNPTmxOE74LU+VlLI+uJl
	IHIvb9xE3id5MWDQ==
From: "tip-bot2 for Xianwei Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] arm64: dts: amlogic: Add gpio_intc node for
 Amlogic S7D SoCs
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-5-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-5-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176303925349.498.11336435067405411827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     1d787348123b34166ad2cccf12c9c00beb4ee3ae
Gitweb:        https://git.kernel.org/tip/1d787348123b34166ad2cccf12c9c00beb4=
ee3ae
Author:        Xianwei Zhao <xianwei.zhao@amlogic.com>
AuthorDate:    Wed, 05 Nov 2025 17:45:36 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Nov 2025 14:04:17 +01:00

arm64: dts: amlogic: Add gpio_intc node for Amlogic S7D SoCs

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251105-irqchip-gpio-s6-s7-s7d-v1-5-b4d1fe478=
1c1@amlogic.com
---
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi b/arch/arm64/boot/d=
ts/amlogic/amlogic-s7d.dtsi
index c4d260d..5ef1682 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
@@ -184,6 +184,16 @@
 					gpio-ranges =3D <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+
+			gpio_intc: interrupt-controller@4080 {
+				compatible =3D "amlogic,s7d-gpio-intc",
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

