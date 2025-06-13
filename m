Return-Path: <linux-tip-commits+bounces-5826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15015AD8570
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69023B377F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2AA2727E6;
	Fri, 13 Jun 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2aNnCsS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2bMyJCJG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E238258CF8;
	Fri, 13 Jun 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803110; cv=none; b=V9roQ0joXozx6zYrBSbruwSvcVwIEhEu0iXMNVb6aQrid2YkI0qn53m/r5167ZN95KEOAh/DeyrPSBQoHr0uIAhafJxn7puOQ4pcAStUVMWn674rWD4pYVNpGaGUikJUgj/w9pKxcuK+ULCDk2igcte6HbAn5lbev4og8O/Kb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803110; c=relaxed/simple;
	bh=247R6gMIs6cC84FWuPU4n6fDclrW/0zDpxU2hdHYdGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ULkWe9TZtqLO+EcRAQb2nMx6eP1WPBE9N2/7veHuOQWVmfdKPLa94a5l2dTfSRSVgGhIs3vpWa6hUDYgEDEnl4bNCmti5JhG0cRd3QtuuJY3KxG/RX61hv7z/xNw7GaQdpcjWnDBv3wW8DlrhAiR1nN0l98rVpSyUvls20UtKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2aNnCsS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2bMyJCJG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FByje//bunYQBmH9xfDEqgKwv9q13CuebdZewRAoDBs=;
	b=v2aNnCsSaRJ2G2fNYlKUMtyyiaK8TFnxoP3zy48sM77E75IziDB3oUBuUhD4hduE9C2jZw
	/i96sRNxtqwtMDHW9TevH7ujcHtOXAAjB9bEgUdX2ZL6MAo+z1BXtkfuLBz1wXPv5LM0eZ
	3kmyI1gLO+qYJ65OA9PztJZMYmvwLdrJP55CdMGxuZbX7WzO2MBr8sKXpYsYIQB2lmG7uo
	60ycje3WeF4nPr/WyvrDMDoZHP10uCbWuqZpBf2yzJmfnko+iupmHQhPXTAcV9o/UGRuFX
	6GTCJCXbHsyg1o+yYlqc1/9EmTWRRzTq4avMFonwKlPckCXTRWt4zRChkdan9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FByje//bunYQBmH9xfDEqgKwv9q13CuebdZewRAoDBs=;
	b=2bMyJCJGt+uOOsl+CFfje2YvwBl7FC7iyhYj7VXnxSRAKlHtOGTCk/63Um5ZgUNk5/8+T8
	3dOEbKgKfjkbtADQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/64: Enable popular scheduler, cgroups
 and namespaces options in the defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-12-mingo@kernel.org>
References: <20250515132719.31868-12-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310568.406.14415636981131609770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     c0fa332499207d4cb5e88f2592e23ea6c9d6c7c9
Gitweb:        https://git.kernel.org/tip/c0fa332499207d4cb5e88f2592e23ea6c9d=
6c7c9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:03:33 +02:00

x86/kconfig/64: Enable popular scheduler, cgroups and namespaces options in t=
he defconfig

Since the x86 defconfig aims to be a distro kernel work-alike with
fewer drivers and a shorter build time, enable a handful of
popular scheduler and cgroups options that are typically enabled
on major Linux distributions.

The options enabled is a superset of the latest Ubuntu and Fedora
kernel debugging configs, using Ubuntu's config-6.11.0-24-generic
file, Fedora's kernel-x86_64-fedora.config and RHEL's
kernel-x86_64-rhel.config from kernel-ark.git.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-12-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 4bd3122..d9f8fae 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -2,6 +2,7 @@ CONFIG_WERROR=3Dy
 CONFIG_SYSVIPC=3Dy
 CONFIG_POSIX_MQUEUE=3Dy
 CONFIG_AUDIT=3Dy
+# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
 CONFIG_BPF_SYSCALL=3Dy
@@ -11,26 +12,45 @@ CONFIG_BPF_PRELOAD=3Dy
 CONFIG_BPF_PRELOAD_UMD=3Dy
 CONFIG_BPF_LSM=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dy
+CONFIG_SCHED_CORE=3Dy
+CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
+CONFIG_IRQ_TIME_ACCOUNTING=3Dy
 CONFIG_BSD_PROCESS_ACCT=3Dy
+CONFIG_BSD_PROCESS_ACCT_V3=3Dy
 CONFIG_TASKSTATS=3Dy
 CONFIG_TASK_DELAY_ACCT=3Dy
 CONFIG_TASK_XACCT=3Dy
 CONFIG_TASK_IO_ACCOUNTING=3Dy
+CONFIG_PSI=3Dy
+CONFIG_PSI_DEFAULT_DISABLED=3Dy
 CONFIG_LOG_BUF_SHIFT=3D18
-CONFIG_CGROUPS=3Dy
+CONFIG_PRINTK_INDEX=3Dy
+CONFIG_UCLAMP_TASK=3Dy
+CONFIG_NUMA_BALANCING=3Dy
+CONFIG_MEMCG=3Dy
+CONFIG_MEMCG_V1=3Dy
 CONFIG_BLK_CGROUP=3Dy
-CONFIG_CGROUP_SCHED=3Dy
+CONFIG_CFS_BANDWIDTH=3Dy
+CONFIG_UCLAMP_TASK_GROUP=3Dy
 CONFIG_CGROUP_PIDS=3Dy
 CONFIG_CGROUP_RDMA=3Dy
+CONFIG_CGROUP_DMEM=3Dy
 CONFIG_CGROUP_FREEZER=3Dy
 CONFIG_CGROUP_HUGETLB=3Dy
 CONFIG_CPUSETS=3Dy
+CONFIG_CPUSETS_V1=3Dy
 CONFIG_CGROUP_DEVICE=3Dy
 CONFIG_CGROUP_CPUACCT=3Dy
 CONFIG_CGROUP_PERF=3Dy
 CONFIG_CGROUP_BPF=3Dy
 CONFIG_CGROUP_MISC=3Dy
 CONFIG_CGROUP_DEBUG=3Dy
+CONFIG_NAMESPACES=3Dy
+CONFIG_USER_NS=3Dy
+CONFIG_CHECKPOINT_RESTORE=3Dy
+CONFIG_SCHED_AUTOGROUP=3Dy
+CONFIG_SYSFS_SYSCALL=3Dy
+CONFIG_EXPERT=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
 CONFIG_PROFILING=3Dy
 CONFIG_KEXEC=3Dy
@@ -304,7 +324,6 @@ CONFIG_LIST_HARDENED=3Dy
 CONFIG_PRINTK_TIME=3Dy
 CONFIG_BOOT_PRINTK_DELAY=3Dy
 CONFIG_DYNAMIC_DEBUG=3Dy
-CONFIG_DEBUG_KERNEL=3Dy
 CONFIG_STRIP_ASM_SYMS=3Dy
 CONFIG_HEADERS_INSTALL=3Dy
 CONFIG_DEBUG_SECTION_MISMATCH=3Dy

