Return-Path: <linux-tip-commits+bounces-1826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4761D9410C8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782DA1C23546
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994919FA87;
	Tue, 30 Jul 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v/TqCyST";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6MVpwxAH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129419EEA9;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339604; cv=none; b=N8h6n4zZfM3pft8Yj46CyNavib0LH/XzZVJ2uP6SRTYsf8PHbuPVmE9lB8+wwGYsBZ6YOXx9Dwx1QCJmxcXIHdZzMVEHQ32GYtHS9Ck/nPm/hHLMD23dKrNrmyJ4O1q9MYSSv7nduZIveN0CLfdq0Gh5xHXd8D4/itH/LGWHeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339604; c=relaxed/simple;
	bh=n4i0Br4J8+W98Gn8vpOYYzPLP3Ekli37oYWNEYeY2DM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UwF4GCVcAdxWG65PNQQZe1AUymApvWsaDTPjearklcyHWS6C4eOXQdgXz6FkKM4YQr8dITguRKFIQU2cDy5tVAaoNaePJiD9EzGYXCQp1lbKSjg6o9I/UKy+kagQcQ1LogTnRrvvE/VIqXKsZngTlNyIrJRmbmeyClJomDa/MZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v/TqCyST; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6MVpwxAH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8sxi6i9MW9pd1o39m2yaZtmVpFMRBFOWQslKXBhbSs=;
	b=v/TqCySTMKHIJriLMRGBwp1Njin2tlrdEVw1GHKEhf65P7hxFvcEN5XKlRZP68ahq1ruGG
	whmjCr3M9iuakhLA+3EEMezk3zmSZA10Edx+xL3RM2cPtrQK3c4JpwXsx0+Urw0IglRfor
	fsqloP++MZURrKmiP/E18kCpfVuhss/Z0nDFMOiPLFRvL1eTM+05mFUq7Tmnc84hKVUHx4
	eZnU91mzoDgQlRsb1dbkrOUoMgzJ6tguf1QmOoSxlZOd7TpQWNgGZ0B7sk9tBPQcNftvLz
	MJOYFM67Br54nSiAfI6vzsrvzbRYL0zyC0ClIE7PDhc3wEgrA2ANnwuuVv38mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8sxi6i9MW9pd1o39m2yaZtmVpFMRBFOWQslKXBhbSs=;
	b=6MVpwxAHuek8NSxEhKSUg6DOmtq/CUeuh6TvE2dks6rkLjYLvtpvMPmcEMfkxRG53VcFUY
	XB0sGjKQ1CzMY5Cw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Simplify
 mpic_reenable_percpu() and mpic_resume()
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-5-kabel@kernel.org>
References: <20240711160907.31012-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959879.2215.15446908449735249182.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     15a50eeaadc169243b00ec90087f689a8a28848e
Gitweb:        https://git.kernel.org/tip/15a50eeaadc169243b00ec90087f689a8a2=
8848e
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Simplify mpic_reenable_percpu() and mpic_resume()

Refactor the mpic_reenable_percpu() and mpic_resume() functions to make
them a little bit simpler.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-5-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 98f90a3..66e14f1 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -517,18 +517,13 @@ static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic_domain, i);
 		struct irq_data *d;
-		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(mpic_domain, i);
-		if (!virq)
+		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
=20
 		d =3D irq_get_irq_data(virq);
-
-		if (!irq_percpu_is_enabled(virq))
-			continue;
-
 		mpic_irq_unmask(d);
 	}
=20
@@ -706,10 +701,9 @@ static void mpic_resume(void)
=20
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic_domain, i);
 		struct irq_data *d;
-		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(mpic_domain, i);
 		if (!virq)
 			continue;
=20

