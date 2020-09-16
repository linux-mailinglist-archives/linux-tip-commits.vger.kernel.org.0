Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F926C745
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgIPSXA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgIPSWz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 14:22:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F770C014DAF;
        Wed, 16 Sep 2020 06:16:44 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:11:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600261878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ob6LRG36H/Mg26kadZ7+igl9R+pR6tqiFceZBDgitf4=;
        b=u3LfCduPssQepsF7IWlVxUprkSTpKWPmYsPqi/iOuj5KRnJMqJd4nVFidjvtevLNfD5G1i
        o4vT+bX/FRK4YsSoYk1oEr008Bgqv8BcjnQ3RqTrXY7MZWXiZ9J1NVGESlIkyL0iANa7kq
        guHhoRF2YeYBdI/mRyi06/WW32dndTPwvBYdjm0woPCjqnOOrXgUoCx8QX9oHw0o6sUUtX
        COVg5OOpUx+sEOWgfV3Su4AWVhQqouWdVTt21L+ipF8BUShOWA0ySsjsMCmj00luLMXLUY
        TEmKApKMLSr1T+q4V3kzhPBjjZPzmxxeyuUBGgPpXZbormj49D7vSVefkucFPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600261878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ob6LRG36H/Mg26kadZ7+igl9R+pR6tqiFceZBDgitf4=;
        b=9YUtZbFkLHkrzAEq94H63OQW2hRaNjna/57eyi3cF7ADzILHTpF05Wa7sP3ZcHOH/MbUwr
        VKp/xSUWl/HHmbDQ==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] Documentation: Add L1D flushing Documentation
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729001103.6450-6-sblbir@amazon.com>
References: <20200729001103.6450-6-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <160026187760.15536.3250026799968833918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     767d46ab566dd489733666efe48732d523c8c332
Gitweb:        https://git.kernel.org/tip/767d46ab566dd489733666efe48732d523c8c332
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Wed, 29 Jul 2020 10:11:03 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 15:08:03 +02:00

Documentation: Add L1D flushing Documentation

Add documentation of l1d flushing, explain the need for the
feature and how it can be used.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200729001103.6450-6-sblbir@amazon.com

---
 Documentation/admin-guide/hw-vuln/index.rst     |  1 +-
 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 70 ++++++++++++++++-
 Documentation/admin-guide/kernel-parameters.txt | 17 ++++-
 Documentation/userspace-api/spec_ctrl.rst       |  8 ++-
 4 files changed, 96 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ca4dbdd..21710f8 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit.rst
    special-register-buffer-data-sampling.rst
+   l1d_flush.rst
diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
new file mode 100644
index 0000000..adc4ecc
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,70 @@
+L1D Flushing
+============
+
+With an increasing number of vulnerabilities being reported around data
+leaks from the Level 1 Data cache (L1D) the kernel provides an opt-in
+mechanism to flush the L1D cache on context switch.
+
+This mechanism can be used to address e.g. CVE-2020-0550. For applications
+the mechanism keeps them safe from vulnerabilities, related to leaks
+(snooping of) from the L1D cache.
+
+
+Related CVEs
+------------
+The following CVEs can be addressed by this
+mechanism
+
+    =============       ========================     ==================
+    CVE-2020-0550       Improper Data Forwarding     OS related aspects
+    =============       ========================     ==================
+
+Usage Guidelines
+----------------
+
+Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst` for
+details.
+
+**NOTE**: The feature is disabled by default, applications need to
+specifically opt into the feature to enable it.
+
+Mitigation
+----------
+
+When PR_SET_L1D_FLUSH is enabled for a task a flush of the L1D cache is
+performed when the task is scheduled out and the incoming task belongs to a
+different process and therefore to a different address space.
+
+If the underlying CPU supports L1D flushing in hardware, the hardware
+mechanism is used, software fallback for the mitigation, is not supported.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+
+The kernel command line allows to control the L1D flush mitigations at boot
+time with the option "l1d_flush_out=". The valid arguments for this option are:
+
+  ============  =============================================================
+  off		Disables the prctl interface, applications trying to use
+                the prctl() will fail with an error
+  ============  =============================================================
+
+By default the API is enabled and applications opt-in by by using the prctl
+API.
+
+Limitations
+-----------
+
+The mechanism does not mitigate L1D data leaks between tasks belonging to
+different processes which are concurrently executing on sibling threads of
+a physical CPU core when SMT is enabled on the system.
+
+This can be addressed by controlled placement of processes on physical CPU
+cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
+document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.
+
+**NOTE** : Checks have been added to ensure that the prctl API associated
+with the opt-in will work only when the task affinity of the task opting
+in, is limited to cores running in non-SMT mode. The same checks are made
+when L1D is flushed.  Changing the affinity after opting in, would result
+in flushes not working on cores that are in non-SMT mode.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a106874..0c3f315 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2295,6 +2295,23 @@
 			feature (tagged TLBs) on capable Intel chips.
 			Default is 1 (enabled)
 
+	l1d_flush_out=	[X86,INTEL]
+			Control mitigation for L1D based snooping vulnerability.
+
+			Certain CPUs are vulnerable to an exploit against CPU
+			internal buffers which can forward information to a
+			disclosure gadget under certain conditions.
+
+			In vulnerable processors, the speculatively
+			forwarded data can be used in a cache side channel
+			attack, to access data to which the attacker does
+			not have direct access.
+
+			This parameter controls the mitigation. The
+			options are:
+
+			off        - Unconditionally disable the mitigation
+
 	l1tf=           [X86] Control mitigation of the L1TF vulnerability on
 			      affected CPUs
 
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 7ddd8f6..f39744e 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -106,3 +106,11 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_SPEC_L1D_FLUSH_OUT: Flush L1D Cache on context switch out of the task
+                        (works only when tasks run on non SMT cores)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_DISABLE, 0, 0);
