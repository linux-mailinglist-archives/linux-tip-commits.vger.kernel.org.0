Return-Path: <linux-tip-commits+bounces-2315-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E610598DF78
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A330B28261C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E222A1D0DD7;
	Wed,  2 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NjbJ5WH/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qjrctR8s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9823CE;
	Wed,  2 Oct 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883822; cv=none; b=pTh9931cqjW1XfNXDd+blhvv/33NsP+0eUoRpFJBwZJ5qB5DvmS77h6g9vnxvUCciV+b9soaxhGUt8D7tlg/fpJ5T+BPOcAwI7A+pq8QoRN/Y+GMV1n3SOocshpSJ7n59MuBTPzwrbP0bJjzWmB2ERKKNTMtATVT4ZQ3tczrd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883822; c=relaxed/simple;
	bh=n02VE0B01R/2Uvo02hQD7fRM+XquEyI9WYwn+zYDsPc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ahh+KJOccWo8/MQBrpCNfxPNw15WjRtXwca0xBci/0JBIGt0co03EA8HlCu9bR2P4U0hSEYwS8aZUpye9bAmsoVQNBJHjmXlKibp2J0svCgnJmphIcshG4TrYr90ORkXGmDhXyv6XxsSGX+ZJs1WKd0J24j9jTCEDY3gJwntLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NjbJ5WH/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qjrctR8s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSpqSYsQJjNbzWBQe2o/zGXerhC4nW5LBS+PHv2BpNk=;
	b=NjbJ5WH/2kt0Y5tmubAhHS4lbcQzTNPPa/MR+SOaZsYFLjLF/WGGnUVFrnG9bCpWp4+qIM
	lW9W2eWxiAdBJv8YxqfCbScW6jYQRKsP1n4slKXSWsVqmoIfocyL2wAqqs1C4wUsBYbETB
	CHA7C1XJ/HolhYINA8tRBCMpGvrDkwCjxVgxlpL7NabIWgvFzxP5FIIdOHbQwF4gc5fPhq
	D+OkXxCyKmlDslKbnTJMdAMpNc2SrRINnMXex6tXNQ2EE73wWS20yrb6FLv4qtjWGgzbwo
	4WcFVRG41l+qlpOaceXb6yRicdTTJe6BxY+E0nsoiD2/2ly85Fmv1REVMyuHLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSpqSYsQJjNbzWBQe2o/zGXerhC4nW5LBS+PHv2BpNk=;
	b=qjrctR8slmFEqUisDpKy1nkpTe8FgLB8UBI5ibzPmLwpyQidMWj4LTDVYkQSJFgKQDTyxP
	Gurv1QvlGg/cdTBA==
From: "tip-bot2 for Hongbo Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Make use of __assign_bit()
Cc: Hongbo Li <lihongbo22@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Palmer Dabbelt <palmer@rivosinc.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240902130824.2878644-1-lihongbo22@huawei.com>
References: <20240902130824.2878644-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788381757.1442.12089508423665995021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     40d7af5375a4e27d8576d9d11954ac213d06f09e
Gitweb:        https://git.kernel.org/tip/40d7af5375a4e27d8576d9d11954ac213d06f09e
Author:        Hongbo Li <lihongbo22@huawei.com>
AuthorDate:    Mon, 02 Sep 2024 21:08:24 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:39:39 +02:00

irqchip/sifive-plic: Make use of __assign_bit()

Replace the open coded

if (foo)
        __set_bit(n, bar);
    else
        __clear_bit(n, bar);

with __assign_bit(). No functional change intended.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20240902130824.2878644-1-lihongbo22@huawei.com

---
 drivers/irqchip/irq-sifive-plic.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f6ef5c..a3b199d 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -251,11 +251,10 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++)
-		if (readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID))
-			__set_bit(i, priv->prio_save);
-		else
-			__clear_bit(i, priv->prio_save);
+	for (i = 0; i < priv->nr_irqs; i++) {
+		__assign_bit(i, priv->prio_save,
+			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
+	}
 
 	for_each_cpu(cpu, cpu_present_mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);

