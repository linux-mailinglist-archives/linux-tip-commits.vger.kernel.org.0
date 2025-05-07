Return-Path: <linux-tip-commits+bounces-5381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64844AADAD0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298D77B6F99
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0D6236A73;
	Wed,  7 May 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXduzSHp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4mSh7QQF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A2235C17;
	Wed,  7 May 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608850; cv=none; b=Gw9DsloYOXaBYipF8v1XfSd4wDeFOw2QN3hdhZLtsG830lq1qGblkMIeraJ79OqqeYhbgtCGFRcteQFfBxN5wNPCi0aeNSbeH06MPwzx7Cq1tY3ipFeAYB4V9gFah+z8TYBdFbHVzqWUkYZFvV3sd5kU9hBUFUMmUNazDBeL0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608850; c=relaxed/simple;
	bh=hb47DFNQ63KCp6MZapCmjKqysYvANQa9BTiv7W5Gpp4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iQ9JVKRBBrlU4WaDBRyuj72B2N7V4sfMlqXMM1AZ9t3zfTCkq02SLcPVgY27z4bGx/+W1O8rDCDqI0LkadvxLpnomAuHw76rRlq5yUuU/PjPrURM6hVi3bCyWiyL7Iw+olNvku1vt9Podm/lO9mmPuZAZ8tnCE3wbJaFV8UW9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXduzSHp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4mSh7QQF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RadFN6TnGytOv2rQfnYhC47GZenBC2PS4rErDywVLWU=;
	b=eXduzSHpwuf9PX2sfiQB/8sxm+CXvzD2i2rVKR2z2uIAlUptX9jbQ/WurTyiIQyUuQqLVc
	F8yP7XaCS6aNP3pkNRUhWjHYuSS5xk0hzDdicGQqUEmgZlEyfctL0AlFu4gT6fvlqNz3JO
	IRyZAZST54XNO48UcwMRZurnbMKWSz7bl7ICr+m92MB/mwLMsNICvXTxjmmta0PfznkiNX
	tYhjnOVdA8Dt5qC6mb3lIHo1hokPVECizd0Ln2cacdiHUUqsMela/91JZ4zoe+jTGonaTa
	tAIzycuiB7LawaaWWUZUk8NXNK5kd+jqabuIQoRixkcCSGPpUKzTTIbJu421Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RadFN6TnGytOv2rQfnYhC47GZenBC2PS4rErDywVLWU=;
	b=4mSh7QQFNDUCfI2eqQlogEFQbEd0yraPwTmV3y6BnYJV2naYQb0xmYoeh2A1KVxih0qhP3
	0MKdGoS7v6sH+BAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework __disable_irq_nosync()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.013088277@linutronix.de>
References: <20250429065422.013088277@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884670.406.17519050300534702759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1b74444467240d9ff11cf109efdfb2af2f0b60c7
Gitweb:        https://git.kernel.org/tip/1b74444467240d9ff11cf109efdfb2af2f0b60c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework __disable_irq_nosync()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.013088277@linutronix.de


---
 kernel/irq/manage.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c18440d..edc8118 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -659,14 +659,11 @@ void __disable_irq(struct irq_desc *desc)
 
 static int __disable_irq_nosync(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
-
-	if (!desc)
-		return -EINVAL;
-	__disable_irq(desc);
-	irq_put_desc_busunlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		__disable_irq(scoped_irqdesc);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 /**

