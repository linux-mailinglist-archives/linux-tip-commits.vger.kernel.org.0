Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57F32CED3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 09:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhCDIwp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 03:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbhCDIwU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 03:52:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C970C061574;
        Thu,  4 Mar 2021 00:51:40 -0800 (PST)
Date:   Thu, 04 Mar 2021 08:51:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614847896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpY9xrjaVQfgAvdH5+f0wRgCrdGcIsGgKyjkDkEdEBA=;
        b=lJMQXLD2SlxgcawdKsKfqCRfpobCaBn7DvLfMpQtW1mWE1HtEqiL5v/VzENk6pxKc8byzF
        7+CMfyWm1pY4lQ9jSmgcY9pRRiabooP7ax36aAhbA9r5k0oJ38U+gd5HhXewDI1OFOAxGi
        3sY1qYE1C1T3Eqx3I3aGlJij0Wvq3EIacZFliWZp1eT03Z+dr6IGhMTiicrZZ14gMEuhXN
        13FGo8P1X975GxtIy80OP8Bpx9vqggwqXpHY5ee6N1X/gNjIhGBwpbz04EU+wIEDbqFJkI
        Ov4xs9iKITBl/CQW7U9zGMoHd3iRWti7WLoqVCeHagEV3njkVIULVTXIUiwGmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614847896;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZpY9xrjaVQfgAvdH5+f0wRgCrdGcIsGgKyjkDkEdEBA=;
        b=1u0iuChaDTPke2h95/Gdqa682hVfewhqwoyRtZKUzSbxNx3dZXiG3VMavq5AW/UDbYFVv/
        Tx8eNbwkFnmyK/Dw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Silence warnings caused by missing ORC data
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ivan Babrou <ivan@cloudflare.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
References: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161484789468.398.5338977176281362987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     86402dcc894951c0a363b6aee12d955ff923b35e
Gitweb:        https://git.kernel.org/tip/86402dcc894951c0a363b6aee12d955ff923b35e
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 05 Feb 2021 08:24:03 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 16:56:30 +01:00

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
 
