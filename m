Return-Path: <linux-tip-commits+bounces-7892-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF27D176F8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 09:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D74A30057F5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64836AB58;
	Tue, 13 Jan 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZMDtsOIi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BgrBjCIh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F71F3B87;
	Tue, 13 Jan 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294758; cv=none; b=IivkNYLihVpU46cPYO+dV+5tbewKzY9wPARnEfY+/MPE/6YmtNBXX/q77+vIt0UpaSqi8KVRbPlPbn3fi2qJXeXWPBPONY5bnErM47lbk8OhjQebbXoDUkI2Ts3o06X48t86U+Q2D/7KFr8i4piej5LOQUUU+2+uCV8pogjSsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294758; c=relaxed/simple;
	bh=xXL6wyXe17X9wxmdjc+rzG904HP8/z+c9fhwkpEjO/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e0p2v30IeZ7egS4Cmekd3mP9yN6hAEi3ADH0jCfBS1jlCuKTdFsDsFYGFBPOzu0d2xp6Fl8Q+5tHWxvyrPuNEW3ZV00CXm2gGaX5G/3Atkx/XXFkwVDwv+keANce6Li1KHKksCJMofGADoX/j7QDBleB0enu/G/MVK390p2KcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZMDtsOIi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BgrBjCIh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 08:58:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768294755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrC0TXdbNR2xy8mixkjZDzJX+tuuWfJUtHAbt86rr0c=;
	b=ZMDtsOIi/mFv7hrh5pRh9J9rnrLwhxfSKtTBXPnEgAl9bBl/WHorpqbPwZIfELKGzq6i81
	VrNI3hPiPwqHAL0Fz988XJxEV3GvykJVBaKn4SHLL2+Y/Z328XMGMXwfRNa6argZTXfyjk
	j5b0Kl21P2hHd5VQO3APoZONmz8WLEqRTu4+1yO+KxCqCBaviOz/tJavbAzzyGnIVXZsdP
	++NO7oILz0PkxOsW6JzMUFAr0sAhQYF8cfJ7rTo+UAZnEBYR1BwoOVTf5Gn0zedxwEVa5B
	wBegIVT+RDPG3S4o8def2f3ykWsO+yheDKTUcam1SkmVEco2EuIG3BE8LjJltg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768294755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DrC0TXdbNR2xy8mixkjZDzJX+tuuWfJUtHAbt86rr0c=;
	b=BgrBjCIhXw9PnOupSIBzEgHTdSMBQ9KBGagpOufEG2Ur7VIW22C//Dv3a6RfObWHGIKDx+
	K7gwQHsQV9bFBqCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260112134013.eQWyReHR@linutronix.de>
References: <20260112134013.eQWyReHR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829473742.510.5940174319056100768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     aef30c8d569c0f31715447525640044c74feb26f
Gitweb:        https://git.kernel.org/tip/aef30c8d569c0f31715447525640044c74f=
eb26f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Jan 2026 14:40:13 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 09:56:25 +01:00

genirq: Warn about using IRQF_ONESHOT without a threaded handler

IRQF_ONESHOT disables the interrupt source until after the threaded
handler completed its work. This is needed to allow the threaded handler
to run - otherwise the CPU will get back to the interrupt handler
because the interrupt source remains active and the threaded handler
will not able to do its work.

Specifying IRQF_ONESHOT without a threaded handler does not make sense.
It could be a leftover if the handler _was_ threaded and changed back to
primary and the flag was not removed. This can be problematic in the
`threadirqs' case because the handler is exempt from forced-threading.
This in turn can become a problem on a PREEMPT_RT system if the handler
attempts to acquire sleeping locks.

Warn about missing threaded handlers with the IRQF_ONESHOT flag.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260112134013.eQWyReHR@linutronix.de
---
 kernel/irq/manage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index bc2d36b..dde1aa6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1474,6 +1474,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, s=
truct irqaction *new)
 		new->flags |=3D irqd_get_trigger_type(&desc->irq_data);
=20
 	/*
+	 * IRQF_ONESHOT means the interrupt source in the IRQ chip will be
+	 * masked until the threaded handled is done. If there is no thread
+	 * handler then it makes no sense to have IRQF_ONESHOT.
+	 */
+	WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn);
+
+	/*
 	 * Check whether the interrupt nests into another interrupt
 	 * thread.
 	 */

