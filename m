Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83840C8C2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhIOPu6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbhIOPus (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:48 -0400
Date:   Wed, 15 Sep 2021 15:49:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ev+7miNV+iOh6coeAk+OApPTcKBsKfOzMxh0tz3M8aw=;
        b=YmsQJQMeDIyTUOpeYSTKGwE51KPNE+nvUqs4vHBSKZyeKW6fZluiI5Fzc7Ts6VdAcaFt78
        bGxxzieC9DsDFC25swFPJMc493S6BT5moBR8/Y8AimDb8grygzfrgg0rlPgBXr+HZ9VB8v
        E4825ijK+TcGa2GDl7ci2eBR77wuOXMC3nvdXktzHA7ZosvxYeuA5btOpBxbCKG9bibBjX
        f2MCEVVd+aP6bKO0gW3mj413+CNHmce86OwhdABAM1KeqXCPujb2b17Tf7iaC8rpY6Vtvf
        cJIp4zbJ6466gAGIBNeWkRPvyFrqpa///s6VUsvWehqLBkGh/iNqYOjCm5uEUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ev+7miNV+iOh6coeAk+OApPTcKBsKfOzMxh0tz3M8aw=;
        b=0ciEpVIKKD6ZOKKIHUCL2okHv3LE8wigVM6hSeAd+SqpcryjmdxA4LGjL0MixHZyyWQteq
        0grur/7NOCDQCNDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/sev: Fix noinstr for vc_ghcb_invalidate()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.250770465@infradead.org>
References: <20210624095148.250770465@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096751.25758.13845936789207554110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2c36d87be49355931da5b29ef7621505e0e46ce9
Gitweb:        https://git.kernel.org/tip/2c36d87be49355931da5b29ef7621505e0e46ce9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:47 +02:00

x86/sev: Fix noinstr for vc_ghcb_invalidate()

vmlinux.o: warning: objtool: __sev_put_ghcb()+0x88: call to __memset() leaves .noinstr.text section
vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x39: call to __memset() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095148.250770465@infradead.org
---
 arch/x86/kernel/sev-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 9f90f46..34f20e0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -64,7 +64,7 @@ static bool sev_es_negotiate_protocol(void)
 static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	ghcb->save.sw_exit_code = 0;
-	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
+	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
 static bool vc_decoding_needed(unsigned long exit_code)
