Return-Path: <linux-tip-commits+bounces-7330-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A5C579D9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 14:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E1426733
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE3352F81;
	Thu, 13 Nov 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ca7K1bW2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ol6seWK/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2957351FB6;
	Thu, 13 Nov 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039261; cv=none; b=o9rnKKjq3vC93oSCNZynS4WXCLG4BuuTxbpyztMMGGui9Al0SQIZiOVsxjdGx0n7negNz/KO4h6RFHGjI3qrTY+GRUn3CTHiRBSKZ+tgc1X47dUTaI0pWJELjwdVOJMTgP74/WDr4cpEeFFjdZVGBSs+ica0iLRdce8EWhYwBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039261; c=relaxed/simple;
	bh=a1gW/bsrHhH+C0lfalEhoUpozVH/CJ7DJehTFop1Q1Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NazlIWbz4Kf8HQoIE/bOwVDJDvH5zubJr6XsM5NNGOo8F2H8gZ1NpVEtIDAKGzKvG4yG7GcbUiTT4V1R4yycXy/cZj59NMzSTPBhdzCk4J4HdUwkRrAUuGTRaxggbwFi9U57fwT2ZFqqff1nke2TIrj+DvuoaR4z5PNYLN0b4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ca7K1bW2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ol6seWK/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 13:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763039258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCdFt+OB4nwuErCQO3FRUrw8nJN6sWIoQuYHJ3j2Dhc=;
	b=ca7K1bW2B0stqTGg0xuuUvxgmNTQI3+uMhGGq7gZp3Glik/O9Y71U1wKztsQQgpXSIBx3i
	H5MJIq2fjfYs1gsCx2eY66J3dGVM8L9RQom+ItTvnSayERmefgZJsqKWgADpl8yOwazxt8
	s2SD3DOb648p9zaz8SVokAOjwwoy0ptsi0Et4qE/aJG1EhzyBOSHxPKjwTOXyxv0GhvZnP
	aD8wyy0stEPtilCdC2wEFwHvRH3ABsTvSwagD9YjQoPNT3A2wYZzEQV/nHX8nxAH4qatCa
	P+R+0NMsBC6EN87pE08nyc/c+pzetErxM/cEhD0sYyeMSKPAw8RFsmqxX4Vn/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763039258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCdFt+OB4nwuErCQO3FRUrw8nJN6sWIoQuYHJ3j2Dhc=;
	b=ol6seWK/cAYSP0INcbzepaJPM58hi+MBMoApI3DC6x7XaxJjsOJvp5ofSS9eaA/0soQoC7
	DcMGmF+Ikx/hNVDA==
From: "tip-bot2 for Xianwei Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/meson-gpio: Add support for Amlogic S6 S7
 and S7D SoCs
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-2-b4d1fe4781c1@amlogic.com>
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-2-b4d1fe4781c1@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176303925686.498.4721975670456734726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     fc584d871c1641949594ccf12a48bb226636b189
Gitweb:        https://git.kernel.org/tip/fc584d871c1641949594ccf12a48bb22663=
6b189
Author:        Xianwei Zhao <xianwei.zhao@amlogic.com>
AuthorDate:    Wed, 05 Nov 2025 17:45:33 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Nov 2025 14:04:16 +01:00

irqchip/meson-gpio: Add support for Amlogic S6 S7 and S7D SoCs

The Amlogic S6/S7/S7D SoCs support GPIO interrupt lines:

    S6 IRQ Number:
    - 99:98    2 pins on bank CC
    - 97       1 pin  on bank TESTN
    - 96:81   16 pins on bank A
    - 80:65   16 pins on bank Z
    - 64:45   20 pins on bank X
    - 44:37    8 pins on bank H offs H1
    - 36:32    5 pins on bank F
    - 31:25    7 pins on bank D
    - 24:22    3 pins on bank E
    - 21:14    8 pins on bank C
    - 13:0    14 pins on bank B

    S7 IRQ Number:
    - 83:82    2 pins on bank CC
    - 81       1 pin  on bank TESTN
    - 80:68   13 pins on bank Z
    - 67:48   20 pins on bank X
    - 47:36   12 pins on bank H
    - 35:24   12 pins on bank D
    - 23:22    2 pins on bank E
    - 21:14    8 pins on bank C
    - 13:0    14 pins on bank B

    S7D IRQ Number:
    - 83:82    2 pins on bank CC
    - 81:75    7 pins on bank DV
    - 74       1 pin  on bank TESTN
    - 73:61   13 pins on bank Z
    - 60:41   20 pins on bank X
    - 40:29   12 pins on bank H
    - 28:24    5 pins on bank D
    - 23:22    2 pins on bank E
    - 21:14    8 pins on bank C
    - 13:0    14 pins on bank B

Add the required compatibles and interrupt count initializers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251105-irqchip-gpio-s6-s7-s7d-v1-2-b4d1fe478=
1c1@amlogic.com
---
 drivers/irqchip/irq-meson-gpio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 6c5e2ff..3fcbb04 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -174,6 +174,14 @@ static const struct meson_gpio_irq_params s4_params =3D {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
=20
+static const struct meson_gpio_irq_params s6_params =3D {
+	INIT_MESON_S4_COMMON_DATA(100)
+};
+
+static const struct meson_gpio_irq_params s7_params =3D {
+	INIT_MESON_S4_COMMON_DATA(84)
+};
+
 static const struct meson_gpio_irq_params c3_params =3D {
 	INIT_MESON_S4_COMMON_DATA(55)
 };
@@ -195,6 +203,9 @@ static const struct of_device_id meson_irq_gpio_matches[]=
 __maybe_unused =3D {
 	{ .compatible =3D "amlogic,a4-gpio-ao-intc", .data =3D &a4_ao_params },
 	{ .compatible =3D "amlogic,a4-gpio-intc", .data =3D &a4_params },
 	{ .compatible =3D "amlogic,a5-gpio-intc", .data =3D &a5_params },
+	{ .compatible =3D "amlogic,s6-gpio-intc", .data =3D &s6_params },
+	{ .compatible =3D "amlogic,s7-gpio-intc", .data =3D &s7_params },
+	{ .compatible =3D "amlogic,s7d-gpio-intc", .data =3D &s7_params },
 	{ .compatible =3D "amlogic,c3-gpio-intc", .data =3D &c3_params },
 	{ .compatible =3D "amlogic,t7-gpio-intc", .data =3D &t7_params },
 	{ }

