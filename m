Return-Path: <linux-tip-commits+bounces-8096-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NdaBzX6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8096-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:21:41 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AF65294
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF1F0509ED2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF3352C51;
	Thu, 22 Jan 2026 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nE3S1RYP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzzFx+Kp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5732824D;
	Thu, 22 Jan 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076943; cv=none; b=vFtopvqonekocnsPOl4cj6FRTRn/jval+U+PG77neBhfBYVEvl91Y6ceLd0kaPyJy8IclAjlSvBR9Fe08R8gxIQ0FXMi3QK3pLliCKQYEFzQEAQt1ks/1o6U3KdIfwmmeliZnPj8YKaBBwRvSLASohZ06ER//wxqSMTp4DqP4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076943; c=relaxed/simple;
	bh=kf5TccnknoDdd0fi3TBW+/BM68rvYiYQzDf3Q6UUIWE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AweRpR4IqNXpCYc//UySnTcnTALzBeBbNmiSHz5zPFfxp6YUwdHN5TJAPj6cxOrSRClwHnLn//bVCIJt5pfkvdE01Vf0eTgWRKIck2g7VKShTJcblZyXx7BhxEbHwk+3otlm8wRdiyPBjKzTuIslaJ2U7NSy/jeO4nXKZ/LzYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nE3S1RYP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzzFx+Kp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bm1j+Ujtsav4NNE6VL4cW5aYFLpAh5BLPgeBvVCaU/Q=;
	b=nE3S1RYPceRoKIYOO8TfPt+Lpp/vPa/MSRw01u3464+XQUIDz9YTeQ9fYKO9gqkS5M720Y
	5vTEQvgcqicc+Ub291VyPtzyGFGTibn971HNHv23CU6Ydy+lCMojiw9uwe216guIP999ew
	sBKpwz5WiPIoIZDX6nVK/NiAJyG+qtYdICcvZsLoVsE5CnHanlWyZQGpv3dxn2QcRzbx0Q
	kZ+aQ53QerjydeeCwV6yUwOBxoZIYHPArXIf0HvQW7dUYQ12gwKsjH1FEHlJT/CBY7S9ob
	RnJJHEKQou6JyEad8vbo68Lz8Kuh2CC5BwsEQUDIPERjqIM2TaY/fm3HD4J3/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bm1j+Ujtsav4NNE6VL4cW5aYFLpAh5BLPgeBvVCaU/Q=;
	b=uzzFx+Kpy8aQ6nyI4WO0AA+W/bKNspZ5d/Yv4uJZE/AKjDh9mgLtyhG9GcDiB3Aol7QUPv
	HcH+k087JskbbYCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Move slice_ext_nsec to debugfs
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121143207.923520192@infradead.org>
References: <20260121143207.923520192@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907693853.510.6603938718127476691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8096-lists,linux-tip-commits=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,vger.kernel.org:replyto,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: 7F0AF65294
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e1d7f54900f1e1d3003a85b78cd7105a64203ff7
Gitweb:        https://git.kernel.org/tip/e1d7f54900f1e1d3003a85b78cd7105a642=
03ff7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 21 Jan 2026 14:21:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:20 +01:00

rseq: Move slice_ext_nsec to debugfs

Move changing the slice ext duration to debugfs, a sliglty less permanent
interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121143207.923520192@infradead.org
---
 Documentation/admin-guide/sysctl/kernel.rst | 11 +---
 Documentation/userspace-api/rseq.rst        |  4 +-
 kernel/rseq.c                               | 69 +++++++++++++-------
 3 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admi=
n-guide/sysctl/kernel.rst
index b09d18e..239da22 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1248,17 +1248,6 @@ reboot-cmd (SPARC only)
 ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
=20
-rseq_slice_extension_nsec
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-A task can request to delay its scheduling if it is in a critical section
-via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
-allowed extension in nanoseconds before scheduling of the task is enforced.
-Default value is 10000ns (10us). The possible range is 10000ns (10us) to
-50000ns (50us).
-
-This value has a direct correlation to the worst case scheduling latency;
-increment at your own risk.
=20
 sched_energy_aware
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-a=
pi/rseq.rst
index e1fdb0d..29af6c3 100644
--- a/Documentation/userspace-api/rseq.rst
+++ b/Documentation/userspace-api/rseq.rst
@@ -79,7 +79,9 @@ slice extension by setting rseq::slice_ctrl::request to 1. =
If the thread is
 interrupted and the interrupt results in a reschedule request in the
 kernel, then the kernel can grant a time slice extension and return to
 userspace instead of scheduling out. The length of the extension is
-determined by the ``rseq_slice_extension_nsec`` sysctl.
+determined by debugfs:rseq/slice_ext_nsec. The default value is 10 usec; whi=
ch
+is the minimum value. It can be incremented to 50 usecs, however doing so
+can/will affect the minimum scheduling latency.
=20
 The kernel indicates the grant by clearing rseq::slice_ctrl::request and
 setting rseq::slice_ctrl::granted to 1. If there is a reschedule of the
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 1c5490a..e423a9b 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -123,7 +123,6 @@ void __rseq_trace_ip_fixup(unsigned long ip, unsigned lon=
g start_ip,
 }
 #endif /* CONFIG_TRACEPOINTS */
