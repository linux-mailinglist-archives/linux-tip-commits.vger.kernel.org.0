Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2641F061
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354852AbhJAPH0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354827AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904CCC0613E4;
        Fri,  1 Oct 2021 08:05:36 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1GcB3oG9NqGusbKrUGSQKD+G28ahqfAw2Cr3bjhI4c=;
        b=P4K+BKZmhTT0xvPgfsd3Z9ZDhkFi4OLyEt/9GdJlW11TycgioK6lk2rEAqmZz/Rp56kHtf
        vXR8KAgiCenUqeeAz6lFoBsIpBw5r4KbpfrdClS9/S5G+6p5iSOatzxb/TDdYKYrfJ9gYD
        ga22olwceMUWEdhAIV1ixM6KYiDtH5D+SsqNm5+LCe1HFzMO0OIsMBeWOB1N3XZPyEcZVX
        gei+GVc3piXAtHweXJmYqunZ7ZZSL79nVxmY4cipClo33d0vWQnpjk+fKA5+knCmLoeOyB
        qrBgXeqwXl2G1EtxoAPCcvE4c/BeTevuHCwJHBe0aZooLMovtdDuhblRJIxbCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1GcB3oG9NqGusbKrUGSQKD+G28ahqfAw2Cr3bjhI4c=;
        b=utpQs1RaCqB5hiE0ithLxDCWNPo5IxUUSczskoOGqBbaoZbjavf6/fb8FzNf1vLBHU0jui
        N580p1F9U0HYPIBw==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww-mutex: Fix uninitialized use of ret in
 test_aa()
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210922145822.3935141-1-nathan@kernel.org>
References: <20210922145822.3935141-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <163310073387.25758.2474180500160006249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1415b49bcd321bca7347f43f8b269c91ec46d1dc
Gitweb:        https://git.kernel.org/tip/1415b49bcd321bca7347f43f8b269c91ec46d1dc
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 22 Sep 2021 07:58:22 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:49 +02:00

locking/ww-mutex: Fix uninitialized use of ret in test_aa()

Clang warns:

kernel/locking/test-ww_mutex.c:138:7: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
                if (!ww_mutex_trylock(&mutex, &ctx)) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/locking/test-ww_mutex.c:172:9: note: uninitialized use occurs here
        return ret;
               ^~~
kernel/locking/test-ww_mutex.c:138:3: note: remove the 'if' if its condition is always false
                if (!ww_mutex_trylock(&mutex, &ctx)) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/locking/test-ww_mutex.c:125:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

Assign !ww_mutex_trylock(...) to ret so that it is always initialized.

Fixes: 12235da8c80a ("kernel/locking: Add context to ww_mutex_trylock()")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20210922145822.3935141-1-nathan@kernel.org
---
 kernel/locking/test-ww_mutex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index d63ac41..3530041 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -135,7 +135,8 @@ static int test_aa(bool trylock)
 			goto out;
 		}
 	} else {
-		if (!ww_mutex_trylock(&mutex, &ctx)) {
+		ret = !ww_mutex_trylock(&mutex, &ctx);
+		if (ret) {
 			pr_err("%s: initial trylock failed!\n", __func__);
 			goto out;
 		}
