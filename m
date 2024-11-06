Return-Path: <linux-tip-commits+bounces-2768-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44519BE4BF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CC728626B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013621DEFF3;
	Wed,  6 Nov 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mxjkqVF0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W1Fmt03f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D41DED79;
	Wed,  6 Nov 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890129; cv=none; b=p69DDSDZl6Ms5oHSKe/TDVW0t73F3NrO1u822opgHf1KYeztEMBvXWzWFnADml8gmChtgw3cvrKzNcoLUxFV2HCFprc7eTpFyL99z7VZxWl/DLZoKZUO5rnqzK5ZfklaUkogi3uKlx9YE82Ux/NOIs95ZVmjfOSKcuNvAptd48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890129; c=relaxed/simple;
	bh=veKXJTm3OTmjBHHxYlEgCfxfT9lPSpdQ1HhJV4V0zAg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bZU+wFdxIeJayMBoVuKcYQN8J1cCic/YDgZ7kDR3HMrR3vU5spMPRTcrGb+ifTsed51APKIrddsyLJsrIMKy4YALZNnFNpdg4HJ2A8eu2UuI5Xuzpx5QWeaNfs+3CSiLepDg0hNtZ3t4AKqpaE3S/h4pu1yajWH2kyIvsrnTF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mxjkqVF0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W1Fmt03f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP+s5xatzZAH0zpujeg1ARo/THzUeCeZN+BqBi9B0eI=;
	b=mxjkqVF0PrcXhrnR3qIB3b9Q/3dqez+QoL0Kgl3WXONIfl8OjLS2lNdEe1yK/nyYp7VzTm
	CAXKSwIYj1Dneb4b/sBNqHpnrsedVq9Ykue56OFWP68yb4bh597+AHUhMBjKd+zeU/YcMx
	+ZRqTnOM7DGl9IqUNgms0oCtR8h3yTHxyVlqH7ZztpqMx+lIGtZvNe6wds9ErRXZldmB4T
	hVwJsPX444rpX/cx6BtML3fM9E1Q3uWuVA8SlmlYviWXPtoLbhYrWAexMim0hNIamEjJ4o
	NSieasLzdWTSl6qjQHV6iCyd8ZGoC0aFJnekZdEW2RsAVELPWosssal+yPBGdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP+s5xatzZAH0zpujeg1ARo/THzUeCeZN+BqBi9B0eI=;
	b=W1Fmt03fgtyjCBvC7xcKUfL3oGpEE6jv++uiNdpuvw3OlIVKseHbZ+fwfOyPPDiUdYqMsz
	HkY9ga3pDVjVogBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched, x86: Enable Lazy preemption
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007075055.555778919@infradead.org>
References: <20241007075055.555778919@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012568.32228.5430722974826547973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     476e8583ca16eecec0a3a28b6ee7130f4e369389
Gitweb:        https://git.kernel.org/tip/476e8583ca16eecec0a3a28b6ee7130f4e369389
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 04 Oct 2024 14:46:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:38 +01:00

sched, x86: Enable Lazy preemption

Add the TIF bit and select the Kconfig symbol to make it go.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20241007075055.555778919@infradead.org
---
 arch/x86/Kconfig                   | 1 +
 arch/x86/include/asm/thread_info.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd..b76aa7f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 12da7df..75bb390 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,8 +87,9 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_LAZY	4	/* rescheduling necessary */
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)

