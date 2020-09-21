Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34A272EAF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Sep 2020 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgIUQvY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Sep 2020 12:51:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbgIUQvQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Sep 2020 12:51:16 -0400
Date:   Mon, 21 Sep 2020 16:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600707074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Sgm2yn0v6HlarYRAA1wq4cFuSB25RZdNG4aFpDVvtug=;
        b=3uqz6yd7s5xG/+rT4dK48m/86EJxwQ77Y2KWTDDvu0OTWuZrWWuOcNLxUz6Qtrqh51QFb1
        h8S6092t6ucpxU/YZ+H8p7pOLPXGsJjNux4flC8qozy2D6LiB2G8XIiN6uf1exVP4RvSC3
        /LA8GLqvX7UdpcKgvvRWJtsaprWR3q0r9FKqL5KWiSaaEVZvI9hzJ8sqzXNdlf18r0sH4s
        pY9jGFNSFpUADO66uaMAp58l6YdOjC4tLMC8hgrSqE54AiaLjM8d6I2fQ1O6pJTQcccdzT
        sbw06qigHv7/IeT107ph9RpnjCH5ojN07l+YTK3PRdAMyIdPnZcJ6dLjukq6DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600707074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Sgm2yn0v6HlarYRAA1wq4cFuSB25RZdNG4aFpDVvtug=;
        b=W7kDNY0lVaPpxwZehNCXzTOnaxPl7ljoYXZ0CZZWoSQpk/UBp8BIBRDjFCHSVLz0u3IPMD
        SxZoJ2+I5bUZZ7BA==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove useless tests before save_reg()
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160070707332.15536.770642380870729185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f4f803984c3685f416a74e9e2fa7d39bdafbe02b
Gitweb:        https://git.kernel.org/tip/f4f803984c3685f416a74e9e2fa7d39bdafbe02b
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 15 Sep 2020 08:53:16 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Fri, 18 Sep 2020 12:02:27 -05:00

objtool: Remove useless tests before save_reg()

save_reg already checks that the register being saved does not already
have a saved state.

Remove redundant checks before processing a register storing operation.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4e2f703..fd2edab 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2030,7 +2030,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				/* drap: push %rbp */
 				cfi->stack_size = 0;
 
-			} else if (regs[op->src.reg].base == CFI_UNDEFINED) {
+			} else {
 
 				/* drap: push %reg */
 				save_reg(cfi, op->src.reg, CFI_BP, -cfi->stack_size);
@@ -2059,9 +2059,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 
 				/* save drap offset so we know when to restore it */
 				cfi->drap_offset = op->dest.offset;
-			}
-
-			else if (regs[op->src.reg].base == CFI_UNDEFINED) {
+			} else {
 
 				/* drap: mov reg, disp(%rbp) */
 				save_reg(cfi, op->src.reg, CFI_BP, op->dest.offset);
