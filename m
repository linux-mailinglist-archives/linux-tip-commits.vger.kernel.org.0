Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5264635338D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDCLLA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbhDCLK7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:10:59 -0400
Date:   Sat, 03 Apr 2021 11:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R85q1NrxXsM6pMwt2sBprgDz/w5BEcS7qFLBJ50Ushk=;
        b=sIF1cXID7VCgWyxqz2RszDA1pa/ca72CvQLQr/aLJ5+bQmne2Gi0rJJ/9PKDLey/E1x67c
        BOdXIEmZsp4G3wvNjvUCRZY0SG3I7+b/3EHKP3g2wExEwDULCu/YlJEalnoP6FSFj6n//0
        MLPnfdpD1n+RAcvaIdHD+QXDu9rrkZIOV/UUQddVEZE1w5ceAzoHXmfmIJR3W2T5/TWw3N
        KC8auS6XXbDrOIj8wPWAL4zgpTLC7g7uGbLHw/imwfQOX7ezPVJNgE+f1k9gxi8lf6a2La
        zvkFsg3nfj4Y6qN0B5VCuxTqq4xR0EXTAKi83HUuoJrEvaQ5mKK5zt9IKY2bYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R85q1NrxXsM6pMwt2sBprgDz/w5BEcS7qFLBJ50Ushk=;
        b=93LLvK1xxpofstKqZZYYenTQ/XanSLWxB5NvFzPpKusxS7kJAe8UqLWfOWcwvr+miwt9D5
        ny+D05KvKZ9lLSAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Skip magical retpoline .altinstr_replacement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.259429287@infradead.org>
References: <20210326151300.259429287@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825510.29796.17367842912977456025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     50e7b4a1a1b264fc7df0698f2defb93cadf19a7b
Gitweb:        https://git.kernel.org/tip/50e7b4a1a1b264fc7df0698f2defb93cadf19a7b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:46:57 +02:00

objtool: Skip magical retpoline .altinstr_replacement

When the .altinstr_replacement is a retpoline, skip the alternative.
We already special case retpolines anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151300.259429287@infradead.org
---
 tools/objtool/special.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 2c7fbda..07b21cf 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -106,6 +106,14 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			return -1;
 		}
 
+		/*
+		 * Skip retpoline .altinstr_replacement... we already rewrite the
+		 * instructions for retpolines anyway, see arch_is_retpoline()
+		 * usage in add_{call,jump}_destinations().
+		 */
+		if (arch_is_retpoline(new_reloc->sym))
+			return 1;
+
 		alt->new_sec = new_reloc->sym->sec;
 		alt->new_off = (unsigned int)new_reloc->addend;
 
@@ -154,7 +162,9 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret)
+			if (ret > 0)
+				continue;
+			if (ret < 0)
 				return ret;
 
 			list_add_tail(&alt->list, alts);
