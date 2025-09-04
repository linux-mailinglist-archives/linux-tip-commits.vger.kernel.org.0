Return-Path: <linux-tip-commits+bounces-6483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA1B43C3B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02DA5E2CB2
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8732FF652;
	Thu,  4 Sep 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oagNGIOh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWkq2YNb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF22FDC58;
	Thu,  4 Sep 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990701; cv=none; b=lCKG1nHfBwExAJQ2RQFj/Y6mnnjWjFZuMYe/8Pr1H4iZCUIjst2aPLSgiKu4bxfn0W1FjqrHE4FAcNO/U8sT+VeOdYrtpmHyYfg2F29dWRdjOx3SkmLmBx2wkW97ePq5arvXJOz+ZMIDYle2BjeFUgD0Zp3PtKlEQ5WatEj1c9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990701; c=relaxed/simple;
	bh=PpHYplGJl6sZBjaRCKvSyWa8eJD3d5J/jPiGdSDYYZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uR0HVkAqLO0yHKM+EyQOZLYb7Ba60KyC9hHk1YmTFb/9GEWPM3xK5/GV5BkvA4huCX+/znrb+keSKoSysMMibh+v5XJFjb4QkMlR4sQcWJ+TVLXsO4vvNqOc3X9mqS5r2IEAIvvPjX0wPikR4aA5GRiXj2xqrrtqV3IzMwJP1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oagNGIOh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWkq2YNb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 12:58:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756990698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqOp5EEYPQ1NJivphkjVm2SdRANjJgB0UbokPm3v7TU=;
	b=oagNGIOhZvRn/j35O5v3Gtfmw0c3NtSpJBXoUdeVBFH5qkgGx+YQ9VZhjca6KS40prSgxv
	O0L6er2aUMND6vIiej2fzHgVB0obwZhfX9Az1x3aXWiQy0kcOJV7S5USaC1+34Nt8a6INE
	75rYiKquXutVupl9BL1aOwdl79aUnUiIfD0NCXU8Few9AOi5ZzaMmwVVcblm4PPLvloZV9
	adNeYb2f8Z2SNR2UCyyDAuDmFDRBCWHQDXmBIKUyQNHioOzs/W8bsLSS9J3ptWGPuEASBF
	UXFfs2zjlJj588W76ex2YRe/jWWOtYOaZehvDU3ZywpFFLknefcxTq/rkI9+Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756990698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqOp5EEYPQ1NJivphkjVm2SdRANjJgB0UbokPm3v7TU=;
	b=HWkq2YNbWAy6z0attREqYcn6e+NIMEekTHR0cV9hyIYn8Wjsh/WO6o/xEsjdDJmIbGOGuk
	RhGQuA6kuxCMCnAg==
From: "tip-bot2 for Christian Bruel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment
Cc: Christian Bruel <christian.bruel@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902091045.220847-1-christian.bruel@foss.st.com>
References: <20250902091045.220847-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175699069703.1920.2950886349069255880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     2ef3886ce626dcdab0cbc452dbbebc19f57133d8
Gitweb:        https://git.kernel.org/tip/2ef3886ce626dcdab0cbc452dbbebc19f57=
133d8
Author:        Christian Bruel <christian.bruel@foss.st.com>
AuthorDate:    Tue, 02 Sep 2025 11:10:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 14:52:47 +02:00

irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment

The PCI Local Bus Specification 3.0 (section 6.8.1.6) allows modifying the
low-order bits of the MSI Message DATA register to encode nr_irqs interrupt
numbers in the log2(nr_irqs) bits for the domain.

The problem arises if the base vector (GICV2m base spi) is not aligned with
nr_irqs; in this case, the low-order log2(nr_irqs) bits from the base
vector conflict with the nr_irqs masking, causing the wrong MSI interrupt
to be identified.

To fix this, use bitmap_find_next_zero_area_off() instead of
bitmap_find_free_region() to align the initial base vector with nr_irqs.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250902091045.220847-1-christian.bruel@fos=
s.st.com

---
 drivers/irqchip/irq-gic-v2m.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 24ef5af..8a3410c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -153,14 +153,19 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *d=
omain, unsigned int virq,
 {
 	msi_alloc_info_t *info =3D args;
 	struct v2m_data *v2m =3D NULL, *tmp;
-	int hwirq, offset, i, err =3D 0;
+	int hwirq, i, err =3D 0;
+	unsigned long offset;
+	unsigned long align_mask =3D nr_irqs - 1;
=20
 	spin_lock(&v2m_lock);
 	list_for_each_entry(tmp, &v2m_nodes, entry) {
-		offset =3D bitmap_find_free_region(tmp->bm, tmp->nr_spis,
-						 get_count_order(nr_irqs));
-		if (offset >=3D 0) {
+		unsigned long align_off =3D tmp->spi_start - (tmp->spi_start & ~align_mask=
);
+
+		offset =3D bitmap_find_next_zero_area_off(tmp->bm, tmp->nr_spis, 0,
+							nr_irqs, align_mask, align_off);
+		if (offset < tmp->nr_spis) {
 			v2m =3D tmp;
+			bitmap_set(v2m->bm, offset, nr_irqs);
 			break;
 		}
 	}

