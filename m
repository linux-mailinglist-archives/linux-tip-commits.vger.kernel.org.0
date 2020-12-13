Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1632D8F98
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgLMTCQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46786 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgLMTB5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:57 -0500
Date:   Sun, 13 Dec 2020 19:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tu/lpyqUbx078+NfjLtnVKwouAvB7CcpJ7rQ3smweaY=;
        b=lOV8Q0CCx4U46viUhK9gzDquWG0IcdFsyToDIpXbhbHwCk1+GEzc7TSe+ii4ThXtQc9aGO
        47OLCbSiXREj7JELxjTSzZaFV6hS2pTGgyGBCYMbz7L8snRT4g5jhnoFh3V2uTBKpPQzyQ
        bU4fUmNBAhkXIDCz3TcPT8wezVWjp4/bS8r4HywfVUxJ6CnznGVYcID0HMnSm31TuvU0Zb
        MCB1I1i+A2oyz1emGl3mt7vL+hz6d/PjnX3qlwkHRV1jjppduh950jJuJpJLQvBIvBGXaY
        mFBDmX6XSz9+Wa9rLfLWFGxAn2cykAyx7TD8WaZ9baFDbO8/B/QumEG/PJK/bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tu/lpyqUbx078+NfjLtnVKwouAvB7CcpJ7rQ3smweaY=;
        b=Oqoq9xRYSMXgogc/kZR2ftg0bES7OPglrFBjP077MUqGbBCY2d9GskBooYC7zlXJtg4dUI
        ZqhRKX9Ik9SqeOCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Don't kill gdb sessions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607236.3364.16622909570052896147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     08c7974293851da6a64989b5ce7a0750e58178b1
Gitweb:        https://git.kernel.org/tip/08c7974293851da6a64989b5ce7a0750e58178b1
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 28 Aug 2020 06:46:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:13:30 -08:00

torture: Don't kill gdb sessions

The rcutorture scripting will do a "kill -9" on any guest OS that exceeds
its --duration by more than a few minutes, which is very valuable when
bugs result in hangs.  However, this is a problem when the "hang" was due
to a --gdb debugging session.

This commit therefore refrains from killing the guest OS when a debugging
session is in progress.  This means that the user must manually kill the
kvm.sh process group if a hang really does occur.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6dc2b49..d04966a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -206,7 +206,10 @@ do
 	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
-		if test $kruntime -ge $seconds -o -f "$TORTURE_STOPFILE"
+		if test -n "$TORTURE_KCONFIG_GDB_ARG"
+		then
+			:
+		elif test $kruntime -ge $seconds || test -f "$TORTURE_STOPFILE"
 		then
 			break;
 		fi
