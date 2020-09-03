Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0925BDFF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Sep 2020 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgICJA2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Sep 2020 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgICJA0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Sep 2020 05:00:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D0C061244;
        Thu,  3 Sep 2020 02:00:25 -0700 (PDT)
Date:   Thu, 03 Sep 2020 09:00:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599123623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEmG++bixu9W7TmmdOMxnU6Msdk80tG/JOFts20Mdh0=;
        b=W2LChxv12wTghU9ex5WnuJjEMgybMoy4d+kM8Tf5h0U7Z8K9U5Za8NnGugFoeo10hJtNSN
        mdGDqAogPXcpBBXzZ+mvFWmfbJDQRRCrrF+PNKbUl5CEBXfsAOddKo3jIs46BObD65so+0
        PtFBeTDmp8kpkmskhFp8QpEtDe57Xv1pwLl78RY9+sXFloeHYZJC/asANANBFYJ1cAPmW7
        dQo+M6AIVwRrI/L7KESwuf59r+Scg7OFQ8Tf/xz38F2anZ7b5hMerDPh95aDwMYB6MtxTI
        C6shn7/yEVRUKfI60Sf2Z/Z7ik2lE8AzvqEm4q5dsB5PWoqE05IfmxDl8EZ2HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599123623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEmG++bixu9W7TmmdOMxnU6Msdk80tG/JOFts20Mdh0=;
        b=sliHzsWTQQkcsGbcYS5iDuIwBVCljhXgpJp6XUlBtacYlOCuFLgd0UeZMOIOjcOeqwLPls
        dnYPk/nUO1BCLeCA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cmdline: Disable jump tables for cmdline.c
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200903023056.3914690-1-nivedita@alum.mit.edu>
References: <20200903023056.3914690-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159912362248.20229.4425613326323772481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     aef0148f3606117352053c015cb33734e9ee7397
Gitweb:        https://git.kernel.org/tip/aef0148f3606117352053c015cb33734e9ee7397
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Wed, 02 Sep 2020 22:30:56 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 10:59:16 +02:00

x86/cmdline: Disable jump tables for cmdline.c

When CONFIG_RETPOLINE is disabled, Clang uses a jump table for the
switch statement in cmdline_find_option (jump tables are disabled when
CONFIG_RETPOLINE is enabled). This function is called very early in boot
from sme_enable() if CONFIG_AMD_MEM_ENCRYPT is enabled. At this time,
the kernel is still executing out of the identity mapping, but the jump
table will contain virtual addresses.

Fix this by disabling jump tables for cmdline.c when AMD_MEM_ENCRYPT is
enabled.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200903023056.3914690-1-nivedita@alum.mit.edu
---
 arch/x86/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index d46fff1..aa06785 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -24,7 +24,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
 endif
 
-CFLAGS_cmdline.o := -fno-stack-protector
+CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
 endif
 
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
