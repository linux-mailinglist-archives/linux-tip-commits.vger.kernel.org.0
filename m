Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0133C063
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhCOPs1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF58C0613D7;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTNs53tDw5b1ljYJ7Z/v3Quw82S7pfeOcoWM2vZPcbs=;
        b=r8HYBMuRGFvT3dRibNh97jzU3JNLgf10QxFXnzRWams1hrzHQQTtKQ7g7HAQfcBIE//Z4S
        noPTY5nN+aCqCjjCh93b/4m4JAP7dgqmLR/CEC/wJGZPNM8U+bkQbmzZv8+6dBonXAY9cU
        clUYnL6nD34g2SgHIVvIqm7/narP9V5i2UZLZo5J2MkArs9P3SZHW5dFfRuuQnChaJE/ew
        mBPvZ2lXPwND+JWXLtpa0pueYePrZ3McxJ4MNLnv3sP0uh7XdiWmKti+sEANT1hDhz2w3s
        GncW8e7MOIQXJ9jv9l7+krXowRrwUTiaTzWJFppCQog5XSOKkx3UJ/RqCF3deQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rTNs53tDw5b1ljYJ7Z/v3Quw82S7pfeOcoWM2vZPcbs=;
        b=hb8kjg8mU5qY5qKnvlIeCvpkMOIcCKVXnTIuin8ybh47VXKuE6UUjAS1uBgkAPfsSYgnUq
        cQmrVcWrFKuaKICg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/uprobes: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-16-bp@alien8.de>
References: <20210304174237.31945-16-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326565.398.12323407900667724874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     88afc23922137cd3efdb0f0b6722785c9f6a35eb
Gitweb:        https://git.kernel.org/tip/88afc23922137cd3efdb0f0b6722785c9f6a35eb
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 17 Nov 2020 15:26:12 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:05:03 +01:00

x86/uprobes: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-16-bp@alien8.de
---
 arch/x86/kernel/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index a2b4133..b63cf8f 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -276,12 +276,12 @@ static bool is_prefix_bad(struct insn *insn)
 
 static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
 {
+	enum insn_mode m = x86_64 ? INSN_MODE_64 : INSN_MODE_32;
 	u32 volatile *good_insns;
+	int ret;
 
-	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
-	/* has the side-effect of processing the entire instruction */
-	insn_get_length(insn);
-	if (!insn_complete(insn))
+	ret = insn_decode(insn, auprobe->insn, sizeof(auprobe->insn), m);
+	if (ret < 0)
 		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
