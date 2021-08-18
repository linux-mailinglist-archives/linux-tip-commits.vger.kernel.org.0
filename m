Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705133EFE6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhHRH7X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbhHRH7S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B9DC061796;
        Wed, 18 Aug 2021 00:58:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zXWioSLCjnctU1dBqjs/QZXhgtTwGGSu8JpOI8mzJro=;
        b=FCHcGGkFi+uu3OMQE7EoyCe2w2CV+4iMN85tZRo2DOFSB8yF5YFuT+zQCDncrNeZKIj8lg
        4KdvFvqHoybay1z50MwF/60PwE+p/MfWhiNTpmfOEme+GMso4PZmOIe1CYtOhpq5ukBi3M
        LExnbJhqYlId2Adyo1j9gnd+lP8aEEW2rGEGdbCHRVponbyRF1Du4VOfzfCSWumHdDIL7G
        HjzeiomYi56lgKUNClJL/wvpqacPHshpFeAyY9xJAWyZCD8FH9WfOq6nxbfpJKhsY7IjLQ
        L0bVrEN/X45Bxsykp/5GQI8rvk3dsN1o54ythjwWYMf/NUrWmYw8QZ0/BjS44w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zXWioSLCjnctU1dBqjs/QZXhgtTwGGSu8JpOI8mzJro=;
        b=Ywx82gPPweN1g+wvUMqHWI/ghafvzWS8gtrkToKqf6o2arg0LJutiJyoGGIfqxFmLqAQn7
        7tObNjki8IVI/UBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] tools/memory-model: Make read_foo_diagnostic()
 more clearly diagnostic
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927352167.25758.12237136355668920471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     1846a7fa767fbf8cf42d71daf75d51e30e3c8327
Gitweb:        https://git.kernel.org/tip/1846a7fa767fbf8cf42d71daf75d51e30e3c8327
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 13 May 2021 11:17:02 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 20 Jul 2021 13:52:03 -07:00

tools/memory-model: Make read_foo_diagnostic() more clearly diagnostic

The current definition of read_foo_diagnostic() in the "Lock Protection
With Lockless Diagnostic Access" section returns a value, which could
be use for any purpose.  This could mislead people into incorrectly
using data_race() in cases where READ_ONCE() is required.  This commit
therefore makes read_foo_diagnostic() simply print the value read.

Reported-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 1ab189f..58bff26 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -259,9 +259,9 @@ diagnostic purposes.  The code might look as follows:
 		return ret;
 	}
 
-	int read_foo_diagnostic(void)
+	void read_foo_diagnostic(void)
 	{
-		return data_race(foo);
+		pr_info("Current value of foo: %d\n", data_race(foo));
 	}
 
 The reader-writer lock prevents the compiler from introducing concurrency
