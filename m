Return-Path: <linux-tip-commits+bounces-7766-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E21CCDBF9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 23:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 272CC300D146
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B1299A90;
	Thu, 18 Dec 2025 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWtH2LPZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5zEx4ie"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C40231845;
	Thu, 18 Dec 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095418; cv=none; b=beXcdkPUzf7uyKcjTKYjpEjrwRgi2sJ4kwxY7uO7CfVJkCM4NsjiA6NrMg10IsspdTdhnbGjEY2tBYqp6TfBCTQkx/UNeoIySYyUXS/1/r7zjABO+8H0vjARPoUgNYkzL3sKo3SLrqJDpM36l2s4a6emK1ktrYGWzoxpdzHjixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095418; c=relaxed/simple;
	bh=CwYlTroVDdhR7NwIjLQ9riM2y1za930mDQ28ZGqmAHw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cs4Qsa6BF7tCMd6XSmxvHK2bLZyWgHPmjtBqkweEwwai8NaRTrM9taPD8cDPR/r75Kxj4dT/a0B7fhxyQQ5DA1aMGD9zkDNedffJHOp/Ej37iurs43mwJYDh8gwQs8+Bg/BhxpDQXMa+AXahl8NWDjfLbS0kiXMRGugJ53nGroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWtH2LPZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5zEx4ie; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 22:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766095414;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVbqNDqXopaIe97xzEVe3j1IAG+mZHW7Ph3dhG8vYo0=;
	b=YWtH2LPZ3pq+Eqp7JUDsGSHiOl/pN2UqTf7BQ0jJZZHd+t2hIs9Wn0ySSZKtyAICWxT+BR
	p/d2Yvazo+Wi0nUnxUWtYFVkSGHcxQJa23iEBmQ3+SIYIGargopKtpQ8wLOh9XdLHoqFoH
	5Rv9q/LIAbHEMhvkEroc7kOBz2g1wan62WI2OloIAd/T6GMWy+n5bHjaP1ZJyjx7VQF8fB
	zgjD1rHPMlp6SmtGMD+fcmvgvFkiap7l/Nx8kwGw+xLo5qOu6ORgZ4TAt9SqmBRiC5LH2d
	4Ajvk0y8kYJtnEg3RwLUvCk+BuhVVPI0m78ScXlzLyzSrw91jPFPe6yL91aiQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766095414;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVbqNDqXopaIe97xzEVe3j1IAG+mZHW7Ph3dhG8vYo0=;
	b=o5zEx4iexqOeubaOKcM8UWMQUmAhOlsTlFrd0Nb4GgJwf02/39lOxu2ZIjkJpJJ8M/gh0V
	hOF96hCl1bcUp4AQ==
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
Message-ID: <176609541311.510.13017225944888809036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     d441e38a2c87824afc7e656e634e55141d015307
Gitweb:        https://git.kernel.org/tip/d441e38a2c87824afc7e656e634e55141d0=
15307
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Nov 2025 22:50:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Dec 2025 22:59:40 +01:00

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

