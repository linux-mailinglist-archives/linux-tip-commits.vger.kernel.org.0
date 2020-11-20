Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DD2BAA5F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgKTMoy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:44:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40530 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgKTMox (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:44:53 -0500
Date:   Fri, 20 Nov 2020 12:44:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605876291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIBXjpgxvCG0XZC2iWlBqZN8tl9BaV+StEkXh9PsKMo=;
        b=KFQCWcyQHo+1agexHAge34ZYl+m+OVeapjNNdIrsRFZuCAo/B58slFlRKrquPr6RYaAEv6
        qq6bLoQ3YLQbwmhEYT5j2lZx2x9/8Xs5N4rrTksyrKm490ChPiu+KtYD6/EiNlWiJ7gfmS
        XN2ktKrziokJIxhCXCG2poIDT5vg1w7k9mT/B85w0pBsfneASd3a07rNRx1zJazX6yDEOz
        WeicNOjoojgONyP8OPMsO6LGsw390ggMv8WRYKibyGEddVfTc2EvZmhiW2PauEPRxoYm3C
        PByFdx/88y94qXz3SV8KURQeaRoO4TdizKW2U1NbW+zt1q+kmjhaW7Ndk9N0EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605876291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIBXjpgxvCG0XZC2iWlBqZN8tl9BaV+StEkXh9PsKMo=;
        b=5K2eDBIGthdsZxQImh+XgvWCla5sb3qiolWvbsl67AeW8PVvtXFbNU3lVCu3WS4y+/zit2
        mKlt/hA0BaKV8wAg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] context_tracking: Don't implement
 exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117151637.259084-3-frederic@kernel.org>
References: <20201117151637.259084-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160587629048.11244.16284513071090020040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     179a9cf79212bb3b96fb69a314583189cd863c5b
Gitweb:        https://git.kernel.org/tip/179a9cf79212bb3b96fb69a314583189cd863c5b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 16:16:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:42 +01:00

context_tracking: Don't implement exception_enter/exit() on CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK

The typical steps with context tracking are:

1) Task runs in userspace
2) Task enters the kernel (syscall/exception/IRQ)
3) Task switches from context tracking state CONTEXT_USER to
   CONTEXT_KERNEL (user_exit())
4) Task does stuff in kernel
5) Task switches from context tracking state CONTEXT_KERNEL to
   CONTEXT_USER (user_enter())
6) Task exits the kernel

If an exception fires between 5) and 6), the pt_regs and the context
tracking disagree on the context of the faulted/trapped instruction.
CONTEXT_KERNEL must be set before the exception handler, that's
unconditional for those handlers that want to be able to call into
schedule(), but CONTEXT_USER must be restored when the exception exits
whereas pt_regs tells that we are resuming to kernel space.

This can't be fixed with storing the context tracking state in a per-cpu
or per-task variable since another exception may fire onto the current
one and overwrite the saved state. Also the task can schedule. So it
has to be stored in a per task stack.

This is how exception_enter()/exception_exit() paper over the problem:

5) Task switches from context tracking state CONTEXT_KERNEL to
   CONTEXT_USER (user_enter())
5.1) Exception fires
5.2) prev_state = exception_enter() // save CONTEXT_USER to prev_state
                                    // and set CONTEXT_KERNEL
5.3) Exception handler
5.4) exception_enter(prev_state) // restore CONTEXT_USER
5.5) Exception resumes
6) Task exits the kernel

The condition to live without exception_enter()/exception_exit() is to
forbid exceptions and IRQs between 2) and 3) and between 5) and 6), or if
any is allowed to trigger, it won't call into context tracking, eg: NMIs,
and it won't schedule. These requirements are met by architectures
supporting CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK and those can
therefore afford not to implement this hack.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201117151637.259084-3-frederic@kernel.org
---
 include/linux/context_tracking.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d53cd33..bceb064 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -51,7 +51,8 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (!context_tracking_enabled())
+	if (IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) ||
+	    !context_tracking_enabled())
 		return 0;
 
 	prev_ctx = this_cpu_read(context_tracking.state);
@@ -63,7 +64,8 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (context_tracking_enabled()) {
+	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
+	    context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			context_tracking_enter(prev_ctx);
 	}
