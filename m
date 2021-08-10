Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C56A3E7BB5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhHJPHi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbhHJPHi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:07:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418EC0613C1;
        Tue, 10 Aug 2021 08:07:16 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:07:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+fTR/VomdRPkol+f9vCD1GWoe1qBK+UFzpSF4GLZYI=;
        b=M1C5mLSr0bq9IuK5Iu3y9eaXf74pYnOXwkK3cyL7lXl1xLz3iTVvRxTKrx0r8SNVA7W8fa
        /j2f1ZpYxH2R0UNTpwkHj5oPtH9oeGnjmdJlaxDvfIB5s1j/Jjo0F6iDakJHK0egb3HEpT
        E12QF6nbvegfqDt1djDjlU2v7CTwJYSZpb7ttOCS+3R+OeKsd6oHmH3d0J3Lq/zPNkMICh
        2QQK3J357ywqzJ0I6wNScPpz64lOz/Pa+drS31v210vgUThoyPj5TcPO3gVTeCe53oK1/P
        Jtss2rsqioR2Rox6/76FxTQJUIfa09dHpfPeA3ue5pVHSkl3Ws7ltrCl2kPwSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+fTR/VomdRPkol+f9vCD1GWoe1qBK+UFzpSF4GLZYI=;
        b=v9ZdkJeshKo6CEL1ZhuaULf+0Rcn3JS1GGZcIIKPbAWHaTyMMn76QtMsstZtZNK/vbfGkh
        u0+DnbA2gtksRuCQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Remove redundant initialization of
 variable ret
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210721120147.109570-1-colin.king@canonical.com>
References: <20210721120147.109570-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <162860803112.395.6863520672522344835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1dae37c7e41d9a75a615ba7b0480acc2e04094d4
Gitweb:        https://git.kernel.org/tip/1dae37c7e41d9a75a615ba7b0480acc2e04094d4
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Wed, 21 Jul 2021 13:01:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:02:11 +02:00

posix-timers: Remove redundant initialization of variable ret

The variable ret is being initialized with a value that is never read, it
is being updated later on. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210721120147.109570-1-colin.king@canonical.com

---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd5697d..3913222 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -336,7 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 int posix_timer_event(struct k_itimer *timr, int si_private)
 {
 	enum pid_type type;
-	int ret = -1;
+	int ret;
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
