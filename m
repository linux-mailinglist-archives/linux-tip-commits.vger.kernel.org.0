Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2E92C3622
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 02:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKYBP0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 20:15:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKYBP0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 20:15:26 -0500
Date:   Wed, 25 Nov 2020 01:15:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606266923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOFdo/J4Apf0WQ2fIbAgwQsZ4YIRFHwosTd2xizv2QA=;
        b=nI+fOXdbb3CvlS/oChTBOdNxDkrFez9Mung/n+TacNY771X1ErCoJUwsfC2L/13KbE09qC
        rkorqi5rYgIJ8dLZ86CkOFTymdV3eWDVr+FdQHYEWGUmhlFWM8Uwy76i+xw2PPZ3ODFnWZ
        ITZfi4aRClchWl8sjEqUBQBBxkJlVoq+e8GLVmNa+stAEUU+jvwAxw6093aSf1glRPaChd
        Vfn+ng9pQ3Er6+D9NrrwViAktOIVd5dteeXSIHfl5RZpNFzFZh0xbqK3G3AIzrNTRUttU0
        uqG3FFrioJSZCLIoeiF8SWBwEFfy2buQwl35im53YJSmc278JXGC8ZGTOQ0aIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606266923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOFdo/J4Apf0WQ2fIbAgwQsZ4YIRFHwosTd2xizv2QA=;
        b=8IlHSkYFoja/drPjQjE8p8M/HgSIxEQIDf0obBDNHuAMeRKn0ez8waBSq7EVDF7fcd3lc9
        ykLMtoqMuL7kJMDQ==
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
Message-ID: <160626692283.3364.16416416609704664088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     0395124a2fbff5132afee5767071ebe7e05885ac
Gitweb:        https://git.kernel.org/tip/0395124a2fbff5132afee5767071ebe7e05885ac
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 23 Nov 2020 10:54:58 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 23:44:28 +01:00

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
index 3173632..5515ab3 100644
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
+	set_ti_thread_flag(current_thread_info(), TIF_WORK_##fl)
 #define test_syscall_work(fl) \
-	test_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+	test_ti_thread_flag(current_thread_info(), TIF_WORK_##fl)
 #define clear_syscall_work(fl) \
-	clear_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+	clear_ti_thread_flag(current_thread_info(), TIF_WORK_##fl)
 
 #define set_task_syscall_work(t, fl) \
 	set_ti_thread_flag(task_thread_info(t), TIF_##fl)
