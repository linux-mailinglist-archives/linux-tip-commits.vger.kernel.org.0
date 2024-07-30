Return-Path: <linux-tip-commits+bounces-1848-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B89410E7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC97B26931
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7411A255E;
	Tue, 30 Jul 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEQdGbXL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKPeAo1H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6D1A00F7;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339611; cv=none; b=G2x91ozoBLsQvywkL6y6PXUf+ma06OPVNokCjDsFXZOHuUGV6s0tXVU8Vm9lddhxuICPY4yFfVAI29u/jlohG+XQ8sOM4llO/RzHbEDVjMshDAwyFoI/2itzsWtn3KyBSm2N0aDOvo8KgGPCMkDaWs8kT/3Qf/pl2Ufe5RZd0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339611; c=relaxed/simple;
	bh=5qe+hErE2DgotsbKf5fMv1bwrwSJ2po3OL+krSagorE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FsvSnqg2aC/G+8CO8lPxyfW2kghbTh00L5ZTdUy76YQ28F+uFO2WK+EmSQCRlARdM9+CPGmeXhjCENXSFttRBHFx6Kszn80vKJNhR6xTPgjrb022/bXKCSRcqWsymyVzBsjPL86eoYrA4oiyj/e7xsgZ2Lg5ydkynLO9+mItkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEQdGbXL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKPeAo1H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpZ+5cF90+OGOJWS0b6zDo0zgnTunlKxPWMm6wOAVEo=;
	b=fEQdGbXLe0BLIpNxXTeWzfBqXUiKsZF+SLGSX158I/323blJ+fCJ7uEAC5fI5ctzwx7ssH
	5ib0XiVIlCD42CRKVkVJhIr5tZJHcRKOPxrg8s8FtFmZzjBqgI1eloBjYV/aZLA747M3hJ
	PrBRX7NnbUoFfTKKqPl49JYw1ckkJgBl5q7iPTevxhv6WQqDsHd7pRT7kVPyIpkwuu//YD
	MBObYM3IT1+T3DHKKsZ41pFjAXMjetx4U15YfzELY963XaZU0hqy3yw1bvtqvHT3lkp1iT
	RuOZdVIWpIUgVv/ICGsdHpW9zpm+daeM/n2EBpmaFzbF56YTBt8f9utyr+BwWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpZ+5cF90+OGOJWS0b6zDo0zgnTunlKxPWMm6wOAVEo=;
	b=GKPeAo1HmmA1fgoN+GN5iZMX+Agpx5M8PV8MUaPsjyaU1MOcMMrNv253wSW2bb046B/dn2
	RmL9DXk1XT96RvCg==
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
Message-ID: <172233960182.2215.12604664156014843719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e4cd7c553a00e2904689cac543e314b1962c6a8e
Gitweb:        https://git.kernel.org/tip/e4cd7c553a00e2904689cac543e314b1962=
c6a8e
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

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

