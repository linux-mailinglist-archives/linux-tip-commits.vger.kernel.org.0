Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4195F269714
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Sep 2020 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgINUwA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 14 Sep 2020 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINUvz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 14 Sep 2020 16:51:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4839C06174A;
        Mon, 14 Sep 2020 13:51:54 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600116713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydzS4LjDHHuUQo7y+TMVzF9Spgu4/8ruP1ZAuxKKJ4U=;
        b=GMztMAEAMqlzffkpCTI2elIHG6Egg7omz1FDsK4r684ySHnti5IvuGKTOZeaI4VnH024GB
        oC3bMMskdVBAgb3ZbQ39H2YU+cBhYiEz5GOMMKtupLCucHL/faE8Vy7XvL/YIUxS+jECQz
        twWZUbypVX+SthCi55jpKhWg1Zp+SYG3PyzKb1sA+YPAy2yrxb9rU2HG5bGdqB6GhgTtYv
        UiXlhgy/dx1KheyeIDa7pwI0a0APJIsY1ykGpUdGl3KDpQSYVuaodQ/Lhi/UGg8OSourAA
        5NLTBuTOBi3m/wruVXHU11ztOFGmtrYqYvwFGobqPe9llXWkSQ1oNI4JjXdAeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600116713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydzS4LjDHHuUQo7y+TMVzF9Spgu4/8ruP1ZAuxKKJ4U=;
        b=I1W2F+DThpQRC7FJcwSbAgVZu+7A+giwZtiXR9K/u/vLAbC4ed1jAGOgXPUIe/Np5OJTuU
        BSCNSQNX1YkEkZAg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] core/entry: Report syscall correctly for trace and audit
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200912005826.586171-1-keescook@chromium.org>
References: <20200912005826.586171-1-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <160011671176.15536.7429378178023419747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b6ec413461034d49f9e586845825adb35ba308f6
Gitweb:        https://git.kernel.org/tip/b6ec413461034d49f9e586845825adb35ba308f6
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 11 Sep 2020 17:58:26 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Sep 2020 22:49:51 +02:00

core/entry: Report syscall correctly for trace and audit

On v5.8 when doing seccomp syscall rewrites (e.g. getpid into getppid
as seen in the seccomp selftests), trace (and audit) correctly see the
rewritten syscall on entry and exit:

	seccomp_bpf-1307  [000] .... 22974.874393: sys_enter: NR 110 (...
	seccomp_bpf-1307  [000] .N.. 22974.874401: sys_exit: NR 110 = 1304

With mainline we see a mismatched enter and exit (the original syscall
is incorrectly visible on entry):

	seccomp_bpf-1030  [000] ....    21.806766: sys_enter: NR 39 (...
	seccomp_bpf-1030  [000] ....    21.806767: sys_exit: NR 110 = 1027

When ptrace or seccomp change the syscall, this needs to be visible to
trace and audit at that time as well. Update the syscall earlier so they
see the correct value.

Fixes: d88d59b64ca3 ("core/entry: Respect syscall number rewrites")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200912005826.586171-1-keescook@chromium.org

---
 kernel/entry/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 1868359..6fdb610 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -60,13 +60,15 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 			return ret;
 	}
 
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
 	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
 	syscall_enter_audit(regs, syscall);
 
-	/* The above might have changed the syscall number */
-	return ret ? : syscall_get_nr(current, regs);
+	return ret ? : syscall;
 }
 
 static __always_inline long
