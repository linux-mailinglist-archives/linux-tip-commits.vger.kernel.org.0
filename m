Return-Path: <linux-tip-commits+bounces-6332-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234AB32F06
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 12:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127BA1B62264
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 10:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C44247299;
	Sun, 24 Aug 2025 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F63WCZKy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhp0ZKlV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447C21ABAE;
	Sun, 24 Aug 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756031624; cv=none; b=t7S8TU3XRKq7bM8MIc0POKelhr1LMMJqGAMixX925VbKZfZZ1iMhY46K3sRdeNZej6T2DpPHt2GG952Xi3ggQDgGvVXZtsgfVuBg7eEtaYZkb3TsH5UM8pVntbhaQBZkPGg+mRrTl/lMO/BQyo1xexILg+4O+vLeFQApq8nR2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756031624; c=relaxed/simple;
	bh=GzKB6pgteqUBRrLK1lb+NTiPkkGaS3hpFo2gZCZHGtk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F1fxNdPyIyuaCwmDEc6ACwmzA21DH8ZP4dSPFHWFg4e2noXY02FOAaJD5nYFXqASzn9DjwPvXc1NpWsDG1Tw1LaabhxrmbzPp9S/rmADYQg4R/hAxRLcJagWQCYWUstP+7NQRaC7SfvhXdCqoBHx6TqXkPBHU2DeZEtaUZRyb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F63WCZKy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhp0ZKlV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 10:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756031621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7AUeVbL8GigkFEdVWdjNPYVQn49zJLQABHK2a32law=;
	b=F63WCZKys8JBFtobM8nEZLs+HCQZ4zEhYD5rJN6KmebmXgqBvTpeGCK1u39wxcQBYBNATi
	caZ5y8mzCaVYs+oKAOOI+Ckv4TsaQ/m4JHSdytfYTHhaUP0fPH/WUWneSMznq5JAqdPYII
	fT0JY9YlYRXc3WJKCXHOBRc/8V5RG0+LIvBqEStPqburwwzFDRtO7MBlEccn5Y+I4NQ0M3
	NC3jEMWtSAbcAjV9yElnVh2FERxiFuO+sMgeE1TrlmfMSBcyqre6bBk6Vhsb4ZztAgIycH
	UmAzkBazs0fazdU8OnfSYqD2/SCFaL0JNixrkxmza0aLDKcAHi97aSRz9uaQlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756031621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7AUeVbL8GigkFEdVWdjNPYVQn49zJLQABHK2a32law=;
	b=vhp0ZKlVE03yf329G+oO6DU9VqbugPZDmbIjidm51k+adN+ETPrw6My5An0nwvXeQiP4zr
	hbL8R4ltEl02cgCg==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sifive-plic: Respect mask state when
 setting affinity
Cc: Thomas Gleixner <tglx@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>,
 Nam Cao <namcao@linutronix.de>, Chen Wang <unicorn_wang@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811002633.55275-1-inochiama@gmail.com>
References: <20250811002633.55275-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603161961.1420.8026332855142123938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     adecf78df945f4c7a1d29111b0002827f487df51
Gitweb:        https://git.kernel.org/tip/adecf78df945f4c7a1d29111b0002827f48=
7df51
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Mon, 11 Aug 2025 08:26:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:20:18 +02:00

irqchip/sifive-plic: Respect mask state when setting affinity

plic_set_affinity() always calls plic_irq_enable(), which clears up the
priority setting even the interrupt is only masked. This unmasks the
interrupt unexpectly.

Replace the plic_irq_enable/disable() with plic_irq_toggle() to avoid
changing the priority setting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de> # VisionFive 2
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250811002633.55275-1-inochiama@gmail.com
Link: https://lore.kernel.org/lkml/20250722224513.22125-1-inochiama@gmail.com/
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 3de5460..559fda8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -179,12 +179,14 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
-	plic_irq_disable(d);
+	/* Invalidate the original routing entry */
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
+	/* Setting the new routing entry if irq is enabled */
 	if (!irqd_irq_disabled(d))
-		plic_irq_enable(d);
+		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
=20
 	return IRQ_SET_MASK_OK_DONE;
 }

