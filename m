Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4328CB6D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Oct 2020 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgJMKMt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 13 Oct 2020 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgJMKMt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 13 Oct 2020 06:12:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9C7C0613D0;
        Tue, 13 Oct 2020 03:12:49 -0700 (PDT)
Date:   Tue, 13 Oct 2020 10:12:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602583967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fmxELie1ZMn/BFrNt1wnQqSU07/ecPS/BFguewf7go=;
        b=AgasP2MSBg6v7lhZcEXR2ZHJ7+Gspd459EP/bzK77khO5GyjE6l/BuGsT8lmOgKzrXT4rX
        TcpDxdEG740hPcmp2xqIoCKihA/6W9VCNK4+My8pO3NjoFzeYfaty88oyeo9dC7/PrGnJr
        t+pOy+dEsMJReeiaY3jQz2vu+SrYmTlc7bGXfywfd9Sk9lJw+iht14Gi7RdKrPIXIKwPV8
        gdqRqK5gcYBQJkoc82a6gyEkSqk51ER/sJ9c94FTL/QBDU7XqzfvK61Zf4yw7O7a2OM3Os
        dtD9C3Iazo9gRCbOW9OVuM8oV/iQWPbHSafmMnuSzllv23YzetvuE98E27uayg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602583967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2fmxELie1ZMn/BFrNt1wnQqSU07/ecPS/BFguewf7go=;
        b=Nq+TpjdnerllWGRgL/X72UNiLqKZHDSroXJJ7Xf/o/YF0IjyHr+2J3B9KExveRINrjynL2
        C4OnS57x5IXtS1BQ==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] perf build: Allow nested externs to enable
 BUILD_BUG() usage
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cpatch-1=2Ethread-251403=2Egit-2514037e9477=2Eyou?=
 =?utf-8?q?r-ad-here=2Ecall-01602244460-ext-7088=40work=2Ehours=3E?=
References: =?utf-8?q?=3Cpatch-1=2Ethread-251403=2Egit-2514037e9477=2Eyour?=
 =?utf-8?q?-ad-here=2Ecall-01602244460-ext-7088=40work=2Ehours=3E?=
MIME-Version: 1.0
Message-ID: <160258396627.7002.9774762955549564502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ab0a40ea88204e1291b56da8128e2845fec8ee88
Gitweb:        https://git.kernel.org/tip/ab0a40ea88204e1291b56da8128e2845fec8ee88
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Fri, 09 Oct 2020 14:25:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 13 Oct 2020 12:08:32 +02:00

perf build: Allow nested externs to enable BUILD_BUG() usage

Currently the BUILD_BUG() macro is expanded to the following:

   do {
           extern void __compiletime_assert_0(void)
                   __attribute__((error("BUILD_BUG failed")));
           if (!(!(1)))
                   __compiletime_assert_0();
   } while (0);

If used in a function body this would obviously produce build errors
with -Wnested-externs and -Werror.

To enable BUILD_BUG() usage in tools/arch/x86/lib/insn.c which perf
includes in intel-pt-decoder, build perf without -Wnested-externs.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # build tested
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/patch-1.thread-251403.git-2514037e9477.your-ad-here.call-01602244460-ext-7088@work.hours
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 190be4f..8137a60 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -16,7 +16,7 @@ $(shell printf "" > $(OUTPUT).config-detected)
 detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
-CFLAGS := $(EXTRA_CFLAGS) $(EXTRA_WARNINGS)
+CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
 include $(srctree)/tools/scripts/Makefile.arch
 
