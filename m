Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941AA35B4E7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhDKNoX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HC4wC4wIkhlW2L9XgKw+jxVlXS7mq16LCQN1e2+uU44=;
        b=AiDxXUjeViLnXJt42hyS6MtecnqItsmlHarm1oNTdKx3cdyW3uSpfqfKGb80eXcoKt69am
        0hXo7/Bgp6Suuzg24TRMWSjHzchzlB83Vx5j3UO7EwrINL+txZpQvF3y4Wxp4zCHFK1GG4
        DaUqFppSy2PXK+eFchKdAnLjjtEtQoFN5sLOtFar80MbU8unS1IyaIJmvGceEFl9jESWBT
        KWGmJK77HtCFQ3OX88IQiZvMLeW0XETh7njbfcSdzDCoMHQvzsnNjTwUYMmDg7W8wPxgoB
        M7ivxhD7Lz7RnCOB2x4KwP3P6VKtvmky6Vghpj8Yiy6p2utaRRVAE+gwoBZfPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HC4wC4wIkhlW2L9XgKw+jxVlXS7mq16LCQN1e2+uU44=;
        b=Y5eBsqiI0Lpi9xw0Z7yl7kH6LmjEPn3QKkb7o/hgnlTIXf0pTFD7nj8WFzAd1qpcMHMVb1
        d/EdepDxWtAI5OCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow 1G of memory for torture.sh kvfree testing
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861221.29796.939856109875902261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3d4977b68101b38c3f9d3be3d89e17ef1fdfc1d3
Gitweb:        https://git.kernel.org/tip/3d4977b68101b38c3f9d3be3d89e17ef1fdfc1d3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 Jan 2021 16:38:19 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Allow 1G of memory for torture.sh kvfree testing

Yes, I do recall a time when 512MB of memory was a lot of mass storage,
much less main memory, but the rcuscale kvfree_rcu() testing invoked by
torture.sh can sometimes exceed it on large systems, resulting in OOM.
This commit therefore causes torture.sh to pase the "--memory 1G"
argument to kvm.sh to reserve a full gigabyte for this purpose.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index ad7525b..56e2e1a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -374,7 +374,7 @@ done
 if test "$do_kvfree" = "yes"
 then
 	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 1G --trust-make
 fi
 
 echo " --- " $scriptname $args
