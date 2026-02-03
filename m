Return-Path: <linux-tip-commits+bounces-8194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOKOIMragWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D71D83F8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB7FC313512A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E96332EBC;
	Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SEw9VlH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TAfNhSG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04073333745;
	Tue,  3 Feb 2026 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117529; cv=none; b=nQZYcArSK23M4yGYfF+02JtvYMK4dDy5PqIzGGDjuXbzhjHphTkK4xK7NBlq+UUyCqLL53zRnV/lurBew8gvL1agexz6KoKpSn+36y/Q7qYFtqILWGyhhYSgBdjdTVX7MAnriPTKTVyTA0enFepMDyO80PyqJUP6XREkFmW4ioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117529; c=relaxed/simple;
	bh=LkkE5g17lg35SxZ3riTq2Z4AJdxjDwdoua6FoVHbC0Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ac7VRT1KlY5k/G9dV8oN2UXMOYFJ9bn+LLBaHP5oex0gN2hSvOdZC3WHbbxbuia32dKS+pOhXN6UP+VelJ5Zt126bkO+lEboB5N32VR52O395X/DssBeISbINMW18paf5aDMaD6CZ2b2sw+rNgdz/WNqzjgARSiLT3SjZ4eRR/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SEw9VlH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TAfNhSG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5QTNDKmd+VwxsjZa1+QElnFg+9G/jqEK0XPEz+MErI=;
	b=1SEw9VlH8gcRbQR7T99PtLKw7eTwL+Mi4dGWPB1+NlM4sQ+zNK08lByeOyZYoHFidMyAH7
	roZO6XRkLGncSHD8VVO8NYWCyhMU/wtx+13p7swoUkIF0kZBlaMIIVTvB+Zk4rSzHaPIdn
	olI28VQPlXx5pjNND3El8VFfA1AwYdG2LyBFQKRnmitPlI+LH1m00Sqqty8fkJ/IjpGA/l
	KSLU3tN5PBctiRRCDxCZaKoZgFv4CMi7mZNHM8fR95jUdgvKpHB3QMr0n1pZ3p32FALu28
	9gZOXzdwBDKrX+u5QjMlncUpj/c3nt3wF3Yny5ytn/kOiXhHkORCqbHfoEKbcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5QTNDKmd+VwxsjZa1+QElnFg+9G/jqEK0XPEz+MErI=;
	b=3TAfNhSGpxwpg9l2G2ERyopPEmOeBc2TSryVo7Odpe216NAQUczO+6PRltVU76rq3tAcnT
	WaDhAvy2Jd2aFvDw==
From: "tip-bot2 for Joel Fernandes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/debug: Add support to change sched_ext server params
Cc: Andrea Righi <arighi@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260126100050.3854740-6-arighi@nvidia.com>
References: <20260126100050.3854740-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011752053.2495410.7129705261433888025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8194-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,msgid.link:url,infradead.org:email,nvidia.com:email,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: E0D71D83F8
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     76d12132ba459ab929cb66eb2030c666aacdb69a
Gitweb:        https://git.kernel.org/tip/76d12132ba459ab929cb66eb2030c666aac=
db69a
Author:        Joel Fernandes <joelagnelf@nvidia.com>
AuthorDate:    Mon, 26 Jan 2026 10:59:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:17 +01:00

sched/debug: Add support to change sched_ext server params

When a sched_ext server is loaded, tasks in the fair class are
automatically moved to the sched_ext class. Add support to modify the
ext server parameters similar to how the fair server parameters are
modified.

Re-use common code between ext and fair servers as needed.

Co-developed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-6-arighi@nvidia.com
---
 kernel/sched/debug.c | 157 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 41e3895..59e650f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -330,14 +330,16 @@ enum dl_param {
 	DL_PERIOD,
 };
=20
-static unsigned long fair_server_period_max =3D (1UL << 22) * NSEC_PER_USEC;=
 /* ~4 seconds */
-static unsigned long fair_server_period_min =3D (100) * NSEC_PER_USEC;     /=
* 100 us */
+static unsigned long dl_server_period_max =3D (1UL << 22) * NSEC_PER_USEC; /=
* ~4 seconds */
+static unsigned long dl_server_period_min =3D (100) * NSEC_PER_USEC;     /* =
100 us */
=20
-static ssize_t sched_fair_server_write(struct file *filp, const char __user =
*ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __use=
r *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq =3D cpu_rq(cpu);
+	struct sched_dl_entity *dl_se =3D (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval =3D 0;
 	size_t err;
@@ -350,8 +352,8 @@ static ssize_t sched_fair_server_write(struct file *filp,=
 const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
=20
-		runtime  =3D rq->fair_server.dl_runtime;
-		period =3D rq->fair_server.dl_period;
+		runtime =3D dl_se->dl_runtime;
+		period =3D dl_se->dl_period;
=20
 		switch (param) {
 		case DL_RUNTIME:
@@ -367,25 +369,25 @@ static ssize_t sched_fair_server_write(struct file *fil=
p, const char __user *ubu
 		}
=20
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
=20
-		is_active =3D dl_server_active(&rq->fair_server);
+		is_active =3D dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
=20
-		retval =3D dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval =3D dl_server_apply_params(dl_se, runtime, period, 0);
=20
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to =
starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled in CPU %d, system may crash due to st=
arvation.\n",
+					server =3D=3D &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
=20
 		if (is_active && runtime)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
=20
 		if (retval < 0)
 			return retval;
@@ -395,36 +397,42 @@ static ssize_t sched_fair_server_write(struct file *fil=
p, const char __user *ubu
 	return cnt;
 }
=20
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_pa=
ram param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_=
param param,
+				       void *server)
 {
-	unsigned long cpu =3D (unsigned long) m->private;
-	struct rq *rq =3D cpu_rq(cpu);
+	struct sched_dl_entity *dl_se =3D (struct sched_dl_entity *)server;
 	u64 value;
=20
 	switch (param) {
 	case DL_RUNTIME:
-		value =3D rq->fair_server.dl_runtime;
+		value =3D dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value =3D rq->fair_server.dl_period;
+		value =3D dl_se->dl_period;
 		break;
 	}
=20
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
=20
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
=20
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu =3D (unsigned long) m->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
=20
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *=
filp)
@@ -440,16 +448,57 @@ static const struct file_operations fair_server_runtime=
_fops =3D {
 	.release	=3D single_release,
 };
=20
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu =3D (unsigned long) m->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *f=
ilp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops =3D {
+	.open		=3D sched_ext_server_runtime_open,
+	.write		=3D sched_ext_server_runtime_write,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
=20
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu =3D (unsigned long) m->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
=20
 static int sched_fair_server_period_open(struct inode *inode, struct file *f=
ilp)
@@ -465,6 +514,40 @@ static const struct file_operations fair_server_period_f=
ops =3D {
 	.release	=3D single_release,
 };
=20
+#ifdef CONFIG_SCHED_CLASS_EXT
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu =3D (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu =3D (unsigned long) m->private;
+	struct rq *rq =3D cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *fi=
lp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops =3D {
+	.open		=3D sched_ext_server_period_open,
+	.write		=3D sched_ext_server_period_write,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static struct dentry *debugfs_sched;
=20
 static void debugfs_fair_server_init(void)
@@ -488,6 +571,29 @@ static void debugfs_fair_server_init(void)
 	}
 }
=20
+#ifdef CONFIG_SCHED_CLASS_EXT
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext =3D debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu =3D debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runt=
ime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_perio=
d_fops);
+	}
+}
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -526,6 +632,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
=20
 	debugfs_fair_server_init();
+#ifdef CONFIG_SCHED_CLASS_EXT
+	debugfs_ext_server_init();
+#endif
=20
 	return 0;
 }

