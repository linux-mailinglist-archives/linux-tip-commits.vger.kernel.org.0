Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE5D8605A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfHHKt2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 06:49:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHKt1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 06:49:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78AnBAk3125791
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:49:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78AnBAk3125791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261351;
        bh=U3Tgbs962kQvNHyxCQiC7WO4y3EUD/5J2eWvr15DwNQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Mrx/EtONmu12sFCDdxNEJ277e4rVNMk1CZGW1hVVMWEJYDaiFNL/9c44wYteLOWjv
         ebFQpwe4WC4sjb7D5mNuUkVpPHScIA4/0tnQQd3EC1FVGyUiEUuEZ+lTQUnd454eS0
         h1wuCcLfPXZXmNehYMDWlcvMEfpfxahesoFWVPGwyPaDzMPpKiJmntJs2+obkqMrds
         UYO2W9AlvnNlNPSc5A1HFTmeZ3W405wd2sSPR48az7ujV9DHEPx5oNVAsEEgQqLyBx
         WxY8jCpHuM7G3a5Ga96EAKBDLk3aFgp2Aka+pRl802zyn+WvNUbUQCaTabLVKUSRgn
         K3EqXUZ+QHVLQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78AnA2h3125786;
        Thu, 8 Aug 2019 03:49:10 -0700
Date:   Thu, 8 Aug 2019 03:49:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e57d143091f1c0b1a98140a4d2e63e113afb62c0@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] mutex: Fix up mutex_waiter usage
Git-Commit-ID: e57d143091f1c0b1a98140a4d2e63e113afb62c0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  e57d143091f1c0b1a98140a4d2e63e113afb62c0
Gitweb:     https://git.kernel.org/tip/e57d143091f1c0b1a98140a4d2e63e113afb62c0
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 8 Aug 2019 08:47:14 +0200
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:25 +0200

mutex: Fix up mutex_waiter usage

The patch moving bits into mutex.c was a little too much; by also
moving struct mutex_waiter a few less common CONFIGs would no longer
build.

Fixes: 5f35d5a66b3e ("locking/mutex: Make __mutex_owner static to mutex.c")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/mutex.h  | 13 +++++++++++++
 kernel/locking/mutex.c | 13 -------------
 kernel/locking/mutex.h |  2 --
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index eb8c62aba263..aca8f36dfac9 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -65,6 +65,19 @@ struct mutex {
 #endif
 };
 
+/*
+ * This is the control structure for tasks blocked on mutex,
+ * which resides on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	struct ww_acquire_ctx	*ww_ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+};
+
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index b4bcb0236d7a..468a9b8422e3 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -36,19 +36,6 @@
 # include "mutex.h"
 #endif
 
-/*
- * This is the control structure for tasks blocked on mutex,
- * which resides on the blocked task's kernel stack:
- */
-struct mutex_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	struct ww_acquire_ctx	*ww_ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-};
-
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 7cde5c6d414e..1c2287d3fa71 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -19,8 +19,6 @@
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 
-struct mutex_waiter;
-
 static inline void
 debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
