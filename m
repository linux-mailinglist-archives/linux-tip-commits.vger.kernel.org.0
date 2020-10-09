Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879D0288230
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgJIGfb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55514 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbgJIGf2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:28 -0400
Date:   Fri, 09 Oct 2020 06:35:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wcF0dEwzNPr90Tbxt4+HSPkK7z1+sIVrBykuBK6vSPA=;
        b=fRa7Wu6dvOzbWz1+s8FEONlV++R4fDVHlqoqyVQ7snJhFzkvcq72T9Q16ssIAbwN+SARRc
        fYwBEn3q8Urx2Kw3dI/WgNhS2s1eRi3NZ6Xlz7bORzWNTJMWYfBRdwN7uhwt/B6APnnzbp
        0EZT18pzIYEVegVzH77gFyjfV1lToBHXnU+kaPT6ETRH0OKfc8L0Uf18vIAAOXEtWh/PUl
        M/ak892ZM6zw4C72cawYJpDs3vtbiRqs1oq4Nod8JtnV30icWhEOy7jxW7sWQsubp7pMpD
        wn3Tefs3qde8EUgxICJ7PFCwhoJSqBkTwkKldvTTm7RRqiKJI/uGOWPg+Nlc3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wcF0dEwzNPr90Tbxt4+HSPkK7z1+sIVrBykuBK6vSPA=;
        b=L6ojb58Xexgf83nBV93G8x8AGJmuXlOi0vPEOWubXAD12CjFkmK2BVCZpplTghYXzH5ySO
        fTW5eYgfMwbaqxBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add cond_resched() to test loop
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532498.7002.8138563909666849426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     65bd77f554336407f5fd7ced7a6df686767fba21
Gitweb:        https://git.kernel.org/tip/65bd77f554336407f5fd7ced7a6df686767fba21
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 23 Jul 2020 15:53:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:38 -07:00

scftorture: Add cond_resched() to test loop

Although the test loop does randomly delay, which would provide quiescent
states and so forth, it is possible for there to be a series of long
smp_call_function*() handler runtimes with no delays, which results in
softlockup and RCU CPU stall warning messages.  This commit therefore
inserts a cond_resched() into the main test loop.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index fc22bcc..554a521 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -420,6 +420,7 @@ static int scftorture_invoker(void *arg)
 			set_cpus_allowed_ptr(current, cpumask_of(cpu));
 			was_offline = false;
 		}
+		cond_resched();
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
