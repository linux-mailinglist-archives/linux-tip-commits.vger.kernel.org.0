Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DA661560E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Nov 2022 00:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKAXZk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Nov 2022 19:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKAXZj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Nov 2022 19:25:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E05F41;
        Tue,  1 Nov 2022 16:25:38 -0700 (PDT)
Date:   Tue, 01 Nov 2022 23:25:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667345136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PgZ2saWcj12B2LGvN6+ymIA0OYwa1Zze0hs3Kr39gnw=;
        b=bJSDssIleaBpjovgILsQGlTqNzv8T8gAtoSpjJoI0/B6/DFl7suBk4wVLhd/S4L41ug3Yh
        KL128xi7nw0YYImRTujRguSE4FtltHeRzrbt1JazQv5rYhvj+ZG/qpeDE9eFMUcckuBSOs
        A1QPdX0cPPRiNgiiiSyrDTPwhVXqdcJVmPQyM5w73ljbF5ObXnU/sAKtfWdfWdoTrIRf2f
        A8kSgMFh0MnffEKdh96LymIbzGyok2KltrYSrfNqeWvsYEAPfRtrFnScsleNVHpaJvY/L0
        yIta/xW1jE++rgehb+RsxuAiCQstHpOy5F97mNbY7zgCuD889BsmoFaR1XMkZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667345136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PgZ2saWcj12B2LGvN6+ymIA0OYwa1Zze0hs3Kr39gnw=;
        b=97arwmJPxXD9DJleqtNiELngt4bkY+BpSss/wPtT35m39LVvetNNhwQE3mjSM3hZQETEhd
        aBmC46HzUA9fiwBg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tdx: Panic on bad configs that #VE on "private"
 memory access
Cc:     ruogui.ygr@alibaba-inc.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166734513448.7716.12910026848446212237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     373e715e31bf4e0f129befe87613a278fac228d3
Gitweb:        https://git.kernel.org/tip/373e715e31bf4e0f129befe87613a278fac228d3
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 28 Oct 2022 17:12:20 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 01 Nov 2022 16:02:40 -07:00

x86/tdx: Panic on bad configs that #VE on "private" memory access

All normal kernel memory is "TDX private memory".  This includes
everything from kernel stacks to kernel text.  Handling
exceptions on arbitrary accesses to kernel memory is essentially
impossible because they can happen in horribly nasty places like
kernel entry/exit.  But, TDX hardware can theoretically _deliver_
a virtualization exception (#VE) on any access to private memory.

But, it's not as bad as it sounds.  TDX can be configured to never
deliver these exceptions on private memory with a "TD attribute"
called ATTR_SEPT_VE_DISABLE.  The guest has no way to *set* this
attribute, but it can check it.

Ensure ATTR_SEPT_VE_DISABLE is set in early boot.  panic() if it
is unset.  There is no sane way for Linux to run with this
attribute clear so a panic() is appropriate.

There's small window during boot before the check where kernel
has an early #VE handler. But the handler is only for port I/O
and will also panic() as soon as it sees any other #VE, such as
a one generated by a private memory access.

[ dhansen: Rewrite changelog and rebase on new tdx_parse_tdinfo().
	   Add Kirill's tested-by because I made changes since
	   he wrote this. ]

Fixes: 9a22bf6debbf ("x86/traps: Add #VE support for TDX guest")
Reported-by: ruogui.ygr@alibaba-inc.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20221028141220.29217-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3fee969..b8998cf 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -34,6 +34,8 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+#define ATTR_SEPT_VE_DISABLE	BIT(28)
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -102,6 +104,7 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 {
 	struct tdx_module_output out;
 	unsigned int gpa_width;
+	u64 td_attr;
 
 	/*
 	 * TDINFO TDX module call is used to get the TD execution environment
@@ -109,19 +112,27 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	 * information, etc. More details about the ABI can be found in TDX
 	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
 	 * [TDG.VP.INFO].
-	 *
-	 * The GPA width that comes out of this call is critical. TDX guests
-	 * can not meaningfully run without it.
 	 */
 	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
 
-	gpa_width = out.rcx & GENMASK(5, 0);
-
 	/*
 	 * The highest bit of a guest physical address is the "sharing" bit.
 	 * Set it for shared pages and clear it for private pages.
+	 *
+	 * The GPA width that comes out of this call is critical. TDX guests
+	 * can not meaningfully run without it.
 	 */
+	gpa_width = out.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
+
+	/*
+	 * The kernel can not handle #VE's when accessing normal kernel
+	 * memory.  Ensure that no #VE will be delivered for accesses to
+	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
+	 */
+	td_attr = out.rdx;
+	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
+		panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");
 }
 
 /*
