Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3540F88B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbhIQM7n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbhIQM73 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6FC061768;
        Fri, 17 Sep 2021 05:58:07 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYgWE68HdmPGjgheq4PuUpfSh3BpvRRLuHSStWiBZwc=;
        b=BQBVhTv4jjsHxwX3DvlSDO0Ixo+qlQabEYX7uIO1jVZC+BwkixAyyOb97I518XYW2AMosM
        BiZjmSD5GdMaayCyFLJ/U2uthigut4u8B87LS3cvOqDVVdMjQQjz5Vgm0PVEauEfLHRiP+
        FWh5x5ClOsfEXjTLtF2Oqtza1bW3Dem4k2EMLWlz5g0aeyXtYU1qZ0jdq2KPymD56tQOzj
        NN7BYftXzQh2wQI+EDK6e4RYvk5j7Ctt3obEtfDGjWRlKcAH4P4M7ypA1907caM0nCEoB6
        Px5PXhd90g5Zaqf9fQsgqkyVlGX6kY3GpN/AY5frV2iwH2f1Syis4f6pLRJa2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883486;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sYgWE68HdmPGjgheq4PuUpfSh3BpvRRLuHSStWiBZwc=;
        b=54ebXT15nKzvG4Q3S6aXMt/gU/jVplKA7a7zYruxjyC7E/d/cFIDO3DCe3vyRTO2RjCVgC
        1sfAt87SMR8sKiBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make hypercall_page noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.810950584@infradead.org>
References: <20210624095148.810950584@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348531.25758.3423530610234107435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     74ea805b79d2b6eb472daa2540ed35ccb4ed23e7
Gitweb:        https://git.kernel.org/tip/74ea805b79d2b6eb472daa2540ed35ccb4ed23e7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:14:44 +02:00

x86/xen: Make hypercall_page noinstr

vmlinux.o: warning: objtool: xen_set_debugreg()+0x3: call to hypercall_page() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_get_debugreg()+0x3: call to hypercall_page() leaves .noinstr.text section
vmlinux.o: warning: objtool: xen_irq_enable()+0x24: call to hypercall_page() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.810950584@infradead.org
---
 arch/x86/xen/xen-head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 488944d..9e27b86 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -20,7 +20,7 @@
 #include <xen/interface/xen-mca.h>
 #include <asm/xen/interface.h>
 
-.pushsection .text
+.pushsection .noinstr.text, "ax"
 	.balign PAGE_SIZE
 SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
