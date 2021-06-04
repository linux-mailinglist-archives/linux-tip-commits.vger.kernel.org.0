Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7A39B9D5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jun 2021 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDN2r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Jun 2021 09:28:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhFDN2r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Jun 2021 09:28:47 -0400
Date:   Fri, 04 Jun 2021 13:26:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622813219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX+bv7+K1Y9RKFj9gTVoQdQoRokKSs6FqRljwLTs9Mk=;
        b=3hZ0oAC7kf7+hjizU/Cj+R3aRmO8TV6ankVZSW7gs6ppkBVGizR1u2HReEkRpBuDsYktSb
        ul0aRyInbRF074mGvKTNNm7/ai+/xphMGFiN1w6PO8yF1F/OGMtKyA6qwJ00pthPNDwQ80
        lC6ei5vourAcR1WKyvrSXXkt+N25MhW1LfunuQRvQQc6vVRs3FUwKfh9Il8YPmXf2fj0ge
        D1SqwDW0TsKG196H0SvATQBHrxyTfZ5BFAmRlpatfYxX7u3q3VLPoZXBP4G9l9vPNCEhid
        D/FM3fCZfjBKppvlySqnKDwxCudJC48MYTWtCDtP1FaNFIeLvKKJJdgRa/hJjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622813219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lX+bv7+K1Y9RKFj9gTVoQdQoRokKSs6FqRljwLTs9Mk=;
        b=SrOXbBfF54ZTb0/Idq5aQ9WLYeMSvI2JjvU00CigDtrE+EYYK09s8J4Le3bwmMltdHSpar
        ed2tHoRr//+fpIDw==
From:   "tip-bot2 for Jiashuo Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fault: Don't send SIGSEGV twice on SEGV_PKUERR
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jiashuo Liang <liangjs@pku.edu.cn>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601085203.40214-1-liangjs@pku.edu.cn>
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
MIME-Version: 1.0
Message-ID: <162281321853.29796.18130084021269864131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5405b42c2f08efe67b531799ba2fdb35bac93e70
Gitweb:        https://git.kernel.org/tip/5405b42c2f08efe67b531799ba2fdb35bac93e70
Author:        Jiashuo Liang <liangjs@pku.edu.cn>
AuthorDate:    Tue, 01 Jun 2021 16:52:03 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 04 Jun 2021 15:23:28 +02:00

x86/fault: Don't send SIGSEGV twice on SEGV_PKUERR

__bad_area_nosemaphore() calls both force_sig_pkuerr() and
force_sig_fault() when handling SEGV_PKUERR. This does not cause
problems because the second signal is filtered by the legacy_queue()
check in __send_signal() because in both cases, the signal is SIGSEGV,
the second one seeing that the first one is already pending.

This causes the kernel to do unnecessary work so send the signal only
once for SEGV_PKUERR.

 [ bp: Massage commit message. ]

Fixes: 9db812dbb29d ("signal/x86: Call force_sig_pkuerr from __bad_area_nosemaphore")
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Jiashuo Liang <liangjs@pku.edu.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lkml.kernel.org/r/20210601085203.40214-1-liangjs@pku.edu.cn
---
 arch/x86/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1c548ad..6bda7f6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -836,8 +836,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 	if (si_code == SEGV_PKUERR)
 		force_sig_pkuerr((void __user *)address, pkey);
-
-	force_sig_fault(SIGSEGV, si_code, (void __user *)address);
+	else
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
 	local_irq_disable();
 }
