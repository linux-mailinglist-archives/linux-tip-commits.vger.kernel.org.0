Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D301723DD8B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Aug 2020 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgHFRLP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 13:11:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgHFRKL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:11 -0400
Date:   Thu, 06 Aug 2020 17:10:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLXFrA6tBJNd4MkbIolJxW97S6FGhmw2sEvJo7KvuFg=;
        b=ZIsmJko36NzKZnMsBeMQEeaujYyg3kLMz2Ci+8j/Y83tU8xs4VOMhFzFMsbAwsqf7prDp5
        lye8DuRvcGPgnKg/MoUyNktMaUpyfBKQZkiqgizgZR4U//nuqqnFRwaJTzZAfyimjwOGW6
        X4bs+XCxh/SA9C87qB+UioHSjRmsDk9yx8OvLfT1NXKUa7Ak0N1Oc6jKTJoXkTcG8S6lr+
        h/lOw67UGKREZn8+tv54nEyJ5d8lL6DVDJ86Siyp1adcyiiSqMZPibCnsJXM7aof+S3CQ/
        K1yIbgw/KyHU020Agtn3j9fddnCKKkM4H2Qc3rCQVaNsc4aRnxAu+b3V4tIcjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLXFrA6tBJNd4MkbIolJxW97S6FGhmw2sEvJo7KvuFg=;
        b=kfHNmATLXnB64iR2BduT1ctQvscrlZBqI5xp8Oh9mIlbPoRBiZSx4lzo4JUCb6qGo4e9SR
        Jg9Q3RBzBE5LL7Cg==
From:   "tip-bot2 for Shuo Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acrn: Allow ACRN guest to use X2APIC mode
Cc:     Yakui Zhao <yakui.zhao@intel.com>, Shuo Liu <shuo.a.liu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806113802.9325-1-shuo.a.liu@intel.com>
References: <20200806113802.9325-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Message-ID: <159673380887.3192.6850923557894856416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f75576c4818fdf344691ca5b791f42bf3878c3a8
Gitweb:        https://git.kernel.org/tip/f75576c4818fdf344691ca5b791f42bf3878c3a8
Author:        Shuo Liu <shuo.a.liu@intel.com>
AuthorDate:    Thu, 06 Aug 2020 19:38:02 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:20:17 +02:00

x86/acrn: Allow ACRN guest to use X2APIC mode

The ACRN Hypervisor did not support x2APIC and thus x2APIC support was
disabled by always returning false when VM checked for x2APIC support.

ACRN received full support of x2APIC and exports the capability through
CPUID feature bits.

Let VM decide if it needs to switch to x2APIC mode according to CPUID
features.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20200806113802.9325-1-shuo.a.liu@intel.com
---
 arch/x86/kernel/cpu/acrn.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 1da9b1c..3b08cdf 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -11,6 +11,7 @@
 
 #include <linux/interrupt.h>
 #include <asm/apic.h>
+#include <asm/cpufeatures.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
 #include <asm/idtentry.h>
@@ -29,12 +30,7 @@ static void __init acrn_init_platform(void)
 
 static bool acrn_x2apic_available(void)
 {
-	/*
-	 * x2apic is not supported for now. Future enablement will have to check
-	 * X86_FEATURE_X2APIC to determine whether x2apic is supported in the
-	 * guest.
-	 */
-	return false;
+	return boot_cpu_has(X86_FEATURE_X2APIC);
 }
 
 static void (*acrn_intr_handler)(void);
