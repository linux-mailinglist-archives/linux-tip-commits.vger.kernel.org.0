Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90863D8B3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhG1J6N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhG1J6M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87B6C061760;
        Wed, 28 Jul 2021 02:58:10 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3D3Wq6f+1h8GAcu6Go8jesmCXdD7EA6hWsHQa/wQl4=;
        b=HNd1AzN3uVLp0Ri7aJxi969/TKut/05Ed1eigXiVqkgtQhJz7JUjoz2PdwqqgYeD5ESemp
        3iz2y06/l56MVH+d+foYj9FQXPNqvOQSIrFpOzrsBnK3BJQx5VZHgrG304SKM9PVn+ZeR5
        rsFgE9Z8Xy3nPDfJme57KxT926DCUb5Srk9ssUthdbVmLPyaGDJFCeOIB0Nb9eUcCpbPjx
        vCTLEUz1roy7wpHgDiJVtPNoxvr194t7V8PMsJCK4K3O4vHYe09fcdfWLEwBbYbqY/xUYV
        d/ZvPBjBVaoyUXYY6mtJvf34uxiU+5gmMI3qdS09NUZaCVUqEdAzHgYbQRaABw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3D3Wq6f+1h8GAcu6Go8jesmCXdD7EA6hWsHQa/wQl4=;
        b=yE6bgyWWNDfZuD+U4/lU3MXxfUMxXuNFsdCSJeuvFlpG5rcIfPu1U7+m0NSzSmrRbxbwhz
        V/4vEieciPqAKbCw==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] Documentation: Add L1D flushing Documentation
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-6-sblbir@amazon.com>
References: <20210108121056.21940-6-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746628606.395.639236158997555984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b7fe54f6c2d437082dcbecfbd832f38edd9caaf4
Gitweb:        https://git.kernel.org/tip/b7fe54f6c2d437082dcbecfbd832f38edd9caaf4
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Fri, 08 Jan 2021 23:10:56 +11:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:25 +02:00

Documentation: Add L1D flushing Documentation

Add documentation of l1d flushing, explain the need for the
feature and how it can be used.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-6-sblbir@amazon.com
---
 Documentation/admin-guide/hw-vuln/index.rst     |  1 +-
 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 69 ++++++++++++++++-
 Documentation/admin-guide/kernel-parameters.txt | 17 ++++-
 Documentation/userspace-api/spec_ctrl.rst       |  8 ++-
 4 files changed, 95 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index f12cda5..8cbc711 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -16,3 +16,4 @@ are configurable at compile, boot or run time.
    multihit.rst
    special-register-buffer-data-sampling.rst
    core-scheduling.rst
+   l1d_flush.rst
diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
new file mode 100644
index 0000000..210020b
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,69 @@
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
+Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst
+<set_spec_ctrl>` for details.
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
+time with the option "l1d_flush=". The valid arguments for this option are:
+
+  ============  =============================================================
+  on            Enables the prctl interface, applications trying to use
+                the prctl() will fail with an error if l1d_flush is not
+                enabled
+  ============  =============================================================
+
+By default the mechanism is disabled.
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
+**NOTE** : The opt-in of a task for L1D flushing works only when the task's
+affinity is limited to cores running in non-SMT mode. If a task which
+requested L1D flushing is scheduled on a SMT-enabled core the kernel sends
+a SIGBUS to the task.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdb2200..b105db2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2421,6 +2421,23 @@
 			feature (tagged TLBs) on capable Intel chips.
 			Default is 1 (enabled)
 
+	l1d_flush=	[X86,INTEL]
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
+			on         - enable the interface for the mitigation
+
 	l1tf=           [X86] Control mitigation of the L1TF vulnerability on
 			      affected CPUs
 
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 7ddd8f6..5e8ed9e 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -106,3 +106,11 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_SPEC_L1D_FLUSH: Flush L1D Cache on context switch out of the task
+                        (works only when tasks run on non SMT cores)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE, 0, 0);
