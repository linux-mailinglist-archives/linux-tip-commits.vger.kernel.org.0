Return-Path: <linux-tip-commits+bounces-7757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB4CC92E9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 19:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509AD31B9BC9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F47357A34;
	Wed, 17 Dec 2025 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uER+mclc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUvRm6da"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9734E27E;
	Wed, 17 Dec 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993715; cv=none; b=orvWlo3MOx9ty5EOQQa6+QSztfMJQOsjCA5K5oPn7hpuPzqHqDiFs3ZaEC1/TRSWsAI/CVm8EUE4rj7laf0zYR5n7q/9rH1HYrE5jEM47uxpT+77IuQ0lm8TqLeOAVibbFJ36GS0h3F5KC5PJ0ZeZu9pI61OZ4NxV9JOVdfcUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993715; c=relaxed/simple;
	bh=gu5yZD/F1fr+Q483zt94xIuaWvRJ8EOmGhL2zTZEFjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eKrnxJYx76yI5DCLwJCi/WA7X6hOPthK5JT1voJqTBITUZ6klpFWqXa3dQBxk6x6xCBRHGb7HXo7UlZyT/Ke9yyUc31Yw8SY7oukpQJhUS1HTfNWMUooXnNgqe91NLWlC5/cQvONJ9Gbmub3PTOj6tTJevg057GpLZKG2GOHpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uER+mclc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUvRm6da; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 17:48:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765993711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGGezLQBWT8WxnCQJFFbQf7/GdRaHY1WqI92Lmdficg=;
	b=uER+mclcbXLRYI3u54Towmh15UIS1NoEc8YngDGI9cB9ZSPEL3XfaVXVmoiCe3BYBN4X0w
	FCcwaNK2jLy5rgIUfejaTwJ+nzwEd5P3k+5um6EYIFkFq4jrl3Y5iWV6Szs+d1Ee7q+za8
	Y5im6MgGYCCqbh0JiZVw7NBmtzyEvFaM7+wbTbjcB7A1EMeiW5ObmeKhRgqyZafDNIxX9W
	R6kE5pLR3kVCbtgOjiyzxZCQugVANM7iHg5ayQ+JgK91sZtRb9zFQeaLz0NPNepfTkPsES
	yyVhRBq24teHmXkFk9V9+AZP01dT3WsRXEKIxWeL6i+xt6Nu8t/2Su9wtqjeAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765993711;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGGezLQBWT8WxnCQJFFbQf7/GdRaHY1WqI92Lmdficg=;
	b=UUvRm6da2kNsL2GbZSv/koQbcsQ3Lv97N1UpH6VKYg/trfZyiIF+VKOYtP7Wu27Mz2/hBW
	GGvF9BuTXhJplVCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq_remapping: Sanitize posted_msi_supported()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251125214631.170499997@linutronix.de>
References: <20251125214631.170499997@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176599370992.510.9601800206559033707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     64d4c88270cf90089434e3db67ed443fd982a9a2
Gitweb:        https://git.kernel.org/tip/64d4c88270cf90089434e3db67ed443fd98=
2a9a2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Nov 2025 22:50:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Dec 2025 18:44:17 +01:00

x86/irq_remapping: Sanitize posted_msi_supported()

posted_msi_supported() is a misnomer as it actually checks whether it is
enabled or not. Aside of that this does not take CONFIG_X86_POSTED_MSI into
account which is required to actually use it.

Rename it to posted_msi_enabled() and make the return value depend on
CONFIG_X86_POSTED_MSI, which allows the compiler to eliminate the related
dead code and data if disabled:

  text	   data	    bss	    dec	    hex	filename
  10046	    701	   3296	  14043	   36db	drivers/iommu/intel/irq_remapping.o
   9904	    413	   3296	  13613	   352d	drivers/iommu/intel/irq_remapping.o

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251125214631.170499997@linutronix.de
---
 arch/x86/include/asm/irq_remapping.h | 5 +++--
 drivers/iommu/intel/irq_remapping.c  | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_=
remapping.h
index 4e55d17..37b94f4 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -67,9 +67,10 @@ static inline struct irq_domain *arch_get_ir_parent_domain=
(void)
=20
 extern bool enable_posted_msi;
=20
-static inline bool posted_msi_supported(void)
+static inline bool posted_msi_enabled(void)
 {
-	return enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
+	return IS_ENABLED(CONFIG_X86_POSTED_MSI) &&
+		enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
 }
=20
 #else  /* CONFIG_IRQ_REMAP */
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_re=
mapping.c
index 8bcbfe3..ecb591e 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1368,7 +1368,7 @@ static void intel_irq_remapping_prepare_irte(struct int=
el_ir_data *data,
 		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		if (posted_msi_supported()) {
+		if (posted_msi_enabled()) {
 			prepare_irte_posted(irte);
 			data->irq_2_iommu.posted_msi =3D 1;
 		}
@@ -1460,7 +1460,7 @@ static int intel_irq_remapping_alloc(struct irq_domain =
*domain,
=20
 		irq_data->hwirq =3D (index << 16) + i;
 		irq_data->chip_data =3D ird;
-		if (posted_msi_supported() &&
+		if (posted_msi_enabled() &&
 		    ((info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSI) ||
 		     (info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSIX)))
 			irq_data->chip =3D &intel_ir_chip_post_msi;

