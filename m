Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC927AFA2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Sep 2020 16:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgI1OEe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Sep 2020 10:04:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1OEe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Sep 2020 10:04:34 -0400
Date:   Mon, 28 Sep 2020 14:04:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601301872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y4sVv2grhAOHDPKb2zKY/ZSYaohyLGxSLIo/y0lo3Rk=;
        b=05I3MKe7Ajc2KpWO6HApEPdZT4BgtTtea7qbT8YdmO+p8fLfsfL3Ra7XHwD35Ybh3Sl/vO
        5U3txyBp+iP8HhYlka+IK6S0hLEeILxJkTvJ7+fI42Ipwjkpa7EY4Rexd/21rxNid1MZva
        MSZ6egN9Lv0bteKxLE3vOrZbmclguDod18d7dJHROdQKDfVSVlmvySzxlmuur8RcAKWmzi
        BduLJ/FvuwqUy6/g84fwldhtn3LCXkwEkdiZ1kI7w6skpoDxnYSBcQlKV1cQck5UFYZDPp
        IEo0WGZeCS1zlWYhsbFgNOuNfh2e4Y5bAf10ONdHtEwF5/pXTW4Hm4GpPqA2UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601301872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Y4sVv2grhAOHDPKb2zKY/ZSYaohyLGxSLIo/y0lo3Rk=;
        b=OrowgIncHQBmvwJTnxj4HBO/eSIpZdz+oyhXegHkyTshS0qbhk+lAaS7d7ImRgw6DrJA+A
        sL5yj5Pk9d/c6XBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] PCI: MSI: Fix Kconfig dependencies for PCI_MSI_ARCH_FALLBACKS
Cc:     Qian Cai <cai@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160130187083.7002.8940002560805277856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     981aa1d366bf46bdc1c9259a5ab818a8d522724e
Gitweb:        https://git.kernel.org/tip/981aa1d366bf46bdc1c9259a5ab818a8d522724e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 28 Sep 2020 12:13:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 28 Sep 2020 16:03:10 +02:00

PCI: MSI: Fix Kconfig dependencies for PCI_MSI_ARCH_FALLBACKS

The unconditional selection of PCI_MSI_ARCH_FALLBACKS has an unmet
dependency because PCI_MSI_ARCH_FALLBACKS is defined in a 'if PCI' clause.

As it is only relevant when PCI_MSI is enabled, update the affected
architecture Kconfigs to make the selection of PCI_MSI_ARCH_FALLBACKS
depend on 'if PCI_MSI'.

Fixes: 077ee78e3928 ("PCI/MSI: Make arch_.*_msi_irq[s] fallbacks selectable")
Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Links: https://lore.kernel.org/r/cdfd63305caa57785b0925dd24c0711ea02c8527.camel@redhat.com
---
 arch/ia64/Kconfig    | 2 +-
 arch/mips/Kconfig    | 2 +-
 arch/powerpc/Kconfig | 2 +-
 arch/s390/Kconfig    | 2 +-
 arch/sparc/Kconfig   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 7ff5b3b..9d0f1e1 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -56,7 +56,7 @@ config IA64
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select NUMA if !FLATMEM
-	select PCI_MSI_ARCH_FALLBACKS
+	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3690582..ea22129 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -86,7 +86,7 @@ config MIPS
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
-	select PCI_MSI_ARCH_FALLBACKS
+	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9e66ca1..1f953c9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,7 +246,7 @@ config PPC
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
-	select PCI_MSI_ARCH_FALLBACKS
+	select PCI_MSI_ARCH_FALLBACKS		if PCI_MSI
 	select PCI_SYSCALL			if PCI
 	select PPC_DAWR				if PPC64
 	select RTC_LIB
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 63dd5a0..0a38993 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -185,7 +185,7 @@ config S390
 	select OLD_SIGSUSPEND3
 	select PCI_DOMAINS		if PCI
 	select PCI_MSI			if PCI
-	select PCI_MSI_ARCH_FALLBACKS
+	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 21a3239..91ed110 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,7 +43,7 @@ config SPARC
 	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select PCI_SYSCALL if PCI
-	select PCI_MSI_ARCH_FALLBACKS
+	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS
