Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76ED3568CE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Apr 2021 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350645AbhDGKE2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Apr 2021 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350529AbhDGKDw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Apr 2021 06:03:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF0C0613DA;
        Wed,  7 Apr 2021 03:03:37 -0700 (PDT)
Date:   Wed, 07 Apr 2021 10:03:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617789815;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83VQLn6NKsei4RkjAGT/OVSC1OxMiBmypxMNM01aLe0=;
        b=T7twzqtffVGz1ehemb7LiWpOSaTcy6Pz5hOVeDX0KeunVjTqoWPWyzwgUxXeyY0L/8MGVv
        WgwbDkjFWSOTyBmwIV6Aytplt96unAR6T45/eoaQZ83jFoonoo1kIZSe7Ga+lJX2lGBcZZ
        WZUTmoZr2ViEkldUIZ6zWeUdw7zQ+m9zpUrHGpxB66riUUO25Me4FmczdCvrlKVhq84fX2
        aqlt5KPya+txOyjWCG6DuBC+KqbN5rZ6lb03SU/qEmJ7XBnk7Gu2tj7C7DRZ5/bm1zCna5
        oCmzj9X1Ul7fZLdW+Q7MH0JSWz9XLW1zIhg5s31uIrMqr9CsLLLqZRNacKx4eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617789815;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83VQLn6NKsei4RkjAGT/OVSC1OxMiBmypxMNM01aLe0=;
        b=dpMDNSUsm3Sy9X8xqYhdt27KKs2SdagyPn7QZ3vJQ4pTjEs86Fq/XQp2h6+hCEEWLoL/h6
        vawlCISOL9k8SHCA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/cpufeatures: Make SGX_LC feature bit depend on SGX bit
Cc:     Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5d4220fd0a39f52af024d3fa166231c1d498dd10.1616136308.git.kai.huang@intel.com>
References: <5d4220fd0a39f52af024d3fa166231c1d498dd10.1616136308.git.kai.huang@intel.com>
MIME-Version: 1.0
Message-ID: <161778981468.29796.2007667039534925425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     e9a15a40e857fc6ccfbb05fec7b184e9003057df
Gitweb:        https://git.kernel.org/tip/e9a15a40e857fc6ccfbb05fec7b184e9003057df
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 19 Mar 2021 20:22:17 +13:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 25 Mar 2021 17:33:11 +01:00

x86/cpufeatures: Make SGX_LC feature bit depend on SGX bit

Move SGX_LC feature bit to CPUID dependency table to make clearing all
SGX feature bits easier. Also remove clear_sgx_caps() since it is just
a wrapper of setup_clear_cpu_cap(X86_FEATURE_SGX) now.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/5d4220fd0a39f52af024d3fa166231c1d498dd10.1616136308.git.kai.huang@intel.com
---
 arch/x86/kernel/cpu/cpuid-deps.c |  1 +
 arch/x86/kernel/cpu/feat_ctl.c   | 12 +++---------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 42af31b..d40f8e0 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
+	{ X86_FEATURE_SGX_LC,			X86_FEATURE_SGX	      },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 3b1b01f..27533a6 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -93,15 +93,9 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c)
 }
 #endif /* CONFIG_X86_VMX_FEATURE_NAMES */
 
-static void clear_sgx_caps(void)
-{
-	setup_clear_cpu_cap(X86_FEATURE_SGX);
-	setup_clear_cpu_cap(X86_FEATURE_SGX_LC);
-}
-
 static int __init nosgx(char *str)
 {
-	clear_sgx_caps();
+	setup_clear_cpu_cap(X86_FEATURE_SGX);
 
 	return 0;
 }
@@ -116,7 +110,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 
 	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
 		clear_cpu_cap(c, X86_FEATURE_VMX);
-		clear_sgx_caps();
+		clear_cpu_cap(c, X86_FEATURE_SGX);
 		return;
 	}
 
@@ -177,6 +171,6 @@ update_sgx:
 	    !(msr & FEAT_CTL_SGX_LC_ENABLED) || !enable_sgx) {
 		if (enable_sgx)
 			pr_err_once("SGX disabled by BIOS\n");
-		clear_sgx_caps();
+		clear_cpu_cap(c, X86_FEATURE_SGX);
 	}
 }
