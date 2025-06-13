Return-Path: <linux-tip-commits+bounces-5827-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90AAD8572
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6EC3B4492
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96267272804;
	Fri, 13 Jun 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCUu0Qa0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+ciaNC+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B22726B777;
	Fri, 13 Jun 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803111; cv=none; b=ifWr9KFq0hUPuMVqganfF8XbMGMhFWyq/qe2AKgiwqg4h5V49e2BzuZU6LZCIcyKl/RjxsvRpFgf3iX2toaKWuDi1rn/SqNn489P/2GUc49zRsZWclnunNo9BaDt9+D0KXn5k3o+lt8hJajKzowOipY0yOfjVHyQttwx4A2hCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803111; c=relaxed/simple;
	bh=JxT4K3EBo5TwCltpCaGCLrHZgA8ZWdzzpq4QmIUpmGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qfvV8C/PaUpGasL0fADX2sPGHK6JCYKAbal/pPVhNAO6xuQyZ1//ZKWxcEwpsklXmuSJ85R1vMuiiz2L8wjCylxlT+H+CK89PkTKDbB76L8I+gMc45ZZ3QMMGDniIrawjUBlzZlLGEgx9BYSo8Mt/idlG+xTunJSgcCDOHeW3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCUu0Qa0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+ciaNC+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803107;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=305DmotqGozWz5+0mjGjOXk0cwN3ZChMVcwlcIPibc8=;
	b=rCUu0Qa01ZmamJaTVAR3mpFcVqW92vJbjo5ugL5tg2O2GLihCd8MoavQwvduOz2fTxp2zQ
	zc9qCS1oVuztvcpWgPmkbKhBEq5ypowClo7LF5uDBfI0XMLB6Wj3D98ulZJBwK8ZFGgdBH
	wmyRI+3AWJyoihSqk5CT2sQNQM1BmMCPmN1LjvZSmA8lwMjxvM1FsZGF5Qbylvi/y8V3cg
	o068RoAYA92/ZFVdwe7oPRHWhMEWJ5571G5g0Q3Albk51aUTvfvHOfML/IXoEkcYSgCzbU
	ForkNGONDMdZ1nF61RLUdgvIg5hkeLU7RhDgZxw8FJFdZ/k0CtBsWHROPDIyFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803107;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=305DmotqGozWz5+0mjGjOXk0cwN3ZChMVcwlcIPibc8=;
	b=V+ciaNC+jaoJhRDF29biumCvIklfUMHfiFsKygql/+zeDcdFZPlm0CT6Xhn/BeR5ECvYlH
	0Pit7GzEdUc/07Dg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/64: Enable popular kernel debugging
 options in the defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, Ivan Shapovalov <intelfx@intelfx.name>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-11-mingo@kernel.org>
References: <20250515132719.31868-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310665.406.15231839566884139146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     53bc35f2d93704ccc012fcbc2039cd72f7942e94
Gitweb:        https://git.kernel.org/tip/53bc35f2d93704ccc012fcbc2039cd72f79=
42e94
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:03:25 +02:00

x86/kconfig/64: Enable popular kernel debugging options in the defconfig

Since the x86 defconfig aims to be a distro kernel work-alike with
fewer drivers and a shorter build time, enable a handful of
kernel debugging options that are typically enabled on major Linux
distributions.

The options enabled is a superset of the latest Ubuntu and Fedora
kernel debugging configs, using Ubuntu's config-6.11.0-24-generic
file, Fedora's kernel-x86_64-fedora.config and RHEL's
kernel-x86_64-rhel.config from kernel-ark.git.

Notable features enabled:

 - CONFIG_UBSAN=3Dy:

     Despite the runtime overhead, UBSAN is actively enabled
     in all 3 major Linux distros I checked, so we want it
     enabled in the defconfig as well - to better see the
     consequences.

 - CONFIG_DEBUG_SHIRQ=3Dy:

     Fedora/RHEL have this enabled, while Ubuntu has it disabled.

 - CONFIG_LIST_HARDENED=3Dy:

     Fedora/RHEL have CONFIG_DEBUG_LIST enabled, while Ubuntu has
     it disabled, so pick the lightweight LIST_HARDENED variant.

 - CONFIG_FUNCTION_PROFILER=3Dy:

     This is enabled on all distros I checked as well.

DEBUGINFO is still disabled, despite enabled in all Linux distros,
because the ~10x .o bloat is still just so painful on anything
but the most powerful build boxes.

