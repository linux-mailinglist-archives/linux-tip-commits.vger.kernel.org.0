Return-Path: <linux-tip-commits+bounces-3962-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F0A4ED34
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73C91890EE1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D65F25F7A8;
	Tue,  4 Mar 2025 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gropIrcf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+egllbR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294E255244;
	Tue,  4 Mar 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116224; cv=none; b=SgxTQN49NIB2yAcwBcJLs0/GkxFKOizj9siMBFjFbw3S2p3CbDlluQ5cKMpClftPaKt7CBqMJBzViObIgEdOLXqAPN28Th39BwfVpJd2zlqvi7S4HELdAzc/DIwQQZ6Hoj6HcRKrAEcrPTqpNZtJHUYXvR4A25vlBzREGqcKOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116224; c=relaxed/simple;
	bh=ECy34Gq9VbU3pNiLr/zhUl6oihQzqPecos/y0FC03C8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ooa+beRA9GVXKLVfeW20xJUuR0iRWWPc/vzGIYSGzYBCIAf3d1YaFmV3KN67Z2WcW2R/JNCqybIymv+/bmWOSyh06X93dIgyNVHinFXMQCLkfg+v7FpGxDQMP4d/bAA3tWmM+WvDkSdP87YGK+l+6rdk7NcyITFsBxratwPK5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gropIrcf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+egllbR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYRGUq2j8u/s74u9ZvI4O1PZlDtHWbL5tuQCp8Qf2f0=;
	b=gropIrcfy4B1SS6xYmmI91NuvWkB1w2G5Gl7vifpEVwr2vftgXqmO89WtUP9je/HVD+vGE
	kvy2PwqC73x0s815JGwbeOdnT8eTvB7tQ+/mYRMJc6qpR3QNoXb68NSDs5B4rt2PmjI0fz
	385hw+Fskgiu3VfvMm+qJEjcZ4f2Mohz3pv2aBvijc0MQd2n2T2lGt2DoINb5JSvFsdM6C
	+Mq3UeDqsVbGi2hrke6spx1JGFpbSQ1xLrq7WUk2Gy2rI8dFQuf6fJ6InK92/TQLvoeSDc
	R4cq2MN2Awo8s2gOpGAIbUhujAfb0OQJX+nmrKJuW8kBv1RkpM3jna3oUzmp8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYRGUq2j8u/s74u9ZvI4O1PZlDtHWbL5tuQCp8Qf2f0=;
	b=f+egllbRDKdEJVtBntCZVy7X5xFeFGF2lh2nafrT7Mws+jxuguz+Vib5c+SgHAzcxfFLCJ
	9UgIJDmVivow3lCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/irq/32: Use current_stack_pointer to avoid asm()
 in check_stack_overflow()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303155446.112769-4-ubizjak@gmail.com>
References: <20250303155446.112769-4-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111621869.14745.3674256832226611076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     1aee47babaa440b92314199963c5ed3395dc4edb
Gitweb:        https://git.kernel.org/tip/1aee47babaa440b92314199963c5ed3395dc4edb
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 16:54:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:12:40 +01:00

x86/irq/32: Use current_stack_pointer to avoid asm() in check_stack_overflow()

Make code more readable by using the 'current_stack_pointer' global variable.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303155446.112769-4-ubizjak@gmail.com
---
 arch/x86/kernel/irq_32.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index f351fa1..2428d66 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -31,10 +31,7 @@ int sysctl_panic_on_stackoverflow __read_mostly;
 /* Debugging check for stack overflow: is there less than 1KB free? */
 static int check_stack_overflow(void)
 {
-	long sp;
-
-	__asm__ __volatile__("andl %%esp,%0" :
-			     "=r" (sp) : "0" (THREAD_SIZE - 1));
+	unsigned long sp = current_stack_pointer & (THREAD_SIZE - 1);
 
 	return sp < (sizeof(struct thread_info) + STACK_WARN);
 }

