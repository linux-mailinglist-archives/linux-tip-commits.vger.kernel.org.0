Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713C232F9B1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhCFLZb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhCFLZF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:25:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB53C06175F;
        Sat,  6 Mar 2021 03:25:04 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:25:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615029903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYVzgnpFzQqJ6+1Q/++zctsfN6V/MytOndqgpQX6xns=;
        b=dllNtQACJcQCClmujtXHHoQxH3yzzfwnW/I+SI7DkI3/YCpwtN5eswWJPKu5lScJyArbA2
        Popty6JqFDgTo0ZYM9E9pWvYhpwt9s5z630nqAFF2Jv9oApQhvxtyT6Jdg5vZ4s21OAvqj
        a3ATuHVM+1tcZRQ6qyO42DWxaxBFJEwZWFY1O1muzy38X3AQd0q7l4BnS41rGmBfR1iWcP
        MpjuFZVHtVQ5Wl+mItg4kOJAU3lTi5aDKa2ckdhMZ07h+piBpxhDewSKxBqg9JZx40bwTA
        bNfZu15LAvtde2Cc20edy6gSjLD8NME+GmriW0W6KZbyHyUmTHBYv/+h07ZT/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615029903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HYVzgnpFzQqJ6+1Q/++zctsfN6V/MytOndqgpQX6xns=;
        b=WNQzp6nvenHT1p3fmjIgRG1rpLR0AQfEphCpSUGVX8BqJGyvFBMqpztCtNIzQN6X4ij00+
        XOc8eS7XBV4pVDDg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Remove subtraction of res variable
Cc:     Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210223111130.16201-1-bp@alien8.de>
References: <20210223111130.16201-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161502990248.398.6445049374742993400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     f3db3365c069c2a8505cdee8033fe3d22d2fe6c0
Gitweb:        https://git.kernel.org/tip/f3db3365c069c2a8505cdee8033fe3d22d2fe6c0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 23 Feb 2021 12:03:19 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Mar 2021 12:08:53 +01:00

x86/sev-es: Remove subtraction of res variable

vc_decode_insn() calls copy_from_kernel_nofault() by way of
vc_fetch_insn_kernel() to fetch 15 bytes max of opcodes to decode.

copy_from_kernel_nofault() returns negative on error and 0 on success.
The error case is handled by returning ES_EXCEPTION.

In the success case, the ret variable which contains the return value is
0 so there's no need to subtract it from MAX_INSN_SIZE when initializing
the insn buffer for further decoding. Remove it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20210223111130.16201-1-bp@alien8.de
---
 arch/x86/kernel/sev-es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 84c1821..1e78f4b 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -267,7 +267,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
 		insn_get_length(&ctxt->insn);
 	}
 
