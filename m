Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9A415B8F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhIWJ7S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:59:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbhIWJ7R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:59:17 -0400
Date:   Thu, 23 Sep 2021 09:57:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632391065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Je/SAgT/J2pQ60AakoXLDn4EAT/Zw7YJ40Gy39s3h4=;
        b=AQqq6pSDO/+4Z9AEpJv5289EGDrESGWx9Y4YRLSjhBtI3+P64BDXHIB1Lbb/GLmvUAsqd3
        wWDm7gIwpSpJRNIUXE8V4wQievj+Esx5kM9ybBxaATysYDqVIFk1/ytynjho9B0jNSCbDO
        m2YAylxZtbD0rqkr+2o0lYaj3nU+VOIKR8jycGC2wArHAV36O0P+Bd7H8KbHN2sma6mRS5
        ssPi2i1FlWdBGaAp1c2GeCIoIyy8mBY9ow5Tr74v2cd1iWRgSmKwKFrL3piAry8KXnFzMD
        fCxT7VyEzv9QUCEVMbopQTbXExAV5PJB2RNXZ3U/Yfvr9I9v4F9VKBFFljXe7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632391065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Je/SAgT/J2pQ60AakoXLDn4EAT/Zw7YJ40Gy39s3h4=;
        b=+7TybvjJEDtY8QglG6+HVQhv0CXaGQP6FbO0taggMQ5PhILKarGnEDi0ByHUVWkwL9ylK/
        RzQspBDH+6OYGTBA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Prevent spuriously armed
 0-value itimer
Cc:     Victor Stinner <vstinner@redhat.com>,
        Chris Hixon <linux-kernel-bugs@hixontech.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210913145332.232023-1-frederic@kernel.org>
References: <20210913145332.232023-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <163239106440.25758.1989053609281702993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     8cd9da85d2bd87ce889043e7b1735723dd10eb89
Gitweb:        https://git.kernel.org/tip/8cd9da85d2bd87ce889043e7b1735723dd10eb89
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 13 Sep 2021 16:53:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Sep 2021 11:53:51 +02:00

posix-cpu-timers: Prevent spuriously armed 0-value itimer

Resetting/stopping an itimer eventually leads to it being reprogrammed
with an actual "0" value. As a result the itimer expires on the next
tick, triggering an unexpected signal.

To fix this, make sure that
struct signal_struct::it[CPUCLOCK_PROF/VIRT]::expires is set to 0 when
setitimer() passes a 0 it_value, indicating that the timer must stop.

Fixes: 406dd42bd1ba ("posix-cpu-timers: Force next expiration recalc after itimer reset")
Reported-by: Victor Stinner <vstinner@redhat.com>
Reported-by: Chris Hixon <linux-kernel-bugs@hixontech.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210913145332.232023-1-frederic@kernel.org
---
 kernel/time/posix-cpu-timers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index ee73686..643d412 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1404,7 +1404,8 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			}
 		}
 
-		*newval += now;
+		if (*newval)
+			*newval += now;
 	}
 
 	/*
