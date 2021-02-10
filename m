Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89CF316892
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBJOAR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhBJOAJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:09 -0500
Date:   Wed, 10 Feb 2021 13:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=saDKPjsdTkVMcdsh6HJLQ77MX1WJzo7YGOauV4u1GrE=;
        b=Cq+YPEVVWAR0e/QCYPeuQdhY9jMkxMZninxdeBiN3obmw8DCQRka3rhLn5izjnlhES3ZOL
        5IPg7umQBdUxTikepzaH93qFbt9Bov11xpcmRNFoOMZsuIPqOEA+6U3jgz0sOzHQ2pJHJ9
        456t15q3QHwsgx1MJxqg+knrhM4QIpkQz1PNOx+XAB0anpC0mR+9TPuRbdrQYpl/cSZo/n
        YcwuU1eVsSsaPovhQN0Rv/si9RosCZ7hDVFKEZOpMJjbdBQGnnCPcSrpT9V+qwLju4zt3v
        LnHCyKdj7sNNHvrM0q8PRoW3TqVjfQcy4nU3wYKWc+Pti+KdPA8wp43iHbQruA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=saDKPjsdTkVMcdsh6HJLQ77MX1WJzo7YGOauV4u1GrE=;
        b=JAEalScjsf7kDdjZZtfCPFcj0reF6qGQx9N5BrlJJt3DugIRNfme5D18IxIUEKDWsPCsv7
        jJtZ4Ki9DrF1t1Cg==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] s390: Use arch_local_irq_{save,restore}() in
 early boot code
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161296556578.23325.2595288129888927828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b38085ba60246fccc2f49d2ac162528dedbc4e71
Gitweb:        https://git.kernel.org/tip/b38085ba60246fccc2f49d2ac162528dedbc4e71
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Wed, 10 Feb 2021 14:24:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:39 +01:00

s390: Use arch_local_irq_{save,restore}() in early boot code

Commit 997acaf6b4b5 ("lockdep: report broken irq restoration") makes
compiling s390 fail because the irq enable/disable functions are now
no longer fully contained in header files.

Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/s390/char/sclp_early_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_early_core.c b/drivers/s390/char/sclp_early_core.c
index ec9f8ad..b7329af 100644
--- a/drivers/s390/char/sclp_early_core.c
+++ b/drivers/s390/char/sclp_early_core.c
@@ -66,13 +66,13 @@ int sclp_early_cmd(sclp_cmdw_t cmd, void *sccb)
 	unsigned long flags;
 	int rc;
 
-	raw_local_irq_save(flags);
+	flags = arch_local_irq_save();
 	rc = sclp_service_call(cmd, sccb);
 	if (rc)
 		goto out;
 	sclp_early_wait_irq();
 out:
-	raw_local_irq_restore(flags);
+	arch_local_irq_restore(flags);
 	return rc;
 }
 
