Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE62B82FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgKRRSy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgKRRSa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:30 -0500
Date:   Wed, 18 Nov 2020 17:18:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynsJm5MbEPdWZx7Vl8x/cQVkoBoJJUr0peOXU4eRE4w=;
        b=w3aKnVJ1+Kg5xEnWhNmpTwXq7a+F0bfX76gp1mVmSghBB7CG5Ix8Jm/QqZ+6u5NnXISCEC
        AXin/ZGTbCA85clBNjSQJRINDSfyitSv5AvUyQesM+bZJGrMawZXwMuObfeHcORWMA+750
        pylVWI40nsXBjVCNzzyYo1PGotK14P8pLR5sUhe3733ks8UAQZ8cc8jkj3rpUYc8NsuwFr
        H5eThI7gymJqAXQ7A236Tq0wW5IFm2K8fD+s9kz+hPTOra86op/XlIe48VzecHa3+UHl40
        3TcNxvkmnYbBXVrt39wf9yxpo1CbUyibhhYyuS1PLtNt3ol95iCMnVfTQHB2sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ynsJm5MbEPdWZx7Vl8x/cQVkoBoJJUr0peOXU4eRE4w=;
        b=O6KteNcarjrKYL/bxs2eU8Z4ASy5HzOeUEQVGEOt3xOUgIOCKaE7ifXDH20DQayTL4r0Gq
        CDjjE+6Onrp//CBg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/mm: Signal SIGSEGV with PF_SGX
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-7-jarkko@kernel.org>
References: <20201112220135.165028-7-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990706.11244.4736828606555513406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     74faeee06db81a06add0def6a394210c8fef0ab7
Gitweb:        https://git.kernel.org/tip/74faeee06db81a06add0def6a394210c8fef0ab7
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Nov 2020 14:36:13 +01:00

x86/mm: Signal SIGSEGV with PF_SGX

The x86 architecture has a set of page fault error codes.  These indicate
things like whether the fault occurred from a write, or whether it
originated in userspace.

The SGX hardware architecture has its own per-page memory management
metadata (EPCM) [*] and hardware which is separate from the normal x86 MMU.
The architecture has a new page fault error code: PF_SGX.  This new error
code bit is set whenever a page fault occurs as the result of the SGX MMU.

These faults occur for a variety of reasons.  For instance, an access
attempt to enclave memory from outside the enclave causes a PF_SGX fault.
PF_SGX would also be set for permission conflicts, such as if a write to an
enclave page occurs and the page is marked read-write in the x86 page
tables but is read-only in the EPCM.

These faults do not always indicate errors, though.  SGX pages are
encrypted with a key that is destroyed at hardware reset, including
suspend. Throwing a SIGSEGV allows user space software to react and recover
when these events occur.

Include PF_SGX in the PF error codes list and throw SIGSEGV when it is
encountered.

[*] Intel SDM: 36.5.1 Enclave Page Cache Map (EPCM)

 [ bp: Add bit 15 to the comment above enum x86_pf_error_code too. ]

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-7-jarkko@kernel.org
---
 arch/x86/include/asm/trap_pf.h |  2 ++
 arch/x86/mm/fault.c            | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
index 305bc12..10b1de5 100644
--- a/arch/x86/include/asm/trap_pf.h
+++ b/arch/x86/include/asm/trap_pf.h
@@ -11,6 +11,7 @@
  *   bit 3 ==				1: use of reserved bit detected
  *   bit 4 ==				1: fault was an instruction fetch
  *   bit 5 ==				1: protection keys block access
+ *   bit 15 ==				1: SGX MMU page-fault
  */
 enum x86_pf_error_code {
 	X86_PF_PROT	=		1 << 0,
@@ -19,6 +20,7 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SGX	=		1 << 15,
 };
 
 #endif /* _ASM_X86_TRAP_PF_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 82bf37a..9339fee 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1102,6 +1102,18 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 		return 1;
 
 	/*
+	 * SGX hardware blocked the access.  This usually happens
+	 * when the enclave memory contents have been destroyed, like
+	 * after a suspend/resume cycle. In any case, the kernel can't
+	 * fix the cause of the fault.  Handle the fault as an access
+	 * error even in cases where no actual access violation
+	 * occurred.  This allows userspace to rebuild the enclave in
+	 * response to the signal.
+	 */
+	if (unlikely(error_code & X86_PF_SGX))
+		return 1;
+
+	/*
 	 * Make sure to check the VMA so that we do not perform
 	 * faults just to hit a X86_PF_PK as soon as we fill in a
 	 * page.
