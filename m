Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9613A4D24
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Jun 2021 08:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFLGou (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Jun 2021 02:44:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44488 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhFLGot (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Jun 2021 02:44:49 -0400
Date:   Sat, 12 Jun 2021 06:42:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623480168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M5FTDgxLgRN4/SO+xik4v7C/W7vGt/0TqRg6a0Ipeuk=;
        b=HNLt+kLZZuMH1FAx2qLPrLZhl1M3HWG4ZAnQeevrpICyFBDpvUjWhA61CBqeDpwW2Y2PKe
        C2O8tpQeTqGtHojoPLd5chUaVgu3LC8jTWIicDsbi5TTVj6tnqERH0dOqN8hmE7cA/abkf
        kLt3db7qdIJaZOgvwgXp/jyWY/6OjGGgdJZMs94NhbqBBOCaS688Jm0ZyKWJcVf2+auCV4
        ObJEu5cTHxqEXQJ2EPQSnslrp/tnamj1Fb2QJTv231/7lUR+9Qzj+fhyJuSTYuhHvewjxl
        wfZjAWdeCEavJ3kSjTumlHpGv7DIcLchnCbzxx11n+zsn7nEwtNbvBmqwPo85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623480168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M5FTDgxLgRN4/SO+xik4v7C/W7vGt/0TqRg6a0Ipeuk=;
        b=StlCiDWqACoMuvGrzzJ8F1uxFslAekicNFQiRiYcV61ZEnTWImalqcIhqbYof3Pl9O0KWN
        L403b8k6goOHDJDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Only rewrite unconditional retpoline
 thunk calls
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162348016780.19906.11444381943657157954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2d49b721dc18c113d5221f4cf5a6104eb66cb7f2
Gitweb:        https://git.kernel.org/tip/2d49b721dc18c113d5221f4cf5a6104eb66cb7f2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Jun 2021 09:04:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jun 2021 08:53:06 +02:00

objtool: Only rewrite unconditional retpoline thunk calls

It turns out that the compilers generate conditional branches to the
retpoline thunks like:

  5d5:   0f 85 00 00 00 00       jne    5db <cpuidle_reflect+0x22>
	5d7: R_X86_64_PLT32     __x86_indirect_thunk_r11-0x4

while the rewrite can only handle JMP/CALL to the thunks. The result
is the alternative wrecking the code. Make sure to skip writing the
alternatives for conditional branches.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Reported-by: Lukasz Majczak <lma@semihalf.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/objtool/arch/x86/decode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 24295d3..523aa41 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -747,6 +747,10 @@ int arch_rewrite_retpolines(struct objtool_file *file)
 
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 
+		if (insn->type != INSN_JUMP_DYNAMIC &&
+		    insn->type != INSN_CALL_DYNAMIC)
+			continue;
+
 		if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
 			continue;
 
