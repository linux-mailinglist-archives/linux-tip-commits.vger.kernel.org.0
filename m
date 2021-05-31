Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737E13965D5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhEaQts (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhEaQrX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 12:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62291C06123B;
        Mon, 31 May 2021 08:07:02 -0700 (PDT)
Date:   Mon, 31 May 2021 15:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622473620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQCKwJoMMrc6hkFo0GdS/W5ziBDmv2vt8lNxFLCanGg=;
        b=4Ne1oH713V0IFIcWa0SDCyzBr4GFYpEWIK3HkRJxf0vv+XJGH7YE0VS6R9cOhmyK9+CKMN
        O7VqW1sdij35tPjCtZdEh54+caJ5FsSZosrAqolUNJsaoEDQdsfUhx6iUit5cezGgNmrZK
        SGeqhCsb4prFuI8qDaQJ45ASb+llYIkcXlDz/Xsd+3YZm50e8J3wvSHRmk0bTYc51cJjxQ
        Jv5Ny0et/4ndqoZo5YgQNGvCnB5jfeow77PbKBPQuhJlJ6lMnM7UHffB8AWEHfPeaf/GJV
        V8sNje4zOEbCMMSV4IpXhL/D0wuB5umTt2KemO8fxNXP/Qdp/u+JgCnK5KJ9tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622473620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQCKwJoMMrc6hkFo0GdS/W5ziBDmv2vt8lNxFLCanGg=;
        b=FjuGBMTeJ6eY+09/qPk12vBMcnS7u5SDzpQ/LS7hMTaTRluiuVVjkT3GzV8MC0nVoIWaNf
        50heDnPP7oaQDiCw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Drop unneeded
 CONFIG_GENERIC_CLOCKEVENTS_BROADCAST guard
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524221818.15850-2-will@kernel.org>
References: <20210524221818.15850-2-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162247362024.29796.4665276490727895520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c2d4fee3f6d170dee5ee7c337a0ba5e92fad7a64
Gitweb:        https://git.kernel.org/tip/c2d4fee3f6d170dee5ee7c337a0ba5e92fad7a64
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 24 May 2021 23:18:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 May 2021 17:04:44 +02:00

tick/broadcast: Drop unneeded CONFIG_GENERIC_CLOCKEVENTS_BROADCAST guard

tick-broadcast.o is only built if CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
so remove the redundant #ifdef guards around the definition of
tick_receive_broadcast().

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210524221818.15850-2-will@kernel.org

---
 kernel/time/tick-broadcast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index a440552..fb794ff 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -253,7 +253,6 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 	return ret;
 }
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 int tick_receive_broadcast(void)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
@@ -268,7 +267,6 @@ int tick_receive_broadcast(void)
 	evt->event_handler(evt);
 	return 0;
 }
-#endif
 
 /*
  * Broadcast the event to the cpus, which are set in the mask (mangled).
