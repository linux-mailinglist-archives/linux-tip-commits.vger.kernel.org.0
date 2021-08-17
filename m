Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC13EF355
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhHQUPO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhHQUOv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:51 -0400
Date:   Tue, 17 Aug 2021 20:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvhLjZ+hl2RuSfAGtbIsIITBd3aKVSRNwB6UYEcKVho=;
        b=KUssHt4JoeyWjsVN2SKvFmYY2/TBiQUp9t8lR3ekE6lCYqzeOYUGIIl2NYOQ+6wZcJ4OvQ
        PQwe5ksmCdCDTEaCyFyBYO8PNbgZ0Ep5x/Zo3uH5/TNBpjROsDftXGqkU+ubhnicMrBUq6
        g7jFLUpwFXPye6CuL1fUlXPtrHlSHJo3pW/2vi0rSACxElf86/cNNYC1x5elX6u0+BcuTo
        mNcYPmFS8FVSQvVzW6t8yEzb89r8jYO9CpjMtabEvUS040aXHI1pthTtyureOtDpt0Rltu
        VrrSxX6/nuc47gCMYJwHQQAWtxpBR/+X2tlSaiwBGNlUTgmgs+u2rxrjCyBTMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvhLjZ+hl2RuSfAGtbIsIITBd3aKVSRNwB6UYEcKVho=;
        b=/rBM4V6NIhSmrFf7MUylahpWM4l925KpEup68482cgRuceD7KgSWZFmbn4umLYeGA/o0yX
        JwkxuDykYrmWuPAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Move the ww_mutex definitions
 from <linux/mutex.h> into <linux/ww_mutex.h>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211304.110216293@linutronix.de>
References: <20210815211304.110216293@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125660.25758.14087450163891307523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4f1893ec8cfb4b17e3b89158a1e3e550a9a9bf3c
Gitweb:        https://git.kernel.org/tip/4f1893ec8cfb4b17e3b89158a1e3e550a9a9bf3c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 18:24:31 +02:00

locking/ww_mutex: Move the ww_mutex definitions from <linux/mutex.h> into <linux/ww_mutex.h>

Move the ww_mutex definitions into the ww_mutex specific header where they
belong.

Preparatory change to allow compiling ww_mutexes standalone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211304.110216293@linutronix.de
---
 include/linux/mutex.h    | 11 -----------
 include/linux/ww_mutex.h |  8 ++++++++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 62bafee..db33675 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,9 +20,6 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
-struct ww_class;
-struct ww_acquire_ctx;
-
 /*
  * Simple, straightforward mutexes with strict semantics:
  *
@@ -66,14 +63,6 @@ struct mutex {
 #endif
 };
 
-struct ww_mutex {
-	struct mutex base;
-	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	struct ww_class *ww_class;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index b77f39f..590aaa2 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -28,6 +28,14 @@ struct ww_class {
 	unsigned int is_wait_die;
 };
 
+struct ww_mutex {
+	struct mutex base;
+	struct ww_acquire_ctx *ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	struct ww_class *ww_class;
+#endif
+};
+
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
