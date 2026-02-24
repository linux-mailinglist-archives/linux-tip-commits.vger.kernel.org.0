Return-Path: <linux-tip-commits+bounces-8238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIG/NZZSnWk2OgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8238-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:26:14 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6BC18302B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8B43173A85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4C365A10;
	Tue, 24 Feb 2026 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="te+iEekF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tkjUZp1p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411A3644AD;
	Tue, 24 Feb 2026 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917634; cv=none; b=ZY9s1G6EKWKBHuVQhmJUzCbkITNntBoP/7gV+FD73BTncGBIzPS8HTylgExJfS6F59U+i7q6mm4CXsGRQsl5bU284iyRCKlQoqn6Cu2DR9XfYg18es5m1YK0tJ0xK0cu9VVoIhDC4KNpKmagzkF/vdIwzVdr/dWYJuc6Gz6vrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917634; c=relaxed/simple;
	bh=ZT5VXPNiZ4iqhIvBdmMZghMUHo4ctlT6O9kX4wUTEgE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eL/w9nLCDIrTj4wcYRtANh4clAyCRUrbgsBAOpknv+f7TptCq2nmK84CbYkjOGB9nnDClhb/Qasq9NuW65nIib7e4ZavtTMq00161cjFcA9PB6eayVw5P2Gf1CAD2wuZGmDCboAHdQB+qiWzvk+kg7aDPEzwgkbgZUgATzeIMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=te+iEekF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tkjUZp1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771917626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjrzL07oWiEmvWXolqx37MnHFZpWRsn6CtuDgvt/tX4=;
	b=te+iEekF12EKMB5YLcMPsR1v1nlrtuDEFyDBIQsUb7YV6F5dn1LsR8+UcyBYw9u1wRwE5O
	MH24qW61ivlLt1mUeSVJfSetlEdrsy2/u01Gnuul1/TrEQCPlSy23uNhlOVWTigp3YCnYV
	T4EGv8DtYTgRaB9FcVjF5e72ZtC5hp8fY3/HZPN1aa75hOb+4TSB1K7Q4GB4C2pDy9wGIf
	m0VLkB62pvgwPXUlBGxRJS9b0KOtufa+fjXnX00PhKSNHNkaJx4uvVKzhFCmqNGHMgrlQI
	XcjuFJphyxeHuxxwKUafbTryfEDBAZ6vmEE+n1Re/EX4U9Oa6ppF4yu+D/0DwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771917626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjrzL07oWiEmvWXolqx37MnHFZpWRsn6CtuDgvt/tX4=;
	b=tkjUZp1ptQySrystYmFlBEXpZieYqLQJKsw1CJHLYnbSQXuKd9esHAuVEI3dJ9in9tENkx
	On+W3bNprUWum8Dg==
From: "tip-bot2 for Brian Masney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-pic32-evic: Define
 board_bind_eic_interrupt for !MIPS builds
Cc: Brian Masney <bmasney@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260222-irqchip-pic32-v1-3-37f50d1f14af@redhat.com>
References: <20260222-irqchip-pic32-v1-3-37f50d1f14af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191762470.1647592.6203034304416468026.tip-bot2@tip-bot2>
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
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8238-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3C6BC18302B
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     282f8b547d51d8a33b9230ba58e2324babe0a96a
Gitweb:        https://git.kernel.org/tip/282f8b547d51d8a33b9230ba58e2324babe=
0a96a
Author:        Brian Masney <bmasney@redhat.com>
AuthorDate:    Sun, 22 Feb 2026 18:43:46 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:15:43 +01:00

irqchip/irq-pic32-evic: Define board_bind_eic_interrupt for !MIPS builds

The board_bind_eic_interrupt() pointer is MIPS specific. When compiling for
other architectures it is undefined which breaks the build.

Define it as a static variable when building for non MIPS architectures
with COMPILE_TEST.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260222-irqchip-pic32-v1-3-37f50d1f14af@redha=
t.com
---
 drivers/irqchip/irq-pic32-evic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evi=
c.c
index 1eeb0e6..afb7002 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -48,6 +48,8 @@ asmlinkage void __weak plat_irq_dispatch(void)
 	hwirq =3D readl(evic_base + REG_INTSTAT) & 0xFF;
 	do_domain_IRQ(evic_irq_domain, hwirq);
 }
+#else
+static void (*board_bind_eic_interrupt)(int irq, int regset);
 #endif
=20
 static struct evic_chip_data *irqd_to_priv(struct irq_data *data)

