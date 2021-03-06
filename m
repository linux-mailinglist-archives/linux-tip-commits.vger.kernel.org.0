Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE36C32F9FF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCFLmd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhCFLmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0616C061762;
        Sat,  6 Mar 2021 03:42:22 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkE9zXVJs1uIjTiJRKhrcBr9hDJuA0FAi4lmYBlnHaQ=;
        b=z2BtPty7j8rcESRaJPMVSacXGptylRaKBVyr11Ur9C9+qJI6KaLf+Yx9s1P1I3jPPVmoa6
        divY8QJVg7mPIy1gXBBecj8rsHe9bJ419uvUiYgrdiFg0l2kk/vxwzSP9DZDwIOheriPRX
        35nWz420Y4IUGdBvHTVitqQhfmr6dIHffAC22BJiWMPTf4WFa2iil226E8foQfNgIGF/pi
        9fZ8yCVt86M7FLgYN8GIZ7yi0e9cu1z65MlKLuY5Qt5n5a/Kdo10mMNXsnPywjmDtAGIE6
        kFMjmBD2KEmRfZKQP4cQknDzt+y1zI9MJG040JVuqeoLmv2pL4UOjO8zS9aIAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkE9zXVJs1uIjTiJRKhrcBr9hDJuA0FAi4lmYBlnHaQ=;
        b=8EgLAgX68iw1HnNgQTimkIGgpQPbFtz1nhprgBxdL4cmcfvo51b9/3KRvIbU6LyFOCCUME
        1gnOI3ApHt8D4zBg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: Allowing to reset fail injection
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-2-vincent.donnefort@arm.com>
References: <20210216103506.416286-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161503094046.398.4094849843898938715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3ae70c251f344976428d1f6ee61ea7b4e170fec3
Gitweb:        https://git.kernel.org/tip/3ae70c251f344976428d1f6ee61ea7b4e170fec3
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:04 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

cpu/hotplug: Allowing to reset fail injection

Currently, the only way of resetting the fail injection is to trigger a
hotplug, hotunplug or both. This is rather annoying for testing
and, as the default value for this file is -1, it seems pretty natural to
let a user write it.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210216103506.416286-2-vincent.donnefort@arm.com
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302e..9121edf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2207,6 +2207,11 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail == CPUHP_INVALID) {
+		st->fail = fail;
+		return count;
+	}
+
 	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
 		return -EINVAL;
 
