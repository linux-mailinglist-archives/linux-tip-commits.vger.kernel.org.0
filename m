Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86F35178E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhDARmW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbhDARkH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212FBC00F7E7;
        Thu,  1 Apr 2021 08:09:02 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGp/1emv1CnmJ/jzv0hWe8ELyeBO/Rl0ogdWD3dTOPY=;
        b=vvlWAXzr9eTgs4R9CO8cNFiY5O2vp4xc4ZZzrpvZGqGKzH9eo1l+r006aKPByANT/NsqiK
        pfvS4Gug3KFv1V7TR048V6Z2JeDYXFLPsqfqh7VqDrwLyWrxCCrPXj9gQW7jyblPA7NTPa
        n8Z67OUxQ2jiRgHH1Tay1Q9ngQ8rL+H80KM+jBieDxqLQeGwNDGZpmmr2VfYbkr10/XUWl
        o/wLujgNVUYSEgoEkKz3EFpKNYTM2IDgzssim1tQfgVI4ho6zNlmDe8oR3Y6pOtmtOlwXG
        j2vWZ1VTqOLhnZco3StxpbNEUSiuQWHl3vSeHZdsGE71+b0RW2/vcO57ORoAPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGp/1emv1CnmJ/jzv0hWe8ELyeBO/Rl0ogdWD3dTOPY=;
        b=yotoOKV2rdZQBhc6b/jlLmlTLGHlJaq+CS5yu1u5azIOXvfIqrAxEujc866O4sCz3j7Id3
        j4C/Lbf9JxPStTCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Skip magical retpoline .altinstr_replacement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151300.259429287@infradead.org>
References: <20210326151300.259429287@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973439.29796.6449261903974714354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     68a59124f4c6363de619fea63231a97dd220a12c
Gitweb:        https://git.kernel.org/tip/68a59124f4c6363de619fea63231a97dd220a12c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:14 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 13:29:40 +02:00

objtool: Skip magical retpoline .altinstr_replacement

When the .altinstr_replacement is a retpoline, skip the alternative.
We already special case retpolines anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
