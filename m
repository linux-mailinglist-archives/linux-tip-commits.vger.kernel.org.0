Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32073803EA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 May 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhENHDC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 May 2021 03:03:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhENHDB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 May 2021 03:03:01 -0400
Date:   Fri, 14 May 2021 07:01:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620975710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyHA5M2dOCVDg3m/djRxK/HYGZdawJDrs810bmzLJ0g=;
        b=UTED7Q4w49m7sqXpF8B6xLOGWMBLSXWyPHSkFbQURJmATV5s6IDQLJ7kN61m8vu99Rz7Kh
        UqnrXXa7hJpaStTxgbp/JEPBzw7KwfmBP7wGxEcYWMikOAJVAIkFqVxInY/ceg9yRj8D6+
        TEa0Y6pQaN3GuS4UWVYPvPW18805ivCOn/dzn1sftUBRZ2OKS8Xu/gChS68BUxEwuKY19s
        c08nDb1lGcwrMYzyZewu3NE+uqed+GEg5+eAKiEjnwEXil+4OaByHjsSO9rbRt3eTPW0w2
        ehHhAtu4/TpuFWAjzjPpgjPNgW+EPn43Os/QflAYGuZO1gLjqyWgOSRCQRpJbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620975710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyHA5M2dOCVDg3m/djRxK/HYGZdawJDrs810bmzLJ0g=;
        b=yxyKu4A2KNBvWCLMbUmMcAsiQrHj3KvfIhvD8Pxq6Yj9xYbHLhN8BOeJc6gDns/TAwIXZz
        0+2J4LeG51uZDtCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label/x86: Remove unused JUMP_LABEL_NOP_SIZE
Cc:     Miroslav Benes <mbenes@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YJ00zxsvocDV5vLU@hirez.programming.kicks-ass.net>
References: <YJ00zxsvocDV5vLU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162097570937.29796.12372580213594221006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d46f61b20b060f03b58fde170ee618f17dc6f99d
Gitweb:        https://git.kernel.org/tip/d46f61b20b060f03b58fde170ee618f17dc6f99d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 May 2021 16:16:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 May 2021 09:00:09 +02:00

jump_label/x86: Remove unused JUMP_LABEL_NOP_SIZE

JUMP_LABEL_NOP_SIZE is now unused, remove it.

Fixes: 001951bea748 ("jump_label, x86: Add variable length patching support")
Reported-by: Miroslav Benes <mbenes@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YJ00zxsvocDV5vLU@hirez.programming.kicks-ass.net
---
 arch/x86/kernel/jump_label.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index a762dc1..674906f 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -17,8 +17,6 @@
 #include <asm/text-patching.h>
 #include <asm/insn.h>
 
-#define JUMP_LABEL_NOP_SIZE	JMP32_INSN_SIZE
-
 int arch_jump_entry_size(struct jump_entry *entry)
 {
 	struct insn insn = {};
