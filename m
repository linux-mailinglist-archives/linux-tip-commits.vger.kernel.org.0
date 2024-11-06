Return-Path: <linux-tip-commits+bounces-2767-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B09BE4BE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7FF1F26A02
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D81DEFC8;
	Wed,  6 Nov 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="II2jd6Tc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aq7H1/0w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC51DED5F;
	Wed,  6 Nov 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890129; cv=none; b=klVqEc+WwD652JXcVKsiKg+9XEAeFZMbRMbOobjnr1pMW18wcEQ8pIwaCAA75PlqEl+5OAomgw00eZ6C44xCppbKZDcdIDRX6ycD2RI6BlWK7P7L399nBhqgE5DlzcOpvsu+ZVMrlowuDNPaP4Mvb6IDzaTgvnfo0d+QcIBLnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890129; c=relaxed/simple;
	bh=MVXnPdPQJllIdrLzL2iIVpbQM93WFHdnmlXbcpravcw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m1G6iVgMbNWR+C89axagxj5rZlgPJZ2p4YYfmmKa6Hln6D5q17Xx6+mK5/4haXRxwyrOGsszo3fa86GwbiqOgy24CRbT6QgUgCkAHpPtHgj5tsJVZ4kYLJ1/naW6Uwts9FOESYdQoQDvBoKFc6ryQF390OpPYAB8E6K1Etts7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=II2jd6Tc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aq7H1/0w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udvKtdWiQsM/QrzAFdMhl6gO2jLVv405s3eHgdleCN8=;
	b=II2jd6TcKju6GJo0fFMhLqtm94W9Ii8nQjvIzs51xivbUDuQ7YZrFpI9W6qKXZizBLevsr
	kKYBLdrL8dmMYnaKjVgaOBowhjmq5XQKx2xHcUsuOOFwA0aL8FuKd44W5uNHMi3WGPhK5p
	bn9kaGx4bSi0U13VyD2qTRY6Lb/D0K3POQf6Qzg6xOime13NnZysbiaQTvj9gCMotwnQIX
	4BYq6jMMeVY4ye/nVoDZ7AvB8GrYpY+E4xn4JFd2Wgg8AGVk3eCaDTIp6mkbN/XTqgerQY
	teEYiiW6wnSp0+6iRFTPYlmzwBwD6bFNe62XJbf7Ik+qdoaIYAnJTndyN1nLMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890125;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udvKtdWiQsM/QrzAFdMhl6gO2jLVv405s3eHgdleCN8=;
	b=aq7H1/0w1gBnXTCGi6CYGhE3d0slYuwvxWlINHfFwgYIy0Os28dn2UfhRpEI1CGe3SR6qV
	M7F3//0SV9qXlLCw==
From: "tip-bot2 for Jisheng Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] riscv: add PREEMPT_LAZY support
Cc: Jisheng Zhang <jszhang@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241021151257.102296-4-bigeasy@linutronix.de>
References: <20241021151257.102296-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012493.32228.9669370223751726698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     22aaec357c1ff85b72c105c90503e3b4187384b8
Gitweb:        https://git.kernel.org/tip/22aaec357c1ff85b72c105c90503e3b4187384b8
Author:        Jisheng Zhang <jszhang@kernel.org>
AuthorDate:    Mon, 21 Oct 2024 17:08:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:39 +01:00

riscv: add PREEMPT_LAZY support

riscv has switched to GENERIC_ENTRY, so adding PREEMPT_LAZY is as simple
as adding TIF_NEED_RESCHED_LAZY related definitions and enabling
ARCH_HAS_PREEMPT_LAZY.

[bigeasy: Replace old PREEMPT_AUTO bits with new PREEMPT_LAZY ]

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lkml.kernel.org/r/20241021151257.102296-4-bigeasy@linutronix.de
---
 arch/riscv/Kconfig                   |  1 +
 arch/riscv/include/asm/thread_info.h | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6254594..3516c58 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API
+	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTE_DEVMAP if 64BIT && MMU
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 9c10fb1..f5916a7 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,9 +107,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
+#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
+#define TIF_NEED_RESCHED_LAZY	1       /* Lazy rescheduling needed */
+#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
+#define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
@@ -117,9 +118,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_32BIT		11	/* compat-mode 32bit process */
 #define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
 
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)

