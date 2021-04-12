Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D680F35CFEC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Apr 2021 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbhDLSBA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Apr 2021 14:01:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhDLSA7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Apr 2021 14:00:59 -0400
Date:   Mon, 12 Apr 2021 18:00:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618250440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/Q8WGPG49QTHQNphYe6VR4ho6sQ4V5RArqWd5c7fSI=;
        b=GV7YobhsPiYeJg6RDocEDg2pq/iB64M8E8JiSAyHZB9RvKxbPalsBlrJKtFQwDOn+BT+GP
        H7Tun+/bpB1Pu50uCwFkvOy64BQhXp5PnAcPyMEPNFt5LgjMhCraDX12SrOwlVQCN76FHw
        S8E1jFh32ln4SwIO9EvHqDLqD51CUh+b9OekDyNApLYDn5KFqbFO/XZVUARVCAb7gmIZav
        k6my48lXTed3hOsawc8f2SxU2BZ3U0+pErpvxIgPscA7T32noyOQWNmNuU57zfjh5QyPXE
        DxL6Uzp4PKqqzdnX6bPPyTC7rrrEoVxJIt7C9zljb0/flRwQrDJpsAe4JHGDAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618250440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/Q8WGPG49QTHQNphYe6VR4ho6sQ4V5RArqWd5c7fSI=;
        b=UYtwP9ar1lzQdIfOArHXDhnDXRuW5w+kNimVFN6k/WvqeaL2L8IAqc/1GZr+t2Bd+fO+im
        7ZWkeuyzzNE/SuCQ==
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Mark sgx_vepc_vm_ops static
Cc:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210412160023.193850-1-weiyongjun1@huawei.com>
References: <20210412160023.193850-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Message-ID: <161825043947.29796.13599096792801642099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     523caed9efbb049339706b124185c9358c1b6477
Gitweb:        https://git.kernel.org/tip/523caed9efbb049339706b124185c9358c1b6477
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Mon, 12 Apr 2021 16:00:23 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 12 Apr 2021 19:48:32 +02:00

x86/sgx: Mark sgx_vepc_vm_ops static

Fix the following sparse warning:

  arch/x86/kernel/cpu/sgx/virt.c:95:35: warning:
    symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?

This symbol is not used outside of virt.c so mark it static.

 [ bp: Massage commit message. ]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210412160023.193850-1-weiyongjun1@huawei.com
---
 arch/x86/kernel/cpu/sgx/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7d221ea..6ad165a 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -92,7 +92,7 @@ static vm_fault_t sgx_vepc_fault(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
-const struct vm_operations_struct sgx_vepc_vm_ops = {
+static const struct vm_operations_struct sgx_vepc_vm_ops = {
 	.fault = sgx_vepc_fault,
 };
 