=20
-#ifdef CONFIG_DEBUG_FS
 #ifdef CONFIG_RSEQ_STATS
 DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
=20
@@ -222,16 +221,19 @@ static const struct file_operations debug_ops =3D {
 	.release	=3D single_release,
 };
=20
+static void rseq_slice_ext_init(struct dentry *root_dir);
+
 static int __init rseq_debugfs_init(void)
 {
 	struct dentry *root_dir =3D debugfs_create_dir("rseq", NULL);
=20
 	debugfs_create_file("debug", 0644, root_dir, NULL, &debug_ops);
 	rseq_stats_init(root_dir);
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+		rseq_slice_ext_init(root_dir);
 	return 0;
 }
 __initcall(rseq_debugfs_init);
-#endif /* CONFIG_DEBUG_FS */
=20
 static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 no=
de_id)
 {
@@ -515,7 +517,9 @@ struct slice_timer {
 	void		*cookie;
 };
=20
-unsigned int rseq_slice_ext_nsecs __read_mostly =3D 10 * NSEC_PER_USEC;
+static const unsigned int rseq_slice_ext_nsecs_min =3D 10 * NSEC_PER_USEC;
+static const unsigned int rseq_slice_ext_nsecs_max =3D 50 * NSEC_PER_USEC;
+unsigned int rseq_slice_ext_nsecs __read_mostly =3D rseq_slice_ext_nsecs_min;
 static DEFINE_PER_CPU(struct slice_timer, slice_timer);
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
=20
@@ -761,30 +765,48 @@ SYSCALL_DEFINE0(rseq_slice_yield)
 	return yielded;
 }
=20
-#ifdef CONFIG_SYSCTL
-static const unsigned int rseq_slice_ext_nsecs_min =3D 10 * NSEC_PER_USEC;
-static const unsigned int rseq_slice_ext_nsecs_max =3D 50 * NSEC_PER_USEC;
+static int rseq_slice_ext_show(struct seq_file *m, void *p)
+{
+	seq_printf(m, "%d\n", rseq_slice_ext_nsecs);
+	return 0;
+}
+
+static ssize_t rseq_slice_ext_write(struct file *file, const char __user *ub=
uf,
+				    size_t count, loff_t *ppos)
+{
+	unsigned int nsecs;
+
+	if (kstrtouint_from_user(ubuf, count, 10, &nsecs))
+		return -EINVAL;
+
+	if (nsecs < rseq_slice_ext_nsecs_min)
+		return -ERANGE;
=20
-static const struct ctl_table rseq_slice_ext_sysctl[] =3D {
-	{
-		.procname	=3D "rseq_slice_extension_nsec",
-		.data		=3D &rseq_slice_ext_nsecs,
-		.maxlen		=3D sizeof(unsigned int),
-		.mode		=3D 0644,
-		.proc_handler	=3D proc_douintvec_minmax,
-		.extra1		=3D (unsigned int *)&rseq_slice_ext_nsecs_min,
-		.extra2		=3D (unsigned int *)&rseq_slice_ext_nsecs_max,
-	},
+	if (nsecs > rseq_slice_ext_nsecs_max)
+		return -ERANGE;
+
+	rseq_slice_ext_nsecs =3D nsecs;
+
+	return count;
+}
+
+static int rseq_slice_ext_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rseq_slice_ext_show, inode->i_private);
+}
+
+static const struct file_operations slice_ext_ops =3D {
+	.open		=3D rseq_slice_ext_open,
+	.read		=3D seq_read,
+	.write		=3D rseq_slice_ext_write,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
 };
=20
-static void rseq_slice_sysctl_init(void)
+static void rseq_slice_ext_init(struct dentry *root_dir)
 {
-	if (rseq_slice_extension_enabled())
-		register_sysctl_init("kernel", rseq_slice_ext_sysctl);
+	debugfs_create_file("slice_ext_nsec", 0644, root_dir, NULL, &slice_ext_ops);
 }
-#else /* CONFIG_SYSCTL */
-static inline void rseq_slice_sysctl_init(void) { }
-#endif  /* !CONFIG_SYSCTL */
=20
 static int __init rseq_slice_cmdline(char *str)
 {
@@ -807,8 +829,9 @@ static int __init rseq_slice_init(void)
 		hrtimer_setup(per_cpu_ptr(&slice_timer.timer, cpu), rseq_slice_expired,
 			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
 	}
-	rseq_slice_sysctl_init();
 	return 0;
 }
 device_initcall(rseq_slice_init);
+#else
+static void rseq_slice_ext_init(struct dentry *root_dir) { }
 #endif /* CONFIG_RSEQ_SLICE_EXTENSION */

