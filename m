Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045042F3DD3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438065AbhALVhU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436708AbhALUMy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:12:54 -0500
Date:   Tue, 12 Jan 2021 20:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2KycOH4b25upkNBmvOPPRiitpDpibgah3ceE5B4ktQ=;
        b=TkWsgycIiwsozg+MdXDlRHQHsgYHOlYAZGu1Pia4t4hqzsQ4ZKivXjV/rrz+aoTwcHpCLa
        eze7Nme/X4j/8TliAWh2zP8vFyDaNFrFIPSPERZBiaz+EhbYEP6OJeqWfUCKDV5KD5jSkE
        J9qFtbcZ0813qyoWBmjPSYntxlxZmVPXJE4ZFJfUlI+IR2IaNVjPMCzkGvprOMjurSyrUc
        qt1fP4eH119lmNXJTbKCbMresDqtdaKUTE/flzp4XGPsUlPiS3d/fhEjt6efKv6tucEgsw
        LH6o5EkjoxrBff1JtjiguRnVpq/hf6JyxQTBwp3hZczYAtG2Xf1SIxqq9vVTCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2KycOH4b25upkNBmvOPPRiitpDpibgah3ceE5B4ktQ=;
        b=uSOOP57aN7jcDSAQ+e1zKW/Bhiz7MdV5TvJHdjNLhd9QZJFWjRRLJHSpl3f8YlocwLbIdz
        p95wzkhNB3XCHACQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] locking/lockdep: Cure noinstr fail
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210106144017.592595176@infradead.org>
References: <20210106144017.592595176@infradead.org>
MIME-Version: 1.0
Message-ID: <161048233036.414.5326778516685333440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0afda3a888dccf12557b41ef42eee942327d122b
Gitweb:        https://git.kernel.org/tip/0afda3a888dccf12557b41ef42eee942327d122b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 06 Jan 2021 15:36:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:10:59 +01:00

locking/lockdep: Cure noinstr fail

When the compiler doesn't feel like inlining, it causes a noinstr
fail:

  vmlinux.o: warning: objtool: lock_is_held_type()+0xb: call to lockdep_enabled() leaves .noinstr.text section

Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210106144017.592595176@infradead.org

---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c1418b4..02bc5b8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -79,7 +79,7 @@ module_param(lock_stat, int, 0644);
 DEFINE_PER_CPU(unsigned int, lockdep_recursion);
 EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
 
-static inline bool lockdep_enabled(void)
+static __always_inline bool lockdep_enabled(void)
 {
 	if (!debug_locks)
 		return false;
