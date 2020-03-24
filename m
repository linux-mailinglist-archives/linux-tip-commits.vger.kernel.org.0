Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E93191CC4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 23:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgCXWc7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 18:32:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46454 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgCXWcc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs61-0006xx-3Q; Tue, 24 Mar 2020 23:32:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EDCEC1C04CC;
        Tue, 24 Mar 2020 23:32:21 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:21 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/bugs: Convert to new matching macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131508.934926587@linutronix.de>
References: <20200320131508.934926587@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508914164.28353.7021276111592948406.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f6d502fcfc51ae025f18a8de8f1ed2ab34503742
Gitweb:        https://git.kernel.org/tip/f6d502fcfc51ae025f18a8de8f1ed2ab34503742
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:48 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:22:23 +01:00

x86/cpu/bugs: Convert to new matching macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

The local wrappers have to stay as they are tailored to tame the hardware
vulnerability mess.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131508.934926587@linutronix.de
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52c9bfb..f4c672e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1008,8 +1008,8 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #define NO_ITLB_MULTIHIT	BIT(7)
 #define NO_SPECTRE_V2		BIT(8)
 
-#define VULNWL(_vendor, _family, _model, _whitelist)	\
-	{ X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
+#define VULNWL(vendor, family, model, whitelist)	\
+	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, whitelist)
 
 #define VULNWL_INTEL(model, whitelist)		\
 	VULNWL(INTEL, 6, INTEL_FAM6_##model, whitelist)
