Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E586272EAD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Sep 2020 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgIUQvQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Sep 2020 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgIUQvP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Sep 2020 12:51:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADF2C0613CF;
        Mon, 21 Sep 2020 09:51:14 -0700 (PDT)
Date:   Mon, 21 Sep 2020 16:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600707073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=05RoIvew5IZ3tq402GZk0c6mzbvf7FYiy/ZYM6fPPjM=;
        b=iCRWrKvOMMqFtR22g0u7ke2TurwE00JJedL2n1zpdKF+ZVtnYVRmNd0BRsnxoYm7yJj7Ue
        QF7201ffg5rpPuFpj8LzgNPSRaA1pj3rJAF7MHQ5qbdOyP45JQTAHIKy5/XV2H6Pi3g89V
        ORi2PkJSH3sTcje7FfnnHYkNsgieeDdHpnlIwrL8S27448cwBLVCAxrRXoiFfRoXUWwzMQ
        Nk6kerh6WWJCSoKF4ouSWx3wUI0ErguV3q2U+eD1jATQaFBzRbTVN7FBz4O79p+Q+GWsJ3
        cBVRf9YyAdmEiPVB4ObLrDWfLA6qVYxDuKO1AIkyBsmKxgZKZXcw1fIRx/MjcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600707073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=05RoIvew5IZ3tq402GZk0c6mzbvf7FYiy/ZYM6fPPjM=;
        b=0Xp82xGFEJJzeqoYDqH3tYfFTfN8pcxDg6G9VilJ8wpz3RWzz4J//gCdcHhS6Sbv4eFj3+
        neyeZwTxkDjCogDg==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Ignore unreachable fake jumps
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160070707261.15536.11614995814851736978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fb136219f0e2b417d84e67b2a3adc1f933997d04
Gitweb:        https://git.kernel.org/tip/fb136219f0e2b417d84e67b2a3adc1f933997d04
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 15 Sep 2020 08:53:17 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Fri, 18 Sep 2020 12:04:00 -05:00

objtool: Ignore unreachable fake jumps

It is possible for alternative code to unconditionally jump out of the
alternative region. In such a case, if a fake jump is added at the end
of the alternative instructions, the fake jump will never be reached.
Since the fake jump is just a mean to make sure code validation does not
go beyond the set of alternatives, reaching it is not a requirement.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fd2edab..cd7c669 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2648,6 +2648,9 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
+	if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->offset == FAKE_JUMP_OFFSET)
+		return true;
+
 	if (!insn->func)
 		return false;
 
