Return-Path: <linux-tip-commits+bounces-5925-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E534CAEA01B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E84E2DBB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A492E889F;
	Thu, 26 Jun 2025 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DK6IkNSg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+7i5CCCZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0122E1C6E;
	Thu, 26 Jun 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947188; cv=none; b=KmB0mMhQoG1oUDGz18HaLn7hD+yd5qk914AWgpk1HPXICUMaHNXoxdG0mXlHEv5AAfwwOxMiQt91VCjX+ZYqdksonpS+lANUcWsZ7SQB1hbaHk62NlwHYN56R9ZHhq1UYkD9VJFn3uUuHIMdgdF04W8XcCQJlmHNPV5/2Yy+Nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947188; c=relaxed/simple;
	bh=Absztsa7/XkzQNU68S8PrKCv1z22Tg6/MyELLt8fe6g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pNr4jXG6lTBidhY4MxJx5xgnvtEntZXelnksvrmEaceDs/vUnB5JBheAkQM0TpPsICzSrdg519KhMsJ8zf70oda608ZmDmyDmI23A0g46f57tH15CeS/56wxo9JEO4T01nkoqlbjZZEgo4zhewjE/FEmFkOIlfYt0IqMvVN085w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DK6IkNSg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+7i5CCCZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLXbbbGIbWJtoWchklgPW25YzsDHzONWgD75yAHzIFs=;
	b=DK6IkNSgJ6xivrXJo5/N/CEDOT8kboic7vvMZ+IFVAlcdMS0Zqe5dW5t2eIlOwdO750Pt4
	8oeZbXTsC0i/tfkclJvcr9RvF2OfU1V+BZOexUmjMc4oDnB/KjZnABZzhEwnouTneEwvLF
	F5YAEdsfv+WuRWed8y/wZQwYB7mwQrcVGizo2GunDu2aY+RDCODJVR9dcSEkWAVK/FqHSF
	GSyctAPTjQckkvTbIdNUI7sqHJ+TH35xZTDC+LJYaNmvLLGR4mv5sFisTxquMzhDG3v5Hc
	kLPqGXeXjw9wtzzLuZ794rbRLMbT4p/YAW9zQDV2cFwyddkg420Dd7KZHeHvEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLXbbbGIbWJtoWchklgPW25YzsDHzONWgD75yAHzIFs=;
	b=+7i5CCCZcvsBxIkVeBar4dnyWDT+AflrUmi8r4nQYjpiUSsgph5dRihjVT7SRNXm0DRa3a
	r52ouI7z9J/WG1BA==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aslint-sswi: Resolve hart index
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-6-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-6-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094718429.406.16067714715595873535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     128ab2cfd0205fe395196a9f3221bcddd6adf54e
Gitweb:        https://git.kernel.org/tip/128ab2cfd0205fe395196a9f3221bcddd6adf54e
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:09 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

irqchip/aslint-sswi: Resolve hart index

Resolve hart index according to assignment in the "riscv,hart-indexes"
property as defined in the specification [1]

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612143911.3224046-6-vladimir.kondratiev@mobileye.com
Link: https://github.com/riscvarchive/riscv-aclint [1]

---
 drivers/irqchip/irq-aclint-sswi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-sswi.c
index 9d8b19b..93e28e9 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -71,6 +71,7 @@ static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode, void __iom
 	for (u32 i = 0; i < contexts; i++) {
 		struct of_phandle_args parent;
 		unsigned long hartid;
+		u32 hart_index;
 		int rc, cpu;
 
 		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
@@ -86,6 +87,11 @@ static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode, void __iom
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 
+		rc = riscv_get_hart_index(fwnode, i, &hart_index);
+		if (rc) {
+			pr_warn("%pfwP: hart index [%d] not found\n", fwnode, i);
+			return -EINVAL;
+		}
 		per_cpu(sswi_cpu_regs, cpu) = reg + hart_index * 4;
 	}
 

