Return-Path: <linux-tip-commits+bounces-6018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BAAFC7BB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3933A2A47
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59F229B28;
	Tue,  8 Jul 2025 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4WrzYO2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/U/yrLo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D42222CC;
	Tue,  8 Jul 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969037; cv=none; b=RfTMJFT+Z+3dT9IPE5g/osTuua9RDS6rXY2HEMkvHXuuLWOU9AHmZgDHYsP5bOG06slLQC4nF4jNIEmDffuRwJv9CV7/23Ki7iQ09wy5Rf+qBtjS8yAO1I49iMBOmfk1rpG0Zup2cA/sOUvQhnAY0XnCuDAX153c+tfAWJrNihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969037; c=relaxed/simple;
	bh=fekYyiiG2tyN0Nh153ANuYAriA1/pCEFi0bOtubPJVc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nVAjG6zHtjcxlBlAnc8OdwkxAItC3swdq++sjRiFjXrIzRzGQvRwBCViWD05xe8f2xVA08mhE0EKGS+r8ETpQQ08pl+RMjNLcC4wOpnXcrH11bnDMiFoPzonB1fBaBj6xkNN+MIycr5xT4SLV3kffbyD6C+CgILwb4tcplBNh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4WrzYO2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q/U/yrLo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnh204Mbsn1V/g1azt8nha6aqff0Sh1XbE2qtAMa814=;
	b=z4WrzYO2/rq4TfCmlbfZ7EyxN5NrjqDfMNBZhpuD3DGW8dIXgJULwmJA9iFdIZMVoIQdqL
	js6OaSbvfYVslqeKyWUtn4ueRKQ3VXp/4Hj/XvzdaG7BMd95WbU7ZeEQuAsoA/xzmM0geM
	PteaYPFwm1IVSHOwe3SNaUrv5Jtx8pHOh02bQyaCgjyshqouPwPXyfgo4jxu+S+tX8L43N
	Qods/nFZw9z9fOAfF2RngR1DBzR/0XCkYV09ecFwkrfdfL/Ag/HyLws3cEwU+Fw/xLLNDu
	XgG+NYtnQcyfbzsINFuBcKZNnozQHXvqQ4hB4ysGj8U2+716Q2abp7WWWaiPXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnh204Mbsn1V/g1azt8nha6aqff0Sh1XbE2qtAMa814=;
	b=q/U/yrLo/wyIRsBeMEfLBa5VoV5ClpqnFtvNadt9ClBgx1arw4ksCqlMubckMVLCY6JE9F
	gVtuKxtO0rdjCOBw==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] x86/itmt: Add debugfs file to show core priorities
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-14-superm1@kernel.org>
References: <20250609200518.3616080-14-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903228.406.9434351357968352011.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     f12682148262aa6deed32c0593c67658573d0600
Gitweb:        https://git.kernel.org/tip/f12682148262aa6deed32c0593c67658573=
d0600
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:18 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 22:35:51 +02:00

x86/itmt: Add debugfs file to show core priorities

Multiple drivers can report priorities to ITMT. To aid in debugging
any issues with the values reported by drivers introduce a debugfs
file to read out the values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-14-superm1@kernel.org
---
 arch/x86/kernel/itmt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9cea1fc..243a769 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -59,6 +59,18 @@ static ssize_t sched_itmt_enabled_write(struct file *filp,
 	return result;
 }
=20
+static int sched_core_priority_show(struct seq_file *s, void *unused)
+{
+	int cpu;
+
+	seq_puts(s, "CPU #\tPriority\n");
+	for_each_possible_cpu(cpu)
+		seq_printf(s, "%d\t%d\n", cpu, arch_asym_cpu_priority(cpu));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(sched_core_priority);
+
 static const struct file_operations dfs_sched_itmt_fops =3D {
 	.read =3D         debugfs_read_file_bool,
 	.write =3D        sched_itmt_enabled_write,
@@ -67,6 +79,7 @@ static const struct file_operations dfs_sched_itmt_fops =3D=
 {
 };
=20
 static struct dentry *dfs_sched_itmt;
+static struct dentry *dfs_sched_core_prio;
=20
 /**
  * sched_set_itmt_support() - Indicate platform supports ITMT
@@ -102,6 +115,14 @@ int sched_set_itmt_support(void)
 		return -ENOMEM;
 	}
=20
+	dfs_sched_core_prio =3D debugfs_create_file("sched_core_priority", 0644,
+						  arch_debugfs_dir, NULL,
+						  &sched_core_priority_fops);
+	if (IS_ERR_OR_NULL(dfs_sched_core_prio)) {
+		dfs_sched_core_prio =3D NULL;
+		return -ENOMEM;
+	}
+
 	sched_itmt_capable =3D true;
=20
 	sysctl_sched_itmt_enabled =3D 1;
@@ -133,6 +154,8 @@ void sched_clear_itmt_support(void)
=20
 	debugfs_remove(dfs_sched_itmt);
 	dfs_sched_itmt =3D NULL;
+	debugfs_remove(dfs_sched_core_prio);
+	dfs_sched_core_prio =3D NULL;
=20
 	if (sysctl_sched_itmt_enabled) {
 		/* disable sched_itmt if we are no longer ITMT capable */

