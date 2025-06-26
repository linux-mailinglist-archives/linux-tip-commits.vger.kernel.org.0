Return-Path: <linux-tip-commits+bounces-5926-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E1AEA02B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A71188CBF3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDEE2E88AA;
	Thu, 26 Jun 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQHGMtEN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/M9oTpdK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51F2E7F18;
	Thu, 26 Jun 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947189; cv=none; b=f5qoCPQpCgpvUoNsQnyZM/rv00IEY09Sf0+S9BHqEtfC8r83H6Ms91+kLnPreWR2IOVIiGPrgAUs9vmmt1S2TsFN5z07i1hwelyaxR7cW7LYekasKwOlp/xpwF5vim2eIP2Sw+ip450oLGm7Gg3avPD916HkpVSK/CQtS1MCHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947189; c=relaxed/simple;
	bh=6bcJtgnt+bBitb7mb1j/GXyO6o75qKntV8XE5Kk88s0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YuO/DAALuiu9egCgtQip+ptlIBco6sLoLnyiDhcFGiKrLJbKS3k3i5Fi2BCbki8COwGWSL03OboP871dvBUruNeCZdRKiq2P/aDJMhBwGdoqvC3X1tSSJ2LGK9wYXCr0d44eiv0LwjeFJ8/h26bFTiMMtfwilDTDFEjqERDpT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQHGMtEN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/M9oTpdK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APStUA87UG+HzOqpiomT3VrQOZZq7CYgRGaMydPIVqw=;
	b=SQHGMtEN5C9CtFuJGOhz9lPOB2+L7IfsiD4u9fTYaJgyYvRSDYz0h0wjEXQqDyWhNUGXgE
	qdnVW88EsT5hsnPOMSUDF5WXZHUzrYtNLir9yzkuprPAmJCIU0CyYE/qiEhokcotKR9vw7
	pzi0Vez4348OghdC7bF7AZryjjarEwxpeERIeBKK1NLjm+tD5UmreKEirpvR5oBCoFwGL4
	9Bdcydgz/1yrL/9FA7RmVbuDIe9B1rUNE0pFpTXKQub0ZwyRv0bO+u7tpll5hQ+9ZzKoZI
	jM8fTS3QdAVAf2NIFgZQixzpCwQe/0oYYGEHX5BYuyTrnejgmZnOJu2apUcINQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APStUA87UG+HzOqpiomT3VrQOZZq7CYgRGaMydPIVqw=;
	b=/M9oTpdKAIB/kWSQFk3aJZ6tzIyXkQBTv/JmyqIkxF5+VtbYk6nIwHB4Cfb3EhuLO2UXv+
	uRiZRYX8tHxhJECQ==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aclint-sswi: Reduce data scope
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-7-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-7-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094718542.406.17103367903859471912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c8c8443a64a186df0508c709d51fe9c7db0b5d55
Gitweb:        https://git.kernel.org/tip/c8c8443a64a186df0508c709d51fe9c7db0b5d55
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:10 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

irqchip/aclint-sswi: Reduce data scope

Move variables to the innermost scope where they are used

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612143911.3224046-7-vladimir.kondratiev@mobileye.com

---
 drivers/irqchip/irq-aclint-sswi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-sswi.c
index d9f28c0..9d8b19b 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -61,18 +61,18 @@ static int aclint_sswi_dying_cpu(unsigned int cpu)
 
 static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode, void __iomem *reg)
 {
-	struct of_phandle_args parent;
-	unsigned long hartid;
-	u32 contexts, i;
-	int rc, cpu;
+	u32 contexts = of_irq_count(to_of_node(fwnode));
 
-	contexts = of_irq_count(to_of_node(fwnode));
 	if (!(contexts)) {
 		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < contexts; i++) {
+	for (u32 i = 0; i < contexts; i++) {
+		struct of_phandle_args parent;
+		unsigned long hartid;
+		int rc, cpu;
+
 		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
 		if (rc)
 			return rc;

