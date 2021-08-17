Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C683EF33A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhHQUOl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34614 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhHQUOi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:38 -0400
Date:   Tue, 17 Aug 2021 20:14:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWglPduLIeN5lZT8P5w+Fq0G4SD7qfVsT/l2OQxrGV8=;
        b=h5pHoNecKcqbzf8a3PCJxajHGJYm15294On+hBYcOFSrx1b14iSQHKPlxBLqmQ3D2PVfh2
        /PQiDWnPCyNfefgc83mnbKYp3d0OhdO0QsjOpDMcfXZfNu4psBaF6aeTMiUM/PSkSpj4Wj
        +gadurtAU8eZ5upD9HTA/f2bXoyJ2JcuT6RQstg+TgrqNFKjU/UE5FZNNaYdM4YLQrOFSK
        cQkMmT6kYq5p9to5alEdbupyv6Gbgx8NDiu5gTt7lMMDFA0S5Ufsm+gOftgIXnPfcxyIKU
        VoRgVlEO3VNPYWdoJ/NPjDRU/XhK6oReUOCutdala318CQju9zJWRBROMOiD+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWglPduLIeN5lZT8P5w+Fq0G4SD7qfVsT/l2OQxrGV8=;
        b=BIF5tQShFcgWhYxrIXZy/VU3TF8ZIzViFQv/Nh+1u2E3oxwJp1G0h7vR8fP/YohSwORkSV
        BjY6YukZhQ4JwkAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove bogus condition for requeue PI
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.362730187@linutronix.de>
References: <20210815211305.362730187@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124348.25758.13935668951132294737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8e74633dcefb280f2cefb49b7201d99650243d96
Gitweb:        https://git.kernel.org/tip/8e74633dcefb280f2cefb49b7201d99650243d96
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:44 +02:00

futex: Remove bogus condition for requeue PI

For requeue PI it's required to establish PI state for the PI futex to
which waiters are requeued. This either acquires the user space futex on
behalf of the top most waiter on the inner 'waitqueue' futex, or attaches to
the PI state of an existing waiter, or creates on attached to the owner of
the futex.

This code can retry in case of failure, but retry can never happen when the
pi state was successfully created. The condition to run this code is:

  (task_count - nr_wake) < nr_requeue

which is always true because:

   task_count = 0
   nr_wake = 1
   nr_requeue >= 0

Remove it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.362730187@linutronix.de
---
 kernel/futex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c39d5f1..8ddc87c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2000,7 +2000,7 @@ retry_private:
 		}
 	}
 
-	if (requeue_pi && (task_count - nr_wake < nr_requeue)) {
+	if (requeue_pi) {
 		struct task_struct *exiting = NULL;
 
 		/*
