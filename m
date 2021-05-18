Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02163387B90
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhEROqC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhEROpw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 10:45:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F77C061347;
        Tue, 18 May 2021 07:44:26 -0700 (PDT)
Date:   Tue, 18 May 2021 14:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621349064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJ0BhvIIV0OZDeLOAdh3lBJMLJZABQBLFu/hbvufQos=;
        b=FDSNGnBawEAwTFBxhQcc/rjZ1KQQBgsukMVGi6qd9xFgR1+2ZJdjVwtg6ByOODYkKyAkl7
        PAzyQBIev4n6AD/MgNCUsjakBFE/4f1H6n7Ew3/VY88CGBaCl2OF0yDdeyTCAfggFQL8rm
        bK3K0JCYwyFgWabzVUQSI1rcc4/wfeKCFKUiPpSB8vE5iUgRXPqyLu0v6ckKegLSuKowX9
        yvKhEYqqkx39sx8D0Bc5murL+27/H4XrCbIUFfg6k9lHZ3bC215T4Lr8ZU8w0nhRhSqBIS
        9nKqROiODupy/oAqAIpYEXEHm1MAzpbUO3oCUiCGl3agXfV105dzDHsvaSx0Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621349064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJ0BhvIIV0OZDeLOAdh3lBJMLJZABQBLFu/hbvufQos=;
        b=WV/ZFUppueWSPvA2q1BDn1BLaxtAXuFCoWIyj2OLbw77BicoCqjN3cQJVZhpoAW4lGJ/0S
        t0smMjAapXbg28Bw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] Documentation/x86: Add buslock.rst
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210419214958.4035512-2-fenghua.yu@intel.com>
References: <20210419214958.4035512-2-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <162134906278.29796.13820849234959966822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     1897907cca5aa22cdfcdb7fb8f0644a6add0877d
Gitweb:        https://git.kernel.org/tip/1897907cca5aa22cdfcdb7fb8f0644a6add0877d
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 19 Apr 2021 21:49:55 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 May 2021 16:39:31 +02:00

Documentation/x86: Add buslock.rst

Add buslock.rst to explain bus lock problem and how to detect and
handle it.

[ tglx: Included it into index.rst and added the missing include ... ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210419214958.4035512-2-fenghua.yu@intel.com

---
 Documentation/x86/buslock.rst | 104 +++++++++++++++++++++++++++++++++-
 Documentation/x86/index.rst   |   1 +-
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/x86/buslock.rst

diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
new file mode 100644
index 0000000..159ff6b
--- /dev/null
+++ b/Documentation/x86/buslock.rst
@@ -0,0 +1,104 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+===============================
+Bus lock detection and handling
+===============================
+
+:Copyright: |copy| 2021 Intel Corporation
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Tony Luck <tony.luck@intel.com>
+
+Problem
+=======
+
+A split lock is any atomic operation whose operand crosses two cache lines.
+Since the operand spans two cache lines and the operation must be atomic,
+the system locks the bus while the CPU accesses the two cache lines.
+
+A bus lock is acquired through either split locked access to writeback (WB)
+memory or any locked access to non-WB memory. This is typically thousands of
+cycles slower than an atomic operation within a cache line. It also disrupts
+performance on other cores and brings the whole system to its knees.
+
+Detection
+=========
+
+Intel processors may support either or both of the following hardware
+mechanisms to detect split locks and bus locks.
+
+#AC exception for split lock detection
+--------------------------------------
+
+Beginning with the Tremont Atom CPU split lock operations may raise an
+Alignment Check (#AC) exception when a split lock operation is attemped.
+
+#DB exception for bus lock detection
+------------------------------------
+
+Some CPUs have the ability to notify the kernel by an #DB trap after a user
+instruction acquires a bus lock and is executed. This allows the kernel to
+terminate the application or to enforce throttling.
+
+Software handling
+=================
+
+The kernel #AC and #DB handlers handle bus lock based on the kernel
+parameter "split_lock_detect". Here is a summary of different options:
+
++------------------+----------------------------+-----------------------+
+|split_lock_detect=|#AC for split lock		|#DB for bus lock	|
++------------------+----------------------------+-----------------------+
+|off	  	   |Do nothing			|Do nothing		|
++------------------+----------------------------+-----------------------+
+|warn		   |Kernel OOPs			|Warn once per task and |
+|(default)	   |Warn once per task and	|and continues to run.  |
+|		   |disable future checking	|			|
+|		   |When both features are	|			|
+|		   |supported, warn in #AC	|			|
++------------------+----------------------------+-----------------------+
+|fatal		   |Kernel OOPs			|Send SIGBUS to user.	|
+|		   |Send SIGBUS to user		|			|
+|		   |When both features are	|			|
+|		   |supported, fatal in #AC	|			|
++------------------+----------------------------+-----------------------+
+
+Usages
+======
+
+Detecting and handling bus lock may find usages in various areas:
+
+It is critical for real time system designers who build consolidated real
+time systems. These systems run hard real time code on some cores and run
+"untrusted" user processes on other cores. The hard real time cannot afford
+to have any bus lock from the untrusted processes to hurt real time
+performance. To date the designers have been unable to deploy these
+solutions as they have no way to prevent the "untrusted" user code from
+generating split lock and bus lock to block the hard real time code to
+access memory during bus locking.
+
+It's also useful for general computing to prevent guests or user
+applications from slowing down the overall system by executing instructions
+with bus lock.
+
+
+Guidance
+========
+off
+---
+
+Disable checking for split lock and bus lock. This option can be useful if
+there are legacy applications that trigger these events at a low rate so
+that mitigation is not needed.
+
+warn
+----
+
+A warning is emitted when a bus lock is detected which allows to identify
+the offending application. This is the default behavior.
+
+fatal
+-----
+
+In this case, the bus lock is not tolerated and the process is killed.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4693e19..0004f5d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -29,6 +29,7 @@ x86-specific Documentation
    microcode
    resctrl
    tsx_async_abort
+   buslock
    usb-legacy-support
    i386/index
    x86_64/index
