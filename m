Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D77F29EB68
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJ2MPe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgJ2MPd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94392C0613CF;
        Thu, 29 Oct 2020 05:15:33 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WNlz1OiUIl6k02HRoYOzLMZ12Xw49A7AJkNnIwjTJc=;
        b=gbIi0H3TR+xzHrGmY5+fiZLl3BX17Ss4V1WLpUFhFYWpuHHNwSaEy+NkgWX+W3sI+CwuBB
        xGb2/Ddn+vndba84/OHievuUpWQFDMBC2r00I4x5hPlQjUyr9ONJSVvJLB/HzRfI+sgyb4
        ltZIVEK5Uc+JH6UHT+XKNM74hanSuHhum596rtcX2StIvbkSaTUldmrQ79dNBQmm2nW4+D
        +bD/Kngm5AvuX3IUcONNEwO23SxUebVXKKLrZ0giiQaPTTTH1Uhcfril3efMD4Ebe3mrG5
        ctPUToHiss7zbyzkxv5+j9RvYlwobt46YzdS6GIjZgXlneBJV9AEbpHfOnA5TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973729;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WNlz1OiUIl6k02HRoYOzLMZ12Xw49A7AJkNnIwjTJc=;
        b=ICC76cSaDulZBCZ6VYjQOk+IWvKemZFagqvXOC+37Ueh9j88mpJnBeCMdbvBrTuMv88KDK
        CzDUGCegpLcSKqBg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/kvm: Enable 15-bit extension when
 KVM_FEATURE_MSI_EXT_DEST_ID detected
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-36-dwmw2@infradead.org>
References: <20201024213535.443185-36-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397372865.397.6913628977988401613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2e008ffe426f927b1697adb4ed10c1e419927ae4
Gitweb:        https://git.kernel.org/tip/2e008ffe426f927b1697adb4ed10c1e419927ae4
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:33 +01:00

x86/kvm: Enable 15-bit extension when KVM_FEATURE_MSI_EXT_DEST_ID detected

This allows the host to indicate that MSI emulation supports 15-bit
destination IDs, allowing up to 32768 CPUs without interrupt remapping.

cf. https://patchwork.kernel.org/patch/11816693/ for qemu

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20201024213535.443185-36-dwmw2@infradead.org

---
 arch/x86/kernel/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7f57ede..5e78e01 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -740,6 +740,11 @@ static void __init kvm_apic_init(void)
 #endif
 }
 
+static bool __init kvm_msi_ext_dest_id(void)
+{
+	return kvm_para_has_feature(KVM_FEATURE_MSI_EXT_DEST_ID);
+}
+
 static void __init kvm_init_platform(void)
 {
 	kvmclock_init();
@@ -769,6 +774,7 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.type				= X86_HYPER_KVM,
 	.init.guest_late_init		= kvm_guest_init,
 	.init.x2apic_available		= kvm_para_available,
+	.init.msi_ext_dest_id		= kvm_msi_ext_dest_id,
 	.init.init_platform		= kvm_init_platform,
 #if defined(CONFIG_AMD_MEM_ENCRYPT)
 	.runtime.sev_es_hcall_prepare	= kvm_sev_es_hcall_prepare,
