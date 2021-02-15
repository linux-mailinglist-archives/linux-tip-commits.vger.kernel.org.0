Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEBC31BB80
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBOO40 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBOO4Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84ABC0613D6;
        Mon, 15 Feb 2021 06:55:43 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YwylC7H9y2dHbUKW3sryi8KSUnemkleFDQwMzzrV3qw=;
        b=Fhjub7ykWl/SPI4quqKU/xfImfBHtnNK2HcRMGticCoWLbHJu2fPc12IWgH452wftzCM1O
        cYGqxzeVYjKPtbQFnoibni7wbOIXvVrt/gpgyML9AZPOav7WF+8hyVmiewmFSOEsgWD6JM
        HLe3F7wMi/E8IPI1WJjTY/jTt3xWLvKWbouVAMk7GeXn6u7QLPdAKjq2hFZVLM47n5fa6f
        9YueY+U5DEKZzVmkXaAVnksWb5PlBJ36qN0AK5SSVASoV/Okw+09e4+LrVrsNoPM/Gx4WO
        VROvqwq14QHBIpepfKGI5WPjoYPq8EZf1+d2O1YVF2pbGF7yToS1P5eXSddwjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YwylC7H9y2dHbUKW3sryi8KSUnemkleFDQwMzzrV3qw=;
        b=OYvvasKkQ+dGVO09WoOGd5zWVPQipkZCcqJ+DX1G+AkwNXCt/kvvSE6DiYCgSzO4MKvigu
        Xe4JTQVITXvPjwCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm.sh "--dryrun sched" summarize
 number of batches
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094117.20312.12013223493780764290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1f947be7f9696fca36e67f0897bc239b4755ae55
Gitweb:        https://git.kernel.org/tip/1f947be7f9696fca36e67f0897bc239b4755ae55
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 08 Nov 2020 15:38:26 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:18 -08:00

torture: Make kvm.sh "--dryrun sched" summarize number of batches

Knowing the number of batches that kvm.sh will split a run into allows
estimation of the duration of a test, give or take the number of builds.
This commit therefore adds a line of output to "--dryrun sched" that
gives the number of batches that will be run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index bd07df7..1078be1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -536,6 +536,8 @@ then
 	egrep 'Start batch|Starting build\.' $T/script |
 		grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
+	nbatches="`grep 'Start batch' $T/script | grep -v ">>" | wc -l`"
+	echo Total number of batches: $nbatches
 	exit 0
 else
 	# Not a dryrun, so run the script.
