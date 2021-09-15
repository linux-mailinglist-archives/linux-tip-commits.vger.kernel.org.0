Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7961140C8B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhIOPun (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbhIOPum (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15896C061574;
        Wed, 15 Sep 2021 08:49:23 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r75Ctp6LB7q3XZR9RpO82k3ukFI64iW5b5XUOQWrsvo=;
        b=IxMz6KUbDETa8N7UcQl1eTPnPGEtAijKruQuG8IL5q1fq8PB3XVK+615e5f23yvcCsibql
        2WJQBVejpAA1TYE444SZVi/JO+Q+9GCHDF7NXIWyIhhJSInHkzGH+K9f/lvmxsBZX22NGt
        0lZfhr3tI81Oz06HV+zjrtvGtoiHoYLyAKadCoSKoEVqf61gQ1T0edcBzP4Be/3unPqgsf
        uJYJ03IRLV6Q6WkQe6lSmlmE7A403+Bws6xm0ZL4lkVuWJ7ipWO/hoZcI1f8osypFKLyuf
        +se4U2F9mbr8qFA6Vi0t62wTbUsdYcu8Ay5fKD0o7HIHdwWhtnz8Gj/+bcQI7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r75Ctp6LB7q3XZR9RpO82k3ukFI64iW5b5XUOQWrsvo=;
        b=Y27QFwK+yZRom7sACYgXFBVNvutTFOtsxlE/ftDTUVPHcRbQNw2cPa/eisZnudoL+uz4o3
        1qHPF/2oZ/JfLbCA==
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
Message-ID: <163172096019.25758.4868421536203773634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9f38b2a0baf1e5c7a1d1231cd8fe706c6f769a73
Gitweb:        https://git.kernel.org/tip/9f38b2a0baf1e5c7a1d1231cd8fe706c6f769a73
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:50 +02:00

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
