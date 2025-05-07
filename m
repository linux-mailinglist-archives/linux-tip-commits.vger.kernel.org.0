Return-Path: <linux-tip-commits+bounces-5431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54733AAE115
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515D13B4F8B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6628A73C;
	Wed,  7 May 2025 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIsEYOEB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2f81xVNL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AF28A3FC;
	Wed,  7 May 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625456; cv=none; b=ljs6j8s/0D8Wb0xdftTZIMywY9JcDNC5temmbniPe7moMBpbNmUnZwXb+YRPsuUjO4Uu7r00BeftEmXNfpMjm2Zu2wtNFtoZwh4PyQLFgOEfuL9u4heVExK0i6tGljBU4evw3raEtbBQJ37rl+J0QFxpz5npSyvgyUqcLA5zetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625456; c=relaxed/simple;
	bh=74+JBQ6ZlgeFQeV6bgnbBp3+o2xzcWomYLyOLF+6LhE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z4OnO60F9CwlstkO+lBY6BAiavXgKPt29iQnku2O6n4kqKlXLB++vDyVrSm7dHaZm5H0rNUYD3E+oa4sXXLFhpJ9rMyJ49DekcqHYTteYO2FTOPNu/DO0baQlMCXDKDP/ebxowO3Sebh9qp4oC27iZY28nLp1S+eKDywKH96UTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sIsEYOEB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2f81xVNL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2Vk0Phphxs3tE/xbSrFaZka4x6AL0eEwhEkQ5NOVUE=;
	b=sIsEYOEBF8N1+FCEMeetS4Tq2mQTvgNW1W4PXABFHGKbq4bKZ5QiGSBgxqoFOjOg605+0b
	CCLhjRyhWVjUxF21ar64/nFeDCT151Tmr8K2QTHHGvhcQNt519VUPzqntdaW8A8c7hIHcq
	QAvnrICV9ul7DTAZpqw0AUP7sPJho62LYn0z4yOSwVjqkvNFrU4/uU9zgcVGkZDLB3Pr7V
	9dcF+4vVqyU1+cZcJ4zaciOpUI/B1cm5aFVObIzPSUL6l9PQhyPq9GOxkXABasltN9RTPB
	P9Msatj6NrhY3fW86qdlU8aVWcpSB/j3LdsAuJiNa0imsbmEy0c5htptyVKD6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2Vk0Phphxs3tE/xbSrFaZka4x6AL0eEwhEkQ5NOVUE=;
	b=2f81xVNLgSibVWCj6wy2M6NrNvUGSFzKo5/6lbF8Srw+X4aZ1H/vYYXVC+QRgMqU1VZQyx
	E79qMkM9MERQrPCQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] sh: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-43-jirislaby@kernel.org>
References: <20250319092951.37667-43-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545217.406.16735991697159310827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     6bd9b88a4b7803acde27922e990ea873cd2c5d4e
Gitweb:        https://git.kernel.org/tip/6bd9b88a4b7803acde27922e990ea873cd2c5d4e
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:41 +02:00

sh: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-43-jirislaby@kernel.org


---
 arch/sh/boards/mach-se/7343/irq.c | 2 +-
 arch/sh/boards/mach-se/7722/irq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 8241bde..730c01b 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -71,7 +71,7 @@ static void __init se7343_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7343_irq_domain, 0);
+	irq_base = irq_find_mapping(se7343_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7343_irq_regs,
 				    handle_level_irq);
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 9a460a8..49aa3a2 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -69,7 +69,7 @@ static void __init se7722_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7722_irq_domain, 0);
+	irq_base = irq_find_mapping(se7722_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7722_irq_regs,
 				    handle_level_irq);

