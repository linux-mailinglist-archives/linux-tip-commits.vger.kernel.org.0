Return-Path: <linux-tip-commits+bounces-3303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD33A259B6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517FA1887A42
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC5C2046B3;
	Mon,  3 Feb 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VoV4j/xF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u2X4B9JA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4884A3E;
	Mon,  3 Feb 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586901; cv=none; b=jVibBdEqOgBbo15GDl7A/4EDWXYd7G9082kOcFqPkE2Ik48LM0/r6t5eN1SCXafrTIkbfbN9CbxPkT8J4oU0vHBU9IFC0RgS3feRFp6HPiMvX+CWRl08DADHFWSs6HzkCMpxpMMb23McGS1D2sY/Lk7yRNRCPbw1Rectk/x0HXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586901; c=relaxed/simple;
	bh=UogOpaxL+UDuwVWt+N42FjsnUlslcVhAM5oSD1Ca8FI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pX2nmUUxWmpHHeRNDHMUCJzV23DiwdWnZaM+L4CeV1G2044yi49YhrNqNNCJUkEIlftFM/ruuspRd9Pi5K+oFeGpmXMuLyo02OhBixzyJg4EtxRQ33waYr/qqBpJMYnhJqofAGYIYpAgzMTWLwPz0sYe28VCrKsb+aNyc01LuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VoV4j/xF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u2X4B9JA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQCFWak7O7cX8918dG2a3xWu+X2sZ22eN4ijueBE4mA=;
	b=VoV4j/xFqPhCL1f9/iN5oQE0vWnAUqNrMmkrGpagQMJjxexBDEvrvapDgk2W303ZdSgyvK
	s+hZoZRjkF2tpOvm5xP5vb+mxXk+FYjokTQSvsXLYK4c8Bdfemx1o5LMuWalNefmXtb7ob
	dRZzTprMOtnQtaxAtQxI1eb2t15j0tYjYZqWLlztrR3wzDjfj79Ul270c5+7YAG8TH8mSj
	/4E3TFy93mUYyb32XAPGJcPp/BgS1JMUeKiFXttjLh0h/HmSgbnxRPmgjtLzVR20PwnyMT
	/YENfguzGDza+v+x1bqppI1NQ3FYhPLhhvBpiigCL8cJuY12Ux0p1qbXZ+61UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQCFWak7O7cX8918dG2a3xWu+X2sZ22eN4ijueBE4mA=;
	b=u2X4B9JAOW1ukaCYGDRQxsImFHm5CaJSe3nLf2pDUZHBhJYqcqCf7IqooyHR14gO06zoxM
	GIGuKhEakxg6pYCw==
From: "tip-bot2 for Liao Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: Remove the spinlock within handle_singlestep()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250124093826.2123675-3-liaochang1@huawei.com>
References: <20250124093826.2123675-3-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689713.10177.999351087906743555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a66396c911bd662d503de3ec8f0a140b1081bde7
Gitweb:        https://git.kernel.org/tip/a66396c911bd662d503de3ec8f0a140b1081bde7
Author:        Liao Chang <liaochang1@huawei.com>
AuthorDate:    Fri, 24 Jan 2025 09:38:26 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:06 +01:00

uprobes: Remove the spinlock within handle_singlestep()

This patch introduces a flag to track TIF_SIGPENDING is suppress
temporarily during the uprobe single-step. Upon uprobe singlestep is
handled and the flag is confirmed, it could resume the TIF_SIGPENDING
directly without acquiring the siglock in most case, then reducing
contention and improving overall performance.

I've use the script developed by Andrii in [1] to run benchmark. The CPU
used was Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@2.4GHz running the
kernel on next tree + the optimization for get_xol_insn_slot() [2].

before-opt
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250124093826.2123675-3-liaochang1@huawei.com
---
 include/linux/uprobes.h | 1 +
 kernel/events/uprobes.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b1df7d7..a40efdd 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -143,6 +143,7 @@ struct uprobe_task {
 
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
+	bool				signal_denied;
 
 	struct arch_uprobe              *auprobe;
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 33bd608..870f697 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2302,6 +2302,7 @@ bool uprobe_deny_signal(void)
 	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
 
 	if (task_sigpending(t)) {
+		utask->signal_denied = true;
 		clear_tsk_thread_flag(t, TIF_SIGPENDING);
 
 		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
@@ -2735,9 +2736,10 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	utask->state = UTASK_RUNNING;
 	xol_free_insn_slot(utask);
 
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* see uprobe_deny_signal() */
-	spin_unlock_irq(&current->sighand->siglock);
+	if (utask->signal_denied) {
+		set_thread_flag(TIF_SIGPENDING);
+		utask->signal_denied = false;
+	}
 
 	if (unlikely(err)) {
 		uprobe_warn(current, "execute the probed insn, sending SIGILL.");

