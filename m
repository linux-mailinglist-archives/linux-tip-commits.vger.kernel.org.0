Return-Path: <linux-tip-commits+bounces-8240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLtELLRRnWkoOgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:22:28 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3613D182F11
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F0793096DB8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2736606E;
	Tue, 24 Feb 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXJP/64C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PtrHpO5V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894E3659E7;
	Tue, 24 Feb 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917636; cv=none; b=QSnhP7ykYHb/ACZO+CQ7PZSsU6nUGxWOdgOTyhvSQ1K8KdPcQT6A3kYZ4REUnY3Oe80tLYo4IRPGkTV2LJGp6mioJV6JbJzkTCet/llCxOIhEoFf2ukHsSxV7JxhX2Mzv1o27p4MYWP1kUYrAILrml0D5pZpiQPC8COIYfiahtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917636; c=relaxed/simple;
	bh=MB5yud4Q5fRaS11CxRQQaYRuYyb97nWWAUTfBdqaBN8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aFkn9mdlRWU2dg1x4Pbgmj76DFPS/AwIIk5WNnNIcKsxdZThJ7cIzn/FU/PDuSD3ZhI5pNaD7ZtzhEhs9UMGSSGZeYEKDJG0Kc3TMZCWrnGoyEO5e4EpZ2KI4PKu0+qDJbkaKvb573VNsXEvc6hYsR1hBdfTaRzGQIDG2QrTHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXJP/64C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PtrHpO5V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:20:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771917627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIHjFzuf8K9BbQvNXBR6jD26l7uPMh+/zM/KFSH95+0=;
	b=CXJP/64C6Uj1JTLfYBAlrYCrrb7WCQCnsLITxn+kO9pgmLVhtgjZfETfPjDCexifsiVWhK
	IObIQ+XyYAYhGpnvRHqyhqBFGcHT6XlB5oh/8l8/LqPZw+C7xxngZwdPtwdBwT3LymiHpr
	2la4D6ANkdjGz7zA3T+yVUJUiSkbtPEk1fdHMlvTHT0Tin18L1GjaNCVxJr2tJNLqUV2t+
	KsJ7lApfb5wJrZ3fTxzhiN2ECUfKl/6C+bklXjQw94llZkQbNk2S8svZ372JYI3KKxZOAi
	s9hHhj6V9PTGv6ZfFv8CJWTkmH7VxfyVpMeKcdnH7XZ4CvM5hQEz1+L13FVhhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771917627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIHjFzuf8K9BbQvNXBR6jD26l7uPMh+/zM/KFSH95+0=;
	b=PtrHpO5VdqT8ANjiUJVDcCXPOp4rr/ZjSOsJopM/o3LgYClUYzkuF8ZrTX06QLNKjEaXMC
	GbUJ3euJoY1cm/Cw==
From: "tip-bot2 for Brian Masney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-pic32-evic: Don't define
 plat_irq_dispatch() for !MIPS builds
Cc: Brian Masney <bmasney@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260222-irqchip-pic32-v1-2-37f50d1f14af@redhat.com>
References: <20260222-irqchip-pic32-v1-2-37f50d1f14af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191762594.1647592.17880415222750089138.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8240-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3613D182F11
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     15f9b251fe404997eef1d7685877479364c4cfcb
Gitweb:        https://git.kernel.org/tip/15f9b251fe404997eef1d7685877479364c=
4cfcb
Author:        Brian Masney <bmasney@redhat.com>
AuthorDate:    Sun, 22 Feb 2026 18:43:45 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:15:43 +01:00

irqchip/irq-pic32-evic: Don't define plat_irq_dispatch() for !MIPS builds

plat_irq_dispatch() is specific to the MIPS architecture, so only include
it when the driver is compiled on that architecture. This is in preparation
for allowing this driver to be compiled on all architectures.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260222-irqchip-pic32-v1-2-37f50d1f14af@redha=
t.com
---
 drivers/irqchip/irq-pic32-evic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evi=
c.c
index 325b97a..1eeb0e6 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -40,6 +40,7 @@ struct evic_chip_data {
 static struct irq_domain *evic_irq_domain;
 static void __iomem *evic_base;
=20
+#ifdef CONFIG_MIPS
 asmlinkage void __weak plat_irq_dispatch(void)
 {
 	unsigned int hwirq;
@@ -47,6 +48,7 @@ asmlinkage void __weak plat_irq_dispatch(void)
 	hwirq =3D readl(evic_base + REG_INTSTAT) & 0xFF;
 	do_domain_IRQ(evic_irq_domain, hwirq);
 }
+#endif
=20
 static struct evic_chip_data *irqd_to_priv(struct irq_data *data)
 {

