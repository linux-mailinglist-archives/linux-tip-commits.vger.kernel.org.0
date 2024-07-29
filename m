Return-Path: <linux-tip-commits+bounces-1756-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EB93F196
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72472810EC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63A1422C7;
	Mon, 29 Jul 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z1T8LmFO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgqWSye3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3913E032;
	Mon, 29 Jul 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246585; cv=none; b=h2+g9wIC8NcrPTlBO7x8Pb52NjceSb97QqWGfcuBGNRBXuWFEAbao1sjKV+A4ZozM/NTeGATaZE3cN+T38sDmwdyhKPhGB6hpBUUOaxTMwYeyF9kXhB4TuMDJ/C3b/zI/XjB9Jz4Oxazh8MTCH2rnLFQcdFjgXwjxcjbBbB5gMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246585; c=relaxed/simple;
	bh=ZrTY6EUV6hcnN6G6ekAfjyDk5xRMn2aiSZDCHuQEElA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pmTIHscGKRcRsbBPBKd5uQGm8N8SetgRROgPMsImZGsFEcDIgThxqvc/RGMHvb+y5I4sGJfnG0jTweIRsGQ85peLCj2xjCMNFBfVLEP3EB0ceMZa7qiF2bE2S2ekE4ORmHryZy68CK38QkwsT1Q8n/IGj6JLNujvAhenavszqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z1T8LmFO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OgqWSye3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGnri7A5otNqLbPQnFDTztgpmrX3xX8MMBonM0UmEzk=;
	b=Z1T8LmFOV/Jz1n2tl1dsgBZHibwDT0VZ87KIDHkX7Fjs8hdZH17blBeU/S9hZM7Nng1GUY
	ElWtsMeUc96o/xR55LBAphlefwdXY7MYuRADoC+csE8NLdstaTw31VvmH+EaqvWdFdP8S4
	AGbf+1eDgZDAFDONK3HSLxrDdyIFq2U7VD8HPQJ6xi+egDhy2jlRR70ZBLzaU+caJ5SaKi
	Nmk7oZkhE1Xb1a/URZHKuPp/rz7bT5+dYOLKTwRrHVnittG4B4FmBx+fQvGKYdsxSWi6+h
	SBZIhxXTjMFRYLO9rx+vnWaQ5HVGnyLhK2mwarO28Si+jUf3zpZT7O0GBldTnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGnri7A5otNqLbPQnFDTztgpmrX3xX8MMBonM0UmEzk=;
	b=OgqWSye3IgmjFZghtXRy8JyrQo84XPihQNvCPOzX6J7UJLby525IUbzteUclM6w56X9NFl
	gUG4M3KDBYgkW4Dg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Rename variable for consistency
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-8-kabel@kernel.org>
References: <20240711160907.31012-8-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658162.2215.14940628528309190335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e827b6cb64b412a6b52e5fc0f453013ac98032f6
Gitweb:        https://git.kernel.org/tip/e827b6cb64b412a6b52e5fc0f453013ac98=
032f6
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

irqchip/armada-370-xp: Rename variable for consistency

Rename the variable holding the cause register to "cause" in
mpic_handle_cascade_irq().

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-8-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index c1085c7..29ce6fe 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -633,15 +633,15 @@ static inline void mpic_handle_ipi_irq(void) {}
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long irqmap, irqsrc, cpuid;
+	unsigned long cause, irqsrc, cpuid;
 	irq_hw_number_t i;
=20
 	chained_irq_enter(chip, desc);
=20
-	irqmap =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
+	cause =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
-	for_each_set_bit(i, &irqmap, BITS_PER_LONG) {
+	for_each_set_bit(i, &cause, BITS_PER_LONG) {
 		irqsrc =3D readl_relaxed(main_int_base + MPIC_INT_SOURCE_CTL(i));
=20
 		/* Check if the interrupt is not masked on current CPU.

