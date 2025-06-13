Return-Path: <linux-tip-commits+bounces-5824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD588AD856C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E1B188699B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45B26B76D;
	Fri, 13 Jun 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ow2VAhoy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rs9n5Bup"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C22DA758;
	Fri, 13 Jun 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803108; cv=none; b=jD9sjzjOl/Q6+vwZhuySvUrc9I19c4LSwLtBK8S/tro8WvMJ+oAF17qnUt2y00UTE8Z3iFI+X4AdVC2TMTxPRsRSJIHTwtPTYfnomkVIRsHDG/Za8ZR+C9fHsANDfFEJq6ihGPh+j714WjAz4i5OHMl0TWRsWlINR0Wa1CnSSDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803108; c=relaxed/simple;
	bh=EfDTC2K2Ceh3M5NfzJGA9JrXAOjpYN9ePhUnrg++IWw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ebn/t9w1QircR674rP2G7H7sWuAqlSyW90zWZSsOCW1zYrm4Cy+Rh1KM7S+ABgIEmdHOXMZaR2kCqlHNe+KOW0qWgb+b2ZJLv8PuAm6KsiMaqCuEpRjiq2v/nhgNMdfIeASDIZA3FcrQkfZL7wa9R+79RFf/xmPT5OQTIeUoGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ow2VAhoy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rs9n5Bup; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8l99Sxx8ZW7LYi5TsRSwrDmL2sVF9RE8qtP0wl0y7uI=;
	b=Ow2VAhoy2lv7E5D9xjMKkre+kaS0XOzeDffU983L/qiexu/66U8ZX8X30214zJga/2BvMM
	6GxcCZeiAt0tX3VsCa9G7Hn/zwtgMndHCdkd0MRoyPiKMCvkE0n/jcl0Otwsk1cjEu7FRS
	ebboBT/DwDctA/UdHSa6zbZ1O59q5fGwWp0qbt9knixocvuOED38/UIrzxNsvlp5+AK8ld
	FRU7V9WDaB0FlkAFu8OuLgC6476RTPpXKInHFuxouuX6hTl8rUVCl9wxI14fNcMIxRdKZr
	qOdy4LJsyxVxeJ5qga27ayqV/h8IhRrQBqdVbQreWBoJycLQPeqpuS7Owth08Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8l99Sxx8ZW7LYi5TsRSwrDmL2sVF9RE8qtP0wl0y7uI=;
	b=rs9n5BupJqpihaC1UK0tPX29Xiz+D6gZm/NuP8E5KU5IDgVdmsqoNoTPKsZHBrdDMWdiw0
	x6YxYUbO2LnLIRCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/32: Synchronize the x86-32 defconfig
 to the x86-64 defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-14-mingo@kernel.org>
References: <20250515132719.31868-14-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310386.406.13253006513273801607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     9e3d5f041005dbd0f5c84bc72424488df4af27fc
Gitweb:        https://git.kernel.org/tip/9e3d5f041005dbd0f5c84bc72424488df4a=
f27fc
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 09:56:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:03:48 +02:00

x86/kconfig/32: Synchronize the x86-32 defconfig to the x86-64 defconfig

Just a mechanic synchronization of kernel options enabled: nobody
really develops kernel features on x86-32 anymore, so make sure the
defconfig is roughly equivalent to the 64-bit one, so that testing
doesn't cover some combination that nobody cares about.

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
Link: https://lore.kernel.org/r/20250515132719.31868-14-mingo@kernel.org
---
 arch/x86/configs/i386_defconfig | 122 +++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index bd18232..fac0f57 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,36 +1,61 @@
 CONFIG_WERROR=3Dy
+CONFIG_UAPI_HEADER_TEST=3Dy
 CONFIG_SYSVIPC=3Dy
 CONFIG_POSIX_MQUEUE=3Dy
