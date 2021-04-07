Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79573574DE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 21:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355592AbhDGTWt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 15:22:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDGTWt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 15:22:49 -0400
Date:   Wed, 07 Apr 2021 19:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617823358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j55FbUowvvspGmP82pJL7+9tG7t14xv/PZWFTM7KWfE=;
        b=H+x4sAwSUuE597t22ctiZDbhL1tUTLRXHQ5srCGuElLO56zxJ/o7FdySYRlYiSDpcllyi1
        lwB06gtmyEGuO50oOubDojXUdJxSXJO+JXenkGv2T2j3oZdouuMcJwEsucoEMjkE0sTWgj
        159l9rEU9wAedwhYaz1fYh72/YuYlNV5UDdmteZbPdueigirHYd1+l2iEPoWiAkLAsfoq/
        DEHIEDURKR/x/ZIMZUmEmtLMxje2oa4mMOMA5/FWJZ6cEnxaPjnkjxKKW5K509RCT6vP3c
        Lc0Yg3PTZUtBuAl7a8dVjeQOSrCqSoZTrlYyz3R3cybIoefM6qqXqA6nu2LS6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617823358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j55FbUowvvspGmP82pJL7+9tG7t14xv/PZWFTM7KWfE=;
        b=US09382ShxFZE2jgnEcwqhAYdLQ1nIvnCsJF6AZiaL46sj/z86oiP73Zz0D0JERlq1Ykw0
        xxGENRDdiyd/MBAw==
From:   "tip-bot2 for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cacheinfo: Remove unneeded dead-store initialization
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <161782335615.29796.11696660764867463693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     dda451f391eee5d68db3ca87fd8b2a42c8c2b507
Gitweb:        https://git.kernel.org/tip/dda451f391eee5d68db3ca87fd8b2a42c8c2b507
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Wed, 31 Mar 2021 16:00:24 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Apr 2021 21:12:12 +02:00

x86/cacheinfo: Remove unneeded dead-store initialization

$ make CC=clang clang-analyzer

(needs clang-tidy installed on the system too)

on x86_64 defconfig triggers:

  arch/x86/kernel/cpu/cacheinfo.c:880:24: warning: Value stored to 'this_cpu_ci' \
	  during its initialization is never read [clang-analyzer-deadcode.DeadStores]
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
                              ^
  arch/x86/kernel/cpu/cacheinfo.c:880:24: note: Value stored to 'this_cpu_ci' \
	during its initialization is never read

So simply remove this unneeded dead-store initialization.

As compilers will detect this unneeded assignment and optimize this
anyway the resulting object code is identical before and after this
change.

No functional change. No change to object code.

 [ bp: Massage commit message. ]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com
---
 arch/x86/kernel/cpu/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 3ca9be4..d66af29 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -877,7 +877,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 				    struct _cpuid4_info_regs *base)
 {
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *this_leaf;
 	int i, sibling;
 
