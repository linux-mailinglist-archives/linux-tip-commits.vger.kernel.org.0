Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553FC33F078
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCQMie (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCQMiX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD3C06174A;
        Wed, 17 Mar 2021 05:38:22 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:38:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qzqhedp0OntONtQytCa2588EidCoFv7TJX9wbYVv3rw=;
        b=sKg26zE1/VNlttDHWIKp6ZwnUo4JuY4EHI2RTYftVeVyIZ0bulGudK5wHnm3Yk5Nq+bHig
        dlbey+rK/ttrmmwVWnqkqd9WJ2euqBojb5Pa80a6XofcqpxNePBPwPoEUkW9W/f6jJwTNC
        u2EtREhwB2gUjIycVfXrGoUgEia+ih4QBp5MeNA2pJ9ZliOIE96n1Mycp+F9O1RmA1Jh/q
        FihgFPYjDzAzMKW27x2HddnUgvJL7qG9NDoeChyRF3JX7Ia0YFN1ImKomQ1logTYsXGm2X
        wPB+GgG5O5iuQ+lKOcUu0E8eA3YaFALZzT9ReNah9xqBElJiauSSICfaTqaj7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qzqhedp0OntONtQytCa2588EidCoFv7TJX9wbYVv3rw=;
        b=31jHdkj+29CDOeUCB5byDWQptKUlFAdK9fDDek8v/TE8eYSuNNLYLKmBjDZJsKJmKJSWwU
        L00p6GncDpBhv2Cw==
From:   "tip-bot2 for Bhaskar Chowdhury" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Fix comment typo
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210317041806.4096156-1-unixbhaskar@gmail.com>
References: <20210317041806.4096156-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Message-ID: <161598469872.398.4566004083780448035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4faf62b1ef1a9367f7dcf8b7ce509980dfdcee83
Gitweb:        https://git.kernel.org/tip/4faf62b1ef1a9367f7dcf8b7ce509980dfdcee83
Author:        Bhaskar Chowdhury <unixbhaskar@gmail.com>
AuthorDate:    Wed, 17 Mar 2021 09:48:06 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Mar 2021 09:34:39 +01:00

locking/rwsem: Fix comment typo

s/folowing/following/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20210317041806.4096156-1-unixbhaskar@gmail.com
---
 kernel/locking/rwsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index abba5df..fe9cc65 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -632,7 +632,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }
 
 /*
- * The rwsem_spin_on_owner() function returns the folowing 4 values
+ * The rwsem_spin_on_owner() function returns the following 4 values
  * depending on the lock owner state.
  *   OWNER_NULL  : owner is currently NULL
  *   OWNER_WRITER: when owner changes and is a writer
