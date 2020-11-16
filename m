Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CA22B5381
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgKPVLh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732595AbgKPVLg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF18EC0613D2;
        Mon, 16 Nov 2020 13:11:35 -0800 (PST)
Date:   Mon, 16 Nov 2020 21:11:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qfiWLUvci0SXTPKDmONd57cxak7yO+7H9B1MludRn0=;
        b=0GXMkHQH1NSXc2iXiR886CMxQnDAnI7wYpX9/lZHS38qD0bt1BYJmjG3TcNp9vHPvswsWn
        n41ouOYKMD7lDIZYk5ZwZxoakkhXkrYaC9vG9nXK2FDPDZ4GSOtpDv2+BHCxK/Ll5J3E4J
        7qjFf0Jolau3nYIuJQ2GaHVMra06hP9CM0TKXB5xfAJT9LeJPVMYeA2LgS/Q5W8stQkP4/
        tM3hKq9o8d1mI8v/gWcpg3loUfjXi6ZrnIOsDuiND6LqQjIKz7u+v+UMI8uO0kRIuCN/RQ
        StQNQ2u9tIs2a+aqeBD8XBpNcA/ektD/RcVscSun2NyiJw8zwxJ7+kpSRGx1ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qfiWLUvci0SXTPKDmONd57cxak7yO+7H9B1MludRn0=;
        b=HDMcwtNTocdVE7jgGxwz3JjMTZ30CcqObC8qHvlzR/PzJ/il+Pj64YOeanQZTMZS+MHcER
        k+i42aFJ/qr8fkBg==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Expose helpers to migrate TIF to SYSCALL_WORK flags
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-3-krisman@collabora.com>
References: <20201116174206.2639648-3-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109363.11244.12347157276941524864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     3136b93c3fb2b7c19e853e049203ff8f2b9dd2cd
Gitweb:        https://git.kernel.org/tip/3136b93c3fb2b7c19e853e049203ff8f2b9dd2cd
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:41:58 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:15 +01:00

entry: Expose helpers to migrate TIF to SYSCALL_WORK flags

With the goal to split the syscall work related flags into a separate
field that is architecture independent, expose transitional helpers that
resolve to either the TIF flags or to the corresponding SYSCALL_WORK
flags.  This will allow architectures to migrate only when they port to
the generic syscall entry code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-3-krisman@collabora.com


---
 include/linux/thread_info.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index e93e249..0e9fb15 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -97,6 +97,38 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 #define test_thread_flag(flag) \
 	test_ti_thread_flag(current_thread_info(), flag)
 
+#ifdef CONFIG_GENERIC_ENTRY
+#define set_syscall_work(fl) \
+	set_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+#define test_syscall_work(fl) \
+	test_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+#define clear_syscall_work(fl) \
+	clear_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
+
+#define set_task_syscall_work(t, fl) \
+	set_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+#define test_task_syscall_work(t, fl) \
+	test_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+#define clear_task_syscall_work(t, fl) \
+	clear_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
+
+#else /* CONFIG_GENERIC_ENTRY */
+
+#define set_syscall_work(fl)						\
+	set_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+#define test_syscall_work(fl) \
+	test_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+#define clear_syscall_work(fl) \
+	clear_ti_thread_flag(current_thread_info(), SYSCALL_WORK_##fl)
+
+#define set_task_syscall_work(t, fl) \
+	set_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define test_task_syscall_work(t, fl) \
+	test_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#define clear_task_syscall_work(t, fl) \
+	clear_ti_thread_flag(task_thread_info(t), TIF_##fl)
+#endif /* !CONFIG_GENERIC_ENTRY */
+
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
