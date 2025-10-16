Return-Path: <linux-tip-commits+bounces-6949-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539ABBE526E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6BA483C4C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FAC22AE45;
	Thu, 16 Oct 2025 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q+yCHwDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPhotfsb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73992186E2E;
	Thu, 16 Oct 2025 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641287; cv=none; b=NrNp0MdsbXSoLsZLclFN4r/Il+vPiKroJR7YGClfkHXYxaTQLMRQ7jUYM8478hY+trabXgAj2ZDQ08o13mxF0CXUhjYiCGS/0TZ5VEHvH6xwJes8VP7cAcBi2LxRkBkWYfZTB2DQjkYVFl4PCqVyMLuCemUHfgLK0OARzN8AIYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641287; c=relaxed/simple;
	bh=k8Em+xzOqIwbfHwsygnJYsk0+SRTFaG1nraFcpWvJug=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KSNW9Dk6h+zQzFXMhbulIRaWd7GSD72ijJnrCd/vDtFQtVpG0LMOv/kUPgxwlnAnGgt6d0tsMZiwhB+gjvXtsT83LsP1td9yQjNM8CXoi0KZEsvb9X7f9byTThLQ6ZhXuwdkIzVFkqUCsfzhvUw/EEKnCW2/p7SurBEc9Wg/EC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q+yCHwDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPhotfsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf7sEw+k3pYo++Sv5eB2+xzcGFcPHDhvZa1LJ6lxMr8=;
	b=Q+yCHwDT3E1doBVHoRLlS+6WIYvc8ng5jIIxfQHR/ZbpIu1y/iPEoYcnm9ckd6BEXULTRG
	t47obSB2bjjaR0bVG4I8aZq81QArSQ4PTemdmhvtrJNYXY/NsDrmhH2y/luj/er4t8+/M6
	2GRy6pbn2/TznYbde6OBTAVfRp4+YHcO/SZLEzuguVcb/NGjQnkR3AtpZ5Gk7b3RPjXdDz
	PKE8WbkgpnbDixJ7FrNFMs4Bfo0gCBR0EFEnFHRCDD8l0hcNMJHlhTnAdZLvQYfF/i9gYM
	yzDRvscQW+cL2cn20boz0RoxE6Gnefat9mz8N9aP193lyCt1IsbXGPB26KQI4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jf7sEw+k3pYo++Sv5eB2+xzcGFcPHDhvZa1LJ6lxMr8=;
	b=yPhotfsbQ8MSeP+wEU28wVWpZXnCWdXp/QOgZQNWX9GBXmv8DwU/7FcpaIMe0IJESdZKmI
	oOTPw0HS56c3QEAg==
From: "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/riscv-imsic: Embed the vector array in lpriv
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251015195712.3813004-3-samuel.holland@sifive.com>
References: <20251015195712.3813004-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176064128257.709179.7684616707926436348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     79eaabc61dfbf5a4b680f42d3a113d05333c3960
Gitweb:        https://git.kernel.org/tip/79eaabc61dfbf5a4b680f42d3a113d05333=
c3960
Author:        Samuel Holland <samuel.holland@sifive.com>
AuthorDate:    Wed, 15 Oct 2025 12:55:13 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:28 +02:00

irqchip/riscv-imsic: Embed the vector array in lpriv

Reduce pointer chasing and the number of allocations by using a flexible
array member for the vector array instead of a separate allocation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ++--------
 drivers/irqchip/irq-riscv-imsic-state.h |  2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
index dc95ad8..9a499ef 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -487,7 +487,6 @@ static void __init imsic_local_cleanup(void)
 		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
=20
 		bitmap_free(lpriv->dirty_bitmap);
-		kfree(lpriv->vectors);
 	}
=20
 	free_percpu(imsic->lpriv);
@@ -501,7 +500,8 @@ static int __init imsic_local_init(void)
 	int cpu, i;
=20
 	/* Allocate per-CPU private state */
-	imsic->lpriv =3D alloc_percpu(typeof(*imsic->lpriv));
+	imsic->lpriv =3D __alloc_percpu(struct_size(imsic->lpriv, vectors, global->=
nr_ids + 1),
+				      __alignof__(*imsic->lpriv));
 	if (!imsic->lpriv)
 		return -ENOMEM;
=20
@@ -521,12 +521,6 @@ static int __init imsic_local_init(void)
 		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
 #endif
=20
-		/* Allocate vector array */
-		lpriv->vectors =3D kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
-					 GFP_KERNEL);
-		if (!lpriv->vectors)
-			goto fail_local_cleanup;
-
 		/* Setup vector array */
 		for (i =3D 0; i <=3D global->nr_ids; i++) {
 			vec =3D &lpriv->vectors[i];
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
index 57f9519..196457f 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -40,7 +40,7 @@ struct imsic_local_priv {
 #endif
=20
 	/* Local vector table */
-	struct imsic_vector			*vectors;
+	struct imsic_vector			vectors[];
 };
=20
 struct imsic_priv {

