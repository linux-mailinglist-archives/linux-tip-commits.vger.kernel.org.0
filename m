Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C692EF115
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Jan 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbhAHLIz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Jan 2021 06:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbhAHLIy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Jan 2021 06:08:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09345C0612F5;
        Fri,  8 Jan 2021 03:08:13 -0800 (PST)
Date:   Fri, 08 Jan 2021 11:08:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610104091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pnteh0V3q9k3AFupSxdyS6az816Sj1h5uCUKQzz+Ydk=;
        b=EkfTnvimciGC1iBifEz3P9yphCmvnuEytWrYRnFEA7NRbCf39HGZZ2tltKgavftUuFwjXy
        nL4KvbcAsujIKcRUwEqOhmuasL1hxCJbcGAxBErJOeeM6IHZeW2VTQVcxxl+JpYe4KtFEJ
        QdV7hMWek83eicQKpH+h/ViAqStjan1Se9OnYgDjQaoSDuQzyCHHYSzIk4KdTBBBl63GOg
        Hz3+RXJQHsLjUGFnJ6b1GF704qZnsUo7SeZCjqanFNGn6Y0VI98J2KSEkt+CtErDM00kC5
        AU6TPNc/d52mLdEktV0ys/RJeOosGyuWAOANBuFNDYEAqYypE6Rha5hLc5qYwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610104091;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pnteh0V3q9k3AFupSxdyS6az816Sj1h5uCUKQzz+Ydk=;
        b=A+aZMs5I9vXgCjJcChxNBlOeaDyokTi1IwyItrTzLnyEHqJdAWRBs66u1mHWrbZS3m0z45
        RF+zNnz+u0XcDXBw==
From:   "tip-bot2 for Dave Jiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Add a missing __iomem annotation in enqcmds()
Cc:     kernel test robot <lkp@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <161003789741.4062451.14362269365703761223.stgit@djiang5-desk3.ch.intel.com>
References: <161003789741.4062451.14362269365703761223.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Message-ID: <161010409071.414.17403934197429773851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     5c99720b28381bb400d4f546734c34ddaf608761
Gitweb:        https://git.kernel.org/tip/5c99720b28381bb400d4f546734c34ddaf608761
Author:        Dave Jiang <dave.jiang@intel.com>
AuthorDate:    Thu, 07 Jan 2021 09:45:21 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Jan 2021 11:57:37 +01:00

x86/asm: Add a missing __iomem annotation in enqcmds()

Add a missing __iomem annotation to address a sparse warning. The caller
is expected to pass an __iomem annotated pointer to this function. The
current usages send a 64-bytes command descriptor to an MMIO location
(portal) on a device for consumption.

Also, from the comment in movdir64b(), which also applies to enqcmds(),
@__dst must be supplied as an lvalue because this tells the compiler
what the object is (its size) the instruction accesses. I.e., not the
pointers but what they point to, thus the deref'ing '*'."

The actual sparse warning is:

  drivers/dma/idxd/submit.c: note: in included file (through arch/x86/include/asm/processor.h, \
	arch/x86/include/asm/timex.h, include/linux/timex.h, include/linux/time32.h, \
	include/linux/time.h, include/linux/stat.h, ...):
  ./arch/x86/include/asm/special_insns.h:289:41: warning: incorrect type in initializer (different address spaces)
  ./arch/x86/include/asm/special_insns.h:289:41:    expected struct <noident> *__dst
  ./arch/x86/include/asm/special_insns.h:289:41:    got void [noderef] __iomem *dst

 [ bp: Massage commit message. ]

Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lkml.kernel.org/r/161003789741.4062451.14362269365703761223.stgit@djiang5-desk3.ch.intel.com
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 4e23464..1d3cbae 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -286,7 +286,7 @@ static inline void movdir64b(void __iomem *dst, const void *src)
 static inline int enqcmds(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
-	struct { char _[64]; } *__dst = dst;
+	struct { char _[64]; } __iomem *__dst = dst;
 	int zf;
 
 	/*
