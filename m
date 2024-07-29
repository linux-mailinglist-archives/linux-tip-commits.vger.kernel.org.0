Return-Path: <linux-tip-commits+bounces-1766-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5B93F1AA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9ADB22E62
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26614535F;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYRhy+0H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pTgN6OE+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55714389A;
	Mon, 29 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246589; cv=none; b=QFLABvfvwVb4/R0FBuBJE5Ex1/5cA3acxJA3+CW5SvkAwwsF/bQhST48d3eOW1fQiwxboA73L896Eb9KdcsZvPvtiasddFZ3OxOv4U3PU8TGpE/JNhtioeeV4S9eiKZHiqpHNzGxw8wYyGdGvuRTmU+6XkBY7ndHcuQXtDra+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246589; c=relaxed/simple;
	bh=rlp5kKfvTXZWJJoyFniWvXKEKUl07XBtFoQzeE3sKLk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BaHJV0cqyFTLVJyg7/ISnyfRgmp6H55Envzs246AJsxm5B7N37nI9MY4I6qgW4FPDpB4UBvZozxXKgawJevYyog1/BEOKkHPMMpI3jBGoo5/JjlSFrGSA+Fy2HTiEnfkmJ9rPdygkFIIZQJK+NlVEb4N6aPXA8TkjQUhh+OXRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYRhy+0H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pTgN6OE+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n62MTVBdDsqRsk5UEZK2ERFeS6f/CpHo/X59G92xfps=;
	b=kYRhy+0HJ/ci+SVD5LbX9/ciS6ckguFS9bDL8ANO5UOa1fBsYmHNLCFmYFfmZOArLXm4D8
	HKaUYGKd3/+0gfa9NkXpxpcdzfcr1e2uhTJlQLwdez0EJYk6aJS7x6VSiGOth1ETlZpXdu
	OXYxbt3weoNvk3yW3huHJHVpdoSmTltNVfPwjCjs02QAT6vmtDYGJ/CA+drV7dA6TKmOsF
	OaKkkR4kTKPMeakiXGHxWf3KjmC3ZXDWXvjfaX2z6UJ2+QeOWg/H8MZRMASvRDB9MHyqpo
	xQ6yP+heqLhFvDGAJJZuJnMD8ThX83kZ/C9XX1Z7/75hgFrYs4OVJcM5lUfUTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n62MTVBdDsqRsk5UEZK2ERFeS6f/CpHo/X59G92xfps=;
	b=pTgN6OE+CRJY51FUzH5vtxLmdydwJKvrMSSK5DflUaydxBoWb40k7DzAws5Y9E9DrRuJG2
	B35BsOJljhAvMeDg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Refactor handling IPI interrupts
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-11-kabel@kernel.org>
References: <20240711115748.30268-11-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658304.2215.8881998759963429933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     47b6575630ebd6f2b5742a5cbdacd126f36b29b4
Gitweb:        https://git.kernel.org/tip/47b6575630ebd6f2b5742a5cbdacd126f36=
b29b4
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:23 +02:00

irqchip/armada-370-xp: Refactor handling IPI interrupts

Refactor the handling of IPI interrupts
- put into own function mpic_handle_ipi_irq(), similar to
  mpic_handle_msi_irq()
- rename the variable holding the doorbell cause register to "cause"
- retype and rename the variable holding the IPI HW IRQ number to
  "irq_hw_number_t i"

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-11-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 30 ++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 5c2631f..d42c7a1 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -619,6 +619,22 @@ static void mpic_handle_msi_irq(void)
 static void mpic_handle_msi_irq(void) {}
 #endif
=20
+#ifdef CONFIG_SMP
+static void mpic_handle_ipi_irq(void)
+{
+	unsigned long cause;
+	irq_hw_number_t i;
+
+	cause =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	cause &=3D IPI_DOORBELL_MASK;
+
+	for_each_set_bit(i, &cause, IPI_DOORBELL_END)
+		generic_handle_domain_irq(mpic_ipi_domain, i);
+}
+#else
+static inline void mpic_handle_ipi_irq(void) {}
+#endif
+
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
@@ -669,19 +685,9 @@ static void __exception_irq_entry mpic_handle_irq(struct=
 pt_regs *regs)
 		if (irqnr =3D=3D 1)
 			mpic_handle_msi_irq();
=20
-#ifdef CONFIG_SMP
 		/* IPI Handling */
-		if (irqnr =3D=3D 0) {
-			unsigned long ipimask;
-			int ipi;
-
-			ipimask =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE) &
-				  IPI_DOORBELL_MASK;
-
-			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
-				generic_handle_domain_irq(mpic_ipi_domain, ipi);
-		}
-#endif
+		if (irqnr =3D=3D 0)
+			mpic_handle_ipi_irq();
 	} while (1);
 }
=20

