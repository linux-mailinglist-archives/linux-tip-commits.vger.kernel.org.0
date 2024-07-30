Return-Path: <linux-tip-commits+bounces-1821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC49410BD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638371F2276F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1FA19B3F9;
	Tue, 30 Jul 2024 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z133id/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbz+1Ukz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC612DD88;
	Tue, 30 Jul 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339601; cv=none; b=dqCzJXZhhT9NPh/u+eZuphSiy/UYZD0Ou1wmUyChwEa0cThR70BA8rLPb9Ya+IHaMndFM5CHlLEMWTDfYrT2euZYyGb+2MqZXTByJT6LUhOdiN1/LDc7660R/0+28o55wvdJGdIgLZjP3KDJ4cHjKmMwESXtA2mViukYYyfkO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339601; c=relaxed/simple;
	bh=LZPxAO5aq+ZFDe0vDdIS3xzrtNpvKIF7DJj2zJh3Y0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c6PL99Zx7IwLs069FNcyKhjdBXM/qMN9tcKm/QyjWxe55G8ZjZvkKK5BMCZ51dSmAZBSu5GvhCAkta80nr+gNRvDtI3G9nmWxi3hLCcdY2XZzSjw4TktfP56QpwB15LHK95jBVKqC9Q17ondZyeMgUyxHyDP2Kt/WxnqRnf+t9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z133id/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbz+1Ukz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exsUMXaVc7HrP9dtiNsP4jvkDQ8Y8nKYFhQivPEv8ZE=;
	b=Z133id/ZQwFkdbkbwqFNhnxOwasmluVfQvrMto9WTSC1CLIgUM9JfYk6nY0QVmSxWpY1uf
	nrUdBeBluzD1g9BYXJn6UtmoEk69J9wDpI5W+ht9sRukH0+qQZby2XjzdfOBNhqNH+6S8/
	Xv9FFlOzI9Ap+pV4Q/x6Z0em/1/W1g23bHhi6n7BP4hoYfR02FGuF191NZzCH2ol7vyS2b
	z+u1UKEebXe9yO2YM1L7DlvTqcaxx/LqOuK6KNxdnvZPCbpbhr9oXoJn7biRzEe5OSla2L
	Ol/npSd16ubtlBEgCre0I4GGMSVzop3OJ8n5FLrR6uikqmPAWJGWk/L6vw7/dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exsUMXaVc7HrP9dtiNsP4jvkDQ8Y8nKYFhQivPEv8ZE=;
	b=hbz+1UkzJkuCjfpOtlFcmXB3jJ2yiLyQTVPCauLWlUDFwU87RMD2JEKhkwm69X8v/eIbLb
	JJW9z8gJ9XblwpDA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use u32 type instead of
 unsigned long where possieble
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-9-kabel@kernel.org>
References: <20240711160907.31012-9-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959804.2215.4929446320859542665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     625f0582f05d1f496ecd598323df1c8bfcdcbd6f
Gitweb:        https://git.kernel.org/tip/625f0582f05d1f496ecd598323df1c8bfcd=
cbd6f
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Use u32 type instead of unsigned long where possieble

For consistency across the driver, use the u32 type instead of unsigned
long for holding register values and return value of cpu_logical_map().

One exception is when the variable is referenced for passing into
for_each_set_bit(), in which case it has to be unsigned long.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-9-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 5cde229..8b28188 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -357,7 +357,7 @@ static inline int mpic_msi_init(struct device_node *node,
=20
 static void mpic_perf_init(void)
 {
-	unsigned long cpuid;
+	u32 cpuid;
=20
 	/*
 	 * This Performance Counter Overflow interrupt is specific for
@@ -396,8 +396,8 @@ static void mpic_ipi_unmask(struct irq_data *d)
=20
 static void mpic_ipi_send_mask(struct irq_data *d, const struct cpumask *mas=
k)
 {
-	unsigned long map =3D 0;
 	unsigned int cpu;
+	u32 map =3D 0;
=20
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -633,7 +633,8 @@ static inline void mpic_handle_ipi_irq(void) {}
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long cause, irqsrc, cpuid;
+	unsigned long cause;
+	u32 irqsrc, cpuid;
 	irq_hw_number_t i;
=20
 	chained_irq_enter(chip, desc);

