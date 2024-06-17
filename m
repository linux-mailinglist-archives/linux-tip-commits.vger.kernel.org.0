Return-Path: <linux-tip-commits+bounces-1415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DBD90B2C4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4A71F2680B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1F91D5402;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUOyHzHz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuTDPtfi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A6C200113;
	Mon, 17 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632278; cv=none; b=nJ7bc3TiSx+vkSYvuby8nE6WPPjMRAVJkAIaOe7ElDuDELf4o3t2a8Mz9Zb5zCEFbrj0gVdhZQSATFAQefBUgPOwrXikYadt6DIiaiXPhPNJ6N48W7Gn/CC+LSkpP35ll8hQeGhlahIGWVYBZsfAcwSCo9mV9wRsfSvn+Wa3b7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632278; c=relaxed/simple;
	bh=YGHr0fBHq1X6VbqwPCnxNVJC5dGoh5maAoGxqeFyXhc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FfA2wElAJnny90ddcwv4w/Zs1NbsYveR5AGMWJcbkfoD12XnkO0rKWgzVGfIrGbMcxabwL49IYDdDJ7LC5/CTxnIyA3ebzWAr6zocUp6COVilxyA5LKyy4zmbiA9Vh2jlJzH4yn5hO2Q31URpHRwXfWeLuvu1SM5bbelLsaa7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUOyHzHz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KuTDPtfi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlytCrJMi8BjIN4si29WfH5a+g2VcfqrTF6aCRS7TqY=;
	b=AUOyHzHzjwzEVCaCTSzepet3jVJc1FcNIupcFJ8JMs1jkfaKm9PmUg/opEA4+MU7u9pKGH
	IYJmEqMiufCMYpbCx+jiAqWhw1noTrxZVFITLsCJveArPwnbecwjz+eAR9/2kdZzdvqJbF
	dhSD6QUxnFu6jv8DaD0ajjJ7FT0zf1K69koEYnPM08ikXOw5W5rvDAAomSfISN87AKltmL
	4pedjn47nMAcuflCxGi9JCGuPp0SaE5HdrX4ZTBkSXlLz68iMYssSTOpJXWO/s05E08C5v
	oUb6blOnc9+dc/xeOZrHADjOjazhnNXOKBlnw9Urs5qRIIcxMbVO6vC0yHkHQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlytCrJMi8BjIN4si29WfH5a+g2VcfqrTF6aCRS7TqY=;
	b=KuTDPtfisf4iPap6kPh42CPh9S/+vKIERV0ayF9Yv1r+NOW/KyONDQE2ASkzyq+Vul22lk
	gTVR7XLHlNu1QKDw==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Use irq_domain_instantiate() for hierarchy
 domain creation
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-10-herve.codina@bootlin.com>
References: <20240614173232.1184015-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227170.10875.4428200346359944530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b986055dd04141efd6d5dcdacd48d6b38cf320c8
Gitweb:        https://git.kernel.org/tip/b986055dd04141efd6d5dcdacd48d6b38cf320c8
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Use irq_domain_instantiate() for hierarchy domain creation

irq_domain_instantiate() handles all needs to be used in
irq_domain_create_hierarchy()

Avoid code duplication and use directly irq_domain_instantiate() for
hierarchy domain creation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-10-herve.codina@bootlin.com

---
 kernel/irq/irqdomain.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1269a81..8dc0007 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1213,23 +1213,16 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		.hwirq_max	= size,
 		.ops		= ops,
 		.host_data	= host_data,
+		.domain_flags	= flags,
+		.parent		= parent,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *d;
 
 	if (!info.size)
 		info.hwirq_max = ~0U;
 
-	domain = __irq_domain_create(&info);
-	if (domain) {
-		if (parent)
-			domain->root = parent->root;
-		domain->parent = parent;
-		domain->flags |= flags;
-
-		__irq_domain_publish(domain);
-	}
-
-	return domain;
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_hierarchy);
 

