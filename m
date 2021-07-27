Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0F3D77A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhG0N7A (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:59:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbhG0N65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:57 -0400
Date:   Tue, 27 Jul 2021 13:58:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/NERakUa3tNBRiJaH0wo8QN/gj+iXhgbtmLMYOHAr0=;
        b=N2pztbHEGumMB56D/GZ1mFVaV1QzKKpudw8w7y7B3oDDn8hdeI8YGrJxqnV8ofVTVgGLFy
        YdA4OWGEz6Tsdry8NO/hyJQa4yxPTQG58uif5+hYrNfxSpJOOesq8LFGfL8n6Db5e/Hc2s
        TVKVuhqJ4ZrsMHeIxG6UWPbT0HnByESrRUSIoTf+sA6y59U5wub8bcF/9nrsu4AVZOxc3y
        B5AdzItcXfCAv+hAMJ2csB4cFXNCAVwy+z2piLvkuy2eEHzQOviPhniaon+lLB0zSNvTG8
        dRwd79gp/6NekQXaFYjjofcnV4fJXZhH3sio9d+YchbB8fDo081apnJHiCP8Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/NERakUa3tNBRiJaH0wo8QN/gj+iXhgbtmLMYOHAr0=;
        b=DYukTkVwtc9YdZh/ybLr/qt2So5poRJg5zKg1TFb9syf4dIy5Ld2Q2f4630fuK01vjUiUx
        e9iBmZRFmpJNyvDw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Refactor permissions check into
 perf_check_permission()
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210705084453.2151729-2-elver@google.com>
References: <20210705084453.2151729-2-elver@google.com>
MIME-Version: 1.0
Message-ID: <162739433584.395.14125645089713310487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b068fc04de10fff8974f6ef32b861ad134d94ba4
Gitweb:        https://git.kernel.org/tip/b068fc04de10fff8974f6ef32b861ad134d94ba4
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 05 Jul 2021 10:44:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:38 +02:00

perf: Refactor permissions check into perf_check_permission()

Refactor the permission check in perf_event_open() into a helper
perf_check_permission(). This makes the permission check logic more
readable (because we no longer have a negated disjunction). Add a
comment mentioning the ptrace check also checks the uid.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/r/20210705084453.2151729-2-elver@google.com
---
 kernel/events/core.c | 58 +++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c13730b..1cb1f9b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11917,6 +11917,37 @@ again:
 	return gctx;
 }
 
+static bool
+perf_check_permission(struct perf_event_attr *attr, struct task_struct *task)
+{
+	unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
+	bool is_capable = perfmon_capable();
+
+	if (attr->sigtrap) {
+		/*
+		 * perf_event_attr::sigtrap sends signals to the other task.
+		 * Require the current task to also have CAP_KILL.
+		 */
+		rcu_read_lock();
+		is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
+		rcu_read_unlock();
+
+		/*
+		 * If the required capabilities aren't available, checks for
+		 * ptrace permissions: upgrade to ATTACH, since sending signals
+		 * can effectively change the target task.
+		 */
+		ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
+	}
+
+	/*
+	 * Preserve ptrace permission check for backwards compatibility. The
+	 * ptrace check also includes checks that the current task and other
+	 * task have matching uids, and is therefore not done here explicitly.
+	 */
+	return is_capable || ptrace_may_access(task, ptrace_mode);
+}
+
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
@@ -12158,43 +12189,18 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (task) {
-		unsigned int ptrace_mode = PTRACE_MODE_READ_REALCREDS;
-		bool is_capable;
-
 		err = down_read_interruptible(&task->signal->exec_update_lock);
 		if (err)
 			goto err_file;
 
-		is_capable = perfmon_capable();
-		if (attr.sigtrap) {
-			/*
-			 * perf_event_attr::sigtrap sends signals to the other
-			 * task. Require the current task to also have
-			 * CAP_KILL.
-			 */
-			rcu_read_lock();
-			is_capable &= ns_capable(__task_cred(task)->user_ns, CAP_KILL);
-			rcu_read_unlock();
-
-			/*
-			 * If the required capabilities aren't available, checks
-			 * for ptrace permissions: upgrade to ATTACH, since
-			 * sending signals can effectively change the target
-			 * task.
-			 */
-			ptrace_mode = PTRACE_MODE_ATTACH_REALCREDS;
-		}
-
 		/*
-		 * Preserve ptrace permission check for backwards compatibility.
-		 *
 		 * We must hold exec_update_lock across this and any potential
 		 * perf_install_in_context() call for this new event to
 		 * serialize against exec() altering our credentials (and the
 		 * perf_event_exit_task() that could imply).
 		 */
 		err = -EACCES;
-		if (!is_capable && !ptrace_may_access(task, ptrace_mode))
+		if (!perf_check_permission(&attr, task))
 			goto err_cred;
 	}
 
