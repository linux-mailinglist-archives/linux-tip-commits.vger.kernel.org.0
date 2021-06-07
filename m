Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0339DC1E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jun 2021 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhFGMYN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Jun 2021 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGMYN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Jun 2021 08:24:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479CCC061787;
        Mon,  7 Jun 2021 05:22:22 -0700 (PDT)
Date:   Mon, 07 Jun 2021 12:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623068540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4YF7i8fPhT93+G8nSyug521WM/6VNQsMBLcpi8HbGQ=;
        b=iWaZk01jw5k4YNzI0WT23RnAW6XIhMkY3aUiPc1Pk/d4FnQZoY8S5jb2jb3/lwj/OokNAX
        xABTKkYWZMjwYQ6ClzuRnMBckQ5mwl7q0utgodUGb/c72zq423W8LTWYbpy1CcflJWuduP
        ACDRztVK/OXC/mCByIUvfgIiUprN5S5n9xUlKOBvAgZMIsS4eofq/aUZd0mcJLmC8x09f7
        3lJz6fFRcIi0Ha8BrD0f6pZmkIJWu/tniCnZkbRI+3wTCRZDBLBIS6XSoKHIxU7mukQ+pZ
        3tqxCQtOImImKcl+DKGDx1ftiw++A2kH6B6Tjzj/X4ZoB6DE/BkBwKyvoU+LOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623068540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4YF7i8fPhT93+G8nSyug521WM/6VNQsMBLcpi8HbGQ=;
        b=WwlDxuI2NYMD3qJiOGhRkde9lusIe+uENZi2gJrOgG/WLIZz4otvbC7Bortv7Tzt+4o7/9
        J6Qollv/M0NjoMBg==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Remove CONFIG_X86_RESERVE_LOW and
 reservelow= options
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210601075354.5149-3-rppt@kernel.org>
References: <20210601075354.5149-3-rppt@kernel.org>
MIME-Version: 1.0
Message-ID: <162306853936.29796.12058741996675426246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1a6a9044b96729abacede172d7591c714a5b81d1
Gitweb:        https://git.kernel.org/tip/1a6a9044b96729abacede172d7591c714a5b81d1
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Tue, 01 Jun 2021 10:53:53 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Jun 2021 11:12:25 +02:00

x86/setup: Remove CONFIG_X86_RESERVE_LOW and reservelow= options

The CONFIG_X86_RESERVE_LOW build time and reservelow= command line option
allowed to control the amount of memory under 1M that would be reserved at
boot to avoid using memory that can be potentially clobbered by BIOS.

Since the entire range under 1M is always reserved there is no need for
these options anymore and they can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210601075354.5149-3-rppt@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +---
 arch/x86/Kconfig                                | 29 +----------------
 arch/x86/kernel/setup.c                         | 24 +-------------
 3 files changed, 58 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbd..d7d8130 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4775,11 +4775,6 @@
 			Reserves a hole at the top of the kernel virtual
 			address space.
 
-	reservelow=	[X86]
-			Format: nn[K]
-			Set the amount of memory to reserve for BIOS at
-			the bottom of the address space.
-
 	reset_devices	[KNL] Force drivers to reset the underlying device
 			during initialization.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b..86dae42 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1693,35 +1693,6 @@ config X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK
 	  Set whether the default state of memory_corruption_check is
 	  on or off.
 
-config X86_RESERVE_LOW
-	int "Amount of low memory, in kilobytes, to reserve for the BIOS"
-	default 64
-	range 4 640
-	help
-	  Specify the amount of low memory to reserve for the BIOS.
-
-	  The first page contains BIOS data structures that the kernel
-	  must not use, so that page must always be reserved.
-
-	  By default we reserve the first 64K of physical RAM, as a
-	  number of BIOSes are known to corrupt that memory range
-	  during events such as suspend/resume or monitor cable
-	  insertion, so it must not be used by the kernel.
-
-	  You can set this to 4 if you are absolutely sure that you
-	  trust the BIOS to get all its memory reservations and usages
-	  right.  If you know your BIOS have problems beyond the
-	  default 64K area, you can set this to 640 to avoid using the
-	  entire low memory range.
-
-	  If you have doubts about the BIOS (e.g. suspend/resume does
-	  not work or there's kernel crashes after certain hardware
-	  hotplug events) then you might want to enable
-	  X86_CHECK_BIOS_CORRUPTION=y to allow the kernel to check
-	  typical corruption patterns.
-
-	  Leave this to the default value of 64 if you are unsure.
-
 config MATH_EMULATION
 	bool
 	depends on MODIFY_LDT_SYSCALL
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1e72062..7638ac6 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -695,30 +695,6 @@ static void __init e820_add_kernel_range(void)
 	e820__range_add(start, size, E820_TYPE_RAM);
 }
 
-static unsigned reserve_low = CONFIG_X86_RESERVE_LOW << 10;
-
-static int __init parse_reservelow(char *p)
-{
-	unsigned long long size;
-
-	if (!p)
-		return -EINVAL;
-
-	size = memparse(p, &p);
-
-	if (size < 4096)
-		size = 4096;
-
-	if (size > 640*1024)
-		size = 640*1024;
-
-	reserve_low = size;
-
-	return 0;
-}
-
-early_param("reservelow", parse_reservelow);
-
 static void __init early_reserve_memory(void)
 {
 	/*
