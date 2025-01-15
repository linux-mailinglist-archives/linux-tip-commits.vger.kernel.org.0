Return-Path: <linux-tip-commits+bounces-3224-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6ACA11D44
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E56C3A9F2B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C1234981;
	Wed, 15 Jan 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlGFdvD0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkuXBraQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A6236A6E;
	Wed, 15 Jan 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932641; cv=none; b=Xe3HgVC8GP8RfsbjXN01G9fnRm/gqVeKT2dR39OBiYGaHtojS97YshfQCIr9Zo78B/hne+HfUNsRIVFeIsXox1a8Ti2BzzeNjlzbXRsLo+xIAILpePOD9Sw5q0V2x5ScCqAqyWNs9OSRCappaInyN29aFpw7E37tU5tRoRXDMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932641; c=relaxed/simple;
	bh=YpXKpQQETMEmck3HRcQgEFFRwFZHoi9KmOPEyl8Wx3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GT5FLHX0itslXrckDCMzSOcN3E4aBlmx/onISLjVzzlVyrnb9h+tuZrqQUroNpSnu4m2D4ilAIlBqv+P6mbBLkB4/H9W9PBzgQyk6LdFfmS+nU7/ScNOIBp1k/R/MUgXx+lySMB9sbFvJ8t84RqEgO2O9Q7iemZdLxnYD2X9lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlGFdvD0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkuXBraQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3BvKjOchkbshnRxwXidXW47mEpAST2MS2fWuciW6QE=;
	b=dlGFdvD0H5dFeF+VofUWz8sQXRRQr1RiXqTCTeN9DTd8XviKstmAjGdow/rRURKCPVWyO7
	sSshdI5JJ/TGoxZsSLpdtGJTxxpzj1/VBeBQWa67tNQ2AbQFAuA0RFvORQTit4woZ0Deyo
	JkVoeoLTC1tV+Qrvponb5RsrGu62/AP4xsyR7ZMUlp6InJhY/4k3ggkVjx77fd0kJN1AL7
	IY2TDmMUiUrQblioFXgFI5yHFsBucchrhPXVwYk5MdeLuhrTMPX1GG0RJY/q2B16KgHCGf
	Ds4lkvICMc+uZzHJGijfd+9dnGfvL2bkUVIcJCKKO3O61gRfF7fVy2/4kNzU6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o3BvKjOchkbshnRxwXidXW47mEpAST2MS2fWuciW6QE=;
	b=TkuXBraQQWDqsoFZM53ker37kXPxAGl4lS/VkFRABAajO/8eo1lUxm05v29B/+BaN7trr6
	xl7APbdRp60gnsAA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] x86/itmt: Move the "sched_itmt_enabled" sysctl to debugfs
Cc: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-4-kprateek.nayak@amd.com>
References: <20241223043407.1611-4-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263689.31546.15174865187592950218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d04013a4b21bd5a4e10c42f71ed1e5e299cacdfe
Gitweb:        https://git.kernel.org/tip/d04013a4b21bd5a4e10c42f71ed1e5e299cacdfe
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:02 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:24 +01:00

x86/itmt: Move the "sched_itmt_enabled" sysctl to debugfs

"sched_itmt_enabled" was only introduced as a debug toggle for any funky
ITMT behavior. Move the sysctl controlled from
"/proc/sys/kernel/sched_itmt_enabled" to debugfs at
"/sys/kernel/debug/x86/sched_itmt_enabled" with a notable change that a
cat on the file will return "Y" or "N" instead of "1" or "0" to
indicate that feature is enabled or disabled respectively. Either "0" or
"N" (or any string that kstrtobool() interprets as false) can be written
to the file will disable the feature, and writing  either "1" or "Y" (or
any string that kstrtobool() interprets as true) will enable it back
when the platform supports ITMT ranking.

Since ITMT is x86 specific (and PowerPC uses SD_ASYM_PACKING too), the
toggle was moved to "/sys/kernel/debug/x86/" as opposed to
"/sys/kernel/debug/sched/"

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20241223043407.1611-4-kprateek.nayak@amd.com
---
 arch/x86/kernel/itmt.c | 56 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index ee43d1b..9cea1fc 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
+#include <linux/debugfs.h>
 #include <linux/mutex.h>
 #include <linux/sysctl.h>
 #include <linux/nodemask.h>
@@ -34,45 +35,38 @@ static bool __read_mostly sched_itmt_capable;
  * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
  * Technology 3.0.
  *
- * It can be set via /proc/sys/kernel/sched_itmt_enabled
+ * It can be set via /sys/kernel/debug/x86/sched_itmt_enabled
  */
 bool __read_mostly sysctl_sched_itmt_enabled;
 
-static int sched_itmt_update_handler(const struct ctl_table *table, int write,
-				     void *buffer, size_t *lenp, loff_t *ppos)
+static ssize_t sched_itmt_enabled_write(struct file *filp,
+					const char __user *ubuf,
+					size_t cnt, loff_t *ppos)
 {
-	unsigned int old_sysctl;
-	int ret;
+	ssize_t result;
+	bool orig;
 
 	guard(mutex)(&itmt_update_mutex);
 
-	if (!sched_itmt_capable)
-		return -EINVAL;
-
-	old_sysctl = sysctl_sched_itmt_enabled;
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	orig = sysctl_sched_itmt_enabled;
+	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
 
-	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
+	if (sysctl_sched_itmt_enabled != orig) {
 		x86_topology_update = true;
 		rebuild_sched_domains();
 	}
 
-	return ret;
+	return result;
 }
 
-static struct ctl_table itmt_kern_table[] = {
-	{
-		.procname	= "sched_itmt_enabled",
-		.data		= &sysctl_sched_itmt_enabled,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_itmt_update_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+static const struct file_operations dfs_sched_itmt_fops = {
+	.read =         debugfs_read_file_bool,
+	.write =        sched_itmt_enabled_write,
+	.open =         simple_open,
+	.llseek =       default_llseek,
 };
 
-static struct ctl_table_header *itmt_sysctl_header;
+static struct dentry *dfs_sched_itmt;
 
 /**
  * sched_set_itmt_support() - Indicate platform supports ITMT
@@ -98,9 +92,15 @@ int sched_set_itmt_support(void)
 	if (sched_itmt_capable)
 		return 0;
 
-	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
-	if (!itmt_sysctl_header)
+	dfs_sched_itmt = debugfs_create_file_unsafe("sched_itmt_enabled",
+						    0644,
+						    arch_debugfs_dir,
+						    &sysctl_sched_itmt_enabled,
+						    &dfs_sched_itmt_fops);
+	if (IS_ERR_OR_NULL(dfs_sched_itmt)) {
+		dfs_sched_itmt = NULL;
 		return -ENOMEM;
+	}
 
 	sched_itmt_capable = true;
 
@@ -131,10 +131,8 @@ void sched_clear_itmt_support(void)
 
 	sched_itmt_capable = false;
 
-	if (itmt_sysctl_header) {
-		unregister_sysctl_table(itmt_sysctl_header);
-		itmt_sysctl_header = NULL;
-	}
+	debugfs_remove(dfs_sched_itmt);
+	dfs_sched_itmt = NULL;
 
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */

