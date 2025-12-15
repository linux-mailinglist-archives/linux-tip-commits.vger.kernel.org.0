Return-Path: <linux-tip-commits+bounces-7708-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4146DCBFFB5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F3C30B0A76
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EC32D7DA;
	Mon, 15 Dec 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFOucKEQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gb7z46TS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1E32AACA;
	Mon, 15 Dec 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834034; cv=none; b=CqwgD1choeqqYpM/7ko2YCTNZxW0bnukzFHOVG8tHD29CyCIcxcvzXcuBKE1sPTEj/tf/teYDA6aCtJEdMVqhU+J96UI11u3H8hFNabIdm3R1pdY1QOTBG2KHZUxdx0rouy7sV5LPc3oKXHOEBSNPviAEq/wfHMqpU1h0gRcgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834034; c=relaxed/simple;
	bh=ZeWJD3Tcsg2hZg3wPFFNy15jIW05rDSuCidtdlI+jT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hhF5EJYj5RY0UXHEkGjwn7WwfrPqvCR8Rw5vP3xvc1EysnCzbxorYR6l/6LMEuBJwzL9zQP6yAJwJ2gx5nILBms9VrSSAdaspH0UAXw3o7aw2BASuDI2vuZmoeqnx2rnqU+TaM+Nc/LvlCxFgm74jErasLUfuFn60r+3w7nDmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFOucKEQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gb7z46TS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:27:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8mHz+pkuqCVp8SY3/Jv6cbB7tBS0L+QV8v7WpC8mrE=;
	b=iFOucKEQdkHKxRRZuDW7WL84DMq1P86sFAQrTDWGIIpwIkks6874S3gWTYclrA8+oy+Xj2
	fbJ1meYKy9XTcqUbCoC1I3xnIoz1jDNY3XYOBRlGKcKK7gC2SVLy3DBi40FLHiQlTrd4JQ
	kItH3aLXGot8Yz6VgxT0vZTcUUrwy/Hb3BsNcN0NfvCzTBMJ2MVuR2LJ7HWstwZ0WnzdCZ
	uE+wa2DmeDbTcJk6rsuu8dJxEi/Hk4vjzmmXNqWXM0YqHqYzNE+oNhR984sflIrG8JIFDW
	6Uu1va31tTZvszCpo/OisE7oFGAS9WalBaLvv+yUu0P/dX90G8GyQiWFxL9z7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8mHz+pkuqCVp8SY3/Jv6cbB7tBS0L+QV8v7WpC8mrE=;
	b=Gb7z46TSTx0my0vI2XbVQVoMkGj/vksn1DFT2e1egG0cKYAjRcRnwu9XIqcxEF9BLUHQ4g
	PmyrguWuHmOWbnBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] clocksource/drivers/mips-gic-timer: Move GIC timer to
 request_percpu_irq()
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-6-maz@kernel.org>
References: <20251210082242.360936-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583402966.510.3686299502471247608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bd04dae0791a8d44adc304d9787916fd4c539bb4
Gitweb:        https://git.kernel.org/tip/bd04dae0791a8d44adc304d9787916fd4c5=
39bb4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:41=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:20:51 +01:00

clocksource/drivers/mips-gic-timer: Move GIC timer to request_percpu_irq()

Teach the MIPS GIC timer about request_percpu_irq(), which ultimately will
allow for the removal of the antiquated setup_percpu_irq() API.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251210082242.360936-6-maz@kernel.org
---
 drivers/clocksource/mips-gic-timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-=
gic-timer.c
index abb685a..1501c7d 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -77,13 +77,6 @@ static irqreturn_t gic_compare_interrupt(int irq, void *de=
v_id)
 	return IRQ_HANDLED;
 }
=20
-static struct irqaction gic_compare_irqaction =3D {
-	.handler =3D gic_compare_interrupt,
-	.percpu_dev_id =3D &gic_clockevent_device,
-	.flags =3D IRQF_PERCPU | IRQF_TIMER,
-	.name =3D "timer",
-};
-
 static void gic_clockevent_cpu_init(unsigned int cpu,
 				    struct clock_event_device *cd)
 {
@@ -152,7 +145,8 @@ static int gic_clockevent_init(void)
 	if (!gic_frequency)
 		return -ENXIO;
=20
-	ret =3D setup_percpu_irq(gic_timer_irq, &gic_compare_irqaction);
+	ret =3D request_percpu_irq(gic_timer_irq, gic_compare_interrupt,
+				 "timer", &gic_clockevent_device);
 	if (ret < 0) {
 		pr_err("IRQ %d setup failed (%d)\n", gic_timer_irq, ret);
 		return ret;

