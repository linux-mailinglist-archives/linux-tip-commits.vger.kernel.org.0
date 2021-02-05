Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09FD3108A0
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Feb 2021 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhBEJ5z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 04:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhBEJzt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 04:55:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21037C0613D6;
        Fri,  5 Feb 2021 01:55:09 -0800 (PST)
Date:   Fri, 05 Feb 2021 09:55:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612518907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nm+eQE37WFWsRlF/7b2lgg3hzVX4/p/13UtpbBDqgZI=;
        b=1E3PZb/HDKtjPsDoBr7xusoYKyt9MCwrvbjiLf2QxgRpv3zwespmEfjJA581G7dhy0kpnx
        PJQd2qb2ZBHGNQjbbvFUf/jby5jvxciWdUejD/tviXiprtJuAPJ7rEHql8I629UUWaVz2C
        Qod0S/xktvYuFgwnAO+Afyhy+F5ikASsM7I8DrhenmvqyCNXi1akKusYly4JEBc7MKvVkg
        OqgHBaw2/ZbRmz8ftuog/FLEwjrFlHJB+os2CI/5bd6m+Elj/nKZKfILho8G3NTVMJSODj
        C/NTGvGiguavWmR2rJLaL40q5Gp978O2PdnnzZWFAFjkM0N2hWuaUDRoMY8pFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612518907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nm+eQE37WFWsRlF/7b2lgg3hzVX4/p/13UtpbBDqgZI=;
        b=jSOJeyn+0WzBo35Dn0GWsm6mrHo7d4SsrwXWO5LGHUufTxsXwACvjrp9fU5jcxndXf0Xue
        Go9A6RAAcYIG2bBw==
From:   "tip-bot2 for Daniel Vetter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Drop racy follow_pfn() check
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210204184519.2809313-1-daniel.vetter@ffwll.ch>
References: <20210204184519.2809313-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Message-ID: <161251890694.23325.7141350574807037445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     dc9b7be557ca94301ea5c06c0d72307e642ffb18
Gitweb:        https://git.kernel.org/tip/dc9b7be557ca94301ea5c06c0d72307e642ffb18
Author:        Daniel Vetter <daniel.vetter@ffwll.ch>
AuthorDate:    Thu, 04 Feb 2021 19:45:19 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 05 Feb 2021 10:45:11 +01:00

x86/sgx: Drop racy follow_pfn() check

PTE insertion is fundamentally racy, and this check doesn't do anything
useful. Quoting Sean:

  "Yeah, it can be whacked. The original, never-upstreamed code asserted
  that the resolved PFN matched the PFN being installed by the fault
  handler as a sanity check on the SGX driver's EPC management. The
  WARN assertion got dropped for whatever reason, leaving that useless
  chunk."

Jason stumbled over this as a new user of follow_pfn(), and I'm trying
to get rid of unsafe callers of that function so it can be locked down
further.

This is independent prep work for the referenced patch series:

  https://lore.kernel.org/dri-devel/20201127164131.2244124-1-daniel.vetter@ffwll.ch/

Fixes: 947c6e11fa43 ("x86/sgx: Add ptrace() support for the SGX driver")
Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20210204184519.2809313-1-daniel.vetter@ffwll.ch
---
 arch/x86/kernel/cpu/sgx/encl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a50..20a2dd5 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -141,7 +141,6 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 	struct sgx_encl_page *entry;
 	unsigned long phys_addr;
 	struct sgx_encl *encl;
-	unsigned long pfn;
 	vm_fault_t ret;
 
 	encl = vma->vm_private_data;
@@ -168,13 +167,6 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
 
-	/* Check if another thread got here first to insert the PTE. */
-	if (!follow_pfn(vma, addr, &pfn)) {
-		mutex_unlock(&encl->lock);
-
-		return VM_FAULT_NOPAGE;
-	}
-
 	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
 	if (ret != VM_FAULT_NOPAGE) {
 		mutex_unlock(&encl->lock);
