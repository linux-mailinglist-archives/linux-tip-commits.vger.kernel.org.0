Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC233F95B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhCQTdP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 15:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhCQTc4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 15:32:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3785C06174A;
        Wed, 17 Mar 2021 12:32:56 -0700 (PDT)
Date:   Wed, 17 Mar 2021 19:32:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616009573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=413vhgPwGyEe8XqBYLwSj3f1JMgtKyL76g5ZfCUfAEE=;
        b=jIMHdEw3btbkTZ4n7zSyc2RlFmXm+rQsVuGHcvBIGkI+EWPI1pKCEWHQV+/ctYTMCCjeSX
        zEdxNqO3VHX+bDpNBuYEPE15OvAG6ALCUd6ufHQCoSGEScare4dbXNQd8Jmt7IOGItb960
        k6xaUHa8/rdl9JNbX9qQEENCPnHL9lllU1dQIOkF+udGDZ5bK3djpO4co9mrzfx8fVQ+of
        8thlIfo+jqrCua5FCDScGaqXDeNtMHzcNlPEFvN8l7V8eiAaMq7hGnB3mug+IGVsSNii+w
        ENzsh5BDlxT803amJfgu59BNBasDKjPxonm3Kdbzp7BvTa0j6/4E9sL89/aCoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616009573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=413vhgPwGyEe8XqBYLwSj3f1JMgtKyL76g5ZfCUfAEE=;
        b=bXkkad0CV4TXUzqy73OaslAE6Uv0x3iTWVv/NraxTZORJ/c40pT+J5KjxXViw03PRdyuIu
        M97PkyauAtHoC/AQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] tools/insn: Restore the relative include paths for
 cross building
Cc:     Ian Rogers <irogers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210317150858.02b1bbc8@canb.auug.org.au>
References: <20210317150858.02b1bbc8@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <161600957270.398.1883140806620586941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0705ef64d1ff52b817e278ca6e28095585ff31e1
Gitweb:        https://git.kernel.org/tip/0705ef64d1ff52b817e278ca6e28095585ff31e1
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 17 Mar 2021 11:33:04 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 17 Mar 2021 20:17:05 +01:00

tools/insn: Restore the relative include paths for cross building

Building perf on ppc causes:

  In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
  util/intel-pt-decoder/../../../arch/x86/lib/insn.c:14:10: fatal error: asm/inat.h: No such file or directory
     14 | #include <asm/inat.h> /*__ignore_sync_check__ */
        |          ^~~~~~~~~~~~

Restore the relative include paths so that the compiler can find the
headers.

Fixes: 93281c4a9657 ("x86/insn: Add an insn_decode() API")
Reported-by: Ian Rogers <irogers@google.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Ian Rogers <irogers@google.com>
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lkml.kernel.org/r/20210317150858.02b1bbc8@canb.auug.org.au
---
 tools/arch/x86/lib/insn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index cd4dedd..c41f958 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -11,13 +11,13 @@
 #else
 #include <string.h>
 #endif
-#include <asm/inat.h> /*__ignore_sync_check__ */
-#include <asm/insn.h> /* __ignore_sync_check__ */
+#include "../include/asm/inat.h" /* __ignore_sync_check__ */
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
 #include <linux/errno.h>
 #include <linux/kconfig.h>
 
-#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
+#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
 
 #define leXX_to_cpu(t, r)						\
 ({									\
