Return-Path: <linux-tip-commits+bounces-8168-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJR0N56Kf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8168-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:17:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43208C6B06
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA491304227F
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B7226CF6;
	Sun,  1 Feb 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IEOrNzL0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/dkyQugE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62827E074;
	Sun,  1 Feb 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966027; cv=none; b=X+xVzwPit4tnlleE6Zj/eC0il0Wb6fkCzSGTlZ9lyCU8i6Jt/5aCzXpcL8XHBWMt4X7BuQpTpJgJvrJS123A5kTq0yukAAqreR90WowhmuaSz84Q91YZnasv0MgW2EKRS8Hs3SZQ+WbB6FMUOhjw1vwzHcwfYafxWmlcjJEd/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966027; c=relaxed/simple;
	bh=68iIDkke98AieQkGRPxD8NMULy5zh7yhiD65Xnsi0jA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JSNHoYzBZnz5blAn9wCopn5OHeKdSwhAvE5+wPzksEeXiHMJKnXPoNUv1kKE/ajkjeKTDuAE03gd4Q1jGXfF6nefylzcAqQYoD17C6ii+wDxHyhyw2QmX02xtb1jwiw5MXOAREoSdUD+L3ByToQXEQ6Dg2uh22aN0qRKPh56Y1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IEOrNzL0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/dkyQugE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+CWnUcf99DCjcW8Dqbss/jKzMFK/g7TxWTTBe3V48Q=;
	b=IEOrNzL0laFxgvc2BQfeaHJdC+fUe0ZPkF2+OgUaDgYDAysj+UAp+iMNWxhQ+xIZabat4c
	mnl/hPIR4s6FQYEHhf0D8lQo1/RxpIdtjefv7L1G+jHR58a1NcZp5yJerY2A2vurkxbhbH
	7dM2Fwa6uLjHbgSbmUBZ8QDdpOCrejy0Vf3UflxLRLwjA8dKH/+mmKW6E8hlQq+7KGK1So
	NqBDJc0RQ/wFC5wAEXbDvybyu38Xpk+jlqN3mZlaAWLDKRmDbtZ9bAAO6KVxkq5N66g/5F
	/c8jyJCvMyrqsDYDD8tFehb39zWoEgNMh1l5tJ+wmUrgGkrKU49GO/1pa4oBww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+CWnUcf99DCjcW8Dqbss/jKzMFK/g7TxWTTBe3V48Q=;
	b=/dkyQugE+xUrRlkKES9umz/JBIpYa2mILMSGebpj2RENm25eRszB49cvg4l224uWxKmeZ3
	gDrnoYorQ/xS3DAQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] thermal/qcom/lmh: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-14-bigeasy@linutronix.de>
References: <20260128095540.863589-14-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996602051.2495410.18164219485843702566.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8168-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email,linutronix.de:dkim];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 43208C6B06
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     781b391557a74f6630d46a0813b389a8ca30b6c8
Gitweb:        https://git.kernel.org/tip/781b391557a74f6630d46a0813b389a8ca3=
0b6c8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:33 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:16 +01:00

thermal/qcom/lmh: Replace IRQF_ONESHOT with IRQF_NO_THREAD

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

The intention here was probably to not allow forced-threading.

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-14-bigeasy@linutronix.de
---
 drivers/thermal/qcom/lmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index ddadcfa..3d072b7 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -220,7 +220,7 @@ static int lmh_probe(struct platform_device *pdev)
 	/* Disable the irq and let cpufreq enable it when ready to handle the inter=
rupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
 	ret =3D devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
+			       IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			       "lmh-irq", lmh_data);
 	if (ret) {
 		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);

