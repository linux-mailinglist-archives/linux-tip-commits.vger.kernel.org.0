Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DB2EF113
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Jan 2021 12:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAHLIy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Jan 2021 06:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAHLIy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Jan 2021 06:08:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01715C0612F4;
        Fri,  8 Jan 2021 03:08:13 -0800 (PST)
Date:   Fri, 08 Jan 2021 11:08:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610104091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbt5GrQZk7/Or5HYgOF7PDj8cEURSPo4rBTl6/xtUBo=;
        b=J1Wx1tGzFCT6XgdDCJCvi8c7gJqpx3kQCcgQla0P/gerTbrvZdjCDHZwhnqHayrBFPf6Gm
        jd0PzIXJDZsyxKmia3aNCllCPT3mc/HmyLZwoV09kDZeF/FWhWQMIJv1uYBZmx46BbcQfD
        XbKMBkZIxCpELsia4pU2S7FRhlEuP/1BeAmLrnv6bfAFv9bRfkX/p186KZpd1NLqg8slLC
        zjqvQa+4jMMrrUOO3sH5Ax361f9tLUZ5jansTRdN27UQwZMqb6bPcCdrbLOk5RB+tIr1Tu
        3MSnTC9IJeByRlHulffKRIqocoQWWcFWv+mVdxgH9dUCRM+2nKJFwKM4+dbgSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610104091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbt5GrQZk7/Or5HYgOF7PDj8cEURSPo4rBTl6/xtUBo=;
        b=vCL4mJllkEXaaw58nKAsBk/+virqsEd88UHKoUatou1DSvsxNk7hwdyjOGIeQqJ11DWCTa
        y7DbwQdldttk0bBg==
From:   "tip-bot2 for Dave Jiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Annotate movdir64b()'s dst argument with __iomem
Cc:     kernel test robot <lkp@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <161003787823.4062451.6564503265464317197.stgit@djiang5-desk3.ch.intel.com>
References: <161003787823.4062451.6564503265464317197.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Message-ID: <161010409107.414.15253065088862415819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     6ae58d871319dc22ef780baaacd393f8543a1e74
Gitweb:        https://git.kernel.org/tip/6ae58d871319dc22ef780baaacd393f8543a1e74
Author:        Dave Jiang <dave.jiang@intel.com>
AuthorDate:    Thu, 07 Jan 2021 09:44:51 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Jan 2021 11:41:29 +01:00

x86/asm: Annotate movdir64b()'s dst argument with __iomem

Add a missing __iomem annotation to address a sparse warning. The caller
is expected to pass an __iomem annotated pointer to this function. The
current usages send a 64-bytes command descriptor to an MMIO location
(portal) on a device for consumption. When future usages for the
MOVDIR64B instruction warrant a separate variant of a memory to memory
operation, the argument annotation can be revisited.

Also, from the comment in movdir64b() @__dst must be supplied as an
lvalue because this tells the compiler what the object is (its size) the
instruction accesses. I.e., not the pointers but what they point to,
thus the deref'ing '*'."

The actual sparse warning is:

  sparse warnings: (new ones prefixed by >>)
     drivers/dma/idxd/submit.c: note: in included file (through include/linux/io.h, include/linux/pci.h):
  >> arch/x86/include/asm/io.h:422:27: sparse: sparse: incorrect type in \
     argument 1 (different address spaces)
		   @@     expected void *dst
		   @@     got void [noderef] __iomem *dst @@
     arch/x86/include/asm/io.h:422:27: sparse:     expected void *dst
     arch/x86/include/asm/io.h:422:27: sparse:     got void [noderef] __iomem *dst

 [ bp: Massage commit message. ]

Fixes: 0888e1030d3e ("x86/asm: Carve out a generic movdir64b() helper for general usage")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lkml.kernel.org/r/161003787823.4062451.6564503265464317197.stgit@djiang5-desk3.ch.intel.com
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index cc177b4..4e23464 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -243,10 +243,10 @@ static inline void serialize(void)
 }
 
 /* The dst parameter must be 64-bytes aligned */
-static inline void movdir64b(void *dst, const void *src)
+static inline void movdir64b(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } *__dst = dst;
+	struct { char _[64]; } __iomem *__dst = dst;
 
 	/*
 	 * MOVDIR64B %(rdx), rax.
