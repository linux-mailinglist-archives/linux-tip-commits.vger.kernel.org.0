Return-Path: <linux-tip-commits+bounces-7328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD6C57AD3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 14:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76813AF89A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF79351FA3;
	Thu, 13 Nov 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZI/cWqrO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NN2gGwAR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17533D6EF;
	Thu, 13 Nov 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039259; cv=none; b=CzCadqC9kFbjQNNYpKsdlC3fnswrAsocNPCo3BIz6rGFe9WIskLKfrv4zFXtgAneYoeg5PNbgyROQSS4GnbP3MdB68+6lG0OAAxOMrsvxPekt182Bog+X6X13UzvFTc1OtA59HdkwLOPCMbp8vPXan3jWEaT8NmvN0oNdWH22qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039259; c=relaxed/simple;
	bh=kSlLwJC26EYknpThRmZ/TNC9vJOMmIrbYnrrebqN0JI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F60Wk3GHtxdOTaa+LIGiEX/TH/lP9PIm81MoFMKAFRvs/86s33Z3zceC4cTTimWtcFuGrt7PnjP+2aH9TlvsQqMTZuzTgwylqBnxL3X6DYVXeuw23eWPR85utkirNYrudp7sXS1wOQozlZl7gaJM8hnmrvM3KUItiZ5M/7yez9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZI/cWqrO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NN2gGwAR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 13:07:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763039255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+2kIKSMc34+rz0SH0D+ATcZBLnNavVkXpWP5DO7Pfs=;
	b=ZI/cWqrOelQTq8qiB/5whI2NYK2cOUiAIgHMxL+5uZM/2XpZEGNwISXyPjJz8laQtpkA0o
	O6kTnestHAwi7KQOP7iQMUCVxppJpQ2Cor1j13st/2H9IefkVKlFj1CHBhcZk5BuI7rKtF
	AAJltR5NAWv/FfCQ2UMVx6EoqaI70TiR9HjmqSy3YVEkMMWz48H8KsZNi5Kr7lN0q+nxZC
	KbXvk02rxabPUcbYoWGYtZyeghK6EDEjIypluo2zkJhfWpeSlgIjBNtnxPJgiNH77HdaeK
	UCdWbJjDK/UtnxHKo0M+4HlXiP+hOw5tayC9PkirkNZuRVN0no6GeY5W0VFQjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763039255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+2kIKSMc34+rz0SH0D+ATcZBLnNavVkXpWP5DO7Pfs=;
	b=NN2gGwARcPlBnU31hGcv3H/ho9g1ms6qohks8lz+Do7055YNPyl2FXLb4gSzFJFwFbc2RB
	7Y31Cc0N+QFFk4Dg==
From: "tip-bot2 for Xianwei Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] arm64: dts: amlogic: Add gpio_intc node for
 Amlogic S7 SoCs
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-4-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-4-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176303925473.498.11480550729573969209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c864e6872127a3eb3acfe59c84c8cb619436dd9f
Gitweb:        https://git.kernel.org/tip/c864e6872127a3eb3acfe59c84c8cb61943=
6dd9f
Author:        Xianwei Zhao <xianwei.zhao@amlogic.com>
AuthorDate:    Wed, 05 Nov 2025 17:45:35 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Nov 2025 14:04:17 +01:00

arm64: dts: amlogic: Add gpio_intc node for Amlogic S7 SoCs

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251105-irqchip-gpio-s6-s7-s7d-v1-4-b4d1fe478=
1c1@amlogic.com
---
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dt=
s/amlogic/amlogic-s7.dtsi
index d262c0b..2cb0090 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
@@ -211,6 +211,16 @@
 					gpio-ranges =3D <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+
+			gpio_intc: interrupt-controller@4080 {
+				compatible =3D "amlogic,s7-gpio-intc",
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

