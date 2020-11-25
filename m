Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1C22C3639
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 02:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgKYB0e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 20:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgKYB0e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 20:26:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA2C0613D4;
        Tue, 24 Nov 2020 17:26:34 -0800 (PST)
Date:   Wed, 25 Nov 2020 01:26:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606267591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PYRq1UsZs6vh3HXuyDgAQnJyYMwqmqRAflznAJPOrA=;
        b=PE6Y2EMnayB2F3uA4+UlgWNe5bXay2GIZAxsKgGh2+upqGsZXZWBIxPAVfBtzPz3fFolUP
        HqYUymRweC1mi6zqLToBzjEAH3/vMrhwEqLWkTRBB/XldQMWc4CUMu3GrRsuUHlRgiPEMQ
        YAxNYpMuE0+sY75+iu8wBELafTWj74Kc3HyamKCJ9DRBtLgK/p6qkaYI8ancNcsHGL5kc5
        umnH/hACi4TM10ePUMvgeSkA8WnUu/Ha1zaVEWwJJQ1eoDLd9lFYwvjeaTOj1hVFW/TAyu
        qwzAnFfwSGytOae3YFhMW33Rd185yBzIV0Ke3bm/yclZlfO5SKZ5kXwXLBLRrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606267591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PYRq1UsZs6vh3HXuyDgAQnJyYMwqmqRAflznAJPOrA=;
        b=py6crgZi2TzLQX7hoLymnGIJgY0JCX76bQGWckjGbcvFejAWChHuceeINYgVDF+u/YLl6+
        AGBLPwek1rk/7sDw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Fix boot for !CONFIG_GENERIC_ENTRY
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jann Horn <jannh@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87a6v8qd9p.fsf_-_@collabora.com>
References: <87a6v8qd9p.fsf_-_@collabora.com>
MIME-Version: 1.0
Message-ID: <160626759088.3364.15796596877725637031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     5903f61e035320104394f721f74cd22171636f63
Gitweb:        https://git.kernel.org/tip/5903f61e035320104394f721f74cd22171636f63
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 23 Nov 2020 10:54:58 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Nov 2020 02:20:09 +01:00

entry: Fix boot for !CONFIG_GENERIC_ENTRY

A copy-pasta mistake tries to set SYSCALL_WORK flags instead of TIF
flags for !CONFIG_GENERIC_ENTRY.  Also, add safeguards to catch this at
compilation time.

Fixes: 3136b93c3fb2 ("entry: Expose helpers to migrate TIF to SYSCALL_WORK flags")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/87a6v8qd9p.fsf_-_@collabora.com
---
 include/linux/thread_info.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 3173632..ca80a21 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -35,6 +35,7 @@ enum {
 	GOOD_STACK,
 };
 
+#ifdef CONFIG_GENERIC_ENTRY
 enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SECCOMP,
 	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
@@ -48,6 +49,7 @@ enum syscall_work_bit {
 #define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
 #define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
 #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#endif
 
 #include <asm/thread_info.h>
 
@@ -129,11 +131,11 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 #else /* CONFIG_GENERIC_ENTRY */
 
 #define set_syscall_work(fl)						\
-	set_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+	set_ti_thread_flag(current_thread_info(), TIF_##fl)
 #define test_syscall_work(fl) \
-	test_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+	test_ti_thread_flag(current_thread_info(), TIF_##fl)
 #define clear_syscall_work(fl) \
-	clear_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+	clear_ti_thread_flag(current_thread_info(), TIF_##fl)
 
 #define set_task_syscall_work(t, fl) \
 	set_ti_thread_flag(task_thread_info(t), TIF_##fl)
