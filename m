Return-Path: <linux-tip-commits+bounces-7853-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A6D0DCAC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B3DB304BE56
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549902EC569;
	Sat, 10 Jan 2026 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfBYQFTN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvIuAacY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C402DECCC;
	Sat, 10 Jan 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074375; cv=none; b=ZTqT2iH1eDu0VCHNVESyfVUX7vaE5bKeu9KnZDZbsruTJOD+IJnbVt7pIspnD1yqldm2SPOnEYsBarrZKeB3LT+iC6JQ7tIrw73bnJ3OL+JYhm0il7tiGn1iMbh14gCF/4K8qQi5nGIh102rqlCBoMoaSx5UDegFM2OgW0F0L1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074375; c=relaxed/simple;
	bh=S6eT8C9QWFudJabgkN3velVmNdg9SF3DQX59Cb+Y/+E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=q1tKahXxgEu4Mn/IHZuw1CjHRQSPsR8Y0C75xYvz7IHUjA6WIM1wzbzlf25eKb5fkz8cdKalGlji6BcxenUWBLvitHUPJvYnUrBE+dAupP7EOj+6hg1vbTbRDVXx3qsgIv3kY4593qhiaG+AH+/SqqqukbD6eKpfJDzlEGXU9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfBYQFTN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fvIuAacY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5kBCF2WIlinJPZuGN5obgC3dzGxHCILX028y1L/Fgw8=;
	b=pfBYQFTNceU/NoVUx0+g8e6f+F0At6Crx6viFtAVJ1aHQkm9B9KobOfHbtO3AuzDAPk5qX
	LEWJAzyMEbe3CylXQDIG+MhAPhZmRie+CWV2RIBYvhPdL1Qa9FxeuKD6ZMwTlEGUWeZnOD
	0p948E5PA6uU2agNW8539l/qw7hAA4ZKm85jOh3IBbCyugnPvyWWIQ01iegPL1OV0LLZ+E
	7DVrgNeECHiyYJgqb0yg6KgHdHXt5o7fCKfd1XPGS492xDKIRzteGiSzLPP3JCNquOrtW7
	wf/IPu7bs0SvpbVFx2P3Mo+wSnxNC8vsAKETmI39Ov7e41P3i6lk8p8qKwQDdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5kBCF2WIlinJPZuGN5obgC3dzGxHCILX028y1L/Fgw8=;
	b=fvIuAacY8r0ians0vetD/3Sf9KTifTXENvya1u8eiBRnQfK/q6BGfIqFPXEI7ovdjLo0HM
	ADVPwSyM9u4E+IBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Add an architectural hook called for
 first mount
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436834.510.6643581674604084359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     39208e73a40e0e81a5b12ddc11157c0a414df307
Gitweb:        https://git.kernel.org/tip/39208e73a40e0e81a5b12ddc11157c0a414=
df307
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 08 Jan 2026 09:42:25 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 16:36:34 +01:00

x86,fs/resctrl: Add an architectural hook called for first mount

Enumeration of Intel telemetry events is an asynchronous process involving
several mutually dependent drivers added as auxiliary devices during the
device_initcall() phase of Linux boot. The process finishes after the probe
functions of these drivers completes. But this happens after
resctrl_arch_late_init() is executed.

Tracing the enumeration process shows that it does complete a full seven
seconds before the earliest possible mount of the resctrl file system (when
included in /etc/fstab for automatic mount by systemd).

Add a hook for use by telemetry event enumeration and initialization and
run it once at the beginning of resctrl mount without any locks held.
The architecture is responsible for any required locking.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20260105191711.GBaVwON5nZn-uO6Sqg@fat_crate.l=
ocal
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++++
 fs/resctrl/rdtgroup.c              | 3 +++
 include/linux/resctrl.h            | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 9222eee..a2b7f86 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -726,6 +726,10 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 	return 0;
 }
=20
+void resctrl_arch_pre_mount(void)
+{
+}
+
 enum {
 	RDT_FLAG_CMT,
 	RDT_FLAG_MBM_TOTAL,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 771e40f..0e3b8bc 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -18,6 +18,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
+#include <linux/once.h>
 #include <linux/resctrl.h>
 #include <linux/seq_buf.h>
 #include <linux/seq_file.h>
@@ -2785,6 +2786,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	struct rdt_resource *r;
 	int ret;
=20
+	DO_ONCE_SLEEPABLE(resctrl_arch_pre_mount);
+
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 	/*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index c43526c..2f938a5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -514,6 +514,12 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, =
struct rdt_domain_hdr *h
 void resctrl_online_cpu(unsigned int cpu);
 void resctrl_offline_cpu(unsigned int cpu);
=20
+/*
+ * Architecture hook called at beginning of first file system mount attempt.
+ * No locks are held.
+ */
+void resctrl_arch_pre_mount(void);
+
 /**
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
  *			      for this resource and domain.

