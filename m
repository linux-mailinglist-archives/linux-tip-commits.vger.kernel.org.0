Return-Path: <linux-tip-commits+bounces-6942-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD17BE454C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5E63359A87
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D53570D1;
	Thu, 16 Oct 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JLW0fXS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJc56Qzj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13BB34F461;
	Thu, 16 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629603; cv=none; b=rR7nwYkJ8ZUSvxFf1lEqNk5E5uQ7Yw9Q8fYu1VJmHJXQGRXh/b1BthTao2oTIxchUK6Jj58jWgvdDFw7mwf8EGiwKZiQODQSJvp3DMrlycuDzFfknHOWL6ztUM3/GO4tNLm4YFb7EYaNW2lEMgtOURdFsvQhv6+eDq4/8RtI0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629603; c=relaxed/simple;
	bh=KDMghBObFSwx3SoRtVw8gr5M8p0b7nF6Vlor2HtLO+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=miK3h1wYN9rBNkX4oQaeci5pnonfMzp9pDZvVIC5GNaen9N2ribu8xJ74UBYndzFGLZWdlZSWdZFcMqIymLEsA0fHSLvbUnft5VkzfULWyyTnUoEvTiEQvioEUvMU2GrsIs54HAjev2r2zoDGa6yR5e2GGYHzHHpXJPVFK7Fhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JLW0fXS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJc56Qzj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 15:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760629600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsXLeYdOwW7xVmM+F0zp9ZUIgR3vkXAwpzjD2wdqskI=;
	b=1JLW0fXS87ct/hUzB9lR2dvlvCcLkU7BC0gWCqtL6rpsulRT/y3rsn0CqouwuP5yxs8STS
	l3H4AJrK+zsKFozNPUN156af5DMmAAX7yS3avoy88N8lvhEvjXPVvV5P6x0W3I14q6FEhz
	vzlYLi7tH81C9NlsN4SFjZ9rnXQm6O8Gh1IInUcpy0bDrTrtGBgSn4BL3NawvmUw/FE7Ay
	vn4B3Uba28xwzI2rfTEqP+meT5S35vsk2PCYaNkGYPsWoel18VMeM5hh98KQwoazgjdxej
	jlvWQlhxXVVSKxEdgo40O4TkspFJT3BxU7G+obWR8k4DggVomRlDgWkHHXxKAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760629600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsXLeYdOwW7xVmM+F0zp9ZUIgR3vkXAwpzjD2wdqskI=;
	b=RJc56Qzj2ZrgSpdkfh/PywcTRIzG+aNhTNnKwBR7dC+1SzI6cTe/Q3MoHRxsJZArufstHr
	+HEqG2q9WyShuTDg==
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
Message-ID: <176062959896.709179.127728558938514987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f0954a66c9742e0801063f390995d2ea537ef085
Gitweb:        https://git.kernel.org/tip/f0954a66c9742e0801063f390995d2ea537=
ef085
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 17:26:34 +02:00

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

