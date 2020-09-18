Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB026F8DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIRJD1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 05:03:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRJD1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 05:03:27 -0400
Date:   Fri, 18 Sep 2020 09:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600419805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+kXnnTGhK+z6ZpNRUPD47PPgu90ft+gqoY9kRw890s=;
        b=o3lYoFksFwyoriu1hS1QebqnH1AIWHmATREyetjU7IceYNQNBmz6AaNDrIaUIrxQfSdmdN
        niDEwT7YIZDpEKl8yDwc3f02aQmamx3pMjoOedkY+/RuuRWU4MKSFFkBS/Ush7+Ecm20+S
        joRUCxalbOgEJq7xcF2i1LfTs1uFLwZdtGfY2s6QSNVmNxuCmt7DxdnCLcdfq5CUnTnc01
        6xkt6CjTv3h0jHCpoBvI6dzx8CcyJQIoLFOT+YPaA3pzGL4myS2+UaAn2ZhmQFPjarKPPD
        pMocp0NwniCFCVOwHBqZzepwxoWDwN9ny0F+I7T8spzuzDV4cFNvqlUBme6EdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600419805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+kXnnTGhK+z6ZpNRUPD47PPgu90ft+gqoY9kRw890s=;
        b=aIwdlh90mdveNpGnqTVpegymmQPlDTe4bEm8kp07bsigVoybex40jUv3wMUvNfBIqPUG0A
        U75do3Aw0DWfq4AQ==
From:   "tip-bot2 for Krish Sadhukhan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm/pat: Don't flush cache if hardware enforces
 cache coherency across encryption domnains
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200917212038.5090-3-krish.sadhukhan@oracle.com>
References: <20200917212038.5090-3-krish.sadhukhan@oracle.com>
MIME-Version: 1.0
Message-ID: <160041980431.15536.3131614271066491139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     75d1cc0e05af579301ce4e49cf6399be4b4e6e76
Gitweb:        https://git.kernel.org/tip/75d1cc0e05af579301ce4e49cf6399be4b4e6e76
Author:        Krish Sadhukhan <krish.sadhukhan@oracle.com>
AuthorDate:    Thu, 17 Sep 2020 21:20:37 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Sep 2020 10:47:00 +02:00

x86/mm/pat: Don't flush cache if hardware enforces cache coherency across encryption domnains

In some hardware implementations, coherency between the encrypted and
unencrypted mappings of the same physical page is enforced. In such a
system, it is not required for software to flush the page from all CPU
caches in the system prior to changing the value of the C-bit for the
page. So check that bit before flushing the cache.

 [ bp: Massage commit message. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200917212038.5090-3-krish.sadhukhan@oracle.com
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d1b2a88..40baa90 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1999,7 +1999,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush(&cpa, 1);
+	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
