Return-Path: <linux-tip-commits+bounces-6115-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173C7B041C6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC94A1882C2D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913625A2C0;
	Mon, 14 Jul 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nk7lvDPA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDdNosVP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EBE258CDC;
	Mon, 14 Jul 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503624; cv=none; b=C1vepEg/09st860aL7TMhHu2vGjXBePQ0KWPhFXLZ37MGX5IjFa7ivSdE9mw2XKwM9d/gAW8OwPDhdFiQ3VbvZQZkZZQzGanqz3w5hvIo7YI9DyTFliXUZE+MGG9JH4DX1SBPLFox12vBMl51p71t1azkPJdjWdDesA0hmHM5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503624; c=relaxed/simple;
	bh=CCy3/tcLdKBHAoj0Ahy6wRHlLbiaCQxC7Caq9fzgUHY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UGGLH6UFSDtUrtoCEgf4/p8i/h0645gm220/EVgMt/B8/wqCdUAq9gFMmSWa76/B+zlPF0Z3ptIGNZqc7OFnL3WWvWB+3A6adKR1rFKSbqjJcdyijnxWsZgMnCFfW1FisIc+SKhgfF0Q6qM/m9LcW09zv+lWCZhoDDg+AHoxyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nk7lvDPA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDdNosVP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 14:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752503620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXAFAtfIbNlZND+51bkByIkeKRoBFicPXh8a7e1y58g=;
	b=Nk7lvDPAOhjBaeOyNUHDXDtYf2PVH+xg/j32mwOLpzG0rw2sLm62XgQbJDSxI/mK4q2OTy
	ajpSGX8j8mrFZ93q3ObtlSiV6vtkVDKIPE+BsqIzPZ3J5ToagPtLey95E6F1I+N0XLvRUN
	lXGdLUlvlwSo2GTpYSh0kqr6AU+DECzQNopaRJ0Gq8Tg8IWFO8mC8kLJXNxHGmjsV9hGUN
	9JPZk6wEDG/dTShfoJW1VAGn3JbWDztmu0atHnHsbhLqasSuL39HmJ4iIN9YakyE73Vfj4
	G3ol0hgRLktJV9GNv1ZQPbaLfFXEbXSqdIRJQv3y6nD16XVpZN1ABxpjieyjzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752503620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXAFAtfIbNlZND+51bkByIkeKRoBFicPXh8a7e1y58g=;
	b=IDdNosVP2HNmmSTaatXCpdFIO+lsVvpKDgNtC57x8XMI+pcvdHRJ8nBmt4d/HEHzNGSvND
	CIJLXVoQXLVnxOBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/32: Refresh defconfig
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-2-mingo@kernel.org>
References: <20250515132719.31868-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175250361972.406.12425241615885595310.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     6453e7cc32d1fd69344311224dbd00692eadc592
Gitweb:        https://git.kernel.org/tip/6453e7cc32d1fd69344311224dbd00692ea=
dc592
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 10:00:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 14 Jul 2025 16:25:46 +02:00

x86/kconfig/32: Refresh defconfig

Refresh the x86-32 defconfig to pick up changes in the
general Kconfig environment: removed options, different
defaults, renames, etc.

No changes to the actual result of 'make ARCH=3Di386 defconfig'.

  [ bp: Fold in a fix as reported by Andy:
    https://lore.kernel.org/r/20250626150118.318836-1-andriy.shevchenko@linux=
.intel.com ]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
Link: https://lore.kernel.org/r/20250515132719.31868-2-mingo@kernel.org
---
 arch/x86/configs/i386_defconfig | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 7cd2f39..79fa38c 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -27,10 +27,12 @@ CONFIG_CGROUP_DEBUG=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
 CONFIG_PROFILING=3Dy
+CONFIG_KEXEC=3Dy
+# Do not remove this as it results in non-bootable kernels
+# CONFIG_64BIT is not set
 CONFIG_SMP=3Dy
 CONFIG_HYPERVISOR_GUEST=3Dy
 CONFIG_PARAVIRT=3Dy
-CONFIG_NR_CPUS=3D8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
 CONFIG_X86_MSR=3Dy
 CONFIG_X86_CPUID=3Dy
@@ -39,9 +41,6 @@ CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
 CONFIG_EFI=3Dy
 CONFIG_EFI_STUB=3Dy
 CONFIG_HZ_1000=3Dy
-CONFIG_KEXEC=3Dy
-CONFIG_CRASH_DUMP=3Dy
-# CONFIG_MITIGATION_RETHUNK is not set
 CONFIG_HIBERNATION=3Dy
 CONFIG_PM_DEBUG=3Dy
 CONFIG_PM_TRACE_RTC=3Dy
@@ -52,7 +51,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
 CONFIG_X86_ACPI_CPUFREQ=3Dy
 CONFIG_KPROBES=3Dy
 CONFIG_JUMP_LABEL=3Dy
-CONFIG_COMPAT_32BIT_TIME=3Dy
 CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_MODULE_FORCE_UNLOAD=3Dy
@@ -63,9 +61,7 @@ CONFIG_BINFMT_MISC=3Dy
 # CONFIG_COMPAT_BRK is not set
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
-CONFIG_UNIX=3Dy
 CONFIG_XFRM_USER=3Dy
-CONFIG_INET=3Dy
 CONFIG_IP_MULTICAST=3Dy
 CONFIG_IP_ADVANCED_ROUTER=3Dy
 CONFIG_IP_MULTIPLE_TABLES=3Dy
@@ -134,7 +130,6 @@ CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 CONFIG_DEBUG_DEVRES=3Dy
 CONFIG_CONNECTOR=3Dy
-CONFIG_EFI_CAPSULE_LOADER=3Dy
 CONFIG_BLK_DEV_LOOP=3Dy
 CONFIG_VIRTIO_BLK=3Dy
 CONFIG_BLK_DEV_SD=3Dy
@@ -210,7 +205,6 @@ CONFIG_SND_HDA_INTEL=3Dy
 CONFIG_SND_HDA_HWDEP=3Dy
 CONFIG_HIDRAW=3Dy
 CONFIG_HID_GYRATION=3Dy
-CONFIG_LOGITECH_FF=3Dy
 CONFIG_HID_NTRIG=3Dy
 CONFIG_HID_PANTHERLORD=3Dy
 CONFIG_PANTHERLORD_FF=3Dy
@@ -241,7 +235,6 @@ CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=3Dy
 CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
@@ -266,19 +259,13 @@ CONFIG_SECURITY=3Dy
 CONFIG_SECURITY_NETWORK=3Dy
 CONFIG_SECURITY_SELINUX=3Dy
 CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
-CONFIG_SECURITY_SELINUX_DISABLE=3Dy
 CONFIG_PRINTK_TIME=3Dy
 CONFIG_DEBUG_KERNEL=3Dy
-CONFIG_FRAME_WARN=3D1024
 CONFIG_MAGIC_SYSRQ=3Dy
-CONFIG_DEBUG_WX=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
-# CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
 CONFIG_EARLY_PRINTK_DBGP=3Dy
 CONFIG_DEBUG_BOOT_PARAMS=3Dy
-CONFIG_UNWINDER_FRAME_POINTER=3Dy
 CONFIG_DEBUG_ENTRY=3Dy
-# CONFIG_64BIT is not set

