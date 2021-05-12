Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4830E37B906
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELJYm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49928 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELJYl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:41 -0400
Date:   Wed, 12 May 2021 09:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yLskxp+T54yaB75w1TwykFQ4IneP+lbPszxoQc47VBU=;
        b=BhfZMi1gE4pxyJFPk+tihGd5It6rgLZCmmXUa0iJW7LJTKNJhMTWBk1Ggv+9WKXeAt/WnE
        G9iyPRMs0Yheel/CJAMGgpzE3l34JkYXbFw24yq6Frn/xEP91H6AmQcnkvkKhHZKKoU5ki
        ydZ/0GWolqZ0yHuHkR8LXsn4TjDuLxSRjEDYPQTIR/PMfdOgxsBBQ3h5K4Z92J+OMitAqE
        RWED7syhNREM+DT7nt7eEgbFxt5TS/vQ+UjoppWybe94s9gBMZm+Owggw4gxpOK1FzZRWp
        Fc7ldzwBqY39S35DoQhTtWlZL7o1pQxS0GqUqtugVd7omKvaZNHg30SbfA3sAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yLskxp+T54yaB75w1TwykFQ4IneP+lbPszxoQc47VBU=;
        b=3bE+zWZrmjEhR+wocGKPdfw7On7XBbUiQbgRu630a2R+ySIiG+h7+LJYznuQLB/uJ6tVtt
        ZJCAA/V3NVzMhvDQ==
From:   "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/regs: Syscall_get_nr() returns -1 for a non-system call
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210510185316.3307264-7-hpa@zytor.com>
References: <20210510185316.3307264-7-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162081141182.29796.4223827304608276963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     9ddcb87b9218dec760e8d8a780bc8ad514c3d36a
Gitweb:        https://git.kernel.org/tip/9ddcb87b9218dec760e8d8a780bc8ad514c3d36a
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 11:53:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:49:15 +02:00

x86/regs: Syscall_get_nr() returns -1 for a non-system call

syscall_get_nr() is defined to return -1 for a non-system call or a
ptrace/seccomp restart; not just any arbitrary number. See comment in
<asm-generic/syscall.h> for the official definition of this function.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510185316.3307264-7-hpa@zytor.com
---
 arch/x86/kernel/ptrace.c | 2 +-
 arch/x86/kernel/signal.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 87a4143..4c208ea 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -911,7 +911,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 		 * syscall with TS_COMPAT still set.
 		 */
 		regs->orig_ax = value;
-		if (syscall_get_nr(child, regs) >= 0)
+		if (syscall_get_nr(child, regs) != -1)
 			child->thread_info.status |= TS_I386_REGS_POKED;
 		break;
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index a06cb10..e12779a 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -713,7 +713,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
 
 	/* Are we from a system call? */
-	if (syscall_get_nr(current, regs) >= 0) {
+	if (syscall_get_nr(current, regs) != -1) {
 		/* If so, check system call restarting.. */
 		switch (syscall_get_error(current, regs)) {
 		case -ERESTART_RESTARTBLOCK:
@@ -793,7 +793,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 	}
 
 	/* Did we come from a system call? */
-	if (syscall_get_nr(current, regs) >= 0) {
+	if (syscall_get_nr(current, regs) != -1) {
 		/* Restart the system call - no handlers present */
 		switch (syscall_get_error(current, regs)) {
 		case -ERESTARTNOHAND:
