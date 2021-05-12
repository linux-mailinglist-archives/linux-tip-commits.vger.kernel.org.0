Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0A37BA6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhELK3r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhELK3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:39 -0400
Date:   Wed, 12 May 2021 10:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cDvnlLgJnlpX5hGJ8jiKNhhEhx6z82lpjP5ic7YRPM=;
        b=JSRdQkZylpbTjfkr/+WSehyDheEzUJgc5IQau6Wjb78L8DpwQskcO2peFna/Fn+oZ4qXmX
        MMWHsQby2K699jAx2uQcYiD//j8suZFYiUmvuIqtd6T2vJGGWMwjunRTGEuW8TEvTirK3U
        db+TCN7HoWFH9VjSmKUxsXRXqPs+MUbKKfQTw7hdfCJLGWwFGmRjAlqrDMDln3XRAEgNQh
        BkpdiMpHmZboR+ZhpJvwmHxhwWK/rKJ76IniNsBc6k/k+QJNKGPSTwbMf8TSeoEryqSetB
        zVUokTvtKCaznFnU1RCgzkZVushTfbXK9IUZ0S4JkrVtvUTS26TDXP4fY7XjZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cDvnlLgJnlpX5hGJ8jiKNhhEhx6z82lpjP5ic7YRPM=;
        b=rmEqycGfCRUbXFGTKIMUsZzy7lq/3zXSo/Y3UODI2W7Mr2LiGLuq9AqfhEpMDkMtPcDPUG
        3pvgF3iH7XPOt/Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] delayacct: Add static_branch in scheduler hooks
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505111525.248028369@infradead.org>
References: <20210505111525.248028369@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530948.29796.14722409380598313239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eee4d9fee2544389e5ce5697ed92db67c86d7a9f
Gitweb:        https://git.kernel.org/tip/eee4d9fee2544389e5ce5697ed92db67c86d7a9f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 May 2021 22:43:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:25 +02:00

delayacct: Add static_branch in scheduler hooks

Cheaper when delayacct is disabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210505111525.248028369@infradead.org
---
 include/linux/delayacct.h | 8 ++++++++
 kernel/delayacct.c        | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 21651f9..57fefa5 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -58,8 +58,10 @@ struct task_delay_info {
 
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_TASK_DELAY_ACCT
+DECLARE_STATIC_KEY_TRUE(delayacct_key);
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
@@ -114,6 +116,9 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
 
 static inline void delayacct_blkio_start(void)
 {
+	if (!static_branch_likely(&delayacct_key))
+		return;
+
 	delayacct_set_flag(current, DELAYACCT_PF_BLKIO);
 	if (current->delays)
 		__delayacct_blkio_start();
@@ -121,6 +126,9 @@ static inline void delayacct_blkio_start(void)
 
 static inline void delayacct_blkio_end(struct task_struct *p)
 {
+	if (!static_branch_likely(&delayacct_key))
+		return;
+
 	if (p->delays)
 		__delayacct_blkio_end(p);
 	delayacct_clear_flag(p, DELAYACCT_PF_BLKIO);
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 3a0b910..63012fd 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -14,6 +14,7 @@
 #include <linux/delayacct.h>
 #include <linux/module.h>
 
+DEFINE_STATIC_KEY_TRUE(delayacct_key);
 int delayacct_on __read_mostly = 1;	/* Delay accounting turned on/off */
 struct kmem_cache *delayacct_cache;
 
@@ -28,6 +29,8 @@ void delayacct_init(void)
 {
 	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
 	delayacct_tsk_init(&init_task);
+	if (!delayacct_on)
+		static_branch_disable(&delayacct_key);
 }
 
 void __delayacct_tsk_init(struct task_struct *tsk)
