Return-Path: <linux-tip-commits+bounces-6849-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C3BE2828
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1512D19A6B62
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F331BCAB;
	Thu, 16 Oct 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VCwtzq3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KC0um+Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7A31A554;
	Thu, 16 Oct 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608307; cv=none; b=Mc7NZa+1KLXFIkTfEQdAB05aR6Vuwibjv9KO6EckJ/JRCdLbKr4Vk9zoG0RwtAMexNSHct0gZO4OQHByJpMt83xSTF8koquGt8hrMJGL4QYYRLOMSquDgNjIdmvvpexfEYpebAwVby0pOVCGpAlkU22VKe1eUkxRy2LuYgWmYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608307; c=relaxed/simple;
	bh=rV5nuOO8aNStbE5e+veBOOufM0LDmjLsHtJd8HJtOiY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z+91xXi3mrJN6jwqIKic8pOLnbCUJwmAX+d9XmL59xK4d2h50iG5Qby5I5i5SbKn8ohTOzYuy9pj80pGHmfoquFtjBfvGifMDf92geiFdc/AprL1ss2f9sIstwsKUy1+pKzgJ7mZFDKEj3X91DTt9hWSSb3Um2NQNAG1n/TGycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VCwtzq3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KC0um+Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MWm9RtBbNAgdzilDBTaBszYqTfJ3SmDMH4fozszT1A=;
	b=2VCwtzq3wGh5KcEHKInTrL8CX/FNynihX9ZlZF+mm+pPsr3b5dQPVhoE8+orleYErmqToI
	8ev4ezhhZV9tyLTkl6ghSnpS/DTBy2Q9lju2jkTOo3IZEcNqUG0f7C8JYNIqfsd1uxwe1U
	Jd0svbZ0MeND0vd5QLdD64YupXScLA6Z9D1plHajcPFWRQRbHyUh0eGoygm7fPaqGmPtSP
	i9b6afzTHoZSBA+sB5DRQC+epg2tygE4cmsJje0NSvXWgvLjdHAiWUSplsGQu9oTRp9ca1
	bOBIMJ37Br+Zl7Szd7Q5ZKlqpAjbfNrcIRDo6N/0/0/Uju8b6iAptIAVfoUzRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MWm9RtBbNAgdzilDBTaBszYqTfJ3SmDMH4fozszT1A=;
	b=5KC0um+YHVJYeYtBBPsUiW3ai1ABGHdxAZ/uwRVxKjJSXy+fjZFGs/esurYhFHANzBh73O
	lKw49IaPgasiRZDQ==
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
Message-ID: <176060828929.709179.5092452558434451270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     4ef1e024f757c2cbd22d295209ed73180d84f5da
Gitweb:        https://git.kernel.org/tip/4ef1e024f757c2cbd22d295209ed73180d8=
4f5da
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:34:24 +02:00

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

