Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F261D2D022F
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Dec 2020 10:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgLFJKS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 6 Dec 2020 04:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgLFJKO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 6 Dec 2020 04:10:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07659C0613D0;
        Sun,  6 Dec 2020 01:09:34 -0800 (PST)
Date:   Sun, 06 Dec 2020 09:09:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607245771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XIcmMDqZP+StD6WMSScIteYahFlEKzsPdt6JyXYW1U=;
        b=U/GIY2TBUYfhca6FnFMzF7a+4GS8iQjwXLHxMFsyfASJ2tfWitBNdz7CFtJ2i1pNocO9/I
        bHvexH6GJuCHryDMv+JPl0iJUXtN9bELvQsQ7Je/7snLWDHW5vkL1LXpo+9cg2wdraR/EW
        /GYP69rCft/pKre3ODQsk17Vx1gr+rySAEDuOoDb2AcW3BImi+v58ZJJeAAXxdgFS65xDy
        CAIBEehQ/Pue8ZaW1GZX5hW8VsRw1ck+X8oI8O5DhWOByfWmZ36XePVELV8SVZdTgCo7RG
        VYoKLZndLFCssNvXKt0JG7yNqX6as6YWrYjC3i6PXcSXiubEhYI64a9gqX9Y/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607245771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XIcmMDqZP+StD6WMSScIteYahFlEKzsPdt6JyXYW1U=;
        b=81pcTWM4u1eK+0sjNZscGEWnbQsOrRX3WoLx/qCxkZIKAVR5+MCsmocsobkZ2VTvfdLRUm
        hHaL71oduOKWpHCw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev-es: Use new for_each_insn_prefix() macro to
 loop over prefixes bytes
Cc:     syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <160697106089.3146288.2052422845039649176.stgit@devnote2>
References: <160697106089.3146288.2052422845039649176.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <160724577024.3364.5782296021920253763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     84da009f06e60cf59d5e861f8e2101d2d3885517
Gitweb:        https://git.kernel.org/tip/84da009f06e60cf59d5e861f8e2101d2d3885517
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 03 Dec 2020 13:51:01 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 06 Dec 2020 10:03:08 +01:00

x86/sev-es: Use new for_each_insn_prefix() macro to loop over prefixes bytes

Since insn.prefixes.nbytes can be bigger than the size of
insn.prefixes.bytes[] when a prefix is repeated, the proper
check must be:

  insn.prefixes.bytes[i] != 0 and i < 4

instead of using insn.prefixes.nbytes. Use the new
for_each_insn_prefix() macro which does it correctly.

Debugged by Kees Cook <keescook@chromium.org>.

 [ bp: Massage commit message. ]

Fixes: 25189d08e516 ("x86/sev-es: Add support for handling IOIO exceptions")
Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/160697106089.3146288.2052422845039649176.stgit@devnote2
---
 arch/x86/boot/compressed/sev-es.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 954cb27..27826c2 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -32,13 +32,12 @@ struct ghcb *boot_ghcb;
  */
 static bool insn_has_rep_prefix(struct insn *insn)
 {
+	insn_byte_t p;
 	int i;
 
 	insn_get_prefixes(insn);
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
-		insn_byte_t p = insn->prefixes.bytes[i];
-
+	for_each_insn_prefix(insn, i, p) {
 		if (p == 0xf2 || p == 0xf3)
 			return true;
 	}
