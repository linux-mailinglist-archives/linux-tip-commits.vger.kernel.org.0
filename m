Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAA37BE04
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhELNVC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhELNVB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:21:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF3C061574;
        Wed, 12 May 2021 06:19:52 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkZN07inHB1xbqHtuDq0apL5bq2Jakwc9TFeWwuzvn4=;
        b=M/ea9vIb2C9tZu23vYt0gAq1nq29bSVqM4OfA8ib7IgwL4weIYUJljiygyl/dXLttOucqq
        JKdJl8UXQoXz286b9NsQQzQ7tnB/9Bh+q6Anbtwrb/6Rtl9duOaolhi8xok2ih/T9J2A3j
        OziEcSdH2+yd0tSZpQjuzHj/WkO2kisTwhIAeoLRg5Bgfm57FxTn3s2pVCGiCeZiMxf5mY
        P5K2IR8pTf3EOmtwIapAIf5JXUE42E11/cnEFzRvyFU7PMun5ivgKELz06Ddpsf0SEFGN2
        fEKOQCNioZi4d5msSlkfuTRdKfqeD9B4QHZcDjAoA7c160tlsrlAgUVYXFbNhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkZN07inHB1xbqHtuDq0apL5bq2Jakwc9TFeWwuzvn4=;
        b=1AKNRBs5BvfIyCyDHfvvzmVRJfqQVAJcW96l3QI0iY45gazRoB2hmnKzscJi7HaEnNabOL
        ZK/EM44EBV7IPDCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label, x86: Introduce jump_entry_size()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.786777050@infradead.org>
References: <20210506194157.786777050@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559074.29796.17634250861071580910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fa5e5dc39669b4427830c546ede8709323b8276c
Gitweb:        https://git.kernel.org/tip/fa5e5dc39669b4427830c546ede8709323b8276c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label, x86: Introduce jump_entry_size()

This allows architectures to have variable sized jumps.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.786777050@infradead.org
---
 arch/x86/include/asm/jump_label.h |  4 ++--
 arch/x86/kernel/jump_label.c      |  7 +++++++
 include/linux/jump_label.h        |  9 +++++++++
 kernel/jump_label.c               |  2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index dfdc2b1..d85802a 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,8 +4,6 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
-#define JUMP_LABEL_NOP_SIZE 5
-
 #include <asm/asm.h>
 #include <asm/nops.h>
 
@@ -47,6 +45,8 @@ l_yes:
 	return true;
 }
 
+extern int arch_jump_entry_size(struct jump_entry *entry);
+
 #endif	/* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index 638d3b9..a29eecc 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,6 +16,13 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
+#define JUMP_LABEL_NOP_SIZE	JMP32_INSN_SIZE
+
+int arch_jump_entry_size(struct jump_entry *entry)
+{
+	return JMP32_INSN_SIZE;
+}
+
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
 {
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 05f5554..8c45f58 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -176,6 +176,15 @@ static inline void jump_entry_set_init(struct jump_entry *entry)
 	entry->key |= 2;
 }
 
+static inline int jump_entry_size(struct jump_entry *entry)
+{
+#ifdef JUMP_LABEL_NOP_SIZE
+	return JUMP_LABEL_NOP_SIZE;
+#else
+	return arch_jump_entry_size(entry);
+#endif
+}
+
 #endif
 #endif
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index ba39fbb..521cafc 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit);
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
 	if (jump_entry_code(entry) <= (unsigned long)end &&
-	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	    jump_entry_code(entry) + jump_entry_size(entry) > (unsigned long)start)
 		return 1;
 
 	return 0;
