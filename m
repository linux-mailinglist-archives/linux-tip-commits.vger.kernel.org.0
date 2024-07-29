Return-Path: <linux-tip-commits+bounces-1773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41693F1B6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7031F23B2C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F7145FFC;
	Mon, 29 Jul 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwnV+Z3D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juibbRt9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F914535C;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246592; cv=none; b=Kxi7KJggEBnJX7Rix7WgbHScUL98ZMK+2rBH5nTmmSEiQHt9a50NEML1wtp9+Qx+D9rXpo2Gb9zakRX2TjPGDeEVFgTOG4IouqKi/ZnAvSjbdiAP3Pr7gPTg5auv8IMsREgAtsW84x4Y6tf3rQTBL7JZMuPDs6tw9i2xB1x7Ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246592; c=relaxed/simple;
	bh=yKalEnWySj2IVdnPBTtJBnnFZpE8UV+hzjrCOdCgazg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DeSolySvgnlmaCvrp3sup9aiR2OkpCvwNg+Jrc4fdTyIJg4wh6Mr/GWk0eTEo64fGIhuTzCbXw3dQYEtlKVrPU9lkxZmgmX2F6j6HIfOCceORN87cB+8ZTNKhs6IFSAgAWtw+S4kjwYw6BHQ5Zgi40Wn+YUjUit7H81RgrKQtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwnV+Z3D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juibbRt9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jE15wW6ujJnTvbAfItlzMtNDGHQQXqOtyNP8CxI8zpk=;
	b=JwnV+Z3D7p2YtyodXdUdl8MwSz+hzgDCZoexlhzws4iccjOwWIFBH6okizvG/oKzdVNQmI
	ZBFkjrVINTKBlK/cAGXXeNdNV11IWDRGz1rm82wHZcO6E5GA+2wLdn15hhsaiBvg2RouBp
	n9cHyxyYvDUD2z3ya0DDpd7kU1xK/ZUyb3q1uHWILP4klYhWKX8haR8JLUxRwQxmRbwhKW
	cGjzvW7MW+iCf33n8CPvWs3WzEzUvVdH/LRVLIwTwv7b26p/INIyKyWra447bsCMXdJnwQ
	vIVWjwEocr1UWWbFGm7Ib3HjgkeNI/vtHmYaTJq1UcswPxuWxlCje4q3YBB2JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jE15wW6ujJnTvbAfItlzMtNDGHQQXqOtyNP8CxI8zpk=;
	b=juibbRt9QwaWbtGxePG6p7mYj2iwyNmscrr4sLAFtbcOEMblPu4noyPERXS+H9fvVEhuJN
	Gl41MnfA5dxmgFAA==
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
Message-ID: <172224658628.2215.14563267430930585085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     dc778d7994e9f64294afce8ab31dedf74560b6c7
Gitweb:        https://git.kernel.org/tip/dc778d7994e9f64294afce8ab31dedf7456=
0b6c7
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

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

