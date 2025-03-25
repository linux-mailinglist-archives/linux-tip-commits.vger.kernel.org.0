Return-Path: <linux-tip-commits+bounces-4436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FEEA6EAC9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CC716AFFB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FE19D8A3;
	Tue, 25 Mar 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4FO4qeL/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pi7tqKcu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F498460;
	Tue, 25 Mar 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888779; cv=none; b=eSRsMV3XtfOfjzfBwx1FiEZyhnxpLfdi5JvxIvs7ax7bOU/AkdW8X7M23dEybV1jaK3GKi4Cz1LxmobnaMwb6gGS1wE07X8HDE6hFgGjx1yXBqHtGkeJSJmrZT6eM8FKDec0FcuCLVGmZQgJQPbIoVfG5okN2cSCVPSFo27NyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888779; c=relaxed/simple;
	bh=L6kB/Ks+1IwTo8ncneuLLs+OEKs9Y+Eas0DcSJtqa9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bx9SgmDHv/06kMrzJ89AnxwSWCRfr68tZflHBdcUn74ST976Niovvelqn/UHkIuoddVwAD5rJGD9XZkXLRoSn/4BVuBqRPoPPUnTnwsN4a0462DLviPRu4qfmaCvWrlGr2lAGFYurzXlwKdP7ptPoVL2r53+slNARxpNnHLxAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4FO4qeL/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pi7tqKcu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:46:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWNXSt6uUvxFro85omf+Aa1Y1ZAz/1rAZ5VKNH6qjyk=;
	b=4FO4qeL/OnbqBIY5TRd4loIFJaeQq3LxILz4TYRfqJfwg0t5VhL8cfznYwB7HNghQvCUpc
	iBzs87WB2/l2Zj18PmTywJfqU5RChcmiat7gPmS470zVCqBcSLPQDgemTo5dmvjJ+GokTU
	6zNBPN2hxhzBfn8pPfkNsrXS+yozg85/IKEACWI3IXdx7C1Ct3i9gCyuTHnIn43Vt9FyAC
	tO0ujI7uDI3qCtSZxH2Js1qFewBmYy8dG+1/jzkaiN7OvlFrY7X4xfKbAbWxd7+k2jYcOc
	80Cp8AHfd9QGOD8GWyd3Gqx8ucQp1ocGHCquuzbI+WGSKfXiORoIoYPuwJRLBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWNXSt6uUvxFro85omf+Aa1Y1ZAz/1rAZ5VKNH6qjyk=;
	b=Pi7tqKcuCFko640hEw6+sYnqZFlzukYknLpjW9yeilzAPWBHR6+8GJB2+FKhC23e8lzu7e
	9qYCEQV/4+NVgFCQ==
From: "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/dumpstack: Fix inaccurate unwinding from
 exception stacks due to misplaced assignment
Cc: Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
References: <20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288877589.14745.11891370184181289037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2c118f50d7fd4d9aefc4533a26f83338b2906b7a
Gitweb:        https://git.kernel.org/tip/2c118f50d7fd4d9aefc4533a26f83338b2906b7a
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Tue, 25 Mar 2025 03:01:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 08:30:43 +01:00

x86/dumpstack: Fix inaccurate unwinding from exception stacks due to misplaced assignment

Commit:

  2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is aligned, again")

was intended to ensure alignment of the stack pointer; but it also moved
the initialization of the "stack" variable down into the loop header.

This was likely intended as a no-op cleanup, since the commit
message does not mention it; however, this caused a behavioral change
because the value of "regs" is different between the two places.

Originally, get_stack_pointer() used the regs provided by the caller; after
that commit, get_stack_pointer() instead uses the regs at the top of the
stack frame the unwinder is looking at. Often, there are no such regs at
all, and "regs" is NULL, causing get_stack_pointer() to fall back to the
task's current stack pointer, which is not what we want here, but probably
happens to mostly work. Other times, the original regs will point to
another regs frame - in that case, the linear guess unwind logic in
show_trace_log_lvl() will start unwinding too far up the stack, causing the
first frame found by the proper unwinder to never be visited, resulting in
a stack trace consisting purely of guess lines.

Fix it by moving the "stack = " assignment back where it belongs.

Fixes: 2e4be0d011f2 ("x86/show_trace_log_lvl: Ensure stack pointer is aligned, again")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250325-2025-03-unwind-fixes-v1-2-acd774364768@google.com
---
 arch/x86/kernel/dumpstack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 91639d1..c6fefd4 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -195,6 +195,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	printk("%sCall Trace:\n", log_lvl);
 
 	unwind_start(&state, task, regs, stack);
+	stack = stack ?: get_stack_pointer(task, regs);
 	regs = unwind_get_entry_regs(&state, &partial);
 
 	/*
@@ -213,9 +214,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * - hardirq stack
 	 * - entry stack
 	 */
-	for (stack = stack ?: get_stack_pointer(task, regs);
-	     stack;
-	     stack = stack_info.next_sp) {
+	for (; stack; stack = stack_info.next_sp) {
 		const char *stack_name;
 
 		stack = PTR_ALIGN(stack, sizeof(long));

