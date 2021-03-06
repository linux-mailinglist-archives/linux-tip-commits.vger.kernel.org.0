Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F4632FA9F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhCFMTO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:19:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhCFMSz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:18:55 -0500
Date:   Sat, 06 Mar 2021 12:18:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615033133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPwGF9GluJChKp2hs/hvWVBHjDwzvWx8N4NtTtqx68c=;
        b=jN6rHOyzzZnw6ULdwMT4eiRBP9vpOmjacdzE/BrHvBLKYHMOi/f68/OTqfVNYopJlzV1i9
        xIF6nWzspYdN6hTIiR+gY4YyF18duqeono0UZoJ9i6a4tboT3E8MIqK+0sSPlBcroFSVYf
        rb+ME9hJxc7dKODkSfNZhoeC67e5tO4F5IvdVGbsGE/bVSywGV48uKDVWAktA2BpXGIeVB
        mFMJYDuiPK5XILk65z5R5b8GABqoozxfYclQjZ+CshLqjP+U6Ou0wjKclCbHuubYwnLVoo
        q5bx50a2FDpy73Ye/HtU38GSeZmbiemTJ/9SepSplidnGSeNt5G4bntmth6G1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615033133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPwGF9GluJChKp2hs/hvWVBHjDwzvWx8N4NtTtqx68c=;
        b=9kCu0GTJqEb52Z8zSziMl2yNWb0gNWHR0BFcN7BMcIc4s0lNnh/7rLPt7Gweax5cITQaKQ
        B2CmgzevAemlpYAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Silence warnings caused by missing ORC data
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Ivan Babrou <ivan@cloudflare.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
References: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161503313330.398.3537176169423600436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b59cc97674c947861783ca92b9a6e7d043adba96
Gitweb:        https://git.kernel.org/tip/b59cc97674c947861783ca92b9a6e7d043adba96
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 05 Feb 2021 08:24:03 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Mar 2021 13:09:45 +01:00

x86/unwind/orc: Silence warnings caused by missing ORC data

The ORC unwinder attempts to fall back to frame pointers when ORC data
is missing for a given instruction.  It sets state->error, but then
tries to keep going as a best-effort type of thing.  That may result in
further warnings if the unwinder gets lost.

Until we have some way to register generated code with the unwinder,
missing ORC will be expected, and occasionally going off the rails will
also be expected.  So don't warn about it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Ivan Babrou <ivan@cloudflare.com>
Link: https://lkml.kernel.org/r/06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 1bcc14c..a120253 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -13,7 +13,7 @@
 
 #define orc_warn_current(args...)					\
 ({									\
-	if (state->task == current)					\
+	if (state->task == current && !state->error)			\
 		orc_warn(args);						\
 })
 
