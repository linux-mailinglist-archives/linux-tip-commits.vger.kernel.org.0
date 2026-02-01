Return-Path: <linux-tip-commits+bounces-8179-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DA3JUGKf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8179-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B18C6ACD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA99E300DD78
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9FC27F749;
	Sun,  1 Feb 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RiEfI4ac";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A8wIvkmt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0428688D;
	Sun,  1 Feb 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966043; cv=none; b=EhFJEzEzna63EQ8WBb8ZrPDkNudQeEJOVoqFXdTFQkIQ6x2JHBkrkbAiI90UkYL9vH83DCB+OHd7bPxDWu/Mu9ow1RhPiyOM1NLU+b2uJz7ys4sanuIBaXp+GYdhYZ0eGRqcB0Lr6ZkdR0Sv9RFBaBZ7sGLnV3VEFyieKMDP2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966043; c=relaxed/simple;
	bh=J1waG+0qLbRNAu1D9idabhax+PeJpJ0aqyKMm2OY9bM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SWbgbp9AQR47S1nlQRn2ZEBPAah3t5a11TW6VdzuRq7+MHzD1qrtbc0T3cz/HzHXqJvqsXCplr6RMvPlJNESRV1RpRAplGd9ToNkN5/7zi8ySvh3QEOyRaHPdHotxEhxYzoV0JZe9WWy9YC24CWaM7yNZdMzCpeFzYqLoO9j7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RiEfI4ac; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A8wIvkmt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7dLNl9bHpCOcr6wqvmZphi8zXoLsPqnE/QfBQWrsC0=;
	b=RiEfI4acrgFA9blCmV+Vd9/5N40P56JBMtMZgez+KJqteV4ls1grmcZTd0v3O6EXGR/hQo
	mb8J3rrQz4u+HQVJBvUwrTOPg5+xeep4mfY9QJqLeWEo9k6TktL5XYEQqom/TKn+spYeaY
	LjL+fJMBnP/1UpTr2/8wVCxfIu9OmIpCGCtnsMYW4KUCQrhvlmOjMeCt4kAxsz5eJmIB54
	CvGIXMAIRMgzTk4eElMSkLP7/aXh0SIGuO19hpKPtX+uGiR6G3vl1oUg6o6/VMxNPkkTcT
	ZDoCgvvFOmasdPvzq6ogUVtuNLGf1tUN/UzJA/8v5fePeCGhGD6Thl9t+uzSig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7dLNl9bHpCOcr6wqvmZphi8zXoLsPqnE/QfBQWrsC0=;
	b=A8wIvkmtOQwl2XWNzg2ifqu6gsAhBVFyvdnhqTy9lXuv1tENULrBaSPrdZMP5yaykQtz8W
	YTQNNZKzC9hoLZCA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] platform/x86: int0002: Remove IRQF_ONESHOT from
 request_irq()
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>,
 ilpo.jarvinen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-3-bigeasy@linutronix.de>
References: <20260128095540.863589-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996603257.2495410.6898984647181446363.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8179-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url,qualcomm.com:email]
X-Rspamd-Queue-Id: 44B18C6ACD
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     f6bc712877f24dc89bdfd7bdbf1a32f3b9960b34
Gitweb:        https://git.kernel.org/tip/f6bc712877f24dc89bdfd7bdbf1a32f3b99=
60b34
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:22 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:13 +01:00

platform/x86: int0002: Remove IRQF_ONESHOT from request_irq()

Passing IRQF_ONESHOT ensures that the interrupt source is masked until the
secondary (threaded) handler is done. If only a primary handler is used
then the flag makes no sense because the interrupt cannot fire (again)
while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

The flag was added to match the flag on the shared handler which uses a
threaded handler and therefore IRQF_ONESHOT. This is no longer needed
because devm_request_irq() now passes IRQF_COND_ONESHOT for this case.

Revert adding IRQF_ONESHOT to irqflags.

Fixes: 8f812373d1958 ("platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHOT =
to request_irq()")
Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260128095540.863589-3-bigeasy@linutronix.de
Closes: https://lore.kernel.org/all/555f1c56-0f74-41bf-8bd2-6217e0aab0c6@inte=
l.com
---
 drivers/platform/x86/intel/int0002_vgpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x8=
6/intel/int0002_vgpio.c
index 6f5629d..562e880 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -206,8 +206,8 @@ static int int0002_probe(struct platform_device *pdev)
 	 * FIXME: augment this if we managed to pull handling of shared
 	 * IRQs into gpiolib.
 	 */
-	ret =3D devm_request_irq(dev, irq, int0002_irq,
-			       IRQF_ONESHOT | IRQF_SHARED, "INT0002", chip);
+	ret =3D devm_request_irq(dev, irq, int0002_irq, IRQF_SHARED, "INT0002",
+			       chip);
 	if (ret) {
 		dev_err(dev, "Error requesting IRQ %d: %d\n", irq, ret);
 		return ret;

