Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8F2A28E4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Nov 2020 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgKBLSO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Nov 2020 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKBLSO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Nov 2020 06:18:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A8C0617A6;
        Mon,  2 Nov 2020 03:18:14 -0800 (PST)
Date:   Mon, 02 Nov 2020 11:18:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604315889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0dFmKfKW5jqD0mtw57D+Bx75qoa8cI4qEpvWoAjqe0=;
        b=XBx6lGZDWZo/269t+5x7MKhJSYBjYPdi7JVxA6l/QAZl/ylOCeJQBmozAkddIXT6Z/2tMZ
        UTAbmLZkK8C/vLzGsMh/krytQBdSjHr24rJQ5FdpQV1LVAIVFRIs02RbFDdXMft/R9q6ST
        J0JQHYpJXDzSIjSyDvv5TASCVywp4N0CuoL6rEXaJvN3+wYB4Jcsf+mbD9UmuhErSML/Lh
        cn770NsN+tI1+2aYiYUoTY3H/59trvyp6aeQ0OpK0rUbVC/jJA86k8jToHPXjFjt9gb3Dw
        pX3VJ2JOYnbu1LkAtn7bjnDXZUnadD4jCP7fyJwmRwvHCCo8RnR4wG8HN9IuwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604315889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0dFmKfKW5jqD0mtw57D+Bx75qoa8cI4qEpvWoAjqe0=;
        b=7dG+IqL+eczJUQE9d7AIz+tnbOuDALHl5UVecwsrJAplCvkfwmzToCJxiWSlYD/WowTuo0
        rfqDfIVJK+eDaOCA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Enable additional error logging on certain
 Intel CPUs
Cc:     Boris Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
References: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <160431588828.397.16468104725047768957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     68299a42f84288537ee3420c431ac0115ccb90b1
Gitweb:        https://git.kernel.org/tip/68299a42f84288537ee3420c431ac0115ccb90b1
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 30 Oct 2020 12:04:00 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 02 Nov 2020 11:15:59 +01:00

x86/mce: Enable additional error logging on certain Intel CPUs

The Xeon versions of Sandy Bridge, Ivy Bridge and Haswell support an
optional additional error logging mode which is enabled by an MSR.

Previously, this mode was enabled from the mcelog(8) tool via /dev/cpu,
but userspace should not be poking at MSRs. So move the enabling into
the kernel.

 [ bp: Correct the explanation why this is done. ]

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201030190807.GA13884@agluck-desk2.amr.corp.intel.com
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/kernel/cpu/mce/intel.c  | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 972a34d..b2dd264 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -139,6 +139,7 @@
 #define MSR_IA32_MCG_CAP		0x00000179
 #define MSR_IA32_MCG_STATUS		0x0000017a
 #define MSR_IA32_MCG_CTL		0x0000017b
+#define MSR_ERROR_CONTROL		0x0000017f
 #define MSR_IA32_MCG_EXT_CTL		0x000004d0
 
 #define MSR_OFFCORE_RSP_0		0x000001a6
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index abe9fe0..b47883e 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -509,12 +509,32 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 	}
 }
 
+/*
+ * Enable additional error logs from the integrated
+ * memory controller on processors that support this.
+ */
+static void intel_imc_init(struct cpuinfo_x86 *c)
+{
+	u64 error_control;
+
+	switch (c->x86_model) {
+	case INTEL_FAM6_SANDYBRIDGE_X:
+	case INTEL_FAM6_IVYBRIDGE_X:
+	case INTEL_FAM6_HASWELL_X:
+		rdmsrl(MSR_ERROR_CONTROL, error_control);
+		error_control |= 2;
+		wrmsrl(MSR_ERROR_CONTROL, error_control);
+		break;
+	}
+}
+
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
 	intel_init_thermal(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_ppin_init(c);
+	intel_imc_init(c);
 }
 
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
