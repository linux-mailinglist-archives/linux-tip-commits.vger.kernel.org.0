Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346EA33C066
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhCOPs1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B562C0613DB;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeddighmRUTuHyh41CoEbOoaahpE2nFQrVbGfXQM7oE=;
        b=4m8Ab0AX+nrH+jaygUMz5dd8P+bwfBMTvKKeH1KSwMpc9y5RyE/3HXB2feiRxDGIrHcq4I
        /2se25XP0g4UcCuzWU8hRAxEAG8J6sETtSHWWzYbUaEDBGNy1vKOWRnHXW+7aYwmez4akZ
        lA9YWWT16rrvJoNc+UJzAnNW8u2Z9Wdku3yEtw9iZu7dsgcLHA0s5RyF6iejXERw549Gox
        I5FkI72FY1EMUfUoPpyJFCOO4jgAWgl4HZFUaxCT+0pA9mcFn6j6JFacnN5rJEaG0PXb9u
        zjzzwEomwKrE9I16aJ2NZJeFgwcvf2Juz08izGYynHBX1moydtmV+JE8Z//uLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeddighmRUTuHyh41CoEbOoaahpE2nFQrVbGfXQM7oE=;
        b=XdUdyKzVE7wGmENFuV2nt30Z6jwtkP0GWaxfF5US/xH9/wdP6THYOlmLGOihG/h94x5HbJ
        dlLnmdGQKcGfltAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Use insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-10-bp@alien8.de>
References: <20210304174237.31945-10-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326756.398.4176877360621612828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     63c66cde7bbcc79aac14b25861c5b2495eede57b
Gitweb:        https://git.kernel.org/tip/63c66cde7bbcc79aac14b25861c5b2495eede57b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 06 Nov 2020 19:37:25 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:25:38 +01:00

x86/alternative: Use insn_decode()

No functional changes, just simplification.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-10-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8d778e4..ce28c5c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1274,15 +1274,15 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
+	int ret;
 
 	memcpy((void *)tp->text, opcode, len);
 	if (!emulate)
 		emulate = opcode;
 
-	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
-	insn_get_length(&insn);
+	ret = insn_decode(&insn, emulate, MAX_INSN_SIZE, INSN_MODE_KERN);
 
-	BUG_ON(!insn_complete(&insn));
+	BUG_ON(ret < 0);
 	BUG_ON(len != insn.length);
 
 	tp->rel_addr = addr - (void *)_stext;
