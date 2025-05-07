Return-Path: <linux-tip-commits+bounces-5375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BF8AADAC2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829C71BC2AB1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96CF233726;
	Wed,  7 May 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1C5asD9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjhqRq0j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5B23237C;
	Wed,  7 May 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608846; cv=none; b=H7t0nWe2pFVzpOCALd5NHV1ztYHo4hY2gkqGFdnDWck8recmhQbOX52QlTHbxduLrMVkYviSXAOyeWPQ3SZ03rHxfzOH3gDdKvqwJei4GiaJ8X/qVnvmKX8AKGun6EzHvzjECvqIPYpxZEHWd6gVcZ/GsLkFx85F8s0XXdJeQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608846; c=relaxed/simple;
	bh=Hk7ao+3X4mf4YJDywz/n5Ji2VPY9xjXJye9n7xTYQxM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nb1JhjhBsqJg/Lyhhs4GvzBvpHM2hJ9xjgyfQdAtCLMKRMLbxpVrXMKbptTwcsneij4q1Fqi+1av0P9wvUF/gtt7/wgZEWWePW6BYsR0cIJnmwJHonA4ZqWZ2Tu1+e16oqTHjbMff+HK59B1QCUmPi8q/qnkLw2CRpiwrvH5FhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i1C5asD9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjhqRq0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bgjv2RY2XxTLWK83aELv013QolkTyfyBQSp0Gtwc/bk=;
	b=i1C5asD9W/3vJEuptn/q/+Uv6XxK8yFg/wHvnZuGmjZrYbiG8FPskXtSsCZukTtzzPeNf6
	2z2X8b+Olyz1lm0zrXAGLrPFmUk/E7zVbVtAF4+UccMI2Jyb+n9BlaPer5w3mpGMEvDQMc
	r1BeIo96DO7y8Z9E6caQreB/5hpxfaA61wYVG7iW9IcTUvOkqHV7cVgU00V778Y07DTdle
	aiqdWBjbgFYriFIrfZVnFyj7BoaHtEFojndN+a8KQ8z9rHkVXtKha0TGsGaHBYlAEwMs9F
	soC8w7z+Qr5lfjuNpwu3PT8pOs0vmP9gFyTg8TbI02bPZbANP0EQl9RP5pJH9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bgjv2RY2XxTLWK83aELv013QolkTyfyBQSp0Gtwc/bk=;
	b=gjhqRq0jFTqirdkeaWJnAD+0xE59sRx0N75ZBih534vbGoLWNrCCg+6jcvvGGqJs7bgG/I
	keKWjYJsCWcQvbBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_percpu_is_enabled()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.376836282@linutronix.de>
References: <20250429065422.376836282@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884255.406.15956923073834374847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b171f712d6ef1ae073d18e8ea9df1e96eb34f226
Gitweb:        https://git.kernel.org/tip/b171f712d6ef1ae073d18e8ea9df1e96eb34f226
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework irq_percpu_is_enabled()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.376836282@linutronix.de


---
 kernel/irq/manage.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e27fa4e..3a491c7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2322,19 +2322,9 @@ void enable_percpu_nmi(unsigned int irq, unsigned int type)
  */
 bool irq_percpu_is_enabled(unsigned int irq)
 {
-	unsigned int cpu = smp_processor_id();
-	struct irq_desc *desc;
-	unsigned long flags;
-	bool is_enabled;
-
-	desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
-	if (!desc)
-		return false;
-
-	is_enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
-	irq_put_desc_unlock(desc, flags);
-
-	return is_enabled;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU)
+		return cpumask_test_cpu(smp_processor_id(), scoped_irqdesc->percpu_enabled);
+	return false;
 }
 EXPORT_SYMBOL_GPL(irq_percpu_is_enabled);
 

