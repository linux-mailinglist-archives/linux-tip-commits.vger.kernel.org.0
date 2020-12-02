Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3E2CBF43
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgLBOMv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbgLBOMp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 09:12:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73091C0617A7;
        Wed,  2 Dec 2020 06:12:05 -0800 (PST)
Date:   Wed, 02 Dec 2020 14:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tbsIkaop7pC3knwQHnfKKRvpwep8cfxUJSf6Cdw0tk=;
        b=lFfp2jKX1rB5lpRqPSMD19kk2fh7h1cpy+C1EQ5tuBNY1xyLBjETRRADd7pgr5sYs8Rb/n
        cIOM5oaoiSPdCB3Mo3PfNQ8oOKuLhi/8mKhmGyBTTizL9r+Fl7Z3MYoWiAjwzOxm+Fp9ku
        UrH0PyQrcUi9n6og2WpNcKRIAALdOzs/PYqIfhN4M7sNULoVVkve6sY+foZTVIIKdUMdS0
        iKTpElTaj9uluuhV67PXvavs3fxZjG2sYrbf6MklyE/3iP00ikJzMLCyHZD4iMD9EbpDit
        VixTTDxk+kAi2j9DArrvnxLEhNEEtxVK1QhNP7tOWg0MWw4Cmqw5hRkGwPwL6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tbsIkaop7pC3knwQHnfKKRvpwep8cfxUJSf6Cdw0tk=;
        b=TFDaEhSDc2qFFVaM5ru5xcyj+vQ3KcYSGGhtkdjf9eXt+OQbp+K7h9zU19JVLGE+IFZA7c
        062pc6LenWdfnHBw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] docs: Document Syscall User Dispatch
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127193238.821364-8-krisman@collabora.com>
References: <20201127193238.821364-8-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160691832261.3364.17061203625721748275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     a4452e671c6770e1bb80764f39995934067f70a0
Gitweb:        https://git.kernel.org/tip/a4452e671c6770e1bb80764f39995934067f70a0
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 27 Nov 2020 14:32:38 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 15:07:57 +01:00

docs: Document Syscall User Dispatch

Explain the interface, provide some background and security notes.

[ tglx: Add note about non-visibility, add it to the index and fix the
  	kerneldoc warning ] 

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201127193238.821364-8-krisman@collabora.com
---
 Documentation/admin-guide/index.rst                 |  1 +-
 Documentation/admin-guide/syscall-user-dispatch.rst | 90 ++++++++++++-
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 4e0c4ae..b29d3c1 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -111,6 +111,7 @@ configure specific aspects of kernel behavior to your liking.
    rtc
    serial-console
    svga
+   syscall-user-dispatch
    sysrq
    thunderbolt
    ufs
diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
new file mode 100644
index 0000000..a380d65
--- /dev/null
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Syscall User Dispatch
+=====================
+
+Background
+----------
+
+Compatibility layers like Wine need a way to efficiently emulate system
+calls of only a part of their process - the part that has the
+incompatible code - while being able to execute native syscalls without
+a high performance penalty on the native part of the process.  Seccomp
+falls short on this task, since it has limited support to efficiently
+filter syscalls based on memory regions, and it doesn't support removing
+filters.  Therefore a new mechanism is necessary.
+
+Syscall User Dispatch brings the filtering of the syscall dispatcher
+address back to userspace.  The application is in control of a flip
+switch, indicating the current personality of the process.  A
+multiple-personality application can then flip the switch without
+invoking the kernel, when crossing the compatibility layer API
+boundaries, to enable/disable the syscall redirection and execute
+syscalls directly (disabled) or send them to be emulated in userspace
+through a SIGSYS.
+
+The goal of this design is to provide very quick compatibility layer
+boundary crosses, which is achieved by not executing a syscall to change
+personality every time the compatibility layer executes.  Instead, a
+userspace memory region exposed to the kernel indicates the current
+personality, and the application simply modifies that variable to
+configure the mechanism.
+
+There is a relatively high cost associated with handling signals on most
+architectures, like x86, but at least for Wine, syscalls issued by
+native Windows code are currently not known to be a performance problem,
+since they are quite rare, at least for modern gaming applications.
+
+Since this mechanism is designed to capture syscalls issued by
+non-native applications, it must function on syscalls whose invocation
+ABI is completely unexpected to Linux.  Syscall User Dispatch, therefore
+doesn't rely on any of the syscall ABI to make the filtering.  It uses
+only the syscall dispatcher address and the userspace key.
+
+As the ABI of these intercepted syscalls is unknown to Linux, these
+syscalls are not instrumentable via ptrace or the syscall tracepoints.
+
+Interface
+---------
+
+A thread can setup this mechanism on supported kernels by executing the
+following prctl:
+
+  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
+
+<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
+disable the mechanism globally for that thread.  When
+PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
+
+[<offset>, <offset>+<length>) delimit a memory region interval
+from which syscalls are always executed directly, regardless of the
+userspace selector.  This provides a fast path for the C library, which
+includes the most common syscall dispatchers in the native code
+applications, and also provides a way for the signal handler to return
+without triggering a nested SIGSYS on (rt\_)sigreturn.  Users of this
+interface should make sure that at least the signal trampoline code is
+included in this region. In addition, for syscalls that implement the
+trampoline code on the vDSO, that trampoline is never intercepted.
+
+[selector] is a pointer to a char-sized region in the process memory
+region, that provides a quick way to enable disable syscall redirection
+thread-wide, without the need to invoke the kernel directly.  selector
+can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
+value should terminate the program with a SIGSYS.
+
+Security Notes
+--------------
+
+Syscall User Dispatch provides functionality for compatibility layers to
+quickly capture system calls issued by a non-native part of the
+application, while not impacting the Linux native regions of the
+process.  It is not a mechanism for sandboxing system calls, and it
+should not be seen as a security mechanism, since it is trivial for a
+malicious application to subvert the mechanism by jumping to an allowed
+dispatcher region prior to executing the syscall, or to discover the
+address and modify the selector value.  If the use case requires any
+kind of security sandboxing, Seccomp should be used instead.
+
+Any fork or exec of the existing process resets the mechanism to
+PR_SYS_DISPATCH_OFF.
