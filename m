Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03C343B6BC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbhJZQTB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbhJZQTA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C5C061745;
        Tue, 26 Oct 2021 09:16:36 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FqY6OhZXCTo896z2wznqdPLFuD25xH/sS52xXk8oiM=;
        b=n7mDdrxOoB9dgFCUPPez5yMJEC1wkqzdznBwqaod6VU9SbiB1Wai36KAu7gvcFaVlH9lUr
        A+hWSmismjHvAHiTdHlvFsPPixFDkChzgGODS0w78qOEIhdSFhXHil6vMDbOLdylbOqjel
        qLxYweFidVgKLcRH7HCPYYCLEyGI6mPjngptX3QfFBE3rHCJPbO2ZiB8VCYBSwMdyqA+Nv
        ZZ6inLmPcoWQLOP6oOraNKd11A92elwD0+GYH9apt0KbwLoNhbHhI3ELF2E5CLcBXcz5oN
        XKvLB6rOKdrjIsgizeRKBHE6meyuIWPRoVEw9L3stNkLyOmESE5H1u+UP42wTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6FqY6OhZXCTo896z2wznqdPLFuD25xH/sS52xXk8oiM=;
        b=qkq7yuROSqH3u97rrqnxfX2d9CHocTvNrRUcnnIS+3RhRnSmp0LtVG0BKllf9hAR2LSLcS
        8v/d+bao3x4gMxBw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] Documentation/x86: Add documentation for using dynamic
 XSTATE features
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026091157.16711-1-chang.seok.bae@intel.com>
References: <20211026091157.16711-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499263.626.6925055115989146880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     93175ec299f8418b415da8aabd9cc97506d49ab7
Gitweb:        https://git.kernel.org/tip/93175ec299f8418b415da8aabd9cc97506d49ab7
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 26 Oct 2021 02:11:57 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 11:31:56 +02:00

Documentation/x86: Add documentation for using dynamic XSTATE features

Explain how dynamic XSTATE features can be enabled via the
architecture-specific prctl() along with dynamic sigframe size and
first use trap handling.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211026091157.16711-1-chang.seok.bae@intel.com
---
 Documentation/x86/index.rst  |  1 +-
 Documentation/x86/xstate.rst | 65 +++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/x86/xstate.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 3830483..f498f1d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -37,3 +37,4 @@ x86-specific Documentation
    sgx
    features
    elf_auxvec
+   xstate
diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
new file mode 100644
index 0000000..f6be368
--- /dev/null
+++ b/Documentation/x86/xstate.rst
@@ -0,0 +1,65 @@
+Using XSTATE features in user space applications
+================================================
+
+The x86 architecture supports floating-point extensions which are
+enumerated via CPUID. Applications consult CPUID and use XGETBV to
+evaluate which features have been enabled by the kernel XCR0.
+
+Up to AVX-512 and PKRU states, these features are automatically enabled by
+the kernel if available. Features like AMX TILE_DATA (XSTATE component 18)
+are enabled by XCR0 as well, but the first use of related instruction is
+trapped by the kernel because by default the required large XSTATE buffers
+are not allocated automatically.
+
+Using dynamically enabled XSTATE features in user space applications
+-------------------------------------------------------------------
+
+The kernel provides an arch_prctl(2) based mechanism for applications to
+request the usage of such features. The arch_prctl(2) options related to
+this are:
+
+-ARCH_GET_XCOMP_SUPP
+
+ arch_prctl(ARCH_GET_XCOMP_SUPP, &features);
+
+ ARCH_GET_XCOMP_SUPP stores the supported features in userspace storage of
+ type uint64_t. The second argument is a pointer to that storage.
+
+-ARCH_GET_XCOMP_PERM
+
+ arch_prctl(ARCH_GET_XCOMP_PERM, &features);
+
+ ARCH_GET_XCOMP_PERM stores the features for which the userspace process
+ has permission in userspace storage of type uint64_t. The second argument
+ is a pointer to that storage.
+
+-ARCH_REQ_XCOMP_PERM
+
+ arch_prctl(ARCH_REQ_XCOMP_PERM, feature_nr);
+
+ ARCH_REQ_XCOMP_PERM allows to request permission for a dynamically enabled
+ feature or a feature set. A feature set can be mapped to a facility, e.g.
+ AMX, and can require one or more XSTATE components to be enabled.
+
+ The feature argument is the number of the highest XSTATE component which
+ is required for a facility to work.
+
+When requesting permission for a feature, the kernel checks the
+availability. The kernel ensures that sigaltstacks in the process's tasks
+are large enough to accommodate the resulting large signal frame. It
+enforces this both during ARCH_REQ_XCOMP_SUPP and during any subsequent
+sigaltstack(2) calls. If an installed sigaltstack is smaller than the
+resulting sigframe size, ARCH_REQ_XCOMP_SUPP results in -ENOSUPP. Also,
+sigaltstack(2) results in -ENOMEM if the requested altstack is too small
+for the permitted features.
+
+Permission, when granted, is valid per process. Permissions are inherited
+on fork(2) and cleared on exec(3).
+
+The first use of an instruction related to a dynamically enabled feature is
+trapped by the kernel. The trap handler checks whether the process has
+permission to use the feature. If the process has no permission then the
+kernel sends SIGILL to the application. If the process has permission then
+the handler allocates a larger xstate buffer for the task so the large
+state can be context switched. In the unlikely cases that the allocation
+fails, the kernel sends SIGSEGV.
