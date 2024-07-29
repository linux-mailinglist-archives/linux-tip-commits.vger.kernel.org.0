Return-Path: <linux-tip-commits+bounces-1771-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FE93F1B2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B81F23AF2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3955145B3E;
	Mon, 29 Jul 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j5XHIJ8E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBWJIdjF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806D145332;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246591; cv=none; b=SG/UxH/e5EIaThW2qMOe1IC8ku4vGAb4qCRRI7dtvkn8or8CL/7n0jRbkjt3qE7Kj/28FtTzsIssp/XFS6GctNB2WgwP1h03YFs+XMuBI7ufdxk1jNaZ0oHg5A1114+rQs5GS065O5QRD98LGGIFE5priN9ROW2B25WA0tGjohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246591; c=relaxed/simple;
	bh=+/gMSoyNeDiClAEmgfhaYCt5qulnnyxvXdhCgq/Radw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xy8eTJCWU+vkEcTX9flkW1UzlBj6Slnsm5Imyjypo/qpsTU9AnVVbuj5wdgHdLdlhra1aVERzsq3K40JzqLkQCjITt4YRcDJcZ7suwpVInGyrpCXPXJvDOI+UkfuXLy5/35lxzAsmWj5xuRpjS8rXIlvJvYiOi5V1tq0TIy7dZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j5XHIJ8E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBWJIdjF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Isb0seI8xb3pgsRCptWjxIA7I614Lqw/3DZbwXgGF+U=;
	b=j5XHIJ8E0jPFKT5QSA//ZBsqOoyDdIVjZpMHjM3LX056K1ONu9p1uiN9ZNz5E7WNd98JkY
	6l1AtlXGvqspaqeV7EC/klER9qQMKPReE/9fvDnbRf6hoLwcsa0aNo54Cw8ERBDSJZINw1
	k13FDHl+sk3gbw8Ac7ZqAET8WBTKNJbxxp6T9D4Le3uMZ0cpz5vgAI5xQsbJAoQMM7YpwK
	Ov+bZx+6STb5LSpsanDRY+oTgTHbeBrJpn2U1XW9vGJ/rcxgmsG5UVqeRRuZNgQ5ecQsQp
	T/nJ5t2ZU7nUL9+1IiDaq/lVOjRcmX+/MyX2KqxXRu8cccRKZCLzbd/RPXXmVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Isb0seI8xb3pgsRCptWjxIA7I614Lqw/3DZbwXgGF+U=;
	b=xBWJIdjF7ogmM4CN88WF4+3FR0yoncNW5hXnSKgKldSC8+IX/4MGue51HJ7fTt82M3qRP2
	kwf6uuvWmdHL0QCg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Use unsigned int type for virqs
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-3-kabel@kernel.org>
References: <20240711115748.30268-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658507.2215.9647572935606125906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     661c797ad537b8097893ebc98f4995934766e423
Gitweb:        https://git.kernel.org/tip/661c797ad537b8097893ebc98f499593476=
6e423
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

irqchip/armada-370-xp: Use unsigned int type for virqs

The return type of irq_find_mapping() and irq_linear_revmap() is
unsigned int. Use the unsigned int type for the variables storing the
return value.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-3-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 7016b20..b29f3bb 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -462,10 +462,10 @@ static const struct irq_domain_ops ipi_domain_ops =3D {
 static void ipi_resume(void)
 {
 	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
-		int virq;
+		unsigned int virq;
=20
 		virq =3D irq_find_mapping(ipi_domain, i);
-		if (virq <=3D 0)
+		if (!virq)
 			continue;
 		if (irq_percpu_is_enabled(virq)) {
 			struct irq_data *d;
@@ -539,7 +539,7 @@ static void armada_xp_mpic_reenable_percpu(void)
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (unsigned int irq =3D 0; irq < MPIC_MAX_PER_CPU_IRQS; irq++) {
 		struct irq_data *data;
-		int virq;
+		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
 		if (virq =3D=3D 0)
@@ -734,7 +734,7 @@ static void armada_370_xp_mpic_resume(void)
 	nirqs =3D (readl(main_int_base + MPIC_INT_CONTROL) >> 2) & 0x3ff;
 	for (irq_hw_number_t irq =3D 0; irq < nirqs; irq++) {
 		struct irq_data *data;
-		int virq;
+		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
 		if (virq =3D=3D 0)

