Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B193D37EDD4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbhELUzU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357083AbhELShy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:37:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D61C061239;
        Wed, 12 May 2021 11:32:33 -0700 (PDT)
Date:   Wed, 12 May 2021 18:32:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620844351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuZ52jdPatIbvnFuE0KauhphGZeSHfIiCbzAT4VZhjE=;
        b=x5Zf6aIE8iyxwSftVm70auKJY26mhjI/DGuZhWhaz4TOaYbhwHWootACL5aoKppgB6P57y
        55x66l9tRPYNI9KV/Fk0sKrEonuLyV85etfuWuwA0hkIdVEAqa73r643WUGAy0xtRiJArh
        dFuD9TgkA+19n9pNNWdqdD10lzRk2SOmakA5CxRios7T3eY61homkcQdCccnNRrfvY+ndd
        0qRpw5EycdbOmggrrtb2+6pFAztWcO0ZjHRp24re1x1B20sAtcsML6PprE9ND3ZDACnP1J
        EF2tPdkpez/u3NxYAIHpT9xfRyuOa2bas/jHT2B+oIyGIlVTDCyMCQ9aPva+eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620844351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuZ52jdPatIbvnFuE0KauhphGZeSHfIiCbzAT4VZhjE=;
        b=G1RE2eUJvQPVIJWPwLNDtmDyfQQQTBBdWREQelBYmcBX4mWrUqDs/QDb532HWlp4yAEPXi
        OjlMvvRQJpER8RDQ==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/x86: Fix elf_add_alternative() endianness
Cc:     Vasily Gorbik <gor@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cpatch-2=2Ethread-6c9df9=2Egit-6c9df9a8098d=2Eyou?=
 =?utf-8?q?r-ad-here=2Ecall-01620841104-ext-2554=40work=2Ehours=3E?=
References: =?utf-8?q?=3Cpatch-2=2Ethread-6c9df9=2Egit-6c9df9a8098d=2Eyour?=
 =?utf-8?q?-ad-here=2Ecall-01620841104-ext-2554=40work=2Ehours=3E?=
MIME-Version: 1.0
Message-ID: <162084435091.29796.15613736364949786764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     e63db0917117b26e0217dde51a9df238d3ed63d2
Gitweb:        https://git.kernel.org/tip/e63db0917117b26e0217dde51a9df238d3ed63d2
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Wed, 12 May 2021 19:42:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 20:25:48 +02:00

objtool/x86: Fix elf_add_alternative() endianness

Currently x86 kernel cross-compiled on big endian system fails at boot with:

  kernel BUG at arch/x86/kernel/alternative.c:258!

Corresponding bug condition look like the following:

  BUG_ON(feature >= (NCAPINTS + NBUGINTS) * 32);

Fix that by converting alternative feature/cpuid to target endianness.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/patch-2.thread-6c9df9.git-6c9df9a8098d.your-ad-here.call-01620841104-ext-2554@work.hours
---
 tools/objtool/arch/x86/decode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cedf3ed..24295d3 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -19,6 +19,7 @@
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
+#include <objtool/endianness.h>
 #include <arch/elf.h>
 
 static int is_x86_64(const struct elf *elf)
@@ -725,7 +726,7 @@ static int elf_add_alternative(struct elf *elf,
 		return -1;
 	}
 
-	alt->cpuid = cpuid;
+	alt->cpuid = bswap_if_needed(cpuid);
 	alt->instrlen = orig_len;
 	alt->replacementlen = repl_len;
 
