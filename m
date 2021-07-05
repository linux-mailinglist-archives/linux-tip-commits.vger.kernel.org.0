Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC963BB844
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGEH4N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGEH4M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3815C061760;
        Mon,  5 Jul 2021 00:53:35 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQOvQ+qkc9xglz7UhzwOoq8Vmgv+m7a3d4m8NcXZ7aY=;
        b=nWFfWS8kla8PqcUYcn1SWxsdtH+TrKJTgKWQ5UETYmq+2LprzuDLRSfM0IiDQ5pmS6gsl2
        IWUI6yM+ifcBdQ6q/ruqMkWIbVqlsn1oiVY4GW7OINCu0V0VY7SbGdHayRcQUaccWaWD8e
        SeNGwjfOs9MsnK6OSuQ4lxhDXj9XNl0kzooE/RLVqFo/7AiKsxJvCcGfZ0gk2O6SHYzazw
        kI3336d6JweHOwMtSU4qDcO0QSpCYca5f3vWsNkntw88dihtWs0WwXT7B7Hz/xCJex1ZH3
        xl/VgbSCQYJgXqQpcT27kKcno82rZpwBi7iCVgfxu6wSs8R4spXnTOeI1eYWcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQOvQ+qkc9xglz7UhzwOoq8Vmgv+m7a3d4m8NcXZ7aY=;
        b=nzcU2p6gRyJn3gdn7CV+WTWzMejwXJL5E8R0AjWp7pg7/mWMiKkE0U4S1bBc1NPgczQ07q
        IFgJPQTQ5Bllt2Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] kprobe/static_call: Restore missing
 static_call_text_reserved()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210628113045.167127609@infradead.org>
References: <20210628113045.167127609@infradead.org>
MIME-Version: 1.0
Message-ID: <162547161298.395.6324392978346107886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1dcba646c86dc86114ac666a1887e84282154515
Gitweb:        https://git.kernel.org/tip/1dcba646c86dc86114ac666a1887e84282154515
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 28 Jun 2021 13:24:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:27 +02:00

kprobe/static_call: Restore missing static_call_text_reserved()

Restore two hunks from commit 6333e8f73b83 ("static_call: Avoid
kprobes on inline static_call()s") that went walkabout.

Fixes: 76d4acf22b48 ("Merge tag 'perf-kprobes-2020-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210628113045.167127609@infradead.org
---
 kernel/kprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e41385a..069388d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/static_call.h>
 #include <linux/perf_event.h>
 
 #include <asm/sections.h>
@@ -1551,6 +1552,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
+	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
