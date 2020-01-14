Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2450F13A6F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgANKQ6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 05:16:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42305 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbgANKQ4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 05:16:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFk-0007f7-F3; Tue, 14 Jan 2020 11:16:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1FCCB1C001A;
        Tue, 14 Jan 2020 11:16:52 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:51 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] KVM: VMX: Use VMX feature flag to query BIOS enabling
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-16-sean.j.christopherson@intel.com>
References: <20191221044513.21680-16-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701188.1022.3670681480292304801.tip-bot2@tip-bot2>
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

Commit-ID:     a4d0b2fdbcf75ef6654713c83c316ea3a661ddc3
Gitweb:        https://git.kernel.org/tip/a4d0b2fdbcf75ef6654713c83c316ea3a661ddc3
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:09 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 19:19:32 +01:00

KVM: VMX: Use VMX feature flag to query BIOS enabling

Replace KVM's manual checks on IA32_FEAT_CTL with a query on the boot
CPU's MSR_IA32_FEAT_CTL and VMX feature flags.  The MSR_IA32_FEAT_CTL
indicates that IA32_FEAT_CTL has been configured and that dependent
features are accurately reflected in cpufeatures, e.g. the VMX flag is
now cleared during boot if VMX isn't fully enabled via IA32_FEAT_CTL,
including the case where the MSR isn't supported.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-16-sean.j.christopherson@intel.com
---
 arch/x86/kvm/vmx/vmx.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a026334..06e0e52 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2204,31 +2204,8 @@ static __init int cpu_has_kvm_support(void)
 
 static __init int vmx_disabled_by_bios(void)
 {
-	u64 msr;
-
-	rdmsrl(MSR_IA32_FEAT_CTL, msr);
-
-	if (unlikely(!(msr & FEAT_CTL_LOCKED)))
-		return 1;
-
-	/* launched w/ TXT and VMX disabled */
-	if (!(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX) &&
-	    tboot_enabled())
-		return 1;
-	/* launched w/o TXT and VMX only enabled w/ TXT */
-	if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX) &&
-	    (msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX) &&
-	    !tboot_enabled()) {
-		pr_warn("kvm: disable TXT in the BIOS or "
-			"activate TXT before enabling KVM\n");
-		return 1;
-	}
-	/* launched w/o TXT and VMX disabled */
-	if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX) &&
-	    !tboot_enabled())
-		return 1;
-
-	return 0;
+	return !boot_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
+	       !boot_cpu_has(X86_FEATURE_VMX);
 }
 
 static void kvm_cpu_vmxon(u64 addr)
