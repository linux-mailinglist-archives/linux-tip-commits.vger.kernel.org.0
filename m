Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43679319EA6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhBLMjp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhBLMia (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:30 -0500
Date:   Fri, 12 Feb 2021 12:37:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/VxtpuwnvaNTvJkVnn5Ma6UNy9In9RdZgzgwgnX5gz4=;
        b=iHDvFYXaklVCbWxxfm/fr6YNWsOIAvZ7HGhVZ6MVYDuR2YtvTpa9KB2rPVyDN4xxm9qLw7
        w+Tu0MTRbFeAogjpISxJYaNKwh65jPwaqBC7yqKbvkagXfPYV6RQmsLDw66nOziS5KW6bJ
        e5hpI7QhJSEwCLELuZ+V468oG9XcAX+mxHOWXtZ/xzt91macgKJFGiiGNNU1eHPGu1RAyW
        mO6IZplTXnZnJ9hCPLd9TCPF/Qu3MytAJ1vHgJyHlwtOS4MjHDZDc9bkRjA6d2AlR7Tyn2
        RNy15w68+y7ezvAM/eAl8fULoHdQfJmlHpAUzlBMc+TdkNkBw2hAQ7oU+Za2Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/VxtpuwnvaNTvJkVnn5Ma6UNy9In9RdZgzgwgnX5gz4=;
        b=VVP6dqhG6qkOYLhcuhSYRrdMbXUGdTOZXz4NM3mBXY3TcDpt+IW2daiuRXmeGodUfRyQ+Q
        LGv6E6rqAAPETKAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture.sh rcuscale and refscale deal
 with allmodconfig
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343353.23325.11008300364151660207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7a99487c76aad613b7533e3ea1b8d3eaf30ca37e
Gitweb:        https://git.kernel.org/tip/7a99487c76aad613b7533e3ea1b8d3eaf30ca37e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Nov 2020 18:57:47 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:42 -08:00

torture: Make torture.sh rcuscale and refscale deal with allmodconfig

The .mod.c files created by allmodconfig builds interfers with the approach
torture.sh uses to enumerate types of rcuscale and refscale runs.  This
commit therefore tightens the pattern matching to avoid this interference.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 8e66797..a89b521 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -302,7 +302,7 @@ fi
 
 if test "$do_refscale" = yes
 then
-	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
 else
 	primlist=
 fi
@@ -314,7 +314,7 @@ done
 
 if test "$do_rcuscale" = yes
 then
-	primlist="`grep '\.name[ 	]*=' kernel/rcu/rcuscale*.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
+	primlist="`grep '\.name[ 	]*=' kernel/rcu/rcuscale.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
 else
 	primlist=
 fi
