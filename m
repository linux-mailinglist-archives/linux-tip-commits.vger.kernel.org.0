Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177B8288233
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgJIGfd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbgJIGf2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:28 -0400
Date:   Fri, 09 Oct 2020 06:35:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qCvqBe26Y7DN7alxVVb15r1PO4+YP+mATWQzRyrhAZA=;
        b=aDfnhj1YXxVpQSVGahTIH2torBz2h/N5fR8DKcZZfHHTqvQg8eKMdMiXR1+LJNxq6AyISO
        laN835iELqiwJ57O/E6srCQ+brD063Z9wi+fwJCbHad3dz/XFanqa2XDQYtgWLesmCkycS
        Y9q9VYdG3rRZRF4RmZHaYdOl7Rg5XydpxH85c4pATQD73vNVCJX/sM9yLxxNqXLmD36hUZ
        RQlzbN5f7/gEtLRbO1yet78yDndGO1l+0IW0YA82VObP7G6uPwtYU2QswPcivAH8ybDe7z
        d389JIjRhSHFrIsfXnjL3HBY3uf11n/+1uTmZAi9L0Kbl1UxSdqS6/ADHPBLVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qCvqBe26Y7DN7alxVVb15r1PO4+YP+mATWQzRyrhAZA=;
        b=RuVQCLjo4032JIovO+iNV/7vAbNB8CIxiRqpOJj4rNNsb/IFh9jOxeNFdQp6Y5lMZd6V9W
        s1fQygeN6GR9t1CA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Adapt memory-ordering test to UP operation
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532556.7002.15028957921678826005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9e66bf03f9c538863e614a72c5799bcd9579630e
Gitweb:        https://git.kernel.org/tip/9e66bf03f9c538863e614a72c5799bcd9579630e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 15:23:19 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:37 -07:00

scftorture: Adapt memory-ordering test to UP operation

On uniprocessor systems, smp_call_function() does nothing.  This commit
therefore avoids complaining about the lack of handler accesses in the
single-CPU case where there is no handler.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 04d3a42..fc22bcc 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -363,7 +363,8 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_out = true;
 	}
 	if (scfcp && scfsp->scfs_wait) {
-		if (WARN_ON_ONCE(!scfcp->scfc_out))
+		if (WARN_ON_ONCE((num_online_cpus() > 1 || scfsp->scfs_prim == SCF_PRIM_SINGLE) &&
+				 !scfcp->scfc_out))
 			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
 		else
 			kfree(scfcp);
