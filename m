Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2B2EB294
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Jan 2021 19:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbhAES2w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Jan 2021 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbhAES2v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Jan 2021 13:28:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F60C061798;
        Tue,  5 Jan 2021 10:28:11 -0800 (PST)
Date:   Tue, 05 Jan 2021 18:28:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1609871288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X75TBPO0punS/DRVX3qhlp0d7NpDwu3ZcCMazY6Mg8I=;
        b=HZgD0CO6vUCeL+nYJ+6ihTAob/e0ArcJKZjogDkzJM+JGeMcLopmKssALNmvqZhqRLPHJ/
        DQP/9cZsc60dR9tRQrd2+RflC3nVhu9pSkTWc6pch4pWInmdCZk0VSFfbDX2WdkalXtuyK
        Xvofao878dFwWnkhY3vG0Ij6MmAocjRyHWmleI04p0P5DD1QUiflz9mCU14Ei7sJbBLjZc
        yZe0AbNmYTKDA10sUBI1hbAyDctUB+vtLuzJXNRXN/1E3fbfEYa9bj97rVhOSjXmxy3qod
        yyHpwNeVbYnb7Z+C6vkdDRStOm/jMwBAwo4jYilNFKNHIRbhNKPHDOyBQDMlEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1609871288;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X75TBPO0punS/DRVX3qhlp0d7NpDwu3ZcCMazY6Mg8I=;
        b=xb3aH5Ok96BXu6Th7EXx/IN2OREbjXW70uHArnfRe0A9jQlDNRBj5RySn9wupfaAmoovAQ
        RXQlqBD362J+ymCg==
From:   "tip-bot2 for Adrian Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Refine mmap syscall implementation
Cc:     Adrian Huang <ahuang12@lenovo.com>, Borislav Petkov <bp@suse.de>,
        Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201217052648.24656-1-adrianhuang0701@gmail.com>
References: <20201217052648.24656-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Message-ID: <160987128790.414.308593720085652897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     91a8f6cb06b33adc79fbf5f7381d907485767c00
Gitweb:        https://git.kernel.org/tip/91a8f6cb06b33adc79fbf5f7381d907485767c00
Author:        Adrian Huang <ahuang12@lenovo.com>
AuthorDate:    Thu, 17 Dec 2020 13:26:48 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Jan 2021 19:07:42 +01:00

x86/mm: Refine mmap syscall implementation

It is unnecessary to use the local variable 'error' in the mmap syscall
implementation function - just return -EINVAL directly and get rid of
the local variable altogether.

 [ bp: Massage commit message. ]

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lkml.kernel.org/r/20201217052648.24656-1-adrianhuang0701@gmail.com
---
 arch/x86/kernel/sys_x86_64.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 504fa54..660b788 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -90,14 +90,10 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
 		unsigned long, fd, unsigned long, off)
 {
-	long error;
-	error = -EINVAL;
 	if (off & ~PAGE_MASK)
-		goto out;
+		return -EINVAL;
 
-	error = ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
-out:
-	return error;
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
 
 static void find_start_end(unsigned long addr, unsigned long flags,
