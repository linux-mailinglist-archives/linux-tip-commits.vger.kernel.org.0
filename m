Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC02CD3C6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgLCKg3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgLCKg0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:26 -0500
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwuwXB17kd/2kzcZLI1QiaXVaXGPcrjjuuZfTBg7ZkE=;
        b=KjmKvKGCMxy5Uzl9eKZCq38WsCvg9SzEW2rWEoFDnCR+I/giSa1wNopUGvKW00rQOYuU5w
        btnJbPdCMUsTU7vSpYuQiXgKgiqBXDTOIiRjPp5AWxIBNq4HItf0MPgcFebKuq7gUThIxg
        Lttwx9GBK0DTxZsqVnswODU2oYzO1yihH5QorTYuyJjGiaFgF/UTHElyHR9lIe3t3IS0pz
        m1RNCISHXbiIqxxZiMi1Hma1A5Y3eV630XUGQtgOgPgBJ2fISU1Qi0PJkIbf1FApDI1MSN
        k40vNXEC1vFoTscFdQZs+aftRxqLoWJ7ONku6PXc/T++eA/LfWu1ZhQEm6xXrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwuwXB17kd/2kzcZLI1QiaXVaXGPcrjjuuZfTBg7ZkE=;
        b=IPfOb9QCfpuzbSj8DG79rPrMvlc9s3/RsjAjVwoP61KzmDV3o9rYs9EPZuDJRFbxGzYZWa
        pHdQ9fHfRjNakYBg==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] completion: Drop init_completion define
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce657bfc533545c185b1c3c55926a449ead56a88b=2E16068?=
 =?utf-8?q?23973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3Ce657bfc533545c185b1c3c55926a449ead56a88b=2E160682?=
 =?utf-8?q?3973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160699174402.3364.17969224143860964280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b6498aad59b091e5618a9f05e7636e2ad2c6732d
Gitweb:        https://git.kernel.org/tip/b6498aad59b091e5618a9f05e7636e2ad2c6732d
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 01 Dec 2020 13:09:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:52 +01:00

completion: Drop init_completion define

Changeset cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
added a CONFIG_LOCKDEP_COMPLETE (that was later renamed to
CONFIG_LOCKDEP_COMPLETIONS).

Such changeset renamed the init_completion, and add a macro
that would either run a modified version or the original code.

However, such code reported too many false positives. So, it
ended being dropped later on by
changeset e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks").

Yet, the define remained there as just:

	 #define init_completion(x) __init_completion(x)

Get rid of the define, and return __init_completion() function
to its original name.

Fixes: e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/e657bfc533545c185b1c3c55926a449ead56a88b.1606823973.git.mchehab+huawei@kernel.org
---
 include/linux/completion.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e770..51d9ab0 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -28,8 +28,7 @@ struct completion {
 	struct swait_queue_head wait;
 };
 
-#define init_completion_map(x, m) __init_completion(x)
-#define init_completion(x) __init_completion(x)
+#define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
@@ -82,7 +81,7 @@ static inline void complete_release(struct completion *x) {}
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
