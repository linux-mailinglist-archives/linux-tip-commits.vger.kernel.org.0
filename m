Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9837BDFD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhELNVA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhELNU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4591C06175F;
        Wed, 12 May 2021 06:19:50 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8F/e2Ae19Kft+w86bW7OPlklULDEOMaT9PUg7yPD2w=;
        b=EJSAgd0i5alrREgNxYCPxCXXq2uhfzQK4llIKKg3QU5v11sHvEWo5gzOZ/BrwGOaZYG9lS
        y8VqEcIn9LTxdu2LygAgoQJvt6V4AQcLlKYTI6KX8cciCdRfgmusu9ACxaga/baYxBjg2W
        3PLUYrFUIPo9y61lzOD4SKqqGTuK54jHpvptf67xOZfk8+gVFgwWDUR0atb9xvuzH5e4M/
        lrtl/UKmghv1nTgpYDcuLtJ3wcnIBDZVGCS9yMYq//Xi3NMHlu5bG5qwpsNi/aiTqWYHJY
        UmxHjvvRNGFGu7qSLprMYJKwyrOUgfvuylFFeXy+oBOXBtpqPt1YNSG85B/Nvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8F/e2Ae19Kft+w86bW7OPlklULDEOMaT9PUg7yPD2w=;
        b=gEZHBcpMbZZeDh/DKQcB8NPDGktKGgoLdtaAxKxQT/RdELO8DQxo/5i3PJAUWpbh7Xekti
        0Rkkq57GebN9oaBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Decode jump_entry::key addend
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194158.028024143@infradead.org>
References: <20210506194158.028024143@infradead.org>
MIME-Version: 1.0
Message-ID: <162082558867.29796.17810756155208472815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     cbf82a3dc241aea82b941a872ed5c52f6af527ea
Gitweb:        https://git.kernel.org/tip/cbf82a3dc241aea82b941a872ed5c52f6af527ea
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:34:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

objtool: Decode jump_entry::key addend

Teach objtool about the the low bits in the struct static_key pointer.

That is, the low two bits of @key in:

  struct jump_entry {
	s32 code;
	s32 target;
	long key;
  }

as found in the __jump_table section. Since @key has a relocation to
the variable (to be resolved by the linker), the low two bits will be
reflected in the relocation's addend.

As such, find the reloc and store the addend, such that we can access
these bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194158.028024143@infradead.org
---
 tools/objtool/arch/x86/include/arch/special.h |  1 +
 tools/objtool/include/objtool/special.h       |  1 +
 tools/objtool/special.c                       | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/tools/objtool/arch/x86/include/arch/special.h b/tools/objtool/arch/x86/include/arch/special.h
index 14271cc..f2918f7 100644
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -9,6 +9,7 @@
 #define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
 #define JUMP_NEW_OFFSET		4
+#define JUMP_KEY_OFFSET		8
 
 #define ALT_ENTRY_SIZE		12
 #define ALT_ORIG_OFFSET		0
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 8a09f4e..dc4721e 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -27,6 +27,7 @@ struct special_alt {
 	unsigned long new_off;
 
 	unsigned int orig_len, new_len; /* group only */
+	u8 key_addend;
 };
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 07b21cf..bc925cf 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -23,6 +23,7 @@ struct special_entry {
 	unsigned char size, orig, new;
 	unsigned char orig_len, new_len; /* group only */
 	unsigned char feature; /* ALTERNATIVE macro CPU feature */
+	unsigned char key; /* jump_label key */
 };
 
 struct special_entry entries[] = {
@@ -42,6 +43,7 @@ struct special_entry entries[] = {
 		.size = JUMP_ENTRY_SIZE,
 		.orig = JUMP_ORIG_OFFSET,
 		.new = JUMP_NEW_OFFSET,
+		.key = JUMP_KEY_OFFSET,
 	},
 	{
 		.sec = "__ex_table",
@@ -122,6 +124,18 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			alt->new_off -= 0x7ffffff0;
 	}
 
+	if (entry->key) {
+		struct reloc *key_reloc;
+
+		key_reloc = find_reloc_by_dest(elf, sec, offset + entry->key);
+		if (!key_reloc) {
+			WARN_FUNC("can't find key reloc",
+				  sec, offset + entry->key);
+			return -1;
+		}
+		alt->key_addend = key_reloc->addend;
+	}
+
 	return 0;
 }
 
