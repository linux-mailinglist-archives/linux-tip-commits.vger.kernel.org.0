Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952762EFA08
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Jan 2021 22:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbhAHVNW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Jan 2021 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbhAHVNV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Jan 2021 16:13:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99636C061786;
        Fri,  8 Jan 2021 13:12:41 -0800 (PST)
Date:   Fri, 08 Jan 2021 21:12:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610140359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqdn9tTnffQSLkYfhRcIkKOlV9xpxyqAn5x2Uk+zX3s=;
        b=YMEXm+KaY+eIWdlS1WElq6Q2XL0efbPDqWlibu8cKo8X+GeNcHVGeS7/nd4m9JOBfoPGv8
        /dmGI1KIfX388iXM5lpPbYnQ3lGozyXL8G6Z3vjUv9LT17NJLbHumE9pCSalxq3KHqFqox
        rmJUsH1u22rzw/l4uMLb848NCQZcsCQIJ0RO4ScEBRhUMNIRE1srq4GLq6nd1IOc8+Fdt3
        zeAqWLzuhjfhp4suowCFplvuWbUUSezf/EtgnsmEq9H7lKndCIb3lJZYnt8lxRj2y4yJyT
        Zt3EhsyEUu5X555mvVazwYFdzBSjoYwSK/RuXCiroNfZBe/Tto8z5/lKVnDa7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610140359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqdn9tTnffQSLkYfhRcIkKOlV9xpxyqAn5x2Uk+zX3s=;
        b=l1LPJDsDQXriNwtiE8WCWftykAdd8Bvx2AffVl0NbT56y9r7M/ICUxNcK8tClMX1Hm6BbC
        fFbSu4YUS3mTKLBg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Remove duplicate definition of _PAGE_PAT_LARGE
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201111160946.147341-2-nivedita@alum.mit.edu>
References: <20201111160946.147341-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <161014035797.414.11830416349451082577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4af0e6e39b7ed77796a41537db91d717fedd0ac3
Gitweb:        https://git.kernel.org/tip/4af0e6e39b7ed77796a41537db91d717fedd0ac3
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Wed, 11 Nov 2020 11:09:46 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 08 Jan 2021 22:04:51 +01:00

x86/mm: Remove duplicate definition of _PAGE_PAT_LARGE

_PAGE_PAT_LARGE is already defined next to _PAGE_PAT. Remove the
duplicate.

Fixes: 4efb56649132 ("x86/mm: Tabulate the page table encoding definitions")
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20201111160946.147341-2-nivedita@alum.mit.edu
---
 arch/x86/include/asm/pgtable_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 394757e..f24d7ef 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -177,8 +177,6 @@ enum page_cache_mode {
 #define __pgprot(x)		((pgprot_t) { (x) } )
 #define __pg(x)			__pgprot(x)
 
-#define _PAGE_PAT_LARGE		(_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
-
 #define PAGE_NONE	     __pg(   0|   0|   0|___A|   0|   0|   0|___G)
 #define PAGE_SHARED	     __pg(__PP|__RW|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_SHARED_EXEC     __pg(__PP|__RW|_USR|___A|   0|   0|   0|   0)
