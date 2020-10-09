Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB692882BC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgJIGja (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbgJIGfR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:17 -0400
Date:   Fri, 09 Oct 2020 06:35:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hktCKB57NMny/ZVJn+IYMffH5neAZJJaTKA0jK9ks0=;
        b=qRHtI4le2EZ5Lxyl+W5I5LkzfuYm3D2Z5OoEhlxs4r5/BbAChL314OodDR9WsX64FhRkFd
        JttKtl2h8CZayNCxH5qyC650i/wmOQjuh+By5Gnnj0UdV8hFGyc11di0cXvKLx50nJbsh+
        WJt/0RZNIBW1yOry5nhcScJypcopWfOpcT5LjQGHSlO3avYVE3l0QHyQK71I6Hxts+yRBZ
        h3MjWWKBvQUAzvD6zYxcd6Omuf/2HRtkEdCEK/N0pAwpccRFPlK3C6liD5gjxwiOuCwt2A
        X2TSEFaKQiHSmX041LE9K9QgF4YDdLjOUkZpcvN4fGjJqXp8oPWamV5cAChQQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hktCKB57NMny/ZVJn+IYMffH5neAZJJaTKA0jK9ks0=;
        b=OEXLP7n/9etFVMQVeH7I6mn31hzCjFw41xq9idqMFHqLalyU2+86I3dooeUDMgYKNDELvM
        m+v0p9xHm8JTCiBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Update initrd documentation
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531439.7002.12486379852581633282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     33595581f53011d1f0ba64a9a2f76d6fa5528f7f
Gitweb:        https://git.kernel.org/tip/33595581f53011d1f0ba64a9a2f76d6fa5528f7f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 13 Jul 2020 14:18:33 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:33 -07:00

torture: Update initrd documentation

The rcu-test-image.txt documentation covers a very uncommon case where
a real userspace environment is required.  However, someone reading this
document might reasonably conclude that this is in fact a prerequisite.
In addition, the initrd.txt file mentions dracut, which is no longer used.
This commit therefore provides the needed updates.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/doc/initrd.txt         | 36 +------
 tools/testing/selftests/rcutorture/doc/rcu-test-image.txt | 35 ++++++-
 2 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/doc/initrd.txt b/tools/testing/selftests/rcutorture/doc/initrd.txt
index 933b4fd..41a4255 100644
--- a/tools/testing/selftests/rcutorture/doc/initrd.txt
+++ b/tools/testing/selftests/rcutorture/doc/initrd.txt
@@ -1,12 +1,11 @@
-The rcutorture scripting tools automatically create the needed initrd
-directory using dracut.  Failing that, this tool will create an initrd
-containing a single statically linked binary named "init" that loops
-over a very long sleep() call.  In both cases, this creation is done
-by tools/testing/selftests/rcutorture/bin/mkinitrd.sh.
+The rcutorture scripting tools automatically create an initrd containing
+a single statically linked binary named "init" that loops over a
+very long sleep() call.  In both cases, this creation is done by
+tools/testing/selftests/rcutorture/bin/mkinitrd.sh.
 
-However, if you are attempting to run rcutorture on a system that does
-not have dracut installed, and if you don't like the notion of static
-linking, you might wish to press an existing initrd into service:
+However, if you don't like the notion of statically linked bare-bones
+userspace environments, you might wish to press an existing initrd
+into service:
 
 ------------------------------------------------------------------------
 cd tools/testing/selftests/rcutorture
@@ -15,24 +14,3 @@ mkdir initrd
 cd initrd
 cpio -id < /tmp/initrd.img.zcat
 # Manually verify that initrd contains needed binaries and libraries.
-------------------------------------------------------------------------
-
-Interestingly enough, if you are running rcutorture, you don't really
-need userspace in many cases.  Running without userspace has the
-advantage of allowing you to test your kernel independently of the
-distro in place, the root-filesystem layout, and so on.  To make this
-happen, put the following script in the initrd's tree's "/init" file,
-with 0755 mode.
-
-------------------------------------------------------------------------
-#!/bin/sh
-
-while :
-do
-	sleep 10
-done
-------------------------------------------------------------------------
-
-This approach also allows most of the binaries and libraries in the
-initrd filesystem to be dispensed with, which can save significant
-space in rcutorture's "res" directory.
diff --git a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
index cc280ba..b2fc247 100644
--- a/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
+++ b/tools/testing/selftests/rcutorture/doc/rcu-test-image.txt
@@ -1,8 +1,33 @@
-This document describes one way to create the rcu-test-image file
-that contains the filesystem used by the guest-OS kernel.  There are
-probably much better ways of doing this, and this filesystem could no
-doubt be smaller.  It is probably also possible to simply download
-an appropriate image from any number of places.
+Normally, a minimal initrd is created automatically by the rcutorture
+scripting.  But minimal really does mean "minimal", namely just a single
+root directory with a single statically linked executable named "init":
+
+$ size tools/testing/selftests/rcutorture/initrd/init
+   text    data     bss     dec     hex filename
+    328       0       8     336     150 tools/testing/selftests/rcutorture/initrd/init
+
+Suppose you need to run some scripts, perhaps to monitor or control
+some aspect of the rcutorture testing.  This will require a more fully
+filled-out userspace, perhaps containing libraries, executables for
+the shell and other utilities, and soforth.  In that case, place your
+desired filesystem here:
+
+	tools/testing/selftests/rcutorture/initrd
+
+For example, your tools/testing/selftests/rcutorture/initrd/init might
+be a script that does any needed mount operations and starts whatever
+scripts need starting to properly monitor or control your testing.
+The next rcutorture build will then incorporate this filesystem into
+the kernel image that is passed to qemu.
+
+Or maybe you need a real root filesystem for some reason, in which case
+please read on!
+
+The remainder of this document describes one way to create the
+rcu-test-image file that contains the filesystem used by the guest-OS
+kernel.  There are probably much better ways of doing this, and this
+filesystem could no doubt be smaller.  It is probably also possible to
+simply download an appropriate image from any number of places.
 
 That said, here are the commands:
 
