Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2315E3B83DE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhF3NvB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbhF3Nu2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE3C0611FA;
        Wed, 30 Jun 2021 06:47:45 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fS4ytAepcpCvZpy7951mTjnruDx4TSWue2nVJYDoviA=;
        b=l3UIa7VFzghspdNqcUqURyV+fpt3JNc0xrYNZqYcoPaz0kcGeBvGXUPfNk3+uWvek2FaNX
        RDKPQ4nfKiUIxhJ0L2s7jQwBD1dJl9+/BM6x9mae07UszyDSFaim7T8BUx3L09gxhGSP+S
        uRFOEgeLpsWkAffIOoXcjnDUb9/cdzqrbFfPmz4OoEu0tjjsNk+rOAlfw09OfGzAQJqnvU
        mOqKin/NDtcrRzLOzjtsWezTMaKfQNxFAgUuU2weWyvfqJL64PZnP2uOaMJaa5p+/12eHf
        vCIcbGo3BPalAE00DmH5PuHjGcQSOqKYf2ahlxFnP+4pOWIQvtsim918x2LZ/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fS4ytAepcpCvZpy7951mTjnruDx4TSWue2nVJYDoviA=;
        b=drhXWnemVmDAJIwar+BZmr5z/JrJnOoLauDNhq/uABHdnlg2xDpSw9PmifUeHd2nACdeHX
        CMsyLeC/UTq8eUDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Set kvm.sh language to English
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086306.395.8587867830739240977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     00ad25f6019b3bd61bd2ddc128509728b49ac589
Gitweb:        https://git.kernel.org/tip/00ad25f6019b3bd61bd2ddc128509728b49ac589
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 01 Apr 2021 15:26:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:06 -07:00

torture:  Set kvm.sh language to English

Some of the code invoked directly and indirectly from kvm.sh parses
the output of commands.  This parsing assumes English, which can cause
failures if the user has set some other language.  In a few cases,
there are language-independent commands available, but this is not
always the case.  Therefore, as an alternative to polyglot parsing,
this commit sets the LANG environment variable to en_US.UTF-8.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index fab3bd9..390bb97 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -20,6 +20,9 @@ mkdir $T
 
 cd `dirname $scriptname`/../../../../../
 
+# This script knows only English.
+LANG=en_US.UTF-8; export LANG
+
 dur=$((30*60))
 dryrun=""
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