+CONFIG_WATCH_QUEUE=3Dy
 CONFIG_AUDIT=3Dy
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
+CONFIG_BPF_SYSCALL=3Dy
+CONFIG_BPF_JIT=3Dy
+CONFIG_BPF_JIT_ALWAYS_ON=3Dy
+CONFIG_BPF_PRELOAD=3Dy
+CONFIG_BPF_PRELOAD_UMD=3Dy
+CONFIG_BPF_LSM=3Dy
 CONFIG_PREEMPT_VOLUNTARY=3Dy
+CONFIG_SCHED_CORE=3Dy
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
+CONFIG_CGROUP_BPF=3Dy
 CONFIG_CGROUP_MISC=3Dy
 CONFIG_CGROUP_DEBUG=3Dy
-CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_NAMESPACES=3Dy
+CONFIG_USER_NS=3Dy
+CONFIG_CHECKPOINT_RESTORE=3Dy
+CONFIG_SCHED_AUTOGROUP=3Dy
+CONFIG_SYSFS_SYSCALL=3Dy
+CONFIG_EXPERT=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
 CONFIG_PROFILING=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_SMP=3Dy
 CONFIG_HYPERVISOR_GUEST=3Dy
-CONFIG_PARAVIRT=3Dy
+CONFIG_PARAVIRT_SPINLOCKS=3Dy
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
 CONFIG_X86_MSR=3Dy
 CONFIG_X86_CPUID=3Dy
@@ -47,7 +72,11 @@ CONFIG_ACPI_BGRT=3Dy
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
 CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_X86_ACPI_CPUFREQ=3Dy
-CONFIG_KPROBES=3Dy
+CONFIG_KVM=3Dy
+CONFIG_KVM_INTEL=3Dy
+CONFIG_KVM_AMD=3Dy
+CONFIG_KVM_XEN=3Dy
+CONFIG_KVM_MAX_NR_VCPUS=3D4096
 CONFIG_JUMP_LABEL=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
@@ -56,7 +85,22 @@ CONFIG_BLK_CGROUP_IOLATENCY=3Dy
 CONFIG_BLK_CGROUP_IOCOST=3Dy
 CONFIG_BLK_CGROUP_IOPRIO=3Dy
 CONFIG_BINFMT_MISC=3Dy
+CONFIG_ZSWAP=3Dy
+CONFIG_SLAB_FREELIST_RANDOM=3Dy
+CONFIG_SLAB_FREELIST_HARDENED=3Dy
+# CONFIG_SLAB_BUCKETS is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_KSM=3Dy
+CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
+CONFIG_MEMORY_FAILURE=3Dy
+CONFIG_HWPOISON_INJECT=3Dy
+CONFIG_TRANSPARENT_HUGEPAGE=3Dy
+CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
+CONFIG_IDLE_PAGE_TRACKING=3Dy
+CONFIG_ANON_VMA_NAME=3Dy
+CONFIG_USERFAULTFD=3Dy
+CONFIG_LRU_GEN=3Dy
+CONFIG_LRU_GEN_ENABLED=3Dy
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_XFRM_USER=3Dy
@@ -116,6 +160,7 @@ CONFIG_CFG80211=3Dy
 CONFIG_MAC80211=3Dy
 CONFIG_MAC80211_LEDS=3Dy
 CONFIG_RFKILL=3Dy
+CONFIG_RFKILL_INPUT=3Dy
 CONFIG_NET_9P=3Dy
 CONFIG_NET_9P_VIRTIO=3Dy
 CONFIG_PCI=3Dy
@@ -166,6 +211,7 @@ CONFIG_FORCEDETH=3Dy
 CONFIG_8139TOO=3Dy
 # CONFIG_8139TOO_PIO is not set
 CONFIG_R8169=3Dy
+CONFIG_HYPERV_NET=3Dy
 CONFIG_INPUT_EVDEV=3Dy
 CONFIG_INPUT_JOYSTICK=3Dy
 CONFIG_INPUT_TABLET=3Dy
@@ -183,6 +229,8 @@ CONFIG_SERIAL_8250_RSA=3Dy
 CONFIG_SERIAL_NONSTANDARD=3Dy
 CONFIG_VIRTIO_CONSOLE=3Dy
 CONFIG_HW_RANDOM=3Dy
