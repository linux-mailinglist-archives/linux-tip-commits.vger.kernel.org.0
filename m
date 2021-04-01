Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E723518B5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhDARrT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhDARmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA029C00F7E1;
        Thu,  1 Apr 2021 08:09:00 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RawVVOBQnOse9wzSp0veH5ywvvL/w83HATbNVsuOpo0=;
        b=KrvcHn+iFI3OcN/8p3GAdPrfknzCK/OE65PNIFV7mLBYyB1uW2b8/BmuTaLltLwVOLPGTJ
        dZMPDXmnSTOFpQhoG379SM7qpHWiWfKHSWwxoC8m1XqpUcSx2AkeL7TB7qXga7ZoQSht8b
        hyrpYCv3U9k1gepw6nO7Txd9RzvT3I9NQrNqbqxxHdExZt5jAlo1vwkOM/PS+wIjXJbeaD
        2oEDh+RKsVo6WXrqe/R1052suTRHyIDzBpE0stRXGrVVSzBH/ekCNTaQOpmAlh3KHKDx0n
        khqmtDuDHI0tHcWV+4D3QbKxEPw9N9GwTT266mHMr2Eteg4NDpy8N6PL5wpOhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RawVVOBQnOse9wzSp0veH5ywvvL/w83HATbNVsuOpo0=;
        b=SVq0FtbSjmbVNSLJL5NxxjHPNkdCAqA6J9qFm+YaeYcy9NRG8AUogukAtcHf0yFptbJ/Bc
        GD+ecKL0ZHyNwMCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Handle per arch retpoline naming
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.630296706@infradead.org>
References: <20210326151259.630296706@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973776.29796.16947282482844348452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3b652980a250c1ed9e0c361750f029781831cdc3
Gitweb:        https://git.kernel.org/tip/3b652980a250c1ed9e0c361750f029781831cdc3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:04 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 11:36:52 +02:00

objtool: Handle per arch retpoline naming

The __x86_indirect_ naming is obviously not generic. Shorten to allow
matching some additional magic names later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.630296706@infradead.org
---
 tools/objtool/arch/x86/decode.c      |  5 +++++
 tools/objtool/check.c                |  9 +++++++--
 tools/objtool/include/objtool/arch.h |  2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 8380d0b..e5fa3a5 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -645,3 +645,8 @@ int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg)
 
 	return 0;
 }
+
+bool arch_is_retpoline(struct symbol *sym)
+{
+	return !strncmp(sym->name, "__x86_indirect_", 15);
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 519af4b..6fbc001 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -850,6 +850,11 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+__weak bool arch_is_retpoline(struct symbol *sym)
+{
+	return false;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -872,7 +877,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1026,7 +1031,7 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 6ff0685..bb30993 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -86,4 +86,6 @@ const char *arch_nop_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 
+bool arch_is_retpoline(struct symbol *sym);
+
 #endif /* _ARCH_H */
