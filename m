Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0228827E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgJIGhb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55566 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732002AbgJIGff (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:35 -0400
Date:   Fri, 09 Oct 2020 06:35:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GKrApThDfing+PzCo7HXOwjqkrk11hlRaOMZynbI2Bw=;
        b=MX6EE6EtNdBzapoukz4MglCrLfo2KvJZggKz2w8tPshLnTavpxk3NEGl9tvwEhTbNg/xMk
        yKZKcSFIEaj55XswCS2fSfgxpL3dpaJTswNweVSJ+83rNVTpm5akH33TW0R9w5LApDimQ5
        PaZIW5qapmuQ0C1dvMJ5TOkj6AepLQHcpxPQ1EgGjKkVnPo2vkraC086B9WFyfdKtA7LWl
        2ha3yaWbC2pFMophgGpE4MmT6I/P8gJsZ2YLLZk/8ZDy8dQVVFunSJFDJzgktfrxG53fZE
        HVPf2+fz2s0v02mVgS5iTVFjS1/FoOILeZZQ7QESQt7wPlga91CYzUovLrWaAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GKrApThDfing+PzCo7HXOwjqkrk11hlRaOMZynbI2Bw=;
        b=cgj6yL6v9YjUcM64+FPNok5gJeNXvWzCFK2++/xQc6WngOhb4hUR3QJBroQ7l2QCEfa+Rb
        HudYKQ9s05sPolAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Declare parse-console.sh independence from
 rcutorture
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533314.7002.16716415780347224351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     687d4775db56d24c81b4704056186d6c506de30d
Gitweb:        https://git.kernel.org/tip/687d4775db56d24c81b4704056186d6c506de30d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 30 Jun 2020 13:37:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:31 -07:00

torture: Declare parse-console.sh independence from rcutorture

Currently, parse-torture.sh looks at the fifth field of torture-test
console output for the version number.  This works fine for rcutorture,
but not for scftorture, which lacks the pointer field.  This commit
therefore adjusts matching lines so that the parse-console.sh awk script
always sees the version number as the first field in the lines passed
to it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 71a9f43..4e081a2 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -67,6 +67,7 @@ then
 	grep --binary-files=text 'torture:.*ver:' $file |
 	egrep --binary-files=text -v '\(null\)|rtc: 000000000* ' |
 	sed -e 's/^(initramfs)[^]]*] //' -e 's/^\[[^]]*] //' |
+	sed -e 's/^.*ver: //' |
 	awk '
 	BEGIN	{
 		ver = 0;
@@ -74,13 +75,13 @@ then
 		}
 
 		{
-		if (!badseq && ($5 + 0 != $5 || $5 <= ver)) {
+		if (!badseq && ($1 + 0 != $1 || $1 <= ver)) {
 			badseqno1 = ver;
-			badseqno2 = $5;
+			badseqno2 = $1;
 			badseqnr = NR;
 			badseq = 1;
 		}
-		ver = $5
+		ver = $1
 		}
 
 	END	{
