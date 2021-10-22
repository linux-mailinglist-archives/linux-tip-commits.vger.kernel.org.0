Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3128643737A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 10:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhJVILq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 04:11:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37634 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJVILo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 04:11:44 -0400
Date:   Fri, 22 Oct 2021 08:09:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634890166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K7Xez+/CMiBeijLNxA0L6szHRUp94JA5qcW0WNLmdUI=;
        b=PGAoQvt/3J1SuJJxs9NsWZEspzanf+5EUcm9q5tdiIttEjfs/KctMhRC4tDq5FmNYEw+nJ
        NH8Q3/8nQvNgTPC8kdU1dn1FI43mq0tlnXt6BgT3HlLfFQJ8ErbeM9+X0goCo4dDtyJpx1
        Tmap8TCXtRjbooLyqagptw9S2Yzw/PbQiRvr6cwnOksn20qChlAM6CS8FEqa84elXBTkic
        8TfW9cZvlRE42bSrAkNvdZaRqcQU5kJeNbtchaWmygoHmelBBHckKIVZtF9Vb/Ujjm5bRr
        udkYS0nNcye5RbulVGZTrJH5d+0izZUVJMzYwHwJAi/4MjZqQYeImJAepbzY6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634890166;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K7Xez+/CMiBeijLNxA0L6szHRUp94JA5qcW0WNLmdUI=;
        b=mperyT37rIFI4Ob65C4iF71n27hJKk2zf7MyHVTr2kndAQdwHS0lF0M8Jqb3SpcycY3gIV
        5EzpQe8WzmEXz5Ag==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] stacktrace: Provide stack_trace_save_tsk() stub in
 the !CONFIG_STACKTRACE case too
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163489016535.626.9246162835594085125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     037495eb8133281667b6dbc98912086825015286
Gitweb:        https://git.kernel.org/tip/037495eb8133281667b6dbc98912086825015286
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 22 Oct 2021 09:40:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Oct 2021 09:40:27 +02:00

stacktrace: Provide stack_trace_save_tsk() stub in the !CONFIG_STACKTRACE case too

The following commit:

  bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")

Added stack_trace_save_tsk() use to __get_wchan(), while this method is not
unconditionally defined: it's not available in the !CONFIG_STACKTRACE case.

Give a default implementation that does nothing.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/stacktrace.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 9edecb4..3ccaf59 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -91,8 +91,19 @@ extern void save_stack_trace_tsk(struct task_struct *tsk,
 extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 					 struct stack_trace *trace);
 extern void save_stack_trace_user(struct stack_trace *trace);
+
 #endif /* !CONFIG_ARCH_STACKWALK */
-#endif /* CONFIG_STACKTRACE */
+
+#else /* !CONFIG_STACKTRACE: */
+static inline unsigned int
+stack_trace_save_tsk(struct task_struct *task,
+		     unsigned long *store, unsigned int size,
+		     unsigned int skipnr)
+{
+	return -ENOSYS;
+}
+
+#endif /* !CONFIG_STACKTRACE */
 
 #if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
 int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
