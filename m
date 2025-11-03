Return-Path: <linux-tip-commits+bounces-7188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38ABC2C880
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC601893850
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05401316909;
	Mon,  3 Nov 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1gXS4j8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQtekrVm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0C3164CE;
	Mon,  3 Nov 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181260; cv=none; b=a960MD8lwqK9nVCgYEEe4+fSGZ0gh9LJtkrUdIFVsI5ws9NskPqffzoLyvNKJ81F4w/cIEgVtJa/I7JvB3pLXE+SHjlFsfkeJR/mHwhtR521kp59yPW7KjVp4UTtivmN/7MUGsRD21bB51OnCDstnM14IyUhL8f4ux7wUmV+5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181260; c=relaxed/simple;
	bh=rsVa0A8JXO04SQj2kNBiec7hjNvDGdY0dFmNSXg36xI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sBYk6FAQDsj2OLCLpS3jE8xHlKWuAjNAEudkRtqDuYWuIjfyB6KVNZai5HYm9QJLqaDj5TCuCK6Z/6eXR2KPqfhlysFz/0NBBxzU+/P4Yf3F/4b8sbk2V3YEhO8O0vJqQ4s1HID0lPrFYnjaIVqxRxbHbEXQW52MI/XzH/PYW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1gXS4j8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQtekrVm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vU6A81+g27H6BgroJ/1iEUHY3WUmgSMi4LKWaV45eRU=;
	b=J1gXS4j8lUDIeRcoQ5Et/0hgAiZQi2Tv1W0/0q+MPI5akZOhxWpl/yYAJfE5gRPupN0Bls
	wZKIjU7rLak0xuOml8jCY65puwa3Br1oD2q5eIkmjp62ZlVp6HybgcdFppGtg/nRIaQbGV
	jvH2r0lFi3rQ/NI8URMmdETfrrotPXliXsVcK802fT+Iizri177DX+zksOf0rEaz+1217w
	ByLw0XGOvr5vDYYlGIUKzbXmqqO8UWSSBHeT7apHHvfH+LFj23aUJWQ3Q3nMYVMdYwTqjA
	T23UhcVXuKY1F2wHWY1CQQ5tiTgC469TvqHQrQI17TTzXWZMDqQUBh3LWl0jgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181257;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vU6A81+g27H6BgroJ/1iEUHY3WUmgSMi4LKWaV45eRU=;
	b=jQtekrVmhDGXLuvQg9JidIQ8NfMWgzm68hM/WAT9CLlYchYys5VNP+CgyF0dMJU851M4eW
	b1uY79j6bTCADZAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Provide static branch for runtime debugging
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.089270547@linutronix.de>
References: <20251027084307.089270547@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218125615.2601451.12825797052567741642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     01395f041c84fd0be161efbaba3a76dabc16125e
Gitweb:        https://git.kernel.org/tip/01395f041c84fd0be161efbaba3a76dabc1=
6125e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:18 +01:00

rseq: Provide static branch for runtime debugging

Config based debug is rarely turned on and is not available easily when
things go wrong.

Provide a static branch to allow permanent integration of debug mechanisms
along with the usual toggles in Kconfig, command line and debugfs.

Requested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.089270547@linutronix.de
---
 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 include/linux/rseq_entry.h                      |  3 +-
 init/Kconfig                                    | 14 +++-
 kernel/rseq.c                                   | 73 +++++++++++++++-
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 6c42061..e638274 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6500,6 +6500,10 @@
 			Memory area to be used by remote processor image,
 			managed by CMA.
=20
+	rseq_debug=3D	[KNL] Enable or disable restartable sequence
+			debug mode. Defaults to CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE.
+			Format: <bool>
+
 	rt_group_sched=3D	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
 			when CONFIG_RT_GROUP_SCHED=3Dy. Defaults to
 			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index ff9080b..ed8e5f8 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -34,6 +34,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
 #endif /* !CONFIG_RSEQ_STATS */
=20
 #ifdef CONFIG_RSEQ
+#include <linux/jump_label.h>
 #include <linux/rseq.h>
=20
 #include <linux/tracepoint-defs.h>
@@ -64,6 +65,8 @@ static inline void rseq_trace_ip_fixup(unsigned long ip, un=
signed long start_ip,
 				       unsigned long offset, unsigned long abort_ip) { }
 #endif /* !CONFIG_TRACEPOINT */
