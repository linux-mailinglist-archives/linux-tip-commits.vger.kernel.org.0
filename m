Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC1330CA7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 12:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHLrY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 06:47:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhCHLrA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 06:47:00 -0500
Date:   Mon, 08 Mar 2021 11:46:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615204019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64DrBJ5PPOx7zbYtHA04Cmn8KxbscZ0DtP+JelBJ3zQ=;
        b=S2rgQbqRqb7NB6Atmojk4RE3eaVPk2lIIcp5WigiNEU6SvnTUrMiaSpJe2krj85sIfgyPd
        rHtvyBPauIR5+hBXHJuqXvWcX5qDnbkptU2ZxG1xdw6h6y+a8vRFRb0pf3teinO0F1dPlN
        1E6w+QqQQx4ffEm7KQU77M3eHcJv4PpvuHOfG0g8S9buIoL38DwRUNVfIjywXyqtfpQxTM
        2TCFQTJqasnyt1fx4GJmTXw6JQN5JxZDp+ilhHcMYhlArPvgkbo3J1fsCJMnGEcE77reL+
        VbqSaNxiJ6dotjkwlUersLdj7yV9/ZqiGk82Z8sodvDGbMByOh54fiy5s419mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615204019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64DrBJ5PPOx7zbYtHA04Cmn8KxbscZ0DtP+JelBJ3zQ=;
        b=jL7XSSGzmux24k0e3VFk9oZRzAfKlbT7kH2smoo2ODqimfV2sIcPRSqaZXUDvvJpxgzyvH
        5UO+PZBBKTnambCA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Remove duplicate TSC DEADLINE MSR definitions
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
MIME-Version: 1.0
Message-ID: <161520401893.398.448414971699650740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     09141ec0e4efede4fb5e2aa68cb819fba974325c
Gitweb:        https://git.kernel.org/tip/09141ec0e4efede4fb5e2aa68cb819fba974325c
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Thu, 05 Mar 2020 09:47:06 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Mar 2021 11:05:20 +01:00

x86: Remove duplicate TSC DEADLINE MSR definitions

There are two definitions for the TSC deadline MSR in msr-index.h,
one with an underscore and one without.  Axe one of them and move
all the references over to the other one.

 [ bp: Fixup the MSR define in handle_fastpath_set_msr_irqoff() too. ]

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200305174706.0D6B8EE4@viggo.jf.intel.com
---
 arch/x86/include/asm/msr-index.h               | 2 --
 arch/x86/kvm/x86.c                             | 8 ++++----
 tools/arch/x86/include/asm/msr-index.h         | 2 --
 tools/perf/trace/beauty/tracepoints/x86_msr.sh | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ec..4502935 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -628,8 +628,6 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
-#define MSR_IA32_TSCDEADLINE		0x000006e0
-
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2a20ce6..c020499 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1288,7 +1288,7 @@ static const u32 emulated_msrs_all[] = {
 	MSR_KVM_PV_EOI_EN, MSR_KVM_ASYNC_PF_INT, MSR_KVM_ASYNC_PF_ACK,
 
 	MSR_IA32_TSC_ADJUST,
-	MSR_IA32_TSCDEADLINE,
+	MSR_IA32_TSC_DEADLINE,
 	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_IA32_PERF_CAPABILITIES,
 	MSR_IA32_MISC_ENABLE,
@@ -1841,7 +1841,7 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 			ret = EXIT_FASTPATH_EXIT_HANDLED;
 		}
 		break;
-	case MSR_IA32_TSCDEADLINE:
+	case MSR_IA32_TSC_DEADLINE:
 		data = kvm_read_edx_eax(vcpu);
 		if (!handle_fastpath_set_tscdeadline(vcpu, data)) {
 			kvm_skip_emulated_instruction(vcpu);
@@ -3075,7 +3075,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		return kvm_set_apic_base(vcpu, msr_info);
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
 		return kvm_x2apic_msr_write(vcpu, msr, data);
-	case MSR_IA32_TSCDEADLINE:
+	case MSR_IA32_TSC_DEADLINE:
 		kvm_set_lapic_tscdeadline_msr(vcpu, data);
 		break;
 	case MSR_IA32_TSC_ADJUST:
@@ -3437,7 +3437,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
 		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
-	case MSR_IA32_TSCDEADLINE:
+	case MSR_IA32_TSC_DEADLINE:
 		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
 		break;
 	case MSR_IA32_TSC_ADJUST:
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 546d6ec..4502935 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -628,8 +628,6 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
-#define MSR_IA32_TSCDEADLINE		0x000006e0
-
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.sh b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
index 27ee1ea..9b0614a 100755
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh
@@ -15,7 +15,7 @@ x86_msr_index=${arch_x86_header_dir}/msr-index.h
 
 printf "static const char *x86_MSRs[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|IA32_(TSCDEADLINE|UCODE_REV)|IDT_FCR4)' | \
+egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|IA32_(TSC_DEADLINE|UCODE_REV)|IDT_FCR4)' | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
