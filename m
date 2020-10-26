Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED8298A83
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770068AbgJZKkW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 06:40:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770047AbgJZKkV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 06:40:21 -0400
Date:   Mon, 26 Oct 2020 10:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603708819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlltfML5jURE2ETArGNEwnvKipiQeRNukCX9me9ih2s=;
        b=RxHzGEXe4vuRUO1fGmwPtt2AaFDGxwPZN4iqxNLeoy3wHQ3qCwICwa+C1tw/yQsldjn6SV
        QJuMZXXdY15rIRIsj4SWI8+D3fKyeQ0UaaK/m1oxey8fQeG2vDxkPg0//b/E27hJjAxgdf
        9ThDZvfdJnYBIDGsskVKtoesbhgARHZO+k+05ggR58wlOqSo2APdp/Mx/3qcaB/HzOX1IK
        uAUi2TMPccl5XvDjlLaykIZzw50axTlzYHPQf9E1fywbbk4Dp9V3H16mRjwtXVlnJOBRN3
        fXbAfQTSuL9wLJlvfkpDhX62YLPE0/fHVQaqJN+7enBa01RvgYxoC0E57YGMnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603708819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlltfML5jURE2ETArGNEwnvKipiQeRNukCX9me9ih2s=;
        b=RWqM2yYqyHYFn/6roKZfY1ZFPm5M8zfQJQL/ahCGU6pZ04zbUNK2Zokh50hqHDeL5oWQle
        xOg7xWY/FL9CKWDQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers: Remove unused inline funtion debug_timer_free()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200909134749.32300-1-yuehaibing@huawei.com>
References: <20200909134749.32300-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <160370881802.397.15234178664001900654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     9010e3876e1c3f7b1c3769bee519d6a871589aca
Gitweb:        https://git.kernel.org/tip/9010e3876e1c3f7b1c3769bee519d6a871589aca
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Wed, 09 Sep 2020 21:47:49 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 11:39:21 +01:00

timers: Remove unused inline funtion debug_timer_free()

There is no caller in tree, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200909134749.32300-1-yuehaibing@huawei.com

---
 kernel/time/timer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index de37e33..c3ad64f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -732,11 +732,6 @@ static inline void debug_timer_deactivate(struct timer_list *timer)
 	debug_object_deactivate(timer, &timer_debug_descr);
 }
 
-static inline void debug_timer_free(struct timer_list *timer)
-{
-	debug_object_free(timer, &timer_debug_descr);
-}
-
 static inline void debug_timer_assert_init(struct timer_list *timer)
 {
 	debug_object_assert_init(timer, &timer_debug_descr);