+# CONFIG_HW_RANDOM_INTEL is not set
+# CONFIG_HW_RANDOM_AMD is not set
 CONFIG_NVRAM=3Dy
 CONFIG_HPET=3Dy
 # CONFIG_HPET_MMAP is not set
@@ -194,6 +242,7 @@ CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
 CONFIG_DRM_I915=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
+CONFIG_DRM_HYPERV=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_HRTIMER=3Dy
@@ -202,7 +251,19 @@ CONFIG_SND_SEQ_DUMMY=3Dy
 CONFIG_SND_HDA_INTEL=3Dy
 CONFIG_SND_HDA_HWDEP=3Dy
 CONFIG_HIDRAW=3Dy
+CONFIG_HID_A4TECH=3Dy
+CONFIG_HID_APPLE=3Dy
+CONFIG_HID_BELKIN=3Dy
+CONFIG_HID_CHERRY=3Dy
+CONFIG_HID_CHICONY=3Dy
+CONFIG_HID_CYPRESS=3Dy
+CONFIG_HID_EZKEY=3Dy
 CONFIG_HID_GYRATION=3Dy
+CONFIG_HID_ITE=3Dy
+CONFIG_HID_KENSINGTON=3Dy
+CONFIG_HID_REDRAGON=3Dy
+CONFIG_HID_MICROSOFT=3Dy
+CONFIG_HID_MONTEREY=3Dy
 CONFIG_HID_NTRIG=3Dy
 CONFIG_HID_PANTHERLORD=3Dy
 CONFIG_PANTHERLORD_FF=3Dy
@@ -210,6 +271,7 @@ CONFIG_HID_PETALYNX=3Dy
 CONFIG_HID_SAMSUNG=3Dy
 CONFIG_HID_SONY=3Dy
 CONFIG_HID_SUNPLUS=3Dy
+CONFIG_HID_HYPERV_MOUSE=3Dy
 CONFIG_HID_TOPSEED=3Dy
 CONFIG_HID_PID=3Dy
 CONFIG_USB_HIDDEV=3Dy
@@ -227,7 +289,12 @@ CONFIG_RTC_CLASS=3Dy
 CONFIG_DMADEVICES=3Dy
 CONFIG_VIRTIO_PCI=3Dy
 CONFIG_VIRTIO_INPUT=3Dy
+CONFIG_HYPERV=3Dy
+CONFIG_HYPERV_UTILS=3Dy
+CONFIG_HYPERV_BALLOON=3Dy
 CONFIG_EEEPC_LAPTOP=3Dy
+CONFIG_INTEL_IOMMU=3Dy
+# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
@@ -258,12 +325,53 @@ CONFIG_SECURITY_NETWORK=3Dy
 CONFIG_SECURITY_SELINUX=3Dy
 CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
 CONFIG_PRINTK_TIME=3Dy
-CONFIG_DEBUG_KERNEL=3Dy
-CONFIG_MAGIC_SYSRQ=3Dy
+CONFIG_BOOT_PRINTK_DELAY=3Dy
+CONFIG_DYNAMIC_DEBUG=3Dy
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
 CONFIG_DEBUG_STACK_USAGE=3Dy
+CONFIG_SCHED_STACK_END_CHECK=3Dy
+CONFIG_DEBUG_MEMORY_INIT=3Dy
+CONFIG_KFENCE=3Dy
+CONFIG_DEBUG_SHIRQ=3Dy
+CONFIG_PANIC_ON_OOPS=3Dy
+CONFIG_HARDLOCKUP_DETECTOR=3Dy
+CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
+# CONFIG_DETECT_HUNG_TASK is not set
+CONFIG_WQ_CPU_INTENSIVE_REPORT=3Dy
 CONFIG_SCHEDSTATS=3Dy
+CONFIG_NMI_CHECK_CPU=3Dy
+CONFIG_DEBUG_LIST=3Dy
+CONFIG_RCU_CPU_STALL_CPUTIME=3Dy
+CONFIG_BOOTTIME_TRACING=3Dy
+CONFIG_FUNCTION_GRAPH_RETVAL=3Dy
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

