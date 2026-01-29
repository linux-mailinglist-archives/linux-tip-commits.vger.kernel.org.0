Return-Path: <linux-tip-commits+bounces-8138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJwfHfLSe2nrIgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:36:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC0B4DBE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0FD4300B11C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B3635CB91;
	Thu, 29 Jan 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PWnzoz6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lki4NBVl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAC3590DF;
	Thu, 29 Jan 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722330; cv=none; b=qNNm9mxox0EYjHIq+qrFUdV1KuzqfPDxdiNhJCjDAGHKKe3Eujr2Hgg8mjrPimWgsQaDasrAMMyBOOogFBerH3vALkq0aUtQnPkM+OBQtOG4Rmn+OxFreWLXIwEEiNMBDw3q07DCaptIzC4yG23w+uw0vGG70hPXc4NWL3IDHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722330; c=relaxed/simple;
	bh=usRxsmYYkjR2zU88UzbgMoOyoJa+iATJI8k2Y25wfm0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LZZGRktjYDXmj8CW16DsKTEK+zNo+ldy2OLdBBHAvLgxo4qcLe0PYE3NKp/WwxZ8q4QNoK4Ft/+Bc5H0VnKmYHZugq7qgSqnjU0f137QvljkSpdfIoRx810d5Cy1tLUvlP6Zcrlc27E4WiImOKa4sISJyyvtdZhp6M0OmA8wUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PWnzoz6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lki4NBVl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 21:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769722328;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMOpjiti5JA8GnWgI7ZiZ5M6EJbxP2xtqudsnoFbukw=;
	b=0PWnzoz6OzP5mGfqXPEk6zdH0spoZtZprEO34rztdHQECPjNoWvpu4yRS3gCGtnAdIVsi1
	mhRn+cTRWk65iqaJKXNwwMQO/VqPJ3GaIBI4oDnB3p4WtTAWRsSaSnkLbfrzLqB/zkgIyW
	Sf05yZcAU2HX4TEhZzYUzFnvQmdafNpuCHB/bhPSaIn3MSXzef0qCKXLKjkxe+h/0O8mPV
	CUXam1RUaKTIpJ7/zm+cY2IZhsFy289m0YpJj3uRa4qVLaniEmdZcnnRscrcLPCHN0PTh+
	oSW8QY5xKn5Jq7SjMlSc7TCSkz4GxeI9h83R9niDGst4bCh5OcsRD06pp7BXcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769722328;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMOpjiti5JA8GnWgI7ZiZ5M6EJbxP2xtqudsnoFbukw=;
	b=Lki4NBVlf7HStyNLnvJrgLVINWa+96MBMbPwEuOyAUB4ShgYP51E9vLHwkkRM6XIcQuyul
	YRYZUpHgfjjO98Cw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/mips-gic-timer: Move
 GIC timer to request_percpu_irq()
Cc: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-6-maz@kernel.org>
References: <20251210082242.360936-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972232659.2495410.7501794785803810414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8138-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,vger.kernel.org:replyto,linaro.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: CBFC0B4DBE
X-Rspamd-Action: no action

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     a83f9c04be4e807d1c3961eec3fe3310c60ed9aa
Gitweb:        https://git.kernel.org/tip/a83f9c04be4e807d1c3961eec3fe3310c60=
ed9aa
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:41=20
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Jan 2026 18:07:24 +01:00

clocksource/drivers/mips-gic-timer: Move GIC timer to request_percpu_irq()

Teach the MIPS GIC timer about request_percpu_irq(), which ultimately
will allow for the removal of the antiquated setup_percpu_irq() API.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

