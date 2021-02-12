Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D92319EA9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBLMj7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhBLMib (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:31 -0500
Date:   Fri, 12 Feb 2021 12:37:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LQaYlpZvQGAG2s1Mp0VkEoVN5SvRJ9wJ0W9mmHf1fYs=;
        b=orC9clBCbUJwu5pcuxQ4H15UIXzof4bQw1AylPAxX6JQkOL/zLHV5TXi9pOeet9m//I2sj
        iD7yR/kauKByZZqW15xQEJs1c3suY01JYFtltoRrDVr6HY9ftY8tr6O+F4q04C9zyYFaMT
        WkIJBqQODFrHiJPsH96CaYkB3ymcgkyS/jkFUnviQaYiQFjypxiaeV/17q15te4f5VMgR+
        LKiz0TkYbwNC6GMd5yrW/nIhxwrDWihLWO+sArW7Sv5hEJXZJLmT28Gk9monZ92rQDxxYJ
        awEM7SVHUe+Zidd74S5sbzn4PGXhmBoWn4sSWKGvLfv5qNyRXVFzVa7lTsqTIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LQaYlpZvQGAG2s1Mp0VkEoVN5SvRJ9wJ0W9mmHf1fYs=;
        b=zCahXckz20G9x+hp7B4urQvwzHBs49T4r6oQsvJhuiEr7BcAY9xqB6V0I5p0YhgVkEGkTn
        JFRQLxz29ow1NbBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Enable torture.sh argument checking
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343377.23325.18439431830904983448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     532017b11950a7042d130477747cced4b7e44199
Gitweb:        https://git.kernel.org/tip/532017b11950a7042d130477747cced4b7e44199
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Nov 2020 16:28:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:41 -08:00

torture: Enable torture.sh argument checking

This commit uncomments the argument checking for the --duration argument
to torture.sh.  While in the area, it also corrects the duration units
from seconds to minutes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e13dacf..8e66797 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -157,17 +157,17 @@ do
 		fi
 		;;
 	--duration)
-		# checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
-		mult=60
-		if echo "$2" | grep -q 's$'
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(m\|h\|d\|\)$' '^error'
+		mult=1
+		if echo "$2" | grep -q 'm$'
 		then
 			mult=1
 		elif echo "$2" | grep -q 'h$'
 		then
-			mult=3600
+			mult=60
 		elif echo "$2" | grep -q 'd$'
 		then
-			mult=86400
+			mult=1440
 		fi
 		ts=`echo $2 | sed -e 's/[smhd]$//'`
 		duration_base=$(($ts*mult))