=20
+DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enable=
d);
+
 static __always_inline void rseq_note_user_irq_entry(void)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
diff --git a/init/Kconfig b/init/Kconfig
index f39fdfb..bde40ab 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1925,10 +1925,24 @@ config RSEQ_STATS
=20
 	  If unsure, say N.
=20
+config RSEQ_DEBUG_DEFAULT_ENABLE
+	default n
+	bool "Enable restartable sequences debug mode by default" if EXPERT
+	depends on RSEQ
+	help
+	  This enables the static branch for debug mode of restartable
+	  sequences.
+
+	  This also can be controlled on the kernel command line via the
+	  command line parameter "rseq_debug=3D0/1" and through debugfs.
+
+	  If unsure, say N.
+
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
 	depends on RSEQ && DEBUG_KERNEL
+	select RSEQ_DEBUG_DEFAULT_ENABLE
 	help
 	  Enable extra debugging checks for the rseq system call.
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index c0dbe2e..679ab8e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -95,6 +95,27 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
=20
+DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled=
);
+
+static inline void rseq_control_debug(bool on)
+{
+	if (on)
+		static_branch_enable(&rseq_debug_enabled);
+	else
+		static_branch_disable(&rseq_debug_enabled);
+}
+
+static int __init rseq_setup_debug(char *str)
+{
+	bool on;
+
+	if (kstrtobool(str, &on))
+		return -EINVAL;
+	rseq_control_debug(on);
+	return 1;
+}
+__setup("rseq_debug=3D", rseq_setup_debug);
+
 #ifdef CONFIG_TRACEPOINTS
 /*
  * Out of line, so the actual update functions can be in a header to be
@@ -112,10 +133,11 @@ void __rseq_trace_ip_fixup(unsigned long ip, unsigned l=
ong start_ip,
 }
 #endif /* CONFIG_TRACEPOINTS */
=20
+#ifdef CONFIG_DEBUG_FS
 #ifdef CONFIG_RSEQ_STATS
 DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
=20
-static int rseq_debug_show(struct seq_file *m, void *p)
+static int rseq_stats_show(struct seq_file *m, void *p)
 {
 	struct rseq_stats stats =3D { };
 	unsigned int cpu;
@@ -140,14 +162,56 @@ static int rseq_debug_show(struct seq_file *m, void *p)
 	return 0;
 }
=20
+static int rseq_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rseq_stats_show, inode->i_private);
+}
+
+static const struct file_operations stat_ops =3D {
+	.open		=3D rseq_stats_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int __init rseq_stats_init(struct dentry *root_dir)
+{
+	debugfs_create_file("stats", 0444, root_dir, NULL, &stat_ops);
+	return 0;
+}
+#else
+static inline void rseq_stats_init(struct dentry *root_dir) { }
+#endif /* CONFIG_RSEQ_STATS */
+
+static int rseq_debug_show(struct seq_file *m, void *p)
+{
+	bool on =3D static_branch_unlikely(&rseq_debug_enabled);
+
+	seq_printf(m, "%d\n", on);
+	return 0;
+}
+
+static ssize_t rseq_debug_write(struct file *file, const char __user *ubuf,
+			    size_t count, loff_t *ppos)
+{
+	bool on;
+
+	if (kstrtobool_from_user(ubuf, count, &on))
+		return -EINVAL;
+
+	rseq_control_debug(on);
+	return count;
+}
+
 static int rseq_debug_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, rseq_debug_show, inode->i_private);
 }
=20
-static const struct file_operations dfs_ops =3D {
+static const struct file_operations debug_ops =3D {
 	.open		=3D rseq_debug_open,
 	.read		=3D seq_read,
+	.write		=3D rseq_debug_write,
 	.llseek		=3D seq_lseek,
 	.release	=3D single_release,
 };
@@ -156,11 +220,12 @@ static int __init rseq_debugfs_init(void)
 {
 	struct dentry *root_dir =3D debugfs_create_dir("rseq", NULL);
=20
-	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
+	debugfs_create_file("debug", 0644, root_dir, NULL, &debug_ops);
+	rseq_stats_init(root_dir);
 	return 0;
 }
 __initcall(rseq_debugfs_init);
-#endif /* CONFIG_RSEQ_STATS */
+#endif /* CONFIG_DEBUG_FS */
=20
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)

