Return-Path: <linux-tip-commits+bounces-8175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBiJNF+Kf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8175-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:16:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6DC6AE9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44E21300F1E9
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9107296BA4;
	Sun,  1 Feb 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fn6zVjKI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTpJOauo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86F226CF6;
	Sun,  1 Feb 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966037; cv=none; b=SKcLkkhKVW+K+9yeDDmZGR7ijBAPVrihTPK/XvaAmCAnpn2U/1GYMOAMf2XUFw+Q/vjmEAPM7Qf1AvEjcigC15QjGrjK0fOWArTehp1/Ht208BPFW8sLsqhX/JYvsXKY3CG8jfh6pWQfCcDJiKtsv9o+JdAgDMNIEFP46x3iQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966037; c=relaxed/simple;
	bh=4VVR/3NCJqXF+dOLbqfdH7bWfcjgg1033tAqVhoFriQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gl4nADC63IyDcS1+iqp0Hh21y9jW2jWbZv9VdWRDkZhJ3gghwcywlvjV6QWTa6/BL18pn3SDwNMixo8DEdXYkpXuiIy4eXim+OjqvMc2ETcexn1ULIZy49ZYJzHFCrXuVdnR3SrOLj7hNpUWtnT3k0vKYZ6igXTeHWj9eacOGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fn6zVjKI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTpJOauo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t2A89LVxkEeYN4p1FAGOK4SqfBLb73E0WD4SIXpj4k=;
	b=Fn6zVjKIE44PqEJXhYe2prSPOvXbwKLG+gKwwRZ+lArIXlG93scFl55/2ZHT36G8pCCVHn
	y4Q0ZLOOW790cS0iOq0bTisHqTpEws7jSO7iBIAQusY3duzZd3JkzBYvJNj5WMkOUUjrSr
	vNv4Z9gE9hTIrb7MWYrOsErUt+sPbafBAB8D8tWBtwnCZuBxPVjHK28NU/vYnz7Zrs2MhX
	EM9J6yaN89UgxWrC3RtbaUJaXvnIDn43cKtz/vFCgFjgjUDGDbwAHLp0swzi/4myZh//qv
	cwa13c+sDyXzHSGW0yiaEYpaBF73plBpjoZ5xzlbwSfeRXgZa5dNOHwnLXM7Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t2A89LVxkEeYN4p1FAGOK4SqfBLb73E0WD4SIXpj4k=;
	b=aTpJOauoFBbLC7MzKt2qhK6nj0njrKBQQhhw4R8ax02NEQaaX0brtiOLpTjCajifdmkmri
	0xARHQ1LbSbq3NBA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] bus: fsl-mc: Use default primary handler
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-6-bigeasy@linutronix.de>
References: <20260128095540.863589-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996602933.2495410.8739189321451615740.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8175-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,linutronix.de:email,linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 0FC6DC6AE9
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     29d4ff55fe9866be7afa3669ff54da0e4bfd5fb8
Gitweb:        https://git.kernel.org/tip/29d4ff55fe9866be7afa3669ff54da0e4bf=
d5fb8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:25 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:14 +01:00

bus: fsl-mc: Use default primary handler

There is no added value in dprc_irq0_handler() compared to
irq_default_primary_handler().

Use the default primary interrupt handler by specifying NULL.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://patch.msgid.link/20260128095540.863589-6-bigeasy@linutronix.de
---
 drivers/bus/fsl-mc/dprc-driver.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-drive=
r.c
index c63a7e6..db67442 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -381,17 +381,6 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
 EXPORT_SYMBOL_GPL(dprc_scan_container);
=20
 /**
- * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
- *
- * @irq_num: IRQ number of the interrupt being handled
- * @arg: Pointer to device structure
- */
-static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
-{
-	return IRQ_WAKE_THREAD;
-}
-
-/**
  * dprc_irq0_handler_thread - Handler thread function for DPRC interrupt 0
  *
  * @irq_num: IRQ number of the interrupt being handled
@@ -527,7 +516,7 @@ static int register_dprc_irq_handler(struct fsl_mc_device=
 *mc_dev)
 	 */
 	error =3D devm_request_threaded_irq(&mc_dev->dev,
 					  irq->virq,
-					  dprc_irq0_handler,
+					  NULL,
 					  dprc_irq0_handler_thread,
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					  dev_name(&mc_dev->dev),

