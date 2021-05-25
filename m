Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C45B39058D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhEYPh3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhEYPh3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 11:37:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47471C061574;
        Tue, 25 May 2021 08:35:59 -0700 (PDT)
Date:   Tue, 25 May 2021 15:35:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621956957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxzj1Dd5TfmGzP473Z114NoxQ+f2KoEw6CfiQZ9U6UQ=;
        b=hVgbDeCESU9LVcpnUjHn4rN0IeWw0cKakH4A+644GiXKgvkihIVUw9QUlpX6VK+8CBZQ+M
        eMZr3C+vBa88kdcrWC9mhCSkhFeM1/bCLq2IccCbVeWLQVPFUJaJ/DXt3DPxNSKzNTzEEf
        NUqrr5BTpcO9+4I5fJT1nxbr/IDhaIHyZW0099pBUzElJQkCSks6SzJj83nSmj6pPUAwH2
        KmxZBX1WYaC6MPF9pv/Q3CKC0u5dVA+5pH0nrnjEDlD2TgNGmJ1A78oarTWYZqYXuv1MAJ
        bb7lbcrjV+U767yTUoNTKSNMBUjFyyfjfA9jWKq+mZ6MJ6bhOhXHTmQtPkAZbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621956957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qxzj1Dd5TfmGzP473Z114NoxQ+f2KoEw6CfiQZ9U6UQ=;
        b=uU3rKlcaqseDU6wX/U+NyzwXRSZpHH7AfSRAcRtNxjUHyuEqPZaAAz/J5CGGM5rQ1KVInx
        dQCgxkNRxvbLxRCw==
From:   "tip-bot2 for Pavel Begunkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Deduplicate cond_resched() invocation in
 futex_wake_op()
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9b2588c1fd33c91fb01c4e348a3b647ab2c8baab=2E16212?=
 =?utf-8?q?58128=2Egit=2Easml=2Esilence=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C9b2588c1fd33c91fb01c4e348a3b647ab2c8baab=2E162125?=
 =?utf-8?q?8128=2Egit=2Easml=2Esilence=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <162195695671.29796.5893139946857562110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a82adc7650044b5555d65078bda07866efa4a73d
Gitweb:        https://git.kernel.org/tip/a82adc7650044b5555d65078bda07866efa4a73d
Author:        Pavel Begunkov <asml.silence@gmail.com>
AuthorDate:    Mon, 17 May 2021 14:30:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 17:30:15 +02:00

futex: Deduplicate cond_resched() invocation in futex_wake_op()

After pagefaulting in futex_wake_op() both branches do cond_resched()
before retry. Deduplicate it as compilers cannot figure it out themself.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lore.kernel.org/r/9b2588c1fd33c91fb01c4e348a3b647ab2c8baab.1621258128.git.asml.silence@gmail.com

---
 kernel/futex.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 2f386f0..08008c2 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1728,12 +1728,9 @@ retry_private:
 				return ret;
 		}
 
-		if (!(flags & FLAGS_SHARED)) {
-			cond_resched();
-			goto retry_private;
-		}
-
 		cond_resched();
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
 		goto retry;
 	}
 
