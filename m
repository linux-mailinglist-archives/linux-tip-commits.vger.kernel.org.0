Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7399E3004E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbhAVOHE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 09:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbhAVOGw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 09:06:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE8C061786;
        Fri, 22 Jan 2021 06:05:30 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611324328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjEyQpLdlpP+nK3WF5d/6wMkcIrXKQEb/JmNLb3ansg=;
        b=dTv7WJWa2kRVdAivMSM0XagPV1vCrSUpTx3FReL+9h7zV2Zbpps6C9rIgUrEStH45YZmiG
        S8FIS6C9gkCjxlimVIbTKwtzSutIkyYAOSV8YR+TXp5v3BxGeqsn629CEs1EHM0wYMAajG
        CPqlhQhtUqtlosJ2ZELWuD9FXAzQiJts4L1ay8nXyDbW//nNkBjrtBD+fp1RLJCfSV6NXF
        4QNgmMYC2j6NUdrLQaeTpmM0BA9lSnXT7G1gyaB9C6LAadrMKfbIabySErd9rtkB2dq+rx
        ViXLWeNm5B3J+BEifmzxu29xKG2eezauRaCfY6j3eu0EiU4FIRs68jJbE31Wfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611324328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjEyQpLdlpP+nK3WF5d/6wMkcIrXKQEb/JmNLb3ansg=;
        b=xbeiMUR1Ljc2uTPgRof4GR8p88ohItOQB8kmoUzUbJp7uY7MyCbm8oTmHVtf1imc7voXdV
        +7MXTgG2C5F4cJBA==
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Do not profile branch annotations
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201211163754.585174b9@gandalf.local.home>
References: <20201211163754.585174b9@gandalf.local.home>
MIME-Version: 1.0
Message-ID: <161132432777.414.6986626994909539773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2f0df49c89acaa58571d509830bc481250699885
Gitweb:        https://git.kernel.org/tip/2f0df49c89acaa58571d509830bc481250699885
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Fri, 11 Dec 2020 16:37:54 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 11:08:56 +01:00

jump_label: Do not profile branch annotations

While running my branch profiler that checks for incorrect "likely" and
"unlikely"s around the kernel, there's a large number of them that are
incorrect due to being "static_branches".

As static_branches are rather special, as they are likely or unlikely for
other reasons than normal annotations are used for, there's no reason to
have them be profiled.

Expose the "unlikely_notrace" and "likely_notrace" so that the
static_branch can use them, and have them be ignored by the branch
profilers.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201211163754.585174b9@gandalf.local.home
---
 include/linux/compiler.h   |  2 ++
 include/linux/jump_label.h | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b8fe0c2..df5b405 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -76,6 +76,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #else
 # define likely(x)	__builtin_expect(!!(x), 1)
 # define unlikely(x)	__builtin_expect(!!(x), 0)
+# define likely_notrace(x)	likely(x)
+# define unlikely_notrace(x)	unlikely(x)
 #endif
 
 /* Optimization barrier */
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3280962..d926912 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -261,14 +261,14 @@ static __always_inline void jump_label_init(void)
 
 static __always_inline bool static_key_false(struct static_key *key)
 {
-	if (unlikely(static_key_count(key) > 0))
+	if (unlikely_notrace(static_key_count(key) > 0))
 		return true;
 	return false;
 }
 
 static __always_inline bool static_key_true(struct static_key *key)
 {
-	if (likely(static_key_count(key) > 0))
+	if (likely_notrace(static_key_count(key) > 0))
 		return true;
 	return false;
 }
@@ -460,7 +460,7 @@ extern bool ____wrong_branch_error(void);
 		branch = !arch_static_branch_jump(&(x)->key, true);		\
 	else									\
 		branch = ____wrong_branch_error();				\
-	likely(branch);								\
+	likely_notrace(branch);								\
 })
 
 #define static_branch_unlikely(x)						\
@@ -472,13 +472,13 @@ extern bool ____wrong_branch_error(void);
 		branch = arch_static_branch(&(x)->key, false);			\
 	else									\
 		branch = ____wrong_branch_error();				\
-	unlikely(branch);							\
+	unlikely_notrace(branch);							\
 })
 
 #else /* !CONFIG_JUMP_LABEL */
 
-#define static_branch_likely(x)		likely(static_key_enabled(&(x)->key))
-#define static_branch_unlikely(x)	unlikely(static_key_enabled(&(x)->key))
+#define static_branch_likely(x)		likely_notrace(static_key_enabled(&(x)->key))
+#define static_branch_unlikely(x)	unlikely_notrace(static_key_enabled(&(x)->key))
 
 #endif /* CONFIG_JUMP_LABEL */
 
