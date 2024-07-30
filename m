Return-Path: <linux-tip-commits+bounces-1845-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3229410E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEBF2840CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BB1A0B07;
	Tue, 30 Jul 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFwLkjY6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HxF3Fo9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3F1A01DB;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339610; cv=none; b=auW3e32zio9lFNHusDK1b0ZglLY2QKnyZoXguI78YcMb9ape/4yQmJeMJEshy+aIo8yDtCLVlk0A39fBPIJfFGWsRkrM0ZlsdDcsbVw0KL3F8eRQY0UDtQ1QsPiVxXDzMfX3N2su+9UPWTF8RAAPBbrPWgP6qPXFRNrDVbf3aaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339610; c=relaxed/simple;
	bh=oSBQXs7rweBzQxXmJzvZTl1gDrAyiCeTzd4R/HiKQVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vzk9VXmQe5qz/FWeAJ9QTENvJ1BiNYAfVtaHBU+9LJ9+i5ESO/xEuSJwpTdVcz9IGxHveIz9uHbP3sKCfaouEUr7kwileLqLTEh4orNjEajEo9pA/tOxMxwgF2O2Lsz127Z8Wq3NT3Cn7qrN39PmGBbb2kfiJxIt1h/JVH8oDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFwLkjY6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HxF3Fo9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCS/N2+BNtM3N2oceOYLv/dtrbKp6NHpXmZtJD0CIcU=;
	b=zFwLkjY6Id2A7y8qbSiEFsyKL+jm0jAql896ksT/zNhAvVAyAohtYZfsqq4gtyL75v7jhB
	ww8yOi4XJ7ihSWzuafepBLkRuwQ5JCj4COtneKpPCSg1OZdEECKVzYXFT/g69c5niaZCoh
	VCXwLBHgYLtt5feq+cLfT01H1EEWJFLEIyNuxnymVDnDBKAFjQPZY91OsLFjM2YCKSRSXu
	g2TksJxxEACxDlqHBTSB2ctRXqVPFB1IlLoKo4vrW57Q1OvmacUizSQ0epCXcQnVPQnPhq
	en7WLm9qNEtyjs1Tg07LmvhYFWiVqIlfypBjoLXUIWMXoKkvppDXaVHjnPzerA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCS/N2+BNtM3N2oceOYLv/dtrbKp6NHpXmZtJD0CIcU=;
	b=HxF3Fo9HDYTqI6lZ3+ETOzw8UzM+WR0mhAu8AttrQXLGDQ9K1AT36CDSTedqr3apvhMZ7b
	fg0riUxGvKgH1XDw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/armada-370-xp: Use correct type for cpu variable
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-8-kabel@kernel.org>
References: <20240708151801.11592-8-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960315.2215.8703054499234258541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0cbbf7c15d197ac370387c08d900abe142153cd3
Gitweb:        https://git.kernel.org/tip/0cbbf7c15d197ac370387c08d900abe1421=
53cd3
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Use correct type for cpu variable

Use unsigned int instead of int for variable storing the cpu number.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/all/20240708151801.11592-8-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 8f52de6..b9631cc 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -409,7 +409,7 @@ static void armada_370_xp_ipi_send_mask(struct irq_data *=
d,
 					const struct cpumask *mask)
 {
 	unsigned long map =3D 0;
-	int cpu;
+	unsigned int cpu;
=20
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -507,7 +507,7 @@ static int armada_xp_set_affinity(struct irq_data *d,
 				  const struct cpumask *mask_val, bool force)
 {
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
-	int cpu;
+	unsigned int cpu;
=20
 	/* Select a single core from the affinity mask which is online */
 	cpu =3D cpumask_any_and(mask_val, cpu_online_mask);

