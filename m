Return-Path: <linux-tip-commits+bounces-2256-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8019720E2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29572848F9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944E18D63A;
	Mon,  9 Sep 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKkt9CgN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1+1kUQy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0518C023;
	Mon,  9 Sep 2024 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902880; cv=none; b=e4t6B84C3nsopN+e6WDBWoQ9OkYVaplSS9GflkQcO8c8vhp6ngWlQYmujBvKMUXCqq1KLbbsP9qe6XjHZEE64RieCRV6n43sXzng09HgQ/CSNqbSYcp4+Wl68BnqMfPdthLVEzqHTR/Xh1stnaiJrcxqitmStsCeKcgv4O0OZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902880; c=relaxed/simple;
	bh=fqdu7HK8oeJW79RJ7YeiNUwOTZJdYzmp0YoCRChxanE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f+PWaGkeDcaEY/ampg9FiECTRiBWLVwFrxHBVA0fstuZNREcGB/jfoVElFpHAADAfC+44OU1uorjyKJZ9IlzXsgPNkxwtCeUNUIh2cXSj8CrSQTVfpTH2m+YGsEc8Qs6kDvHjjX86YFGl6Xw8uQBKvcJx0mClvxaXilvL3xWr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKkt9CgN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1+1kUQy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJgAUoT5V+xObaiZOFWnW9dXmthSY6sIGLDiQ1f6L2Q=;
	b=uKkt9CgNcnQwlAvHThTK8srNa90Zkos0EqdM9vT2JQgejtiv2soY/yW0TNWQfcUqknWFEP
	3MRB4OYpRZrs6ClgyNqtkAlRLR6SbLDOTZorbNUz7ay+x4zGV3l+kP8BPJ1zgsPV5uo9TV
	Hn62GPOH+0YB1wY2VcnILGiL61wns3cpEqB/NtdA4UPg/vgmtj52Nke6RMqGG+rlt9M4kN
	4lY2DIznpySqMOV0ftsxrIc58XMe2lK53iSsga5m9Xu1D0CMq1vrgzvvqKNpILKCfF+Ytc
	6gpvSeAJBUsy9ECbQhSrPdIwgdcNAVbM3T6d9dMK90fR0uytR4N6CtvF3lVlNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJgAUoT5V+xObaiZOFWnW9dXmthSY6sIGLDiQ1f6L2Q=;
	b=m1+1kUQy3KPHz7BE4GLB73geVbROro82ax09ZS2R/UC+v8OtMa0HrLGVx9JPDuKbwO0gHm
	0vPzzr9lr9BthLAQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] nbcon: Add API to acquire context for non-printing operations
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-14-john.ogness@linutronix.de>
References: <20240820063001.36405-14-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287597.2215.3608716145534467062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     adf6f37d142e14896115929f3892bbc0a86e25bf
Gitweb:        https://git.kernel.org/tip/adf6f37d142e14896115929f3892bbc0a86e25bf
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:39 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

nbcon: Add API to acquire context for non-printing operations

Provide functions nbcon_device_try_acquire() and
nbcon_device_release() which will try to acquire the nbcon
console ownership with NBCON_PRIO_NORMAL and mark it unsafe for
handover/takeover.

These functions are to be used together with the device-specific
locking when performing non-printing activities on the console
device. They will allow synchronization against the
atomic_write() callback which will be serialized, for higher
priority contexts, only by acquiring the console context
ownership.

Pitfalls:

The API requires to be called in a context with migration
disabled because it uses per-CPU variables internally.

The context is set unsafe for a takeover all the time. It
guarantees full serialization against any atomic_write() caller
except for the final flush in panic() which might try an unsafe
takeover.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-14-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  2 +-
 include/linux/printk.h  | 14 ++++++++++-
 kernel/printk/nbcon.c   | 58 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index aafe312..3706f94 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -322,6 +322,7 @@ struct nbcon_write_context {
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
+ * @nbcon_device_ctxt:	Context available for non-printing operations
  * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
@@ -417,6 +418,7 @@ struct console {
 
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
+	struct nbcon_context	__private nbcon_device_ctxt;
 	struct printk_buffers	*pbufs;
 };
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index eee8e97..9687089 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -9,6 +9,8 @@
 #include <linux/ratelimit_types.h>
 #include <linux/once_lite.h>
 
+struct console;
+
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
 
@@ -198,6 +200,8 @@ extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
+extern bool nbcon_device_try_acquire(struct console *con);
+extern void nbcon_device_release(struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -280,6 +284,16 @@ static inline void printk_trigger_flush(void)
 static inline void console_try_replay_all(void)
 {
 }
+
+static inline bool nbcon_device_try_acquire(struct console *con)
+{
+	return false;
+}
+
+static inline void nbcon_device_release(struct console *con)
+{
+}
+
 #endif
 
 bool this_cpu_in_panic(void);
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index f279f83..61f0ae6 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -5,7 +5,9 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles which does not depend
@@ -546,6 +548,7 @@ static struct printk_buffers panic_nbcon_pbufs;
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
  *
+ * Context:	Under @ctxt->con->device_lock() or local_irq_save().
  * Return:	True if the console was acquired. False otherwise.
  *
  * If the caller allowed an unsafe hostile takeover, on success the
@@ -553,7 +556,6 @@ static struct printk_buffers panic_nbcon_pbufs;
  * in an unsafe state. Otherwise, on success the caller may assume
  * the console is not in an unsafe state.
  */
-__maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
 	unsigned int cpu = smp_processor_id();
@@ -1011,3 +1013,57 @@ void nbcon_free(struct console *con)
 
 	con->pbufs = NULL;
 }
+
+/**
+ * nbcon_device_try_acquire - Try to acquire nbcon console and enter unsafe
+ *				section
+ * @con:	The nbcon console to acquire
+ *
+ * Context:	Under the locking mechanism implemented in
+ *		@con->device_lock() including disabling migration.
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * Console drivers will usually use their own internal synchronization
+ * mechasism to synchronize between console printing and non-printing
+ * activities (such as setting baud rates). However, nbcon console drivers
+ * supporting atomic consoles may also want to mark unsafe sections when
+ * performing non-printing activities in order to synchronize against their
+ * atomic_write() callback.
+ *
+ * This function acquires the nbcon console using priority NBCON_PRIO_NORMAL
+ * and marks it unsafe for handover/takeover.
+ */
+bool nbcon_device_try_acquire(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+
+	cant_migrate();
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console	= con;
+	ctxt->prio	= NBCON_PRIO_NORMAL;
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	if (!nbcon_context_enter_unsafe(ctxt))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
+
+/**
+ * nbcon_device_release - Exit unsafe section and release the nbcon console
+ * @con:	The nbcon console acquired in nbcon_device_try_acquire()
+ */
+void nbcon_device_release(struct console *con)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return;
+
+	nbcon_context_release(ctxt);
+}
+EXPORT_SYMBOL_GPL(nbcon_device_release);

