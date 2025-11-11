Return-Path: <linux-tip-commits+bounces-7313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF0C4FD8B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426D23BA25D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C12735C1A0;
	Tue, 11 Nov 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4lUezpm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOb+vbNZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D7352F95;
	Tue, 11 Nov 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896198; cv=none; b=Fxb0ecAtacxM0DqM0zP6j6xV4Qzw5xOJHXhVWTRN9NAWlSGeLNRFGlbHzCNkiJQiIyjdAUJKYIfR27gr0M9hjJyL5dr+1BPXImWVV/JBUYWvJGXJtfQ5TeAggBvFONB7UGSTafII5WUzkZv0jR5F27F9ukPdw6a+kyClogWhT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896198; c=relaxed/simple;
	bh=MHYjya9m/0kaJDtWUZn8pE6L2T5DulI55Y27mBaNOSw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hDymDUknkznrpQDm+RMJprDhm2LO/gAqatP1gF/dCkmHQBsuXBcLi3cv0BWqZlcB2JonHnJ2hQg1pbqlydEtqAgwOoe/dqZG7mvRxl9HEhJs6Ob37xxKJl0bp1sBc6w/1OmQ1JghnVFzTywHHQO9zIW+IKG65+Cp0CtP4BiiivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4lUezpm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOb+vbNZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762896194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4e0tF7nWBfS0zN7OPRBSJu6fPTwma8m2bt1DLcZZM=;
	b=g4lUezpm8w0ayjAEzb3GMakRnL+exCEALhvaWqwgMt1QoOcDmGaCyU8mFdEJ+9xvKKHCEf
	YtECur+G//I9UFDzEzE8wh3Ylo/kke32Q4dv1i5isDRuHOfeAhLsbE5m4C/c8aKkShRf5G
	HrjmQYlWYF4hLxeLyUs/lzUvcWLdrALC5DdJIvd29yR7NlPqgPsRRCNLXrs1a9ikvnd+gU
	JGiaHahjOu5MX74GNwrnjnmvfcy3GpHi8J2qwV5RU1W90T1p/2CSm8K0DVct0j65Eze6Xx
	ymOSKy9AtVx+KyI2iys22F2OKYZCaJi/dTNMDRlUjF9yHro5NDcnMbPOcZSqSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762896194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Z4e0tF7nWBfS0zN7OPRBSJu6fPTwma8m2bt1DLcZZM=;
	b=bOb+vbNZslbU6tHcR1MyiVV9QmaynlO7vPZQjNGfsQ4hzybj2frzK3UMF5xV7TX4ZhgCSD
	0RSjRsw8cIGzxuCw==
From: "tip-bot2 for Junhui Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aclint-sswi: Add Nuclei UX900 support
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251021-dr1v90-basic-dt-v3-9-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-9-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289619345.498.13373215560399976937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     47a4ebbf91d31782113e7def707b53953bae3050
Gitweb:        https://git.kernel.org/tip/47a4ebbf91d31782113e7def707b53953ba=
e3050
Author:        Junhui Liu <junhui.liu@pigmoral.tech>
AuthorDate:    Tue, 21 Oct 2025 17:41:44 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:17:22 +01:00

irqchip/aclint-sswi: Add Nuclei UX900 support

Reuse the generic ACLINT SSWI probe for Nuclei UX900 since it is
compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251021-dr1v90-basic-dt-v3-9-5478db4f664a@pig=
moral.tech
---
 drivers/irqchip/irq-aclint-sswi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-s=
swi.c
index 93e28e9..fee30f3 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -175,7 +175,8 @@ static int __init generic_aclint_sswi_early_probe(struct =
device_node *node,
 {
 	return generic_aclint_sswi_probe(&node->fwnode);
 }
-IRQCHIP_DECLARE(generic_aclint_sswi, "mips,p8700-aclint-sswi", generic_aclin=
t_sswi_early_probe);
+IRQCHIP_DECLARE(mips_p8700_sswi, "mips,p8700-aclint-sswi", generic_aclint_ss=
wi_early_probe);
+IRQCHIP_DECLARE(nuclei_ux900_sswi, "nuclei,ux900-aclint-sswi", generic_aclin=
t_sswi_early_probe);
=20
 /* THEAD variant */
 #define THEAD_C9XX_CSR_SXSTATUS			0x5c0

