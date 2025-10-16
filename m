Return-Path: <linux-tip-commits+bounces-6952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34EBE5283
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843B31AA03B3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236C24A066;
	Thu, 16 Oct 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s19BsiwP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xvxstcwk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90D246BA7;
	Thu, 16 Oct 2025 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641292; cv=none; b=UsLM0I6m9w3qZMaHjy9yk7pOBMwqLRE3/kdy8rsJZSP0/HU56plyidpYtDXv2LAgSyYvOGpqSesktxHqWaM1Z/I85yaIVUUj7ufT2zNsqbY/+rbWgJLgsuqAv41fpcA7SAqOOSyP84yMWoEb4d3t58jPhaFFxQSzUvMRDCw6G9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641292; c=relaxed/simple;
	bh=REMEO7QydAZV/t+lkQckHgjUZuKTOMawJjc40Eu/KbU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XToxlbgXM4a/GszyAw2Ml/OH95LH3EBtu+/jlR8/FC1QTQ06PeMkmDUHVLP3uUzOq6YMaXSaz5KJasJLaPbS2GWBKRu+TssfFP/q+hL6iZSKjJL4CCErCg23e/YMS5A2V4WXXxVD5KHLsvrSXUG4mYhbGiuijuxKpf3Ll+GQBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s19BsiwP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xvxstcwk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVrhsFUz+Riss7uCYQ/VrM1mRMbJQYJFlGLOjfV8rKA=;
	b=s19BsiwPUxOzCt1gYJb6Q3uxWAGLkbW/MOWZMSUA7HY1gwkSlJ4Tx7edm/+X3S1wW8wfdW
	87euvptZtzpHPBaM05Yowj/6p5f1tVuHhIydYfxBxjMLPx/7zKk3LPcbjn8hleN2hWj8xY
	2AXL/DuOu16c95sNtW7oN4NDdy0XNN6h7HdCGS0JHot+teVtCfQCHHtUuDKy1pbcjbw2L0
	vS8p0Ly066KPsRGGOzboKeTy0WrTK5l94E9y5fjMuebU6B/C5VT55S/XjaNR5fMJdr6PB6
	PIiRi1gw3rwEfx+OoztrKLPbs+0dNy5W4V3PlLWewWe3/YvrI2geswcNyNjy2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641289;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVrhsFUz+Riss7uCYQ/VrM1mRMbJQYJFlGLOjfV8rKA=;
	b=XvxstcwkGfnVE/5cl2wrxfLUhw4J6i6RAQh41VxZvotEsm+9eTGGG6X+C5MG18UKhkXDn5
	g0893Nu3j+FXoBAw==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/meson-gpio: Drop unused module alias
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013095428.12369-2-johan@kernel.org>
References: <20251013095428.12369-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176064128778.709179.14203477009965000417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     867c6aa283fbc1e9eded7d4f2cd7b3f9f4cb5e9e
Gitweb:        https://git.kernel.org/tip/867c6aa283fbc1e9eded7d4f2cd7b3f9f4c=
b5e9e
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:27 +02:00

irqchip/meson-gpio: Drop unused module alias

The driver has never supported anything but OF probing so drop the
unused platform alias that was erroneously added by commit a947aa00edd4
("irqchip/meson-gpio: Make it possible to build as a module").

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-meson-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 09ebf1d..6c5e2ff 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -637,4 +637,3 @@ IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_DESCRIPTION("Meson GPIO Interrupt Multiplexer driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:meson-gpio-intc");

