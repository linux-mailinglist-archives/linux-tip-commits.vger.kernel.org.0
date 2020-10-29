Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8305B29F4BF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 20:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJ2TSd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgJ2TRn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 15:17:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF70C0613CF;
        Thu, 29 Oct 2020 12:17:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:17:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603999061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdbniP1Q2qqRccf48jNi/8ViUe2Tif2mifUmZBuyWYk=;
        b=2X6EUmUIfspSbxjc7cRPjpf7159TpZ/tGQDtSRyClecBDRYknHgHdPsRoabQUXokab59xn
        4CjN5S5vRG432tjwpqBSSeCQzxMSJ0N354L91OvpzRHJmANZ05qy8IJsGf39icQzJdkFFh
        tBwl7ctrIByJt0JWt4TGeZeaV+kob2Hjk23Fsq/9pRp/vnvYViNqAvxcwKKEnikb2PyxdW
        SBnGg1xUMCv/TLD9h+voM3Wgu5CsZ0iD9i7LGci9qponLf5i2Td4wSi6EqkjSrReNnNeSX
        GfVKHmqHka9uBoHdUEibL58aL2aJAHM5eUbjTUHOXR+eOkOTOWWuYzfqc//tYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603999061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdbniP1Q2qqRccf48jNi/8ViUe2Tif2mifUmZBuyWYk=;
        b=LkcBtkMKRMv6m0Z6ADv5Stm3a+WMHnpgWCadVGCnU4Awn4NYwQ9jmAnS1gM6+n2hCqOG8N
        6KlCjLwooSJRCiDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Do not support MMIO to/from encrypted memory
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028164659.27002-6-joro@8bytes.org>
References: <20201028164659.27002-6-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <160399905983.397.18131875456856361815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     2411cd82112397bfb9d8f0f19cd46c3d71e0ce67
Gitweb:        https://git.kernel.org/tip/2411cd82112397bfb9d8f0f19cd46c3d71e0ce67
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 28 Oct 2020 17:46:59 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 29 Oct 2020 19:27:42 +01:00

x86/sev-es: Do not support MMIO to/from encrypted memory

MMIO memory is usually not mapped encrypted, so there is no reason to
support emulated MMIO when it is mapped encrypted.

Prevent a possible hypervisor attack where a RAM page is mapped as
an MMIO page in the nested page-table, so that any guest access to it
will trigger a #VC exception and leak the data on that page to the
hypervisor via the GHCB (like with valid MMIO). On the read side this
attack would allow the HV to inject data into the guest.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20201028164659.27002-6-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 4a96726..0bd1a0f 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -374,8 +374,8 @@ fault:
 	return ES_EXCEPTION;
 }
 
-static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 unsigned long vaddr, phys_addr_t *paddr)
+static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+					   unsigned long vaddr, phys_addr_t *paddr)
 {
 	unsigned long va = (unsigned long)vaddr;
 	unsigned int level;
@@ -394,15 +394,19 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 		if (user_mode(ctxt->regs))
 			ctxt->fi.error_code |= X86_PF_USER;
 
-		return false;
+		return ES_EXCEPTION;
 	}
 
+	if (WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC))
+		/* Emulated MMIO to/from encrypted memory not supported */
+		return ES_UNSUPPORTED;
+
 	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
 	pa |= va & ~page_level_mask(level);
 
 	*paddr = pa;
 
-	return true;
+	return ES_OK;
 }
 
 /* Include code shared with pre-decompression boot stage */
@@ -731,6 +735,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 {
 	u64 exit_code, exit_info_1, exit_info_2;
 	unsigned long ghcb_pa = __pa(ghcb);
+	enum es_result res;
 	phys_addr_t paddr;
 	void __user *ref;
 
@@ -740,11 +745,12 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 
 	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
 
-	if (!vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr)) {
-		if (!read)
+	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
+	if (res != ES_OK) {
+		if (res == ES_EXCEPTION && !read)
 			ctxt->fi.error_code |= X86_PF_WRITE;
 
-		return ES_EXCEPTION;
+		return res;
 	}
 
 	exit_info_1 = paddr;
