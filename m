Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9863B08AB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 17:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhFVPYV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhFVPYU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 11:24:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09598C061574;
        Tue, 22 Jun 2021 08:22:05 -0700 (PDT)
Date:   Tue, 22 Jun 2021 15:22:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624375323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTN1WQMC4muxqMJ5NN7pFDYwqznAKVr4r/AEwbkoa80=;
        b=OfGiSfI/dxD2LXnGYSFi/DmsPkXSYtZ5kcQbaYPPIFIOWG3gLHTAOFUU/S2nmL1uknt3u3
        WBVspc/AVfwKoc+hZ1jR1zqfBxMlMwwKMZEP8eU18n+EWCXCYS67+KIt+Vaio8/S4Lq24c
        eRYTAG+nKITd+mSbUhYEYOnRL6Py861QJ9RitLS5YAHzcMGwqnPjt7f6By4spC3Ss19CbZ
        6lEu3Tvx4eKkhMAZZnsdpgfeNMgMWSNilbocm8A+vgKw4nAjKzEyhloFvRbSVKOsSouBJm
        DOn+N08YzMYHvunNBrl9jjyQLuRUagJrA5PjgZZlfx3MH8Uk/gbpuUXyQ0IBDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624375323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTN1WQMC4muxqMJ5NN7pFDYwqznAKVr4r/AEwbkoa80=;
        b=5AIv/4IKwIvmFr+Zxef8kSz48YI+y/u5nAO7FLgKhBmalZcAacjkcuQ2gNlISaFUO76Jaa
        FWHEeJ5MzqT0t9CA==
From:   "tip-bot2 for Baokun Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Use list_move() instead of
 list_del()/list_add()
Cc:     Hulk Robot <hulkci@huawei.com>, Baokun Li <libaokun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210609070242.1322450-1-libaokun1@huawei.com>
References: <20210609070242.1322450-1-libaokun1@huawei.com>
MIME-Version: 1.0
Message-ID: <162437532284.395.12000007816780541875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4e82d2e20f3b11f253bc5c6e92f05ed3694a1ae3
Gitweb:        https://git.kernel.org/tip/4e82d2e20f3b11f253bc5c6e92f05ed3694a1ae3
Author:        Baokun Li <libaokun1@huawei.com>
AuthorDate:    Wed, 09 Jun 2021 15:02:42 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 17:16:46 +02:00

clockevents: Use list_move() instead of list_del()/list_add()

Simplify the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210609070242.1322450-1-libaokun1@huawei.com

---
 kernel/time/clockevents.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index bb9d2fe..003ccf3 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -347,8 +347,7 @@ static void clockevents_notify_released(void)
 	while (!list_empty(&clockevents_released)) {
 		dev = list_entry(clockevents_released.next,
 				 struct clock_event_device, list);
-		list_del(&dev->list);
-		list_add(&dev->list, &clockevent_devices);
+		list_move(&dev->list, &clockevent_devices);
 		tick_check_new_device(dev);
 	}
 }
@@ -576,8 +575,7 @@ void clockevents_exchange_device(struct clock_event_device *old,
 	if (old) {
 		module_put(old->owner);
 		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
-		list_del(&old->list);
-		list_add(&old->list, &clockevents_released);
+		list_move(&old->list, &clockevents_released);
 	}
 
 	if (new) {