Note that while the following features seemingly get removed from
the defconfig :

  - CONFIG_BLK_DEV_INITRD=3Dy
  - CONFIG_KPROBES=3Dy
  - CONFIG_MAGIC_SYSRQ=3Dy

they are actually still enabled in the actual .config, because they
get selected by other options indirectly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ivan Shapovalov <intelfx@intelfx.name>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-11-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 46 ++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 0529678..4bd3122 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -31,7 +31,6 @@ CONFIG_CGROUP_PERF=3Dy
 CONFIG_CGROUP_BPF=3Dy
 CONFIG_CGROUP_MISC=3Dy
 CONFIG_CGROUP_DEBUG=3Dy
-CONFIG_BLK_DEV_INITRD=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
 CONFIG_PROFILING=3Dy
 CONFIG_KEXEC=3Dy
@@ -68,7 +67,6 @@ CONFIG_KVM_INTEL=3Dy
 CONFIG_KVM_AMD=3Dy
 CONFIG_KVM_XEN=3Dy
 CONFIG_KVM_MAX_NR_VCPUS=3D4096
-CONFIG_KPROBES=3Dy
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
@@ -302,14 +300,56 @@ CONFIG_SECURITY=3Dy
 CONFIG_SECURITY_NETWORK=3Dy
 CONFIG_SECURITY_SELINUX=3Dy
 CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
+CONFIG_LIST_HARDENED=3Dy
 CONFIG_PRINTK_TIME=3Dy
+CONFIG_BOOT_PRINTK_DELAY=3Dy
+CONFIG_DYNAMIC_DEBUG=3Dy
 CONFIG_DEBUG_KERNEL=3Dy
-CONFIG_MAGIC_SYSRQ=3Dy
+CONFIG_STRIP_ASM_SYMS=3Dy
+CONFIG_HEADERS_INSTALL=3Dy
+CONFIG_DEBUG_SECTION_MISMATCH=3Dy
+CONFIG_KGDB=3Dy
+CONFIG_KGDB_TESTS=3Dy
+CONFIG_KGDB_LOW_LEVEL_TRAP=3Dy
+CONFIG_KGDB_KDB=3Dy
+CONFIG_KDB_KEYBOARD=3Dy
+CONFIG_UBSAN=3Dy
+CONFIG_UBSAN_SHIFT=3Dy
+CONFIG_PAGE_OWNER=3Dy
+CONFIG_PAGE_POISONING=3Dy
 CONFIG_DEBUG_WX=3Dy
+CONFIG_PER_VMA_LOCK_STATS=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
+CONFIG_SCHED_STACK_END_CHECK=3Dy
+CONFIG_KFENCE=3Dy
+CONFIG_DEBUG_SHIRQ=3Dy
+CONFIG_PANIC_ON_OOPS=3Dy
+CONFIG_HARDLOCKUP_DETECTOR=3Dy
+CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
+CONFIG_WQ_CPU_INTENSIVE_REPORT=3Dy
 CONFIG_SCHEDSTATS=3Dy
+CONFIG_NMI_CHECK_CPU=3Dy
+CONFIG_RCU_CPU_STALL_CPUTIME=3Dy
+CONFIG_BOOTTIME_TRACING=3Dy
+CONFIG_FUNCTION_GRAPH_RETVAL=3Dy
+CONFIG_FPROBE=3Dy
+CONFIG_FUNCTION_PROFILER=3Dy
+CONFIG_STACK_TRACER=3Dy
+CONFIG_SCHED_TRACER=3Dy
+CONFIG_HWLAT_TRACER=3Dy
+CONFIG_TIMERLAT_TRACER=3Dy
+CONFIG_MMIOTRACE=3Dy
+CONFIG_FTRACE_SYSCALLS=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
+CONFIG_USER_EVENTS=3Dy
+CONFIG_HIST_TRIGGERS=3Dy
+CONFIG_TRACE_EVENT_INJECT=3Dy
+CONFIG_RV=3Dy
+CONFIG_RV_MON_WWNR=3Dy
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
 CONFIG_EARLY_PRINTK_DBGP=3Dy
+CONFIG_EARLY_PRINTK_USB_XDBC=3Dy
 CONFIG_DEBUG_BOOT_PARAMS=3Dy
 CONFIG_DEBUG_ENTRY=3Dy
+CONFIG_FUNCTION_ERROR_INJECTION=3Dy
+CONFIG_MEMTEST=3Dy

