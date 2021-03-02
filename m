Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD41E32B034
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbhCCDfM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:35:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378829AbhCBJD0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
Date:   Tue, 02 Mar 2021 09:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riB0VxmdY1qDxEHE89G6VCtXXBJuhmUkX4+p0/l+CLU=;
        b=vq0byQDZf9+ggdYDtP+n9bXnOzMM+ejB1eJhfmeIfUDNAjcIGg3lJM8P+SWqiDdroKHMgF
        lVVPIVrcbu6/a+bCOPeOhP9VHmnhOEznGmDFb5+eknq93XRF6mxcSguzi1wvC5KDp+43hW
        J25PTabY+i4ZuKieiJoZvU5MUFGn3LTgkhvPqTV8swxUeqcRpU9GurVAl5JytBrqPkxQwE
        gDpMd6FJSGYXekr2vFiiRjDgX8FolkG6VbSjmWs2MV9CWiC1lAKtngc2N0M7NbiqKQmkIu
        1wFiR6/sPy818EDo5cQ/TPDba+hesNSsMW6Wt8rxJdJtS6FOdC8C2idfQrMUsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riB0VxmdY1qDxEHE89G6VCtXXBJuhmUkX4+p0/l+CLU=;
        b=2a7qXMnPW7kGCD2gOYj/kjhcpF0Q/fEwlM0u9zr9ENLNw7MPOjn9bnIovTKyrJo0MbCT3L
        kGVgAzINNQtmWzBA==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: Allowing to reset fail injection
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-2-vincent.donnefort@arm.com>
References: <20210216103506.416286-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161467571285.20312.14821776551824589704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e58422d9789d5c61bb039e40e4e10781d8d43ac3
Gitweb:        https://git.kernel.org/tip/e58422d9789d5c61bb039e40e4e10781d8d43ac3
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:04 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:26 +01:00

cpu/hotplug: Allowing to reset fail injection

Currently, the only way of resetting the fail injection is to trigger a
hotplug, hotunplug or both. This is rather annoying for testing
and, as the default value for this file is -1, it seems pretty natural to
let a user write it.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
