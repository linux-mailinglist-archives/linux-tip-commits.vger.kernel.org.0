Return-Path: <linux-tip-commits+bounces-8174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJR8MRGLf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8174-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:19:13 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B2C6B4A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE79C300EAB9
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47267289824;
	Sun,  1 Feb 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w6ku4Yta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6XQvcVO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E2274B5C;
	Sun,  1 Feb 2026 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966036; cv=none; b=m/oQo8vE2r63TA9V4k9QXpMXNWAHVoirqE8tp+h9durI0pfxnPRArFxGe7QsMco2DM1X8OfwgtLl9FPcv3aUHgWCUNd8K2ycWNka32QOAmqE4faNyoLo1rN76RH+R1q2yunH3nkgfQHuzFZ0nKWtrII5PZR3j8KT705VSHwEwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966036; c=relaxed/simple;
	bh=dwa/Qh8lX26q+H5aazbza9STxlV0uctbCs3J3UHY/xM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P/jUCzApr48LHW2X0kJzvn4R2L/h7/M0qJTw8SjAOdhpZFJ44Xv0jgsVJVrfJxGwVSKKBsocNy8u/+KzHqZBvV2ASzPnHu42RD6KYuUDfbUmi1K+mKCb+nAy8SCTnHT6wflytb7H88RueyEsrAEN16pCQruqPC0qS1kmLr7ka5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w6ku4Yta; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6XQvcVO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEvGfVgvfC1qyn3Y8M0tSU1gsKR9ee6pOxKAQtlSez0=;
	b=w6ku4YtaCnUT3BkY453vWXL/G4NUMuZrCcYx7AYku6Jr6JtashODqe9AOmOs/7P5wMSBeH
	wYPDu3Ht9Yjvv4n+GaZifLkix4hwXEsdv2LAENJMYMr7B5e6JP/t/UNcGjlHBEmX5zvzOC
	Hpd74G+nVfEHU7Gx0wkv6ZFq081k9N3SivkPMUmSYM8Qywc1SHJ3JZPqV0SHDZmA4mLsGN
	YhjjAfx9dIdXNeE3t5iEBfsB6jE6lRRMmbkuipQDefu2KGxWjnq+ZQweVXWa1ZcUCIhrOf
	6YQXeen6ALTGSKRr7zk+BjEvwin65Ka11TBGI6NUykhPe29KaM+awoB45g+Whw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEvGfVgvfC1qyn3Y8M0tSU1gsKR9ee6pOxKAQtlSez0=;
	b=F6XQvcVOztdBBTRnz6TbR0/czWsMsAa7P+q0T9ruC1uA2YpQLYnHkrG+KHpWX+RI9dKzlu
	z7hHngKYijtMuoCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] mailbox: bcm-ferxrm-mailbox: Use default primary handler
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-5-bigeasy@linutronix.de>
References: <20260128095540.863589-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996603043.2495410.10036859762955774694.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8174-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:email,linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 434B2C6B4A
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     03843d95a4a4e0ba22ad4fcda65ccf21822b104c
Gitweb:        https://git.kernel.org/tip/03843d95a4a4e0ba22ad4fcda65ccf21822=
b104c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:24 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:14 +01:00

mailbox: bcm-ferxrm-mailbox: Use default primary handler

request_threaded_irq() is invoked with a primary and a secondary handler
and no flags are passed. The primary handler is the same as
irq_default_primary_handler() so there is no need to have an identical
copy.

The lack of the IRQF_ONESHOT flag can be dangerous because the interrupt
source is not masked while the threaded handler is active. This means,
especially on LEVEL typed interrupt lines, the interrupt can fire again
before the threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary handler
is done.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-5-bigeasy@linutronix.de
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexr=
m-mailbox.c
index 41f79e5..4255fef 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1173,14 +1173,6 @@ static int flexrm_debugfs_stats_show(struct seq_file *=
file, void *offset)
=20
 /* =3D=3D=3D=3D=3D=3D FlexRM interrupt handler =3D=3D=3D=3D=3D */
=20
-static irqreturn_t flexrm_irq_event(int irq, void *dev_id)
-{
-	/* We only have MSI for completions so just wakeup IRQ thread */
-	/* Ring related errors will be informed via completion descriptors */
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t flexrm_irq_thread(int irq, void *dev_id)
 {
 	flexrm_process_completions(dev_id);
@@ -1271,10 +1263,8 @@ static int flexrm_startup(struct mbox_chan *chan)
 		ret =3D -ENODEV;
 		goto fail_free_cmpl_memory;
 	}
-	ret =3D request_threaded_irq(ring->irq,
-				   flexrm_irq_event,
-				   flexrm_irq_thread,
-				   0, dev_name(ring->mbox->dev), ring);
+	ret =3D request_threaded_irq(ring->irq, NULL, flexrm_irq_thread,
+				   IRQF_ONESHOT, dev_name(ring->mbox->dev), ring);
 	if (ret) {
 		dev_err(ring->mbox->dev,
 			"failed to request ring%d IRQ\n", ring->num);

