Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00D92F5FC6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbhANLX5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:23:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbhANLX4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:23:56 -0500
Date:   Thu, 14 Jan 2021 11:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0bvzvx4Xm5LpfiFzZz3b5rL9fvkbYw1fDA2JpVNblk=;
        b=26mIs7nGitOY8pwWUGz6JvgPtzC+IK5rI/8BZ7TEnWaEibOdCnx3V7Q0uFsR6nI+yyS38S
        z7vaKKRtrE3MXxkd8RjIHO9jOGcoKOKM64pcVqvHvaV6L4R3KqMkHxECSLuCVGQq1UEvNw
        pv/wy5i908gvG2K2FiuFyRFUvbuezn5tvhGptLVXyWFEUQj9zG7yURk4U7WXFkBVjXKHQg
        Rvj7reEiC/PGj6eQxUN2WTvkeSAOPlAA+UQen8XaK+8OUlpLloYjgmCfPUEucV5Fi8alQX
        PtsFxaOPJvTSDD47XFGrGVpuuzl1p2xbBkT8pbtD4V7jrj3g3T11vePraI8Eyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0bvzvx4Xm5LpfiFzZz3b5rL9fvkbYw1fDA2JpVNblk=;
        b=LIT10TkKfuM9fQY2scrGLrINHa83Ww2btb8ASqZ/XfUBeL+cAbiB7o/UGA3SCJ5BBVyrmK
        mCMSZY6YrPBaILBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology: Make __max_die_per_package available
 unconditionally
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210114111814.5346-1-bp@alien8.de>
References: <20210114111814.5346-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161062339330.414.11896967291213156157.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1eb8f690bcb565a6600f8b6dcc78f7b239ceba17
Gitweb:        https://git.kernel.org/tip/1eb8f690bcb565a6600f8b6dcc78f7b239ceba17
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 14 Jan 2021 10:36:59 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jan 2021 12:18:36 +01:00

x86/topology: Make __max_die_per_package available unconditionally

Move it outside of CONFIG_SMP in order to avoid ifdeffery at the usage
sites.

Fixes: 76e2fc63ca40 ("x86/cpu/amd: Set __max_die_per_package on AMD")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210114111814.5346-1-bp@alien8.de
---
 arch/x86/include/asm/topology.h | 4 ++--
 arch/x86/kernel/cpu/topology.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 488a8e8..9239399 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -110,6 +110,8 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
 
+extern unsigned int __max_die_per_package;
+
 #ifdef CONFIG_SMP
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
@@ -118,8 +120,6 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern unsigned int __max_logical_packages;
 #define topology_max_packages()			(__max_logical_packages)
 
-extern unsigned int __max_die_per_package;
-
 static inline int topology_max_die_per_package(void)
 {
 	return __max_die_per_package;
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 1068002..8678864 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -25,10 +25,10 @@
 #define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
 #define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
 
-#ifdef CONFIG_SMP
 unsigned int __max_die_per_package __read_mostly = 1;
 EXPORT_SYMBOL(__max_die_per_package);
 
+#ifdef CONFIG_SMP
 /*
  * Check if given CPUID extended toplogy "leaf" is implemented
  */
