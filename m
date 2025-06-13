Return-Path: <linux-tip-commits+bounces-5834-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B71AD8583
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15111897160
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D322C15A1;
	Fri, 13 Jun 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RYrR9Jxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzGzIJ2M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF07279DAF;
	Fri, 13 Jun 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803119; cv=none; b=m/Lx4TMYWix/HYs5nLuJtKZQGrmMWsbqEvN5vLPw/h8lIybDGueJLuhbAOGSs0WUrtiR671cSoLN05TbL2MWxkeQIM6PhOzdEdLvUlMpPoCx+CGMJ5XTsGBFE9t3JhLRgH6MLJS9KJ6XdVo5xqQQh3kHX2dacy8NJKH4Ae6DgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803119; c=relaxed/simple;
	bh=qQMNsNFMXLtKrTeBcmX3MdS6xrj87OSWVkX1WfWiJkQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jdhsXLwpl5K6Oe/uuadMFcIznqOvQtQ45oxd9tkyunj4++V/JtJNyNtJHkwxV/UHKmQgm2e/y49v3qoLRGCHzMIxWoNn20nuW3d3hjk9f+vhcG8cwfH3M2s5bY69wecDE70Yi6FOi7QKW6II+hDAbfZl9wA1hoaI5LWk3nrjUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RYrR9Jxh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uzGzIJ2M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cj7n0VpdzqM9fOR81UcF7y44cj1MbOQjcEjR8SHSY4=;
	b=RYrR9JxhicQ/ZHvURaEz1D+Rs+UQVMvQZcNrFfk1MQXWJrNmKSvGljNRy3yRZ5lvtbzBb/
	0Agdb/d2qyY+eVwAf7hrMLadF+9SP3YW7FyXtuORVPUE9Z2C6z/aYFwmgEkz4q2lzxUqk0
	V2MmRytoGfKONy51NYT5+LSsDbRNpqMO7deHQKUSkl+YcFjSgnp21Uwi+jeNGmOkR+lNBq
	aLB7u+jsVKasomiySw47ZDQHfaSZ3MhX4N8Jq5Y6kb7rJxq++RauTuX6P5lZcH7MihRVR+
	mVVquadJA9Z66DAyJohXtv7eYDNjUtGxjfhYeFv+BFmTyXAlVxbtgD1tbhTKFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Cj7n0VpdzqM9fOR81UcF7y44cj1MbOQjcEjR8SHSY4=;
	b=uzGzIJ2MQGbEXfHAGZvDXxZiV8LVj/AVsBec+3Ht48ID6184q3WQavSaZ2Yvocjw8l0k/j
	yxHOhKNSogWKBiCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/64: Refresh defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <174980311589.406.43050021533084310.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     00c7a872026f9e74055ba5c71cba03c665e8b03e
Gitweb:        https://git.kernel.org/tip/00c7a872026f9e74055ba5c71cba03c665e=
8b03e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 09:51:18 +02:00

x86/kconfig/64: Refresh defconfig

Refresh the x86-64 defconfig to pick up changes in the
general Kconfig environment: removed options, different
defaults, renames, etc.

No changes to the actual result of 'make ARCH=3Dx86 defconfig'.

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
Link: https://lore.kernel.org/r/20250515132719.31868-2-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index 61e25f6..7d7310c 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -27,6 +27,7 @@ CONFIG_CGROUP_DEBUG=3Dy
 CONFIG_BLK_DEV_INITRD=3Dy
 CONFIG_KALLSYMS_ALL=3Dy
 CONFIG_PROFILING=3Dy
+CONFIG_KEXEC=3Dy
 CONFIG_SMP=3Dy
 CONFIG_HYPERVISOR_GUEST=3Dy
 CONFIG_PARAVIRT=3Dy
@@ -40,8 +41,6 @@ CONFIG_EFI=3Dy
 CONFIG_EFI_STUB=3Dy
 CONFIG_EFI_MIXED=3Dy
 CONFIG_HZ_1000=3Dy
-CONFIG_KEXEC=3Dy
-CONFIG_CRASH_DUMP=3Dy
 CONFIG_HIBERNATION=3Dy
 CONFIG_PM_DEBUG=3Dy
 CONFIG_PM_TRACE_RTC=3Dy
@@ -63,9 +62,7 @@ CONFIG_BINFMT_MISC=3Dy
 # CONFIG_COMPAT_BRK is not set
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
-CONFIG_UNIX=3Dy
 CONFIG_XFRM_USER=3Dy
-CONFIG_INET=3Dy
 CONFIG_IP_MULTICAST=3Dy
 CONFIG_IP_ADVANCED_ROUTER=3Dy
 CONFIG_IP_MULTIPLE_TABLES=3Dy
@@ -205,7 +202,6 @@ CONFIG_SND_HDA_INTEL=3Dy
 CONFIG_SND_HDA_HWDEP=3Dy
 CONFIG_HIDRAW=3Dy
 CONFIG_HID_GYRATION=3Dy
-CONFIG_LOGITECH_FF=3Dy
 CONFIG_HID_NTRIG=3Dy
 CONFIG_HID_PANTHERLORD=3Dy
 CONFIG_PANTHERLORD_FF=3Dy
@@ -239,7 +235,6 @@ CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
-# CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=3Dy
 CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
@@ -264,13 +259,11 @@ CONFIG_SECURITY=3Dy
 CONFIG_SECURITY_NETWORK=3Dy
 CONFIG_SECURITY_SELINUX=3Dy
 CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
-CONFIG_SECURITY_SELINUX_DISABLE=3Dy
 CONFIG_PRINTK_TIME=3Dy
 CONFIG_DEBUG_KERNEL=3Dy
 CONFIG_MAGIC_SYSRQ=3Dy
 CONFIG_DEBUG_WX=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
-# CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy

