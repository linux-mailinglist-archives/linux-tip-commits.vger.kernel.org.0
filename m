Return-Path: <linux-tip-commits+bounces-7709-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A4CBFFA6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 668423097499
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2432E6AB;
	Mon, 15 Dec 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4omW6stP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1u0wXC/n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1532D452;
	Mon, 15 Dec 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834035; cv=none; b=PRGMxfdghdpkDngl6hoH4mHJCaFs00mYa+bTixP9CAJplzdGZgiOlnGPXkHXttuLMj7Mfyurfw3+zRD8dJ29goRK2SpQDj7poKeK5GMWXtsFxR5G8UXeaWLEZOWzCqSs66neTqR2R2/6998s0x6mrRICSrMIgW9O876L496poJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834035; c=relaxed/simple;
	bh=6bBIeLQ+kTXp7w8trazcVSMy4wAm1TadBb1u66FUiWE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OD6xmToQ/+Kxk6QToJBU7UGmVjEeIOwyWhWD+iJ8PvgM8k0TT56gKtKPGC28HDpX3b9n4b7uZqpWd9Ba1+35q8z6W2idybWjwDfdqzpeL4hg14P7sLcB1c1sO3/rC3Heab0mO4G/oRrbg9HdiJOZqCwV/bTdA+yWhbAmUolfrow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4omW6stP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1u0wXC/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:27:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQLWoK4KO49dZKGqdo4vlcbkgj9sytdnpLjRe/tIetI=;
	b=4omW6stPLQ+T9TNq1N//VBid+n4aEnKIsh+oUHgrPdx7l6vs7pE/Tjc5E2flM3N7zPWi1Z
	0yoTpMCbu9pJthgO0g5Q5Z2iBR8K6CkcgNmS/Urx9bWqKs4FzKqrOfn2kBKA/dfaAuiBDV
	em4NMToipV8IItyrgSqsPEydhTdPn/45Ngf1ER+kyAQV80CCptJRToXso5lzVd5F/h4x0p
	XApCsgF5TNYtZUvLLOIhs3rii+ak65kubD3E4wxdoMigwFU66B8+r11AIq1FE67MU1FwO/
	5yLh23V/VPstZ7WJAgiTCReGko9SqbjZ5D3/CuxfAXTUWk4ugoNs+oRzeM4SOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQLWoK4KO49dZKGqdo4vlcbkgj9sytdnpLjRe/tIetI=;
	b=1u0wXC/nGNUwdX18bw5S7OJwm+/TUufK2R/kXN0vOOUHjhagBOEZCiE5FCB/CxFzCl2DVQ
	4ae1r5USqB/l8UCw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] MIPS: Move IP27 timer to request_percpu_irq()
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-5-maz@kernel.org>
References: <20251210082242.360936-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583403068.510.1173893746184203789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7f92b583382a1eb4aaafed90d181464969e41656
Gitweb:        https://git.kernel.org/tip/7f92b583382a1eb4aaafed90d181464969e=
41656
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:40=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:20:50 +01:00

MIPS: Move IP27 timer to request_percpu_irq()

Teach the SGI IP27 timer about request_percpu_irq(), which ultimately will
allow for the removal of the antiquated setup_percpu_irq() API.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251210082242.360936-5-maz@kernel.org
---
 arch/mips/sgi-ip27/ip27-timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
index 444b5e0..5f4da05 100644
--- a/arch/mips/sgi-ip27/ip27-timer.c
+++ b/arch/mips/sgi-ip27/ip27-timer.c
@@ -58,13 +58,6 @@ static irqreturn_t hub_rt_counter_handler(int irq, void *d=
ev_id)
 	return IRQ_HANDLED;
 }
=20
-struct irqaction hub_rt_irqaction =3D {
-	.handler	=3D hub_rt_counter_handler,
-	.percpu_dev_id	=3D &hub_rt_clockevent,
-	.flags		=3D IRQF_PERCPU | IRQF_TIMER,
-	.name		=3D "hub-rt",
-};
-
 /*
  * This is a hack; we really need to figure these values out dynamically
  *
@@ -103,7 +96,8 @@ static void __init hub_rt_clock_event_global_init(void)
 {
 	irq_set_handler(IP27_RT_TIMER_IRQ, handle_percpu_devid_irq);
 	irq_set_percpu_devid(IP27_RT_TIMER_IRQ);
-	setup_percpu_irq(IP27_RT_TIMER_IRQ, &hub_rt_irqaction);
+	WARN_ON(request_percpu_irq(IP27_RT_TIMER_IRQ, hub_rt_counter_handler,
+				   "hub-rt", &hub_rt_clockevent));
 }
=20
 static u64 hub_rt_read(struct clocksource *cs)

